module Components.CollisionShape exposing
    ( Category
    , CollisionShape
    , shipScoop
    , starCenter
    )

import Collision.Shape exposing (Shape)


type alias CollisionShape =
    { shape : Shape
    , category : Category
    }


type Category
    = StarCenter
    | ShipScoop


starCenter : Category
starCenter =
    StarCenter


shipScoop : Category
shipScoop =
    ShipScoop
