module LectureNotes.UsefulDatatypes exposing (..)

import Hw.Hw2 exposing (Suit(..))



-- Enumerations, including carrying other data


type Suit
    = Club
    | Diamond
    | Heart
    | Spade


type Rank
    = Jack
    | Queen
    | King
    | Ace
    | Num Int



-- Alternate ways of identifying real-world things/people


type Id
    = StudentNum Int
    | Name String (Maybe String) String



{- Don't do this

   Unfortunately, bad training and languages that make one-of types inconvenient
   lead to common bad style where each-of types are used where one-of types
   are the right tool

   -- use the studentNum and ignore other fields unless
   the studentNum is -1

   { studentNum : Int
   , first : String
   , middle : Maybe String
   , last : String
   }

   Approach gives up all the benefits of the language enforcing
   every value is one variant, you don't forget branches, etc.

   And it makes it less clear what you are doing
-}
{- That said...

   But if instead, the point is that every "person" in your program has a
   name and maybe a student number, then each-of is the way to go:

   { studentNum : Maybe Int
   , first : String
   , middle : Maybe String
   , last : String
   }
-}
-- Expression Trees
-- A more exciting (?) example of a datatype, using self-reference


type Exp
    = Constant Int
    | Negate Exp
    | Add Exp Exp
    | Multiply Exp Exp



{- An expression in ML of type Exp:
      Add (Constant (10 + 9)) (Negate (Constant 4))

     How to picture the resulting value in your head:

         Add
        /   \
   Constant  Negate
     19         \
               Constant
                  4
-}
{- Recursion

   Not surprising:
     Functions over recursive datatypes are usually recursive
-}


eval : Exp -> Int
eval e =
    case e of
        Constant i ->
            i

        Negate e1 ->
            -(eval e1)

        Add e1 e2 ->
            eval e1 + eval e2

        Multiply e1 e2 ->
            eval e1 * eval e2


numberOfAdds : Exp -> number
numberOfAdds e =
    case e of
        Constant _ ->
            0

        Negate e1 ->
            numberOfAdds e1

        Add e1 e2 ->
            1 + numberOfAdds e1 + numberOfAdds e2

        Multiply e1 e2 ->
            numberOfAdds e1 + numberOfAdds e2


exampleExp : Exp
exampleExp =
    Add (Constant 19) (Negate (Constant 4))


exampleAns : Int
exampleAns =
    eval exampleExp


exampleAddCount : number
exampleAddCount =
    numberOfAdds (Multiply exampleExp exampleExp)
