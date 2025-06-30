module LectureNotes.LetAndEfficiency exposing (..)

-- badly named: evaluates to 0 on empty list


badMax : List Int -> Int
badMax xs =
    case xs of
        [] ->
            -- horrible style to use 0 here, we'll fix it later
            0

        [ x ] ->
            x

        x :: rest ->
            if x > badMax rest then
                x

            else
                badMax rest


goodMax : List Int -> Int
goodMax xs =
    case xs of
        [] ->
            -- horrible style to use 0 here, we'll fix it later
            0

        [ x ] ->
            x

        x :: rest ->
            let
                tailMax =
                    goodMax rest
            in
            if x > tailMax then
                x

            else
                tailMax


countUp : number -> number -> List number
countUp from to =
    if from == to then
        [ to ]

    else
        from :: countUp (from + 1) to


countDown : number -> number -> List number
countDown from to =
    if from == to then
        [ to ]

    else
        from :: countDown (from - 1) to



{- Avoiding repeated recursion with `let`

   - Recursive functions should avoid computing the same result more than once
   - In eager ML-like languages (ML, Elm), repeated recursive calls cause exponential slowdown
   - Example: `badMax` calls itself twice on the same sublist
     - Leads to O(2ⁿ) time complexity
     - 30 elements → ~1 billion operations
     - 50 elements → years of computation

   - Solution: use a `let` binding to remember the recursive result
       - Avoids redundant computation
       - Transforms exponential O(2ⁿ) → efficient linear O(n)
       - Essential for recursion in functional programming

   - This pattern is a common and important use of `let` expressions
-}
