module Ecs.Systems.Render exposing (Config, view)

import Ecs exposing (Ecs, EntityId)
import Ecs.Components exposing (Background, Position, Sprite)
import Html exposing (Html)
import Html.Attributes exposing (height, style, width)
import Math.Matrix4 as Mat4 exposing (Mat4, makeOrtho2D)
import Math.Vector2 exposing (Vec2, vec2)
import Math.Vector3 exposing (Vec3, vec3)
import WebGL exposing (Mesh, Shader)
import WebGL.Texture as Texture exposing (Texture)


type alias Config =
    { width : Int
    , height : Int
    , world :
        { width : Float
        , height : Float
        }
    , ecs : Ecs
    }


view : Config -> Html msg
view config =
    WebGL.toHtml
        [ width config.width
        , height config.height
        ]
        (renderEntities config (getCameraTransform config))


getCameraTransform : Config -> Mat4
getCameraTransform { world } =
    makeOrtho2D 0 world.width 0 world.height


renderEntities : Config -> Mat4 -> List WebGL.Entity
renderEntities config cameraTransform =
    ( config.ecs, [] )
        |> Ecs.processEntities
            Ecs.background
            (renderBackground config cameraTransform)
        |> Ecs.processEntities2
            Ecs.sprite
            Ecs.position
            (renderSprite cameraTransform)
        |> Tuple.second


renderBackground :
    Config
    -> Mat4
    -> EntityId
    -> Background
    -> ( Ecs, List WebGL.Entity )
    -> ( Ecs, List WebGL.Entity )
renderBackground { world } cameraTransform entityId background ( ecs, elements ) =
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
                (Mat4.makeScale3 world.width world.height 1)
        , textureOffset = vec2 0 0
        , textureSize =
            vec2
                (world.width / toFloat textureWidth)
                (world.height / toFloat textureHeight)
        , texture = background.texture
        }
        :: elements
    )


renderSprite :
    Mat4
    -> EntityId
    -> Sprite
    -> Position
    -> ( Ecs, List WebGL.Entity )
    -> ( Ecs, List WebGL.Entity )
renderSprite cameraTransform entityId sprite position ( ecs, elements ) =
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
