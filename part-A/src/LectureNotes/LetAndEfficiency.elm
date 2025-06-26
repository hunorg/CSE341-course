module LectureNotes.LetAndEfficiency exposing (..)

-- badly named: evaluates to 0 on empty list


badMax : List number -> number
badMax xs =
    case xs of
        [] ->
            0

        {- horrible style, fix later -}
        [ x ] ->
            x

        x :: y :: rest ->
            let
                tail =
                    y :: rest

                tailMax =
                    badMax tail
            in
            if x > tailMax then
                x

            else
                tailMax


goodMax : List number -> number
goodMax xs =
    case xs of
        [] ->
            0

        {- horrible style, fix later -}
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
   - In ML-like languages, repeated recursive calls can cause exponential slowdown
   - Example: `badMax` calls itself twice on the same sublist — slow in ML
   - In Elm, this isn't exponential (evaluation is eager), but still inefficient

   - Solution: use a `let` binding to remember the recursive result
       - Avoids redundant computation
       - Leads to better style and performance

   - This pattern is a common and important use of `let` expressions
-}
