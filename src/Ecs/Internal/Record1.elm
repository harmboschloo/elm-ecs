module Ecs.Internal.Record1 exposing
    ( Record
    , get1
    , set1
    , update1
    )


type alias Record a1 =
    { a1 : a1
    }


get1 :
    Record a1
    -> a1
get1 =
    .a1


set1 :
    a1
    -> Record a1
    -> Record a1
set1 a1 record =
    { a1 = a1
    }


update1 :
    (a1 -> a1)
    -> Record a1
    -> Record a1
update1 fn record =
    { a1 = fn record.a1
    }
