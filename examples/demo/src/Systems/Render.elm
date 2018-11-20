module Systems.Render exposing (system, view)

import Components exposing (Position, Sprite)
import Ecs exposing (Ecs)
import Entity exposing (Entity, components)
import Frame exposing (Frame)
import History exposing (History)
import Html exposing (Html, div, text)
import Html.Attributes exposing (height, style, width)
import Math.Matrix4 as Mat4 exposing (Mat4, makeOrtho2D)
import Math.Vector2 exposing (Vec2, vec2)
import Math.Vector3 exposing (Vec3, vec3)
import State exposing (State)
import Systems.Render.RenderElement as RenderElement exposing (RenderElement)
import WebGL exposing (Mesh, Shader)
import WebGL.Texture as Texture exposing (Texture)


type alias Renderable =
    { position : Position
    , sprite : Sprite
    }


node : Ecs.Node Entity Renderable
node =
    Ecs.node2 Renderable
        components.position
        components.sprite


system : Ecs.System Entity State
system =
    Ecs.system
        { preProcess = Just preProcess
        , process = Just ( node, processEntity )
        , postProcess = Nothing
        }


preProcess : Ecs Entity -> State -> ( Ecs Entity, State )
preProcess ecs state =
    ( ecs, { state | renderElements = [] } )


processEntity :
    Renderable
    -> Ecs.EntityId
    -> Ecs Entity
    -> State
    -> ( Ecs Entity, State )
processEntity renderable entityId ecs state =
    ( ecs
    , { state
        | renderElements =
            { position = renderable.position
            , sprite = renderable.sprite
            , scale = Ecs.get components.scale entityId ecs
            }
                :: state.renderElements
      }
    )


view : Frame -> History -> Ecs Entity -> State -> Html msg
view frame history ecs state =
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
                " (ecs) - fps: "
                    ++ String.fromInt (round <| History.getFps history)
            , text <|
                " - entities: "
                    ++ String.fromInt (Ecs.size ecs)
            , text <|
                " - test "
                    ++ (if state.test then
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
                [ viewWebGL state
                ]
            ]
        , if Frame.isPaused frame then
            div
                [ style "margin-top" "1.5em" ]
                [ History.view history ]

          else
            text ""
        ]


viewWebGL : State -> Html msg
viewWebGL state =
    WebGL.toHtmlWith
        [ WebGL.antialias
        , WebGL.depth 1
        ]
        [ width state.screen.width
        , height state.screen.height
        ]
        (renderEntities state (getCameraTransform state))


getCameraTransform : State -> Mat4
getCameraTransform { world } =
    makeOrtho2D 0 world.width 0 world.height


renderEntities : State -> Mat4 -> List WebGL.Entity
renderEntities state cameraTransform =
    let
        background =
            renderBackground state cameraTransform

        elements =
            List.map (\e -> renderSprite cameraTransform e) state.renderElements
    in
    background :: elements


renderBackground : State -> Mat4 -> WebGL.Entity
renderBackground state cameraTransform =
    let
        { width, height } =
            state.world

        ( textureWidth, textureHeight ) =
            Texture.size state.assets.background
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
        , texture = state.assets.background
        }


renderSprite : Mat4 -> RenderElement -> WebGL.Entity
renderSprite cameraTransform element =
    let
        { sprite, position } =
            element

        spriteTransform =
            Mat4.makeScale3 sprite.width sprite.height 1
                |> Mat4.translate3 -sprite.pivotX -sprite.pivotY 0

        scalekMat =
            case element.scale of
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
