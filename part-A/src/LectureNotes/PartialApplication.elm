module LectureNotes.PartialApplication exposing (..)

{- "Too Few Arguments"

   • Previously used currying to simulate multiple arguments

   • But if caller provides "too few" arguments, we get back a closure
     " waiting for the remaining arguments"
       - Called partial application
       - Convenient and useful
       - Can be done with any curried function

   • No new semantics here: a pleasent idiom
-}


sorted3 : comparable -> comparable -> comparable -> Bool
sorted3 x y z =
    x <= y && y <= z


fold : (a -> b -> a) -> a -> List b -> a
fold f acc xs =
    case xs of
        [] ->
            acc

        x :: xs_ ->
            fold f (f acc x) xs_


isNonNegative : number -> Bool
isNonNegative =
    sorted3 0 0


sum : List number -> number
sum =
    fold (\x y -> x + y) 0



-- These below are unnecessary function wrapping


isNonNegativeInferior : number -> Bool
isNonNegativeInferior x =
    sorted3 0 0 x


sumInferior : List number -> number
sumInferior xs =
    fold (\x y -> x + y) 0 xs


range : number -> number -> List number
range i j =
    if i > j then
        []

    else
        i :: range (i + 1) j


countup : number -> List number
countup =
    range 1



-- countup 6 [1, 2, 3, 4, 5, 6]


countupInferior : number -> List number
countupInferior x =
    range 1 x


exists : (a -> Bool) -> List a -> Bool
exists predicate xs =
    case xs of
        [] ->
            False

        x :: xs_ ->
            predicate x || exists predicate xs_


no : Bool
no =
    exists (\x -> x == 7) [ 4, 11, 23 ]


hasZero : List number -> Bool
hasZero =
    exists (\x -> x == 0)


inrementAll : List number -> List number
inrementAll =
    List.map (\x -> x + 1)


removeZeros : List number -> List number
removeZeros =
    List.filter (\x -> x /= 0)
