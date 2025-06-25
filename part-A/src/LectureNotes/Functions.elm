module LectureNotes.Functions exposing (..)

-- works only if y >= 0


pow : number -> number -> number
pow x y =
    if y == 0 then
        1

    else
        x * pow x (y - 1)



{- pow 2 3
   → 2 * pow 2 2
   → 2 * (2 * pow 2 1)
   → 2 * (2 * (2 * pow 2 0))
   → 2 * (2 * (2 * 1))    -- base case
   → 2 * (2 * 2)
   → 2 * 4
   → 8
-}


cube : number -> number
cube x =
    pow x 3


sixtyfour : number
sixtyfour =
    cube 4


fortytwo : number
fortytwo =
    pow 2 (2 + 2) + pow 4 2 + cube 2 + 2



{- Function bindings: 3 questions

   • Syntax:
     x0 (x1 : t1) ... (xn : tn) = e
     - x0 is a variable name
     - x1, ..., xn are variable names
     - t1, ..., tn are types
     - e is an expression

   • Evaluation:
     - A function is a value! (No evaluation yet)
     - Adds x0 to the environment so later expressions can call it
     - Function-call semantics will also allow recursion

   • Type-checking:
     - Adds binding x0 : t1 -> ... -> tn -> t if:
         • The body e can be type-checked to have type t in the static environment containing:
             - The "enclosing" static environment (earlier bindings)
             - x1 : t1, ..., xn : tn (arguments with their types)
             - x0 : t1 -> ... -> tn -> t (for recursive calls)
-}
{- More on type-checking:

   • Function definition:
     x0 (x1 : t1) ... (xn : tn) = e

   • Introduces a new kind of type: t1 -> ... -> tn -> t
     - The result type appears on the right
     - The overall goal is to assign x0 this type for use in the rest of the program
     - Arguments can only be used within the body e (as expected)

   • Since evaluating a call to x0 returns the result of evaluating e,
     the return type of x0 must match the type of e

   • The type-checker "magically" figures out t — if such a t exists
-}
{- Function calls:

   • A new kind of expression: 3 questions

   • Syntax:
     e0 e1 ... en

   • Type-checking:
       - If:
           • e0 has type t1 -> ... -> tn -> t
           • e1 has type t1, ..., en has type tn
       - Then:
           • The expression e0 e1 ... en has type t
       - Example:
           pow (x, y - 1) in the previous example has type number

   • Evaluation:
       1. Under the current dynamic environment, evaluate e0 to a function f:
            x0 (x1 : t1) ... (xn : tn) = e
            (Since the call type-checked, the result will be a function)
       2. Under the current dynamic environment, evaluate arguments e1 to v1, ..., en to vn
       3. Result is the evaluation of e in an environment extended to map:
            x1 to v1, ..., xn to vn

          ("An environment" here means the one where the function was defined,
           and it includes x0 to support recursion)
-}
