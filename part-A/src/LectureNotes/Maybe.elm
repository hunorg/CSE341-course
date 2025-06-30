module LectureNotes.Maybe exposing (..)

{- Maybe:
   • Maybe t is a type for any type t
     - (much like List t, but a different type, not a list)

   • Building:
     - Nothing has type Maybe a (much like [] has type List a)
     - Just e has type Maybe t if e has type t (much like e :: xs)

    • Accessing:
     - case expression:
         case maybeVal of
             Just x  -> ...  -- use x
             Nothing -> ...  -- handle absence

     - Maybe.withDefault : a -> Maybe a -> a
         -- returns value inside Just, or `default` if Nothing

     - Maybe.map : (a -> b) -> Maybe a -> Maybe b
         -- applies f to the value inside Just, else returns Nothing

     - Maybe.andThen : (a -> Maybe b) -> Maybe a -> Maybe b
         -- Chains operations that may fail:
         -- If the input is Just x, applies the function to x, returning a new Maybe.
         -- If the input is Nothing, returns Nothing without calling the function.
         -- example:  Maybe.andThen (\s -> Just (String.toUpper s)) (Just "hi") returns Just "HI"
-}


max1 : List Int -> Maybe Int
max1 xs =
    case xs of
        [] ->
            Nothing

        hd :: tl ->
            let
                tlAns =
                    max1 tl
            in
            case tlAns of
                Just val ->
                    if val > hd then
                        tlAns

                    else
                        Just hd

                Nothing ->
                    Just hd



{- RECURSION UNFOLDED: MAX1 EXECUTION VISUALIZATION

   Input: max1 [3,7,5]

   1.  CALL STACK BUILDING (Downward Descent)
       • max1 [3,7,5]
       hd = 3, tl = [7,5]
       → Pauses: needs max1 [7,5]
       • max1 [7,5]
       hd = 7, tl = [5]
       → Pauses: needs max1 [5]
       • max1 [5]
       hd = 5, tl = []
       → Pauses: needs max1 []
       • max1 []
       → Returns: Nothing

   2.  SOLUTION BUILDING (Upward Ascent)
       • max1 [5] resumes with tlAns = Nothing
       → Returns: Just 5
       • max1 [7,5] resumes with tlAns = Just 5
       → Compares: 5 > 7? False → returns Just 7
       • max1 [3,7,5] resumes with tlAns = Just 7
       → Compares: 7 > 3? True → returns Just 7

   3. UNIVERSAL RECURSION MECHANICS
   • Pause: Each call waits for its subproblem's solution
   • Resume: Each call completes using the sub-solution
   • Base case: Provides the initial solution
   • Recompose: Apply problem-specific combinator
        current-state ⊗ sub-solution → new-solution

   4.  DATA TRANSFORMATION
       Problem size: [3,7,5] → [7,5] → [5] → []
       Solutions: Nothing ← Just 5 ← Just 7 ← Just 7

   Key: Recursion =
   • Downward: Problem decomposition
   • Upward: Solution composition

-}
