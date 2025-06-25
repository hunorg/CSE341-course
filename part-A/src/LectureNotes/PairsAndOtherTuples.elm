module LectureNotes.PairsAndOtherTuples exposing (..)

-- Pairs (2-tuples)
-- Need a way to build pairs and access their components
{- Build:
   • Syntax: (e1, e2)
   - e1 and e2 are expressions
   • Type-checking: If e1 has type t1 and e2 has type t2,
     then (e1, e2) has type (t1, t2), a new kind of compound type
   • Evaluation: Evaluate e1 to v1 and e2 to v2; result is (v1, v2)
-}
-- Accessing Pairs in Elm vs. ML
{- In Standard ML:
   • Pairs (2-tuples) can be accessed positionally:
     - #1 (3, True)   → 3
     - #2 (3, True)   → True
   • #1 and #2 are built-in projection functions
-}
{- In Elm:
   • Elm does not support #1, #2, fst, or snd
   • There is no built-in syntax for positional access

   • Instead, Elm uses *pattern matching* to extract components of a pair
     - But at this point in the course, we have not yet covered pattern matching or `let` expressions
     - So for now, we must access parts of a pair inside a function via pattern matching in the parameter list

   • Syntax:
     - f : (t1, t2) -> t
     - f (x, y) = ...

   • Type-checking:
     - If the function receives a value of type (t1, t2), then x : t1 and y : t2

   • Evaluation:
     - When the function is called with a pair (v1, v2), x is bound to v1 and y to v2

   • Example:
     - first : (Int, Bool) -> Int
     - first (x, y) = x

     - second : (Int, Bool) -> Bool
     - second (x, y) = y
-}
{- Summary:
   • ML uses #1 and #2 to access tuple elements
   • Elm does not — access is only done by pattern matching
   • At this point, we use pattern matching *only* in function parameters
-}


swap : ( Int, Bool ) -> ( Bool, Int )
swap ( x, y ) =
    ( y, x )


sumTwoPairs : ( Int, Int ) -> ( Int, Int ) -> Int
sumTwoPairs ( x, y ) ( a, b ) =
    x + y + a + b


divMod : ( Int, Int ) -> ( Int, Int )
divMod ( x, y ) =
    ( x // y, modBy y x )


sortPair : ( Int, Int ) -> ( Int, Int )
sortPair ( x, y ) =
    if x < y then
        ( x, y )

    else
        ( y, x )



-- Actually, you can have tuples with more than two parts
--  • A generalization of pairs: (e1, e2, ..., en)
{- In Elm:
   • Tuples are fixed-size collections grouping values of possibly different types
   • Supported sizes: only 2- and 3-element tuples
   • Tuples with more than 3 elements are not allowed
   • For larger collections, prefer using records
   • Access tuple elements via pattern matching only
-}
{- Nesting
   • Pairs and tuples can be nested however you want
     - Not a new feature: implied by the syntax and semantics
-}


x1 : ( Int, ( Bool, Int ) )
x1 =
    ( 1, ( True, 2 ) )


x2 : ( ( Int, Int ), ( ( Int, Int ), ( Int, Int ) ) )
x2 =
    ( ( 1, 2 ), ( ( 3, 4 ), ( 5, 6 ) ) )
