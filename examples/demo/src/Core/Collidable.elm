module Core.Collidable exposing
    ( Category
    , Collidable
    , shipScoop
    , starCenter
    )

import Core.Collision.Shape exposing (Shape)


type alias Collidable =
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
