module LectureNotes.CaseExpressions exposing (..)


type MyType
    = TwoInts Int Int
    | Str String
    | Pizza


f : MyType -> Int
f x =
    case x of
        TwoInts a b ->
            a + b

        Str s ->
            String.length s

        Pizza ->
            3



{- Pizza -> 4 (redundant case: error)
   fun g x = case x of Pizza -> 3 (missing cases: error)
-}
{- Case

   Elm combines the two aspects of accessing a one-of value with a
   case expression and pattern matching
     - Pattern matching much more general/powerful (soon!)
   Example: f

   • A multi-branch conditional to pick branch based on variant
   • Extracts data and binds to variables local to that branch
   • Type-checking: all branches must have same type
   • Evaluation: evaluate between case ... of and the right branch
-}
{- Patterns

   In general the syntax is:
    case e0 of
        p1 -> e1
        p2 -> e2
        ...
        pn -> en

    For today, each pattern is a constructor name followed by the right
    number of variables (i.e., c or c x or c x y or ...)
    • Syntactically most patterns (all today) look like expressions
    • But they are not expressions
      - We do not evaluate them
      - We see if the result of e0 matches them
-}
