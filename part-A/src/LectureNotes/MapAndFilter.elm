module LectureNotes.MapAndFilter exposing (..)


map : (a -> b) -> List a -> List b
map f xs =
    case xs of
        [] ->
            []

        x :: xs_ ->
            f x :: map f xs_


x1 : List number
x1 =
    map (\x -> x + 1) [ 4, 8, 12, 16 ]


x2 : List (Maybe number)
x2 =
    map List.head [ [ 1, 2 ], [ 3, 4 ], [ 5, 6, 7 ] ]



{- Map is, without doubt, in the "higher-order function hall-of-fame"
   - The name is standard (for any data structure)
   - You use it all the time once you know it: saves a little space,
     but more importantly, communicates what you are doing
-}


filter : (a -> Bool) -> List a -> List a
filter f xs =
    case xs of
        [] ->
            []

        x :: xs_ ->
            if f x then
                x :: filter f xs_

            else
                filter f xs_


isEven : Int -> Bool
isEven v =
    modBy 2 v == 0


allEven : List Int -> List Int
allEven xs =
    filter isEven xs


allEvenSecond : List ( a, Int ) -> List ( a, Int )
allEvenSecond xs =
    filter (\( _, v ) -> isEven v) xs



{- Filter is also in the hall-of-fame
   - So use it whenever your computation is a filter
-}
