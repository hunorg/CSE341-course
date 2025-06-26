module LectureNotes.Lists exposing (..)

-- Despite nested tuples, the type of a variable still "commits" to a particular "amount" of data
-- In contrast, a list:
-- • Can contain any number of elements
-- • But all elements must have the same type
-- Need ways to build lists and access the pieces...
{- Building Lists:
   • The empty list is a value: []
   • In general, a list of values is a value; elements separated by commas:
    [v1, v2, v3, ...]
   • If e1 evaluates to v and e2 evaluates to a list [v1,..., vn],
   then e1::e2 evaluates to [v, ..., vn]
      e1 :: e2 - pronounced "cons"
-}


x1 : List a
x1 =
    []


x2 : List number
x2 =
    [ 3, 4, 5 ]


x3 : List number
x3 =
    [ 1 + 2, 3 + 4, 5 ]


x4 : List Bool
x4 =
    [ True, False, True ]


x5 : List number
x5 =
    5 :: x1


x6 : List number
x6 =
    6 :: 5 :: x2


x7 : List (List number)
x7 =
    [ 6 ] :: [ [ 7, 5 ], [ 5, 2 ] ]



{- Accessing Lists:
   • Until we learn pattern-matching, we will use three standard library functions
     - List.isEmpty e evaluates to True if and only if e evaluates to []
     - If e evaluates to [v1, ..., vn], then List.head e evaluates to v1
     - If e evaluates to [v1, ..., vn], then List.tail e evaluates to [v2, ..., vn]
   • In Elm, List.head and List.tail return a Maybe to handle the case of an empty input list safely
-}


x8 : Bool
x8 =
    List.isEmpty [ 1, 2 ]



-- False


x9 : Maybe number
x9 =
    List.head [ 42, 99 ]



-- Just 42


x10 : Maybe number
x10 =
    List.head [ 5 ]



-- Just 5


x11 : Maybe number
x11 =
    List.head []



-- Nothing


x12 : Maybe (List number)
x12 =
    List.tail [ 42, 99 ]



-- Just [ 99 ]


x13 : Maybe (List number)
x13 =
    List.tail [ 5 ]



-- Just []


x14 : Maybe (List number)
x14 =
    List.tail []



-- Nothing
{- Type-checking list operations:
   • Lots of new types: For any type t, the type List t describes lists
     where all elements are of type t
     - Examples: List Int, List Bool, List (List Int)
   • So [] can have type List t for any type
     - Elm uses type List a to indicate this ("quote a" or "alpha")
   • For e1 :: e2 to type-check, we need a t such that e1 has type t
     and e2 has type List t. Then the result type is List t
   • List.isEmpty : List a -> Bool
   • List.head : List a -> Maybe a
   • List.tail : List a -> Maybe (List a)
-}
