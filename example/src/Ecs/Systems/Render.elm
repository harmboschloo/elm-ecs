module Ecs.Systems.Render exposing (view)

import Ecs exposing (Ecs, EntityId)
import Ecs.Components exposing (Background, Position, Sprite)
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
            |> Ecs.processEntities Ecs.background renderBackground
            |> Ecs.processEntities2 Ecs.sprite Ecs.position renderSprite
            |> Tuple.second
        )


renderBackground :
    EntityId
    -> Background
    -> ( Ecs, List WebGL.Entity )
    -> ( Ecs, List WebGL.Entity )
renderBackground entityId background ( ecs, elements ) =
    let
        ( textureWidth, textureHeight ) =
            Texture.size background.texture
    in
    ( ecs
    , WebGL.entity
        texturedVertexShader
        texturedFragmentShader
        squareMesh
        { transform =
            Mat4.mul
                cameraTransform
                (Mat4.makeScale3 (toFloat width) (toFloat height) 1)
        , textureOffset = vec2 0 0
        , textureSize =
            vec2
                (toFloat width / toFloat textureWidth)
                (toFloat height / toFloat textureHeight)
        , texture = background.texture
        }
        :: elements
    )


renderSprite :
    EntityId
    -> Sprite
    -> Position
    -> ( Ecs, List WebGL.Entity )
    -> ( Ecs, List WebGL.Entity )
renderSprite entityId sprite position ( ecs, elements ) =
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
        texturedVertexShader
        texturedFragmentShader
        squareMesh
        { transform =
            spriteTransform
                |> Mat4.mul positionTransform
                |> Mat4.mul cameraTransform
        , textureOffset =
            vec2
                ((sprite.x / toFloat textureWidth) + (texelWidth / 2))
                ((sprite.y / toFloat textureHeight) + (texelHeight / 2))
        , textureSize =
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


type alias TexturedUniforms =
    { transform : Mat4
    , textureOffset : Vec2
    , textureSize : Vec2
    , texture : Texture
    }


type alias TexturedVaryings =
    { textureCoordinate : Vec2
    }


texturedVertexShader : Shader Attributes TexturedUniforms TexturedVaryings
texturedVertexShader =
    [glsl|

        attribute vec2 vertexPosition;
        uniform mat4 transform;
        uniform vec2 textureOffset;
        uniform vec2 textureSize;
        varying vec2 textureCoordinate;

        void main () {
          gl_Position = transform * vec4(vertexPosition, 0, 1.0);
          textureCoordinate = textureOffset + vertexPosition * textureSize;
        }

    |]


texturedFragmentShader : Shader {} { u | texture : Texture } TexturedVaryings
texturedFragmentShader =
    [glsl|

        precision mediump float;
        uniform sampler2D texture;
        varying vec2 textureCoordinate;

        void main () {
          gl_FragColor = texture2D(texture, textureCoordinate);
          if (gl_FragColor.a == 0.0) discard;
        }

    |]
