module Systems.Collision.Grid exposing
    ( CollisionGrid
    , Item
    , clear
    , collisions
    , empty
    , insert
    , shipScoop
    , starCenter
    )

import Collision.Grid as Grid
import Collision.Position exposing (Position)
import Collision.Shape exposing (Shape)
import Components.CollisionShape as CollisionShape exposing (Category)
import Ecs exposing (EntityId)


type alias CollisionGrid =
    Grid.CollisionGrid Category EntityId


type alias Item =
    Grid.Item EntityId


cellSize : Float
cellSize =
    60


empty : CollisionGrid
empty =
    Grid.empty cellSize cellSize


insert :
    Position
    -> Shape
    -> EntityId
    -> Category
    -> CollisionGrid
    -> CollisionGrid
insert =
    Grid.insert


clear : Category -> CollisionGrid -> CollisionGrid
clear =
    Grid.clear


collisions : Category -> Category -> CollisionGrid -> List ( Item, Item )
collisions =
    Grid.collisions


starCenter : Category
starCenter =
    CollisionShape.starCenter


shipScoop : Category
shipScoop =
    CollisionShape.shipScoop
