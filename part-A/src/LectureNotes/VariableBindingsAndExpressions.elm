module LectureNotes.VariableBindingsAndExpressions exposing (..)

-- this is a comment, this is our first program


x : number
x =
    34



-- static environment: x : number
-- dynamic environment: x -> 34


y : number
y =
    17



-- static environment: x : number, y : number
-- dynamic environment: x -> 34, y -> 17


z : number
z =
    (x + y) + (y + 2)



-- static environment: x : number, y : number, z : number
-- dynamic environment: x -> 34, y -> 17, z -> 70


q : number
q =
    z + 1



-- static environment: x : number, y : number, z : number, q : number
-- dynamic environment: x -> 34, y -> 17, z -> 70, q -> 71


absOfZ : number
absOfZ =
    if z < 0 then
        0 - z

    else
        z



-- static environment: x : number, y : number, z : number, q : number, absOfZ : number
-- dynamic environment: x -> 34, y -> 17, z -> 70, q -> 71, absOfZ -> 70


absOfZSimpler : number
absOfZSimpler =
    abs z



-- Syntax is how we write things; semantics is what they mean
-- Type-checking happens before runtime
-- Evaluation happens at runtime
-- For variable bindings:
-- • Type-check the expression and extend the static environment
-- • Evaluate the expression and extend the dynamic environment
{- Expressions:

   We have seen many kinds of expressions: `34`, `True`, `False`, `x`, `e1 + e2`, `if e1 then e2 else e3`, ...

   • Expressions can be arbitrarily large, since subexpressions can nest indefinitely.

   • Every kind of expression has:
     1. Syntax
     2. Type-checking rules
        - Produces a type or fails (error message)
        - Types so far: number, bool, unit
     3. Evaluation rules (only used if type-checking succeeds)
        - Produces a value
-}
{- Variables:

   • Syntax:
     - A sequence of letters, digits, or underscores, but not starting with a digit

   • Type-checking:
     - Look up the variable's type in the static environment
     - If not found, produce an error

   • Evaluation:
     - Look up the variable's value in the dynamic environment
-}
{- Addition:

   • Syntax:
     e1 + e2, where e1 and e2 are expressions

   • Type-checking:
     - If both e1 and e2 have type number, then e1 + e2 also has type number

   • Evaluation:
     - If e1 evaluates to v1 and e2 evaluates to v2,
       then e1 + e2 evaluates to the sum of v1 and v2
-}
{- Values:

   • All values are expressions — but not all expressions are values

   • Every value evaluates to itself in "zero steps"
-}
{- Conditional expressions:

   • Syntax:
     if e1 then e2 else e3
     - `if`, `then`, and `else` are keywords
     - e1, e2, and e3 are subexpressions

   • Type-checking:
     - e1 must have type bool
     - e2 and e3 must have the same type (call it t)
     - The entire expression has type t

   • Evaluation:
     - Evaluate e1 to v1
     - If v1 is True, evaluate e2 to v2 → result is v2
     - If v1 is False, evaluate e3 to v3 → result is v3
-}
{- Less-than expressions:

   • Syntax:
     e1 < e2, where e1 and e2 are expressions; `<` is a keyword

   • Type-checking:
     - If e1 and e2 are both numbers, then e1 < e2 has type bool

   • Evaluation:
     - Evaluate e1 to v1 and e2 to v2
     - e1 < e2 evaluates to:
         - True if v1 < v2
         - False otherwise
-}
