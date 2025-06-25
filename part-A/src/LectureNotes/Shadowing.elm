module LectureNotes.Shadowing exposing (..)


a : number
a =
    10



-- a : number, a -> 10


b : number
b =
    a * 2



-- a -> 10, b -> 20
{-

   a : number
   a =
       5



   - a is now shadowed, there'll be a name clash error
-}


c : number
c =
    b



-- a -> 10, b -> 20, c -> 20


d : number
d =
    a



-- ..., d -> 10 - a is no longer shadowed


f : number
f =
    a * 2



-- ..., f -> 20 - a is no longer shadowed
{- In Elm and other pure functional languages:

   • Variables are immutable — once you bind a value to a variable,
     you cannot assign a new value to it.

   • There is no way to "assign to" a variable.
-}
