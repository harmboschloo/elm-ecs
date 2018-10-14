module Systems.Render exposing (view)

import Context exposing (Context)
import Ecs exposing (Ecs)
import Html exposing (Html, div, text)
import Html.Attributes exposing (height, style, width)
import Math.Matrix4 as Mat4 exposing (Mat4, makeOrtho2D)
import Math.Vector2 exposing (Vec2, vec2)
import Math.Vector3 exposing (Vec3, vec3)
import WebGL exposing (Mesh, Shader)
import WebGL.Texture as Texture exposing (Texture)


view : Context -> Ecs -> Html msg
view context ecs =
    div
        [ style "color" "#fff"
        , style "position" "absolute"
        , style "top" "0"
        , style "bottom" "0"
        , style "left" "0"
        , style "right" "0"
        , style "overflow" "hidden"
        ]
        [ text <|
            "stepCount: "
                ++ String.fromInt context.stepCount
                ++ " ( "
                ++ String.fromInt (round (1 / context.deltaTime))
                ++ " FPS)"
        , text <|
            if context.running then
                " running"

            else
                " paused"
        , div
            [ style "position" "absolute"
            , style "top" "0"
            , style "left" "0"
            , style "z-index" "-1"
            ]
            [ viewWebGL context ecs
            ]
        ]


viewWebGL : Context -> Ecs -> Html msg
viewWebGL context ecs =
    WebGL.toHtmlWith
        [ WebGL.antialias
        , WebGL.depth 1
        ]
        [ width context.screen.width
        , height context.screen.height
        ]
        (renderEntities context ecs (getCameraTransform context))


getCameraTransform : Context -> Mat4
getCameraTransform { world } =
    makeOrtho2D 0 world.width 0 world.height


renderEntities : Context -> Ecs -> Mat4 -> List WebGL.Entity
renderEntities context ecs cameraTransform =
    let
        entities =
            [ renderBackground context cameraTransform ]
    in
    ( ecs, entities )
        |> Ecs.iterate Ecs.renderNode (renderSprite cameraTransform)
        |> Tuple.second


renderBackground : Context -> Mat4 -> WebGL.Entity
renderBackground context cameraTransform =
    let
        { width, height } =
            context.world

        ( textureWidth, textureHeight ) =
            Texture.size context.assets.background
    in
    WebGL.entity
        texturedVertexShader
        texturedFragmentShader
        squareMesh
        { transform =
            Mat4.mul
                cameraTransform
                (Mat4.makeScale3 width height 1)
        , textureOffset = vec2 0 0
        , textureSize =
            vec2
                (width / toFloat textureWidth)
                (height / toFloat textureHeight)
        , texture = context.assets.background
        }


renderSprite :
    Mat4
    -> Ecs.EntityId
    -> Ecs.RenderNode
    -> ( Ecs, List WebGL.Entity )
    -> ( Ecs, List WebGL.Entity )
renderSprite cameraTransform entityId { position, sprite } ( ecs, elements ) =
    let
        spriteTransform =
            Mat4.makeScale3 sprite.width sprite.height 1
                |> Mat4.translate3 -sprite.pivotX -sprite.pivotY 0

        scalekMat =
            case Ecs.get entityId Ecs.scaleComponent ecs of
                Nothing ->
                    identity

                Just scale ->
                    Mat4.scale3 scale scale 1

        worldTransform =
            Mat4.makeTranslate3 position.x position.y 0
                |> Mat4.rotate (position.angle + pi / 2) (vec3 0 0 1)
                |> scalekMat

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
                |> Mat4.mul worldTransform
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
