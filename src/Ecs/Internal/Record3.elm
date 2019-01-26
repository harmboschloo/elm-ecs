module Ecs.Internal.Record3 exposing
    ( Record
    , get1
    , get2
    , get3
    , set1
    , set2
    , set3
    , update1
    , update2
    , update3
    )


type alias Record a1 a2 a3 =
    { a1 : a1
    , a2 : a2
    , a3 : a3
    }


get1 :
    Record a1 a2 a3
    -> a1
get1 =
    .a1


set1 :
    a1
    -> Record a1 a2 a3
    -> Record a1 a2 a3
set1 a1 record =
    { a1 = a1
    , a2 = record.a2
    , a3 = record.a3
    }


update1 :
    (a1 -> a1)
    -> Record a1 a2 a3
    -> Record a1 a2 a3
update1 fn record =
    { a1 = fn record.a1
    , a2 = record.a2
    , a3 = record.a3
    }


get2 :
    Record a1 a2 a3
    -> a2
get2 =
    .a2


set2 :
    a2
    -> Record a1 a2 a3
    -> Record a1 a2 a3
set2 a2 record =
    { a1 = record.a1
    , a2 = a2
    , a3 = record.a3
    }


update2 :
    (a2 -> a2)
    -> Record a1 a2 a3
    -> Record a1 a2 a3
update2 fn record =
    { a1 = record.a1
    , a2 = fn record.a2
    , a3 = record.a3
    }


get3 :
    Record a1 a2 a3
    -> a3
get3 =
    .a3


set3 :
    a3
    -> Record a1 a2 a3
    -> Record a1 a2 a3
set3 a3 record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = a3
    }


update3 :
    (a3 -> a3)
    -> Record a1 a2 a3
    -> Record a1 a2 a3
update3 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = fn record.a3
    }
