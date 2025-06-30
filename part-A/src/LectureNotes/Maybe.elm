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



{-
   RECURSION UNFOLDED: MAX1 EXECUTION VISUALIZATION

   1. EXECUTION FLOW FOR [3,7,5]

      DOWNWARD PHASE (Problem Decomposition)
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

      UPWARD PHASE (Solution Composition)
      • max1 [5] resumes with tlAns = Nothing
           → Returns: Just 5
      • max1 [7,5] resumes with tlAns = Just 5
           → Returns: Just 7 (5 > 7? False)
      • max1 [3,7,5] resumes with tlAns = Just 7
           → Returns: Just 7 (7 > 3? True)

   2. UNIVERSAL RECURSION PRINCIPLES

      All recursive functions follow this pattern:
      • Base Case: Solve smallest problem directly
           (max1: [] → Nothing)
      • Recursive Case:
           1. Decompose: Break into smaller subproblem
                 (max1: split list → head + tail)
           2. Recurse: Solve subproblem → pauses current
           3. Recompose: Combine using problem-specific logic
                 (max1: select larger of head and tail's max)

   3. KEY MECHANISMS
      • Pause/Resume: Call stack manages execution flow
      • Problem Reduction: Input shrinks toward base case
           [3,7,5] → [7,5] → [5] → []
      • Solution Construction: Results build upward
           Nothing → Just 5 → Just 7 → Just 7

   4. RECURSION ESSENCE
      Downward: Problem decomposition
      Upward: Solution composition
      Core: Base Case + (Decompose → Recurse → Recompose)
-}
