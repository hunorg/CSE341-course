module LectureNotes.ListsAndOptionsAreDatatypes exposing (..)

{- Recursive datatypes

   Datatype bindings can describe recursive structures
     - Have seen arithmetic expression
     - Now, linked lists:
-}


type MyIntList
    = Empty
    | Cons ( Int, MyIntList )


l : MyIntList
l =
    Cons ( 4, Cons ( 23, Cons ( 2008, Empty ) ) )


appendMyList : MyIntList -> MyIntList -> MyIntList
appendMyList xs ys =
    case xs of
        Empty ->
            ys

        Cons ( x, xs_ ) ->
            Cons ( x, appendMyList xs_ ys )



{- Options are datatypes

   Options are just a predefined datatype binding
     - Nothing and Just are constructors, not just functions
     - So use pattern-matching
-}


incOrZero : Maybe number -> number
incOrZero maybeInt =
    case maybeInt of
        Nothing ->
            0

        Just i ->
            i + 1



{- Lists are datatypes

   Do not use List.head, List.tail or List.isEmpty either
     - [] and :: are constructors too
     - (strange syntax, particularly infix)
-}


sumList : List number -> number
sumList xs =
    case xs of
        [] ->
            0

        x :: xs_ ->
            x + sumList xs_


append : List a -> List a -> List a
append xs ys =
    case xs of
        [] ->
            ys

        x :: xs_ ->
            x :: append xs_ ys
