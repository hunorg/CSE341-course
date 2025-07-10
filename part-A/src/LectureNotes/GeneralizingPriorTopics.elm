module LectureNotes.GeneralizingPriorTopics exposing (..)

{- Generalizing

   Our examples of first-class functions so far have all:
     - Taken one function as an argument to another function
     - Processed a number or a list

   But first-class functions are useful anywhere for any kind of data
     - Can pass several functions as arguments
     - Can put functions in data structures (tuples, lists, etc.)
     - Can return functions as results
     - Can write higher-order functions that traverse your own data structures

   Useful whenever you want to abstract over "what to compute with"
     - No new language features
-}

import LectureNotes.UsefulDatatypes exposing (Exp(..))



-- Returning a function


doubleOrTriple : (number -> Bool) -> number -> number
doubleOrTriple f =
    if f 7 then
        \x -> 2 * x

    else
        \x -> 3 * x


double : number -> number
double =
    doubleOrTriple (\x -> x - 3 == 4)


nine : number
nine =
    doubleOrTriple (\x -> x == 42) 3



{- Other data structures

   • Higher-order functions are not just for numbers and lists

   • They work great for common recursive traversals over your own
     data structures (datatype bindings) too

   • Example of a higher-order predicate:

     - Are all constants in an arithmetic expression even numbers?
     - Use a more general function of type (int -> Bool) -> Exp -> Bool
     - And call it with (\x -> modBy 2 x == 0)
-}
-- Higher-order functions over our own datatype bindings


type Exp
    = Constant Int
    | Negate Exp
    | Add Exp Exp
    | Multiply Exp Exp



-- given an exp, is every constant in it an even number?


trueOfAllConstants : (Int -> Bool) -> Exp -> Bool
trueOfAllConstants f e =
    case e of
        Constant i ->
            f i

        Negate e1 ->
            trueOfAllConstants f e1

        Add e1 e2 ->
            trueOfAllConstants f e1 && trueOfAllConstants f e2

        Multiply e1 e2 ->
            trueOfAllConstants f e1 && trueOfAllConstants f e2


allEven : Exp -> Bool
allEven e =
    trueOfAllConstants (\x -> modBy 2 x == 0) e



-- given an exp, is every constant in it larger than 10?


allLargerThan10 : Exp -> Bool
allLargerThan10 =
    trueOfAllConstants (\x -> x > 10)
