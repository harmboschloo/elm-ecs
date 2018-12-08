module Systems.Render exposing (view)

import Components exposing (Position, Scale, Sprite)
import Entities exposing (Entities, Selector)
import EntityId exposing (EntityId)
import Frame exposing (Frame)
import Global exposing (Global)
import History exposing (History)
import Html exposing (Html, div, text)
import Html.Attributes exposing (height, style, width)
import Math.Matrix4 as Mat4 exposing (Mat4, makeOrtho2D)
import Math.Vector2 exposing (Vec2, vec2)
import Math.Vector3 exposing (Vec3, vec3)
import WebGL exposing (Mesh, Shader)
import WebGL.Texture as Texture exposing (Texture)


type alias Renderable =
    { position : Position
    , sprite : Sprite
    , maybeScale : Maybe Scale
    }


renderableSelector : Selector Renderable
renderableSelector =
    Entities.select2 Renderable
        .position
        .sprite
        |> Entities.andGet .scale


view : Frame -> History -> Global -> Entities -> Html msg
view frame history global entities =
    div []
        [ div
            [ style "color" "#fff"
            , style "position" "absolute"
            , style "top" "0"
            , style "bottom" "0"
            , style "left" "0"
            , style "right" "0"
            , style "overflow" "hidden"
            ]
            [ text "controls: arrow keys - "
            , text <|
                if Frame.isPaused frame then
                    "paused"

                else
                    "running"
            , text <|
                " (esc) - fps: "
                    ++ String.fromInt (round <| History.getFps history)
            , text <|
                " - entities: "
                    ++ String.fromInt (Entities.getEntityCount entities)
            , text <|
                " - components: "
                    ++ String.fromInt (Entities.getComponentCount entities)
            , text <|
                " - test "
                    ++ (if Global.isTestEnabled global then
                            "1"

                        else
                            "0"
                       )
                    ++ " (t)"
            , div
                [ style "position" "absolute"
                , style "top" "0"
                , style "left" "0"
                , style "z-index" "-1"
                ]
                [ viewWebGL (Global.getScreen global) global entities
                ]
            ]
        , if Frame.isPaused frame then
            div
                [ style "margin-top" "1.5em" ]
                [ History.view history ]

          else
            text ""
        ]


viewWebGL : Global.Screen -> Global -> Entities -> Html msg
viewWebGL screen global entities =
    WebGL.toHtmlWith
        [ WebGL.antialias
        , WebGL.depth 1
        ]
        [ width screen.width
        , height screen.height
        ]
        (renderEntities global entities (getCameraTransform (Global.getWorld global)))


getCameraTransform : Global.World -> Mat4
getCameraTransform world =
    makeOrtho2D 0 world.width 0 world.height


renderEntities : Global -> Entities -> Mat4 -> List WebGL.Entity
renderEntities global entities cameraTransform =
    let
        background =
            renderBackground global cameraTransform

        elements =
            List.map
                (renderSprite cameraTransform)
                (Entities.selectList renderableSelector entities)
    in
    background :: elements


renderBackground : Global -> Mat4 -> WebGL.Entity
renderBackground global cameraTransform =
    let
        { width, height } =
            Global.getWorld global

        assets =
            Global.getAssets global

        ( textureWidth, textureHeight ) =
            Texture.size assets.background
    in
    WebGL.entity
        texturedVertexShader
        texturedFragmentShader
        squareMesh
        { transform =
            Mat4.makeScale3 width height 1
                |> Mat4.translate3 0 0 -0.1
                |> Mat4.mul cameraTransform
        , textureOffset = vec2 0 0
        , textureSize =
            vec2
                (width / toFloat textureWidth)
                (height / toFloat textureHeight)
        , texture = assets.background
        }


renderSprite : Mat4 -> ( EntityId, Renderable ) -> WebGL.Entity
renderSprite cameraTransform ( entityId, { sprite, position, maybeScale } ) =
    let
        spriteTransform =
            Mat4.makeScale3 sprite.width sprite.height 1
                |> Mat4.translate3 -sprite.pivotX -sprite.pivotY 0

        scalekMat =
            case maybeScale of
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
    WebGL.entity
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
