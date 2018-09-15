module Ecs.Systems.Render exposing (view)

import Ecs exposing (Ecs, EntityId)
import Ecs.Components exposing (Position, Sprite)
import Html exposing (Html)
import Html.Attributes as Attributes exposing (style)
import Math.Matrix4 as Mat4 exposing (Mat4, makeOrtho2D)
import Math.Vector2 exposing (Vec2, vec2)
import Math.Vector3 exposing (Vec3, vec3)
import WebGL exposing (Mesh, Shader)
import WebGL.Texture as Texture exposing (Texture)


width : Int
width =
    500


height : Int
height =
    500


cameraTransform : Mat4
cameraTransform =
    makeOrtho2D 0 (toFloat width) 0 (toFloat height)


view : Ecs -> Html msg
view ecs =
    WebGL.toHtml
        [ Attributes.width width
        , Attributes.height height
        , style "display" "block"
        , style "background-color" "#aaffaa"
        ]
        (( ecs, [] )
            |> Ecs.processEntities2 Ecs.sprite Ecs.position viewEntity
            |> Tuple.second
        )


viewEntity :
    EntityId
    -> Sprite
    -> Position
    -> ( Ecs, List WebGL.Entity )
    -> ( Ecs, List WebGL.Entity )
viewEntity entityId sprite position ( ecs, elements ) =
    let
        spriteTransform =
            Mat4.makeScale3 sprite.width sprite.height 1
                |> Mat4.translate3 -sprite.pivotX -sprite.pivotY 0

        positionTransform =
            Mat4.makeTranslate3 position.x position.y 0
                |> Mat4.rotate position.angle (vec3 0 0 1)

        ( textureWidth, textureHeight ) =
            Texture.size sprite.texture

        texelWidth =
            1 / toFloat textureWidth

        texelHeight =
            1 / toFloat textureHeight
    in
    ( ecs
    , WebGL.entity
        vertexShader
        fragmentShader
        squareMesh
        { transform =
            spriteTransform
                |> Mat4.mul positionTransform
                |> Mat4.mul cameraTransform
        , subTextureOffset =
            vec2
                ((sprite.x / toFloat textureWidth) + (texelWidth / 2))
                ((sprite.y / toFloat textureHeight) + (texelHeight / 2))
        , subTextureSize =
            vec2
                ((sprite.width / toFloat textureWidth) - texelWidth)
                ((sprite.height / toFloat textureHeight) - texelHeight)
        , texture = sprite.texture
        }
        :: elements
    )



-- MESHES --


squareMesh : Mesh Attributes
squareMesh =
    face (vec2 1 0) (vec2 1 1) (vec2 0 1) (vec2 0 0)
        |> WebGL.triangles


face : Vec2 -> Vec2 -> Vec2 -> Vec2 -> List ( Attributes, Attributes, Attributes )
face a b c d =
    [ ( Attributes a, Attributes b, Attributes c )
    , ( Attributes c, Attributes d, Attributes a )
    ]



--  SHADERS


type alias Attributes =
    { vertexPosition : Vec2
    }


type alias Uniforms =
    { transform : Mat4
    , subTextureOffset : Vec2
    , subTextureSize : Vec2
    , texture : Texture
    }


type alias Varyings =
    { textureCoordinate : Vec2
    }


vertexShader : Shader Attributes Uniforms Varyings
vertexShader =
    [glsl|

        attribute vec2 vertexPosition;
        uniform mat4 transform;
        uniform vec2 subTextureOffset;
        uniform vec2 subTextureSize;
        varying vec2 textureCoordinate;

        void main () {
          gl_Position = transform * vec4(vertexPosition, 0, 1.0);
          textureCoordinate = subTextureOffset + vertexPosition * subTextureSize;
        }

    |]


fragmentShader : Shader {} { u | texture : Texture } Varyings
fragmentShader =
    [glsl|

        precision mediump float;
        uniform sampler2D texture;
        varying vec2 textureCoordinate;

        void main () {
          gl_FragColor = texture2D(texture, textureCoordinate);
          if (gl_FragColor.a == 0.0) discard;
        }

    |]
