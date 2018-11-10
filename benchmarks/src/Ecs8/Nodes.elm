module Ecs8.Nodes exposing
    ( node1
    , node2
    , node3
    )

{-| ECS node specs.
-}

import Ecs8.Internal exposing (ComponentSpec(..), NodeSpec(..))


{-| -}
node1 :
    (component1 -> node)
    -> ComponentSpec components component1
    -> NodeSpec components node
node1 createNode (ComponentSpec spec1) =
    NodeSpec
        { getNode =
            \data ->
                case spec1.getComponent data of
                    Nothing ->
                        Nothing

                    Just component1 ->
                        Just
                            (createNode
                                component1
                            )
        }


{-| -}
node2 :
    (component1 -> component2 -> node)
    -> ComponentSpec components component1
    -> ComponentSpec components component2
    -> NodeSpec components node
node2 createNode (ComponentSpec spec1) (ComponentSpec spec2) =
    NodeSpec
        { getNode =
            \data ->
                case spec1.getComponent data of
                    Nothing ->
                        Nothing

                    Just component1 ->
                        case spec2.getComponent data of
                            Nothing ->
                                Nothing

                            Just component2 ->
                                Just
                                    (createNode
                                        component1
                                        component2
                                    )
        }


{-| -}
node3 :
    (component1 -> component2 -> component3 -> node)
    -> ComponentSpec components component1
    -> ComponentSpec components component2
    -> ComponentSpec components component3
    -> NodeSpec components node
node3 createNode (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) =
    NodeSpec
        { getNode =
            \data ->
                case spec1.getComponent data of
                    Nothing ->
                        Nothing

                    Just component1 ->
                        case spec2.getComponent data of
                            Nothing ->
                                Nothing

                            Just component2 ->
                                case spec3.getComponent data of
                                    Nothing ->
                                        Nothing

                                    Just component3 ->
                                        Just
                                            (createNode
                                                component1
                                                component2
                                                component3
                                            )
        }
