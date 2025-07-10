module LectureNotes.FoldAndMoreClosures exposing (..)

{- Another famous function: Fold

   fold (and synonyms/close relatives reduce, inject, etc.) is
   another very famous iterator over recursive structures

   Accumulates an answer by repeatedly applying f to answer so far

     - fold (f acc [x1, x2, x3, x4]) computes
     f (f (f (f acc x1) x2) x3) x4
-}

import LectureNotes.VariableBindingsAndExpressions exposing (y)


fold : (a -> b -> a) -> a -> List b -> a
fold f acc xs =
    case xs of
        [] ->
            acc

        x :: xs_ ->
            fold f (f acc x) xs_



-- This version "folds left"; another version "folds right"
-- Whether the direction matters depends on f (often not)
{- Why iterators again?

   • These "iterator-like" functions are not built into the language
      - Just a programming pattern
      - Though many languages have built-in support, which often
        allows stopping early without resorting to exceptions

   • This pattern separates recursive traversal from data processing
      - Can reuse same traversal for different data processing
      - Can reuse same data processing for different data structures
      - In both cases, using common vocabulary concisely
        communicates intent
-}


f1 : List number -> number
f1 xs =
    fold (+) 0 xs


f2 : List number -> Bool
f2 xs =
    fold (\x y -> x && y >= 0) True xs



-- are all numbers in the list non-negative?


f3 : List comparable -> comparable -> comparable -> number
f3 xs lo hi =
    fold
        (\x y ->
            x
                + (if y >= lo && y <= hi then
                    1

                   else
                    0
                  )
        )
        0
        xs



-- counting the number of elements between lo and hi, inclusive


f4 : List String -> String -> Bool
f4 xs s =
    let
        i =
            String.length s
    in
    fold (\x y -> x && String.length y < i) True xs



-- are all strings in the list shorter than the given string?


f5 : (a -> Bool) -> List a -> Bool
f5 g xs =
    fold (\x y -> x && g y) True xs



-- do all elements of the list produce True when passed to g?


f4Again : List String -> String -> Bool
f4Again xs s =
    let
        i =
            String.length s
    in
    f5 (\y -> String.length y < i) xs



{- Iterators made better

   • Functions like map, filter and fold are much morepowerful thanks
     to clojures and lexical scope

   • Function passed in can use any "private" data in its environment

   • Iterator "doesn't even know the data is there" or what type it has
-}
