module LectureNotes.BooleansAndComparisonOperations exposing (..)

{- Boolean operations:
   -- e1 && e2
   • Type-checking: e1 and e2 must have type Bool
   • Evaluation: If result of e1 is false then false else result of e2
   -- e1 || e2
   • Type-checking: e1 and e2 must have type Bool
   • Evaluation: If result of e1 is true then true else result of e2
   -- not e
   • Type-checking: e must have type Bool
   • Evaluation: If result of e is true then false else true

   • "Short-circuiting" evaluation means && and || only evaluate as far as necessary,
   so they are keywords that are not functions, not is just a pre-defined function
-}
{- If a programming language has if then else expressions, it doesn't need &&, || and not
   - but using more concise forms is generally better style
-}


e1 : Bool
e1 =
    1 > 0


e2 : Bool
e2 =
    1 < 0



-- e1 && e2


x1 : Bool
x1 =
    if e1 then
        e2

    else
        False



-- e1 || e2


x2 : Bool
x2 =
    if e1 then
        True

    else
        e2



-- not e1


x3 : Bool
x3 =
    if e1 then
        False

    else
        True



{- NEVER do this: if e then true else false
   -> just say e !!!
-}
{- Numeric Comparisons (Int, Float)
   >  : Greater than             (3 > 2 → True)
   <  : Less than                (2 < 3 → True)
   >= : Greater than or equal    (3 >= 3 → True)
   <= : Less than or equal       (2 <= 3 → True)
   == : Equal                    (3 == 3 → True)
   /= : Not equal                (3 /= 2 → True)

   -- String Comparisons (Lexicographic order)
   "apple" < "banana" → True
   "cat" == "dog" → False

   -- Float Equality Caution
   Avoid == with Floats due to precision issues:
   (0.1 + 0.2) == 0.3 → False (!)
   Use tolerance checks instead:
   abs (0.1 + 0.2 - 0.3) < 1.0e-10 → True
-}
