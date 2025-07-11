module LectureNotes.ClojureIdiomCombiningFunctions exposing (..)


compose : (a -> b) -> (c -> a) -> c -> b
compose f g =
    \x -> f (g x)


compose2 : (a -> b) -> (c -> a) -> c -> b
compose2 f g =
    f << g


sqrtOfAbs : Int -> Float
sqrtOfAbs i =
    sqrt (toFloat (abs i))


sqrtOfAbs2 : Int -> Float
sqrtOfAbs2 i =
    sqrt <| toFloat <| abs <| i


sqrtOfAbs3 : Int -> Float
sqrtOfAbs3 =
    sqrt << toFloat << abs


sqrtOfAbs4 : Int -> Float
sqrtOfAbs4 i =
    i |> abs |> toFloat |> sqrt


sqrtOfAbs5 : Int -> Float
sqrtOfAbs5 =
    abs >> toFloat >> sqrt


backup1 : (a -> Maybe b) -> (a -> b) -> a -> b
backup1 f g =
    \x ->
        case f x of
            Just y ->
                y

            Nothing ->
                g x
