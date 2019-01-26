module Ecs.Internal.Record2 exposing
    ( Record
    , get1
    , get2
    , set1
    , set2
    , update1
    , update2
    )


type alias Record a1 a2 =
    { a1 : a1
    , a2 : a2
    }


get1 :
    Record a1 a2
    -> a1
get1 =
    .a1


set1 :
    a1
    -> Record a1 a2
    -> Record a1 a2
set1 a1 record =
    { a1 = a1
    , a2 = record.a2
    }


update1 :
    (a1 -> a1)
    -> Record a1 a2
    -> Record a1 a2
update1 fn record =
    { a1 = fn record.a1
    , a2 = record.a2
    }


get2 :
    Record a1 a2
    -> a2
get2 =
    .a2


set2 :
    a2
    -> Record a1 a2
    -> Record a1 a2
set2 a2 record =
    { a1 = record.a1
    , a2 = a2
    }


update2 :
    (a2 -> a2)
    -> Record a1 a2
    -> Record a1 a2
update2 fn record =
    { a1 = record.a1
    , a2 = fn record.a2
    }
