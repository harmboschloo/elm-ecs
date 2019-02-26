module Systems.Ai exposing (update)

import Core.Ai
import Ecs
import Ecs.Select
import World exposing (World)


type alias Ship =
    { ai : World.Ai
    , limits : World.ShipLimits
    , position : World.Position
    , velocity : World.Velocity
    }


shipSelector : World.Selector Ship
shipSelector =
    Ecs.Select.select4 Ship
        World.componentSpecs.ai
        World.componentSpecs.shipLimits
        World.componentSpecs.position
        World.componentSpecs.velocity
        |> Ecs.Select.andHas World.componentSpecs.shipControls


type alias Target =
    { star : World.Star
    , position : World.Position
    }


targetSelector : World.Selector Target
targetSelector =
    Ecs.Select.select2 Target
        World.componentSpecs.star
        World.componentSpecs.position
        |> Ecs.Select.andHas World.componentSpecs.collidable


update : World -> World
update =
    Ecs.processAll shipSelector updateEntity


updateEntity : ( Ecs.EntityId, Ship ) -> World -> World
updateEntity ( entityId, ship ) world =
    let
        maybeTarget =
            case ship.ai.target of
                Just targetId ->
                    case Ecs.select targetSelector targetId world of
                        Just target ->
                            Just ( targetId, target.position )

                        Nothing ->
                            findTargetFor ship world

                Nothing ->
                    findTargetFor ship world

        ( maybeTargetId, targetPosition ) =
            case maybeTarget of
                Just ( targetId, position ) ->
                    ( Just targetId, position )

                Nothing ->
                    let
                        viewConfig =
                            Ecs.getSingleton
                                World.singletonSpecs.viewConfig
                                world
                    in
                    ( Nothing
                    , { x = viewConfig.world.width / 2
                      , y = viewConfig.world.height / 2
                      , angle = 0
                      }
                    )

        controls =
            Core.Ai.findControlsForTarget
                targetPosition
                { limits = ship.limits
                , position = ship.position
                , velocity = ship.velocity
                }
    in
    Ecs.insertComponent World.componentSpecs.shipControls entityId controls world


findTargetFor : Ship -> World -> Maybe ( Ecs.EntityId, World.Position )
findTargetFor ship world =
    Ecs.selectAll targetSelector world
        |> List.map
            (\( entityId, target ) ->
                ( entityId
                , target.position
                , Core.Ai.calculateDistanceSquared target.position ship.position
                )
            )
        |> List.sortBy (\( _, _, distanceSquared ) -> distanceSquared)
        |> List.head
        |> Maybe.map (\( entityId, position, _ ) -> ( entityId, position ))
