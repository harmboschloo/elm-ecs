module World exposing
    ( World
    , AllComponentsSpec, ComponentSpec, ComponentSpecs, componentSpecs
    , Components
    , Ai, Collidable, DelayedOperations, Player, Position
    , Scale, ScaleAnimation, ShipControls, ShipLimits, Sprite, Star, Velocity
    , Selector
    , SingletonSpec, SingletonSpecs, singletonSpecs
    , Singletons, initSingletons
    , ActiveKeys, Assets, ControlMapping, RandomSeed
    , SpawnConfig, Timer, ViewConfig
    )

{-|

@docs World
@docs AllComponentsSpec, ComponentSpec, ComponentSpecs, componentSpecs
@docs Components
@docs Ai, Collidable, DelayedOperations, Player, Position
@docs Scale, ScaleAnimation, ShipControls, ShipLimits, Sprite, Star, Velocity
@docs Selector
@docs SingletonSpec, SingletonSpecs, singletonSpecs
@docs Singletons, initSingletons
@docs ActiveKeys, Assets, ControlMapping, RandomSeed
@docs SpawnConfig, Timer, ViewConfig

-}

import Config.ControlMapping
import Config.SpawnConfig
import Config.ViewConfig
import Core.Animation.Sequence
import Core.Assets
import Core.Assets.Sprite
import Core.Collidable
import Core.Dynamics.Position
import Core.Dynamics.Ship.Controls
import Core.Dynamics.Ship.Limits
import Core.Dynamics.Velocity
import Core.UserInput.ActiveKeys
import Ecs
import Ecs.Components
import Ecs.Select
import Ecs.Singletons
import Random
import Timing.Timer
import World.DelayedOperations



-- WORLD --


type alias World =
    Ecs.World Components Singletons



-- COMPONENT SPECS --


type alias ComponentSpec a =
    Ecs.Components.ComponentSpec Components a


type alias AllComponentsSpec =
    Ecs.Components.AllComponentsSpec Components


type alias ComponentSpecs =
    { all : AllComponentsSpec
    , ai : ComponentSpec Ai
    , collidable : ComponentSpec Collidable
    , delayedOperations : ComponentSpec DelayedOperations
    , player : ComponentSpec Player
    , position : ComponentSpec Position
    , scale : ComponentSpec Scale
    , scaleAnimation : ComponentSpec ScaleAnimation
    , shipControls : ComponentSpec ShipControls
    , shipLimits : ComponentSpec ShipLimits
    , sprite : ComponentSpec Sprite
    , star : ComponentSpec Star
    , velocity : ComponentSpec Velocity
    }


type alias Selector a =
    Ecs.Select.Selector Components a


componentSpecs : ComponentSpecs
componentSpecs =
    Ecs.Components.specs12 ComponentSpecs



-- COMPONENTS --


type alias Components =
    Ecs.Components.Components12 Ai Collidable DelayedOperations Player Position Scale ScaleAnimation ShipControls ShipLimits Sprite Star Velocity



-- COMPONENT TYPES --


type alias Ai =
    { target : Maybe Ecs.EntityId
    }


type alias Collidable =
    Core.Collidable.Collidable


type alias DelayedOperations =
    World.DelayedOperations.DelayedOperations


type alias Player =
    ()


type alias Position =
    Core.Dynamics.Position.Position


type alias Scale =
    Float


type alias ScaleAnimation =
    Core.Animation.Sequence.Animation


type alias ShipLimits =
    Core.Dynamics.Ship.Limits.Limits


type alias ShipControls =
    Core.Dynamics.Ship.Controls.Controls


type alias Sprite =
    Core.Assets.Sprite.Sprite


type alias Star =
    ()


type alias Velocity =
    Core.Dynamics.Velocity.Velocity



-- SINGLETON SPECS --


type alias SingletonSpec a =
    Ecs.Singletons.SingletonSpec Singletons a


type alias SingletonSpecs =
    { activeKeys : SingletonSpec ActiveKeys
    , assets : SingletonSpec Assets
    , controlMapping : SingletonSpec ControlMapping
    , randomSeed : SingletonSpec RandomSeed
    , spawnConfig : SingletonSpec SpawnConfig
    , timer : SingletonSpec Timer
    , viewConfig : SingletonSpec ViewConfig
    }


singletonSpecs : SingletonSpecs
singletonSpecs =
    Ecs.Singletons.specs7 SingletonSpecs



-- SINGLETONS --


type alias Singletons =
    Ecs.Singletons.Singletons7 ActiveKeys Assets ControlMapping RandomSeed SpawnConfig Timer ViewConfig


initSingletons :
    ActiveKeys
    -> Assets
    -> ControlMapping
    -> RandomSeed
    -> SpawnConfig
    -> Timer
    -> ViewConfig
    -> Singletons
initSingletons =
    Ecs.Singletons.init7



-- SINGLETON TYPES --


type alias ActiveKeys =
    Core.UserInput.ActiveKeys.ActiveKeys


type alias Assets =
    Core.Assets.Assets


type alias ControlMapping =
    Config.ControlMapping.ControlMapping


type alias RandomSeed =
    Random.Seed


type alias SpawnConfig =
    Config.SpawnConfig.SpawnConfig


type alias Timer =
    Timing.Timer.Timer


type alias ViewConfig =
    Config.ViewConfig.ViewConfig
