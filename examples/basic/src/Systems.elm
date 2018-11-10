module Systems exposing (update)

import Ecs
import EcsSpecs exposing (Ecs, Entity, SystemSpec)
import Model exposing (Model)
import Nodes


update : Model -> Model
update model =
    let
        ( newEcs, newModel ) =
            Ecs.process
                [ move
                , checkBounce
                , checkTeleport
                , render
                ]
                ( model.ecs, model )
    in
    { newModel | ecs = newEcs }



-- MOVE --


move : SystemSpec Model
move =
    Ecs.processor EcsSpecs.nodes.move moveEntity


moveEntity : Nodes.Move -> ( Entity, Model ) -> ( Entity, Model )
moveEntity { position, velocity } ( entity, model ) =
    ( Ecs.set
        EcsSpecs.components.position
        { x = position.x + velocity.x * model.deltaTime
        , y = position.y + velocity.y * model.deltaTime
        }
        entity
    , model
    )



--  BOUNDS CHECK --


checkBounce : SystemSpec Model
checkBounce =
    Ecs.processor EcsSpecs.nodes.bounce checkEntityBoundsBounce


checkEntityBoundsBounce : Nodes.Bounce -> ( Entity, Model ) -> ( Entity, Model )
checkEntityBoundsBounce { position, velocity, bounce } ( entity, model ) =
    let
        absNewVelocityX =
            abs (velocity.x * bounce.damping)

        absNewVelocityY =
            abs (velocity.y * bounce.damping)

        ( newX, newVelocityX, changedX ) =
            if position.x < 0 then
                ( 0, absNewVelocityX, True )

            else if position.x > toFloat model.worldWidth then
                ( toFloat model.worldWidth, -absNewVelocityX, True )

            else
                ( position.x, velocity.x, False )

        ( newY, newVelocityY, changedY ) =
            if position.y < 0 then
                ( 0, absNewVelocityY, True )

            else if position.y > toFloat model.worldHeight then
                ( toFloat model.worldHeight, -absNewVelocityY, True )

            else
                ( position.y, velocity.y, False )
    in
    if changedX || changedY then
        ( entity
            |> Ecs.set
                EcsSpecs.components.position
                { x = newX, y = newY }
            |> Ecs.set
                EcsSpecs.components.velocity
                { x = newVelocityX, y = newVelocityY }
        , model
        )

    else
        ( entity
        , model
        )


checkTeleport : SystemSpec Model
checkTeleport =
    Ecs.processor EcsSpecs.nodes.teleport checkEntityBoundsTeleport


checkEntityBoundsTeleport :
    Nodes.Teleport
    -> ( Entity, Model )
    -> ( Entity, Model )
checkEntityBoundsTeleport { position } ( entity, model ) =
    let
        newX =
            if position.x < 0 then
                toFloat model.worldWidth

            else if position.x > toFloat model.worldWidth then
                0

            else
                position.x

        newY =
            if position.y < 0 then
                toFloat model.worldHeight

            else if position.y > toFloat model.worldHeight then
                0

            else
                position.y
    in
    if position.x /= newX || position.y /= newY then
        ( Ecs.set EcsSpecs.components.position { x = newX, y = newY } entity
        , model
        )

    else
        ( entity
        , model
        )



-- RENDER --


render : SystemSpec Model
render =
    Ecs.system
        { node = EcsSpecs.nodes.render
        , preProcess = preProcessRender
        , process = processRenderEntity
        , postProcess = identity
        }


preProcessRender : ( Ecs, Model ) -> ( Ecs, Model )
preProcessRender ( ecs, model ) =
    ( ecs
    , { model | viewElements = [] }
    )


processRenderEntity : Nodes.Render -> ( Entity, Model ) -> ( Entity, Model )
processRenderEntity node ( entity, model ) =
    ( entity
    , { model | viewElements = node :: model.viewElements }
    )
