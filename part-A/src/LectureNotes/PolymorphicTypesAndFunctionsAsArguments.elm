module LectureNotes.PolymorphicTypesAndFunctionsAsArguments exposing (..)

{- The key point

   • Higher-order functions are often so "generic" and "reusable" that
     they have polymorphic types, i.e., types with type variables

   • But there are higher-order functions that are not polymorphic

   • And there are non-higher-order (first-order) functions that are polymorphic

   • Always a good idea to understand the type of a function,
     especially a higher-order function
-}
-- Types


nTimes : (a -> a) -> number -> a -> a
nTimes f n x =
    if n == 0 then
        x

    else
        f (nTimes f (n - 1) x)



{- Simpler but less useful: nTimes : (Int -> Int) -> Int -> Int -> Int
   Type is inferred based on how arguments are used (later lecture)
     - Describes which types must be exactly something (e.g., Int) and
     - which can be anything but the same (e.g., a)
-}
