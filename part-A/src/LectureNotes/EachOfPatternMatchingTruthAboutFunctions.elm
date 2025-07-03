module LectureNotes.EachOfPatternMatchingTruthAboutFunctions exposing (..)

{- Pattern Matching in Elm

   • In Elm, pattern matching works with:
       - Custom types (like in ML)
       - Tuples
       - Records (only shallow destructuring)

   • Tuple patterns:
       (x, y) = (1, 2)    -- x = 1, y = 2

   • Record patterns:
       { f1, f2 } = { f1 = "hello", f2 = 42 }    -- f1 = "hello", f2 = 42

   • You can use pattern matching in:
       - `let` bindings
       - `case` expressions
       - Function arguments

   • Every function in Elm still takes and returns exactly one argument,
     but that argument can be a tuple or a record, enabling multiple "inputs".

   • Note:
       - Elm supports only *flat* record destructuring, meaning you can match top-level fields by name.
       - Nested patterns inside records (e.g., `{ middle = Just m }`) are not allowed directly; you must match and handle nested values separately.


-}
-- Example (tuple pattern in function):


addPair : ( Int, Int ) -> Int
addPair ( x, y ) =
    x + y



-- Example (record pattern in function):


fullName : { first : String, last : String } -> String
fullName { first, last } =
    first ++ " " ++ last



-- Functions may look like they take multiple arguments, for example:


f : a -> b -> Bool
f x y =
    True



-- However, this is syntactic sugar for a function that takes one argument and returns another function:


f2 : a -> b -> Bool
f2 =
    \x -> \y -> True



-- This means f takes one argument x and returns a function that takes one argument y
-- This concept is known as currying, more on that later
