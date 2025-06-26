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



{- max1 [3, 7, 5]
   ├─ hd = 3, tl = [7, 5]
   ├─ tlAns = max1 [7, 5]     <-- recursive call
   │
   │  max1 [7, 5]
   │    ├─ hd = 7, tl = [5]
   │    ├─ tlAns = max1 [5]   <-- recursive call
   │    │
   │    │  max1 [5]
   │    │    ├─ hd = 5, tl = []
   │    │    ├─ tlAns = max1 []  <-- recursive call
   │    │    │
   │    │    │  max1 [] = Nothing  (base case)
   │    │    │
   │    │    ├─ tlAns = Nothing
   │    │    └─ returns Just 5  (since tail is empty)
   │    │
   │    ├─ tlAns = Just 5
   │    ├─ Compare hd (7) and val inside tlAns (5)
   │    └─ 7 > 5 → return Just 7
   │
   ├─ tlAns = Just 7
   ├─ Compare hd (3) and val inside tlAns (7)
   └─ 7 > 3 → return Just 7  (final result)
-}
