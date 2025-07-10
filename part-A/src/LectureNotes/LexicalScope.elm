module LectureNotes.LexicalScope exposing (..)

{- Lexical Scope Fundamentals

   • Functions can use bindings in scope
   • With first-class functions: environment = where function was DEFINED (not called)
   • Semantics called lexical scope
   • Crucial for homework, exams, and competent programming
-}
{- Function Closures

   • Function value = pair containing:
       1. The code
       2. Environment at definition time
       • Called a function closure
       • Call = evaluate code in captured environment (extended with arguments)
-}
{- Avoiding Recomputation with Closures

   • Lexical scope enables performance optimization:
       1. Compute invariant values ONCE at closure creation
       2. Store them in closure's environment
       3. Reuse stored values on every call

   • Example:
-}


optimizedFilter : List String -> String -> List String
optimizedFilter strings baseString =
    let
        -- Computed ONCE
        baseLen =
            String.length baseString
    in
    -- Reused via closure
    List.filter (\s -> String.length s < baseLen) strings



{- vs unoptimized (recomputes for every element):
   List.filter (\s -> String.length s < String.length baseString) strings
-}
{- Lexical Scope vs. Shadowing (Elm/ML Differences)

   • Elm: No shadowing → lexical scope is simpler (unique bindings)
   • ML: Shadowing allowed → lexical scope preserves original bindings
   • Ensures predictable behavior regardless of later redefinitions
-}
{- Why Lexical Scope Matters

   • vs. dynamic scope (call-site environment)
   • Renaming safety: Local variable names don't affect behavior
   • Unused variables can be safely removed
   • Type checking/reasoning at definition site
   • Enables powerful closure patterns (data storage in environment)
   • Avoids unnecessary recomputation (as shown above)
   • Standard in modern languages despite rare dynamic scope use cases
-}
