# ECS

This package provides a way to use the [entity-component-system (ECS) pattern](https://en.wikipedia.org/wiki/Entity-component-system) in Elm. This patterns is mainly used in games (and simulations) and is useful when you want to create highly composable game objects and minimize coupling between game logic. The ECS pattern follows these basic ideas:

- An **entity** represents a generic container for components. You can think of this as a game object.
- A **component** contains data. Multiple components can be associated with an entity.
- A **system** contains logic and operates on entities with a specific subset of component types.

Since the [module overview](https://package.elm-lang.org/packages/harmboschloo/elm-ecs/latest/) is a bit cluttered here are the main modules:

- [**Ecs**](https://package.elm-lang.org/packages/harmboschloo/elm-ecs/latest/Ecs) - for creating a world and managing entities, components and singletons.
- [**Ecs.EntityComponents**](https://package.elm-lang.org/packages/harmboschloo/elm-ecs/latest/Ecs-EntityComponents) - for processing entities with a specific subset of component types.
- **Ecs.ComponentsN** - for setting up a container for **N** component types.
- **Ecs.SingletonsN** - for setting up a container for **N** singleton types.

If you want to dive right in, here are some example projects:

- [readme1 - example 1 below](https://harmboschloo.github.io/elm-ecs-2.0/readme1/) ([source](https://github.com/harmboschloo/elm-ecs/blob/master/examples/readme1/Main.elm))
- [readme2 - example 2 below](https://harmboschloo.github.io/elm-ecs-2.0/readme2/) ([source](https://github.com/harmboschloo/elm-ecs/blob/master/examples/readme2/Main.elm))
- [orbits - a playful demo](https://harmboschloo.github.io/elm-ecs-2.0/orbits/) ([source](https://github.com/harmboschloo/elm-ecs/tree/master/examples/orbits))

## Example 1

### Components

Suppose we start building a game and we want some static shapes and some moving shapes. We might define some data types like this:

```elm
type alias Position =
    { x : Float
    , y : Float
    }


type alias Velocity =
    { velocityX : Float
    , velocityY : Float
    }


type alias Shape =
    { width : Float
    , height : Float
    , color : String
    }
```

These three data types will be our ECS _component_ types. To associate a component with an _entity_ we will use an entity id. That is actually all an entity is. It is nothing more than an id that represents a game object. Here we use an `Int` type but it can be any [`comparable` type](https://faq.elm-community.org/#does-elm-have-ad-hoc-polymorphism-or-typeclasses).

```elm
type alias EntityId =
    Int
```

Since we have three component types we will be using the [**Ecs.Components3**](https://package.elm-lang.org/packages/harmboschloo/elm-ecs/latest/Ecs-Components3) module. Now we can define our components container type that we will use for our game world:

```elm
type alias Components =
    Ecs.Components3.Components3 EntityId Position Velocity Shape
```

### Specs

Before we can create our game world and insert our entities and components we need to set up some specs. The [**Ecs**](https://package.elm-lang.org/packages/harmboschloo/elm-ecs/latest/Ecs) module needs these specs to know how to retrieve and update components. First we create a record type for all our specs and then we initialize it with the [**Ecs.Components3.specs**](https://package.elm-lang.org/packages/harmboschloo/elm-ecs/latest/Ecs-Components3#specs) function using the [record constructor](https://guide.elm-lang.org/types/type_aliases.html#record-constructors).

```elm
type alias Specs =
    { all : AllComponentsSpec
    , position : ComponentSpec Position
    , velocity : ComponentSpec Velocity
    , shape : ComponentSpec Shape
    }


type alias AllComponentsSpec =
    Ecs.AllComponentsSpec EntityId Components


type alias ComponentSpec a =
    Ecs.ComponentSpec EntityId a Components


specs : Specs
specs =
    Ecs.Components3.specs Specs
```

### World

Now we can define our world which will hold all our components:

```elm
type alias World =
    Ecs.World EntityId Components ()


emptyWorld : World
emptyWorld =
    Ecs.emptyWorld specs.all ()
```

**Note:** The `()` is a [empty tuple](https://faq.elm-community.org/#what-does--mean) which specifies that we are not using singletons here. Below we will discuss singletons in more detail.

For our game lets create three entities. Note that the first entity (`0`) has a position and shape component while the second and third entities (`1` and `2`) also have a velocity component. This effectively makes entity `0` static and will cause `1` and `2` to move around. More on that below.

```elm
initEntities : World -> World
initEntities world =
    world
        -- entity id 0, static red shape
        |> Ecs.insertEntity 0
        |> Ecs.insertComponent specs.position
            { x = 20
            , y = 20
            }
        |> Ecs.insertComponent specs.shape
            { width = 20
            , height = 15
            , color = "red"
            }
        -- entity id 1, moving green shape
        |> Ecs.insertEntity 1
        |> Ecs.insertComponent specs.position
            { x = 30
            , y = 75
            }
        |> Ecs.insertComponent specs.velocity
            { velocityX = 4
            , velocityY = -1
            }
        |> Ecs.insertComponent specs.shape
            { width = 15
            , height = 20
            , color = "green"
            }
        -- entity id 2, moving blue shape
        |> Ecs.insertEntity 2
        |> Ecs.insertComponent specs.position
            { x = 70
            , y = 30
            }
        |> Ecs.insertComponent specs.velocity
            { velocityX = -5
            , velocityY = -5
            }
        |> Ecs.insertComponent specs.shape
            { width = 15
            , height = 15
            , color = "blue"
            }
```

### Moving

Entities `1` and `2` have a velocity component. Now we have to make sure their position gets updated according to their velocity. For this we create the function below. In ECS terms you could call this a _system_. The function only operates on entities which have a specific subset of component types. In this case only entities which have both a position and a velocity component. This package does not have explicit concept of an ECS _system_. Instead it provides functionality to do operations on entities with a subset of component types in the [Ecs.EntityComponents](https://package.elm-lang.org/packages/harmboschloo/elm-ecs/latest/Ecs-EntityComponents) module. We use the `specs` defined previously to specify which component types we want to include. To update a component for an entity we simple insert a new component, overriding the old component.

```elm
updatePositions : Float -> World -> World
updatePositions deltaSeconds world =
    Ecs.EntityComponents.processFromLeft2
        specs.velocity
        specs.position
        (updateEntityPosition deltaSeconds)
        world


updateEntityPosition : Float -> EntityId -> Velocity -> Position -> World -> World
updateEntityPosition deltaSeconds _ velocity position world =
    Ecs.insertComponent specs.position
        { x = position.x + velocity.velocityX * deltaSeconds
        , y = position.y + velocity.velocityY * deltaSeconds
        }
        world
```

### Bounds check

We will remove an entity when a shape reaches the boundary our game. This only applies to moving shapes so we include the velocity component next to the position and shape components. `Ecs.removeEntity` needs `specs.all` here because it needs to remove all components for the entity. The entity id will also be removed from the world. This means that when you insert new components for this entity they will not be added to the world since the entity id is no longer part of the world.

```elm
checkBounds : World -> World
checkBounds world =
    Ecs.EntityComponents.processFromLeft3
        specs.shape
        specs.velocity
        specs.position
        checkEntityBounds
        world


checkEntityBounds : EntityId -> Shape -> Velocity -> Position -> World -> World
checkEntityBounds _ shape _ position world =
    if
        (position.x < 0 || (position.x + shape.width) > 100)
            || (position.y < 0 || (position.y + shape.height) > 100)
    then
        Ecs.removeEntity specs.all world

    else
        world
```

### Finally

That covers setting up specs, creating a world, inserting and removing entities and inserting components. For more operations checkout the [Ecs](https://package.elm-lang.org/packages/harmboschloo/elm-ecs/latest/Ecs) module. If you want to know more about how everything fits together in a program and how to do rendering please check out the full [source code](https://github.com/harmboschloo/elm-ecs/blob/master/examples/readme1/Main.elm). You can also watch the result [here](https://harmboschloo.github.io/elm-ecs-2.0/readme1/).

If you want to know more about singletons and spawning entities read on.

## Example 2

### Components

Let's modify our first example to allow for spawning entities every `frameInterval`. We create a new component `SpawnConfig` which also includes the `velocity` and `shape` of the entity we are going to spawn. Now we are using 4 components types, so we use the `Ecs.Components4` module.

```elm
type alias Components =
    Ecs.Components4.Components4 EntityId Position Velocity Shape SpawnConfig


type alias SpawnConfig =
    { frameInterval : Int
    , velocity : Velocity
    , shape : Shape
    }
```

### Singletons

Now that we are going to be spawning entities dynamically we can not hard-code the id of the entity anymore. We have to keep track of it in another way. Here we will use a singleton `EntityId`. We also want to keep track of the number of frames rendered, so we also add a `Int` singleton counter. There are two singletons to we use the `Ecs.Singletons2` module.

**Note:** Singletons are optional, they are not required when using this package. You can also just keep this data in your model next to the ecs world just like you do in any Elm program. Singletons where added to the package for convenience and to create a consistent way to deal with data (singletons and components).

```elm
type alias Singletons =
    Ecs.Singletons2.Singletons2 EntityId Int
```

### Specs

We will need to add the new component and singleton types to our specs.

```elm
type alias Specs =
    { allComponents : AllComponentsSpec
    , position : ComponentSpec Position
    , velocity : ComponentSpec Velocity
    , shape : ComponentSpec Shape
    , spawnConfig : ComponentSpec SpawnConfig
    , nextEntityId : SingletonSpec EntityId
    , frameCount : SingletonSpec Int
    }


type alias SingletonSpec a =
    Ecs.SingletonSpec a Singletons


specs : Specs
specs =
    Specs |> Ecs.Components4.specs |> Ecs.Singletons2.specs
```

### World

Our world will now look like this. You have to provide an initial value for every singleton when creating the world.

```elm
type alias World =
    Ecs.World EntityId Components Singletons


emptyWorld : World
emptyWorld =
    Ecs.emptyWorld specs.allComponents (Ecs.Singletons2.init 0 0)
```

To create new entities we are going to add a `newEntity` function which is going to insert a new entity using the `nextEntityId` singleton value. And then the function updates the singleton value for the next new entity to be created.

```elm
newEntity : World -> World
newEntity world =
    world
        |> Ecs.insertEntity (Ecs.getSingleton specs.nextEntityId world)
        |> Ecs.updateSingleton specs.nextEntityId (\id -> id + 1)
```

Now let's create our initial entities. We have one static shape as before, but instead of the moving shapes we create two entity spawners. The spawners have a position and contain data about the shape and velocity of the entities they should spawn.

```elm
initEntities : World -> World
initEntities world =
    world
        -- entity id 0, static red shape
        |> newEntity
        |> Ecs.insertComponent specs.position
            { x = 20
            , y = 20
            }
        |> Ecs.insertComponent specs.shape
            { width = 20
            , height = 15
            , color = "red"
            }
        -- entity id 1, spawner for moving green shapes
        |> newEntity
        |> Ecs.insertComponent specs.position
            { x = 30
            , y = 75
            }
        |> Ecs.insertComponent specs.spawnConfig
            { frameInterval = 120
            , velocity =
                { velocityX = 4
                , velocityY = -1
                }
            , shape =
                { width = 15
                , height = 20
                , color = "green"
                }
            }
        -- entity id 2, spawner for moving blue shapes
        |> newEntity
        |> Ecs.insertComponent specs.position
            { x = 70
            , y = 30
            }
        |> Ecs.insertComponent specs.spawnConfig
            { frameInterval = 60
            , velocity =
                { velocityX = -5
                , velocityY = -5
                }
            , shape =
                { width = 15
                , height = 15
                , color = "blue"
                }
            }
```

### Counting frames

We already saw how the `nextEntityId` singleton gets updated. The `frameCount` singleton is even simpler, it just increments the value. This function is called every render frame.

```elm
updateFrameCount : World -> World
updateFrameCount world =
    Ecs.updateSingleton specs.frameCount (\frameCount -> frameCount + 1) world
```

### Spawning entities

Now let's spawn some entities. Every entity with a `SpawnConfig` and `Position` component will effectively be a spawner. First we get the current frame count and check if it matches the frame interval defined in the spawn config. If it matches we insert a new entity with the position of the spawner and the velocity and shape in the spawn config. If the frame interval does not match the current frame count we do nothing.

```elm
spawnEntities : World -> World
spawnEntities world =
    Ecs.EntityComponents.processFromLeft2
        specs.spawnConfig
        specs.position
        spawnEntity
        world


spawnEntity : EntityId -> SpawnConfig -> Position -> World -> World
spawnEntity _ config position world =
    let
        frameCount =
            Ecs.getSingleton specs.frameCount world
    in
    if remainderBy config.frameInterval frameCount == 0 then
        world
            |> newEntity
            |> Ecs.insertComponent specs.position position
            |> Ecs.insertComponent specs.velocity config.velocity
            |> Ecs.insertComponent specs.shape config.shape

    else
        world
```

### Finally

That covers setting up singletons and spawning entities. Check out the full [source code](https://github.com/harmboschloo/elm-ecs/blob/master/examples/readme2/Main.elm) and the [result](https://harmboschloo.github.io/elm-ecs-2.0/readme2/).

There is also a playful [orbits demo](https://harmboschloo.github.io/elm-ecs-2.0/orbits/) which includes user interaction and randomness ([source code](https://github.com/harmboschloo/elm-ecs/blob/master/examples/orbits/Main.elm)).

## Misc

Originally inspired by [Slime](https://package.elm-lang.org/packages/seurimas/slime/latest/Slime), [Ash](https://www.richardlord.net/ash/), [Mogee](https://github.com/w0rm/elm-mogee) and others.
