module LectureNotes.ListFunctions exposing (..)

import LectureNotes.VariableBindingsAndExpressions exposing (x)



-- SEE LECTURE NOTE ListsAndOptionsAreDatatypes AND
-- OTHER PATTERN MATCHING RELATED NOTES


sumList : List number -> number
sumList xs =
    case xs of
        [] ->
            0

        hd :: tl ->
            hd + sumList tl


listProduct : List number -> number
listProduct xs =
    case xs of
        [] ->
            1

        hd :: tl ->
            hd * listProduct tl


countdown : Int -> List Int
countdown x =
    if x == 0 then
        []

    else
        x :: countdown (x - 1)


append : List a -> List a -> List a
append xs ys =
    case xs of
        [] ->
            ys

        hdxs :: tlxs ->
            hdxs :: append tlxs ys


sumPairList : List ( number, number ) -> number
sumPairList xs =
    case xs of
        [] ->
            0

        ( hdxs1, hdxs2 ) :: tlxs ->
            hdxs1 + hdxs2 + sumPairList tlxs


firsts : List ( a, b ) -> List a
firsts xs =
    case xs of
        [] ->
            []

        ( hdxs1, _ ) :: tlxs ->
            hdxs1 :: firsts tlxs


seconds : List ( a, b ) -> List b
seconds xs =
    case xs of
        [] ->
            []

        ( _, hdxs2 ) :: tlxs ->
            hdxs2 :: seconds tlxs


sumPairList2 : List ( number, number ) -> number
sumPairList2 xs =
    sumList (firsts xs) + sumList (seconds xs)


factorial : Int -> Int
factorial n =
    listProduct (countdown n)



{- Recursion: again

   • Functions over lists are usually recursive
     - Only way to "get to all the elements"

   • What should the answer be for the empty list?
   • What should the answer be for a non-empty list?
     - Typically in terms of the answer for the tail of the list!

   • Similarly, functions that produce lists of potentially any size will be recursive
     - You create a list out of smaller lists
-}
