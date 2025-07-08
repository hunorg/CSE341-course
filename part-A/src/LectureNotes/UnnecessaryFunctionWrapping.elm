module LectureNotes.UnnecessaryFunctionWrapping exposing (..)


rev1 : List a -> List a
rev1 xs =
    List.reverse xs


rev2 : List a -> List a
rev2 =
    \xs -> List.reverse xs


rev3 : List a -> List a
rev3 =
    List.reverse



{- Unnecessary function wrapping is when you define a function
   that does nothing except call another function with the same argument.

   Examples include:
     rev1 xs = List.reverse xs
     rev2    = \xs -> List.reverse xs

   Both are redundant when you could just write:
     rev3    = List.reverse

   It's cleaner, avoids pointless indirection, and makes intent clearer.
   This applies whether you're using anonymous functions or named definitions.
-}
