module LectureNotes.TailRecursion exposing (..)

{- Recursion

   Should now be comfortable with recursion:
   • No harder than using a look (whatever that is)
   • Often much easier than a loop
     - When processing a tree (e.g., evaluate an arithmetic expression)
     - Examples like appending lists
     - Avoids mutation even for local variables

   • Now:
     - How to reason about efficiency of recursion
     - The importance of tail recursion
     - Using an accumulator to achieve tail recursion
       [ No new language features here]
-}
{- Call-stacks

   While a program runs, there is a call stack of function calls that
   have started but not yet returned
     - Calling a function f pushes an instance of f on the stack
     - When a call to f finishes, it is popped from the stack

   These stack-frames store information like the value of local
   variables and "what is left to do" in the function

   Due to recursion, multiple stack-frames may be calls to the same function

   Example:
     fact n =
        if n == 0 then
            1
        else
            n * fact (n - 1)
     val x = fact 3

     fact 3 | fact 3: 3 * _ | fact 3: 3 * _ | fact 3: 3 * _
            | fact 2        | fact 2: 2 * _ | fact 2: 2 * _
                            | fact 1        | fact 1: 1 * _
                                            | fact 0

    fact 3: 3 * _ | fact 3: 3 * _ | fact 3: 3 * _ | fact 3: 3 * 2
    fact 2: 2 * _ | fact 2: 2 * _ | fact 2: 2 * 1 |
    fact 1: 1 * _ | fact 1: 1 * 1 |
    fact 0: 1     |
-}
-- Example Revised


fact : number -> number
fact n =
    let
        aux remaining acc =
            if remaining == 0 then
                acc

            else
                aux (remaining - 1) (acc * remaining)
    in
    aux n 1



-- fact 3 | aux 3 1 | aux 2 3 | aux 1 6 | aux 0 6
{- An optimization

   It is unnecessary to keep around a stack-frame just so it can get a
   callee's result and return it without any further evaluation

   ML recognizes these tail calls in the compiler and treats them
   differently:
     - Pop the caller before the call, allowing callee to reuse the
       samestack space
     - (Along with other optimizations,) as efficient as a loop

   Reasonable to assume all functional-language implementations do
   tail-call optimization
-}
{- Moral of tail recursion

   • Where reasonably elegant, feasible, and important, rewriting
   • functions to be tail-recursive can be much more efficient
     - Tail-recursive: recursive call are tail-calls
        Tail call = A function call that happens as the last action before return
        It’s called “tail” because it sits at the tail (end) of the function

   • There is a methodology that can often guide this transformation:
     - Create a helper function that takes an accumulator
     - Old base case becomes initial accumulator
     - New base case becomes final accumulator
-}


sum : List number -> number
sum xs =
    case xs of
        [] ->
            0

        x :: xs_ ->
            x + sum xs_


sum2 : List number -> number
sum2 xs =
    let
        aux remaining acc =
            case remaining of
                [] ->
                    acc

                x :: xs_ ->
                    aux xs_ (x + acc)
    in
    aux xs 0


reverse : List a -> List a
reverse list =
    case list of
        [] ->
            []

        x :: xs ->
            reverse xs ++ [ x ]


reverse2 : List a -> List a
reverse2 list =
    let
        aux remaining acc =
            case remaining of
                [] ->
                    acc

                x :: xs ->
                    aux xs (x :: acc)
    in
    aux list []



{- Always tail-recursive?

   There are certainly cases where recursive functions cannot be
   evaluated in a constant amount of space

   Most obvious examples are functions that process trees

   In these cases, the natural recursive approach is the way to go
     - You could get one recursive call to be a tail call, but rarely
       worth the complication

   Also beware the wrath of premature optimization
     - Favor clear, concise code
     - But do use less space if inputs may be large
-}
