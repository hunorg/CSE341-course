module LectureNotes.ClosureIdiomCurrying exposing (..)

{- Currying

   • Recall every Elm function takes exactly one argument

   • Instead of encoding n arguments via n-tuple, we take one argument
     and return a function that takes another argument, and so on...
       - Called "currying" after famous logician Haskell Curry
-}


sorted3Tupled : ( Int, Int, Int ) -> Bool
sorted3Tupled ( x, y, z ) =
    x <= y && y <= z


t1 : Bool
t1 =
    sorted3Tupled ( 7, 9, 11 )



-- Curried version:


sorted3 : comparable -> comparable -> comparable -> Bool
sorted3 =
    \x -> \y -> \z -> x <= y && y <= z



-- same as sorted3 x = \y -> \z -> x <= y && y <= z
{- Example

   sorted3 = \x -> \y -> \z -> x <= y && y <= z
   t1 = ((sorted3 7) 9) 11

   • Calling (sorted3 7) returns a closure with:
     - Code \y -> \z -> x <= y && y <= z
     - Environment maps x to 7

   • Calling that closure with 9 returns a closure with:
   - Code \z -> x <= y && y <= z
   - Environment maps x to 7 and y to 9

   • Calling that closure with 11 returns True
-}
{- Syntactic sugar, part 1

   • In general, e1 e2 e3 e4 ..., means (... ((e1 e2) e3) e4)
   • So, sorted3 7 9 11 means (((sorted3 7) 9) 11)
   • Callers can just think "multi-argument function with spaces instead
     of a tuple expression"
       - Different than tupling; caller and callee must use same technique
-}


sorted3Nicer : comparable -> comparable -> comparable -> Bool
sorted3Nicer x y z =
    x <= y && y <= z


t2 : Bool
t2 =
    sorted3Nicer 7 9 11



{- Syntactic sugar, part 2

   • In general, f p1 p2 p3 ... = e means f p1 = \p2 -> \p3 -> ... -> e

   • So, instead of sorted3 = \x -> \y -> \z -> ... or
     sorted3 x = \y -> \z -> ..., we can just write sorted3  x y z = ...

   • Callees can just think "multi-argument function with sapces instead of
     a tuple pattern"
       - Different than tupling: caller and callee must use same technique
-}
-- A more useful example:


fold : (a -> b -> a) -> a -> List b -> a
fold f acc xs =
    case xs of
        [] ->
            acc

        x :: xs_ ->
            fold f (f acc x) xs_


sum : List number -> number
sum xs =
    fold (\x y -> x + y) 0 xs
