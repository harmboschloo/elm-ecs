module Ecs.Systems.Render exposing (view)

import Ecs exposing (Ecs, EntityId)
import Ecs.Components exposing (Display, Position, Sprite)
import Html exposing (Html, div)
import Html.Attributes as Attributes exposing (style)
import Math.Matrix4 as Mat4 exposing (Mat4, makeOrtho2D)
import Math.Vector2 exposing (Vec2, vec2)
import Math.Vector3 exposing (Vec3, vec3)
import WebGL exposing (Mesh, Shader)
import WebGL.Texture as Texture exposing (Texture)


width : Int
width =
    250


height : Int
height =
    250


px : Int -> String
px value =
    String.fromInt value ++ "px"


view : Ecs -> Html msg
view ecs =
    div []
        [ viewWebGL ecs
        , viewHtml ecs
        ]



-- WEBGL --


viewWebGL : Ecs -> Html msg
viewWebGL ecs =
    WebGL.toHtml
        [ Attributes.width width
        , Attributes.height height
        , style "display" "block"

        -- , style "background-color" "#aaffaa"
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
        ( textureWidth, textureHeight ) =
            Texture.size sprite.texture
    in
    ( ecs
    , WebGL.entity
        vertexShader
        fragmentShader
        squareMesh
        { transform =
            Mat4.makeTranslate3 0.5 0.5 0
                |> Mat4.rotate 0 (vec3 0 0 1)
                |> Mat4.translate3 -0.5 -0.75 0
                |> Mat4.mul ortho2D

        -- Mat4.makeTranslate3 position.x position.y 0
        --     |> Mat4.rotate position.angle (vec3 0 0 1)
        --     |> Mat4.translate3 -sprite.offsetX -sprite.offsetY 0
        --     |> Mat4.mul ortho2D
        , subTextureOffset =
            vec2
                (sprite.x / toFloat textureWidth)
                (sprite.y / toFloat textureHeight)
        , subTextureSize =
            vec2
                (sprite.width / toFloat textureWidth)
                (sprite.height / toFloat textureHeight)
        , texture = sprite.texture
        }
        :: elements
    )


ortho2D : Mat4
ortho2D =
    makeOrtho2D 0 1 0 1



-- WEBGL MESHES --


squareMesh : Mesh Attributes
squareMesh =
    face (vec2 1 0) (vec2 1 1) (vec2 0 1) (vec2 0 0)
        |> WebGL.triangles


face : Vec2 -> Vec2 -> Vec2 -> Vec2 -> List ( Attributes, Attributes, Attributes )
face a b c d =
    [ ( Attributes a, Attributes b, Attributes c )
    , ( Attributes c, Attributes d, Attributes a )
    ]



-- WEBGL SHADERS


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
        }

    |]



-- HTML --


viewHtml : Ecs -> Html msg
viewHtml ecs =
    div
        [ style "position" "relative"
        , style "width" (px width)
        , style "height" (px height)
        , style "background-color" "#aaaaff"
        ]
        (( ecs, [] )
            |> Ecs.processEntities2 Ecs.display Ecs.position viewHtmlEntity
            |> Tuple.second
        )


viewHtmlEntity :
    EntityId
    -> Display
    -> Position
    -> ( Ecs, List (Html msg) )
    -> ( Ecs, List (Html msg) )
viewHtmlEntity entityId display position ( ecs, elements ) =
    ( ecs
    , div
        [ style "position" "absolute"
        , style "width" "10px"
        , style "height" "10px"
        , style "left" (position.x / 4 - 5 |> round |> px)
        , style "top" (position.y / 4 - 5 |> round |> px)
        , style "background-color" display.color
        ]
        []
        :: elements
    )
