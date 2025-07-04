module LectureNotes.NestedPatterns exposing (..)

{- Nested patterns

   • We can nest patterns as deep as we want
     - Just like we can nest expressions as deep as we want
     - Often avoids hard-to-read, wordy nested case expressions

   • So the full meaning of pattern-matching is to compare a pattern
     against a value for the "same shape" and bind variables to the
     "right parts"
       - More precise definition after examples
-}


zip3 : ( List a, List b, List c ) -> Maybe (List ( a, b, c ))
zip3 listTriple =
    case listTriple of
        ( [], [], [] ) ->
            Just []

        ( hd1 :: tl1, hd2 :: tl2, hd3 :: tl3 ) ->
            case zip3 ( tl1, tl2, tl3 ) of
                Just rest ->
                    Just (( hd1, hd2, hd3 ) :: rest)

                _ ->
                    Nothing

        _ ->
            Nothing


unzip3 : List ( a, b, c ) -> ( List a, List b, List c )
unzip3 lst =
    case lst of
        [] ->
            ( [], [], [] )

        ( a, b, c ) :: tl ->
            let
                ( l1, l2, l3 ) =
                    unzip3 tl
            in
            ( a :: l1, b :: l2, c :: l3 )


nonDecreasing : List Int -> Bool
nonDecreasing xs =
    case xs of
        [] ->
            True

        _ :: [] ->
            True

        head :: neck :: rest ->
            head <= neck && nonDecreasing (neck :: rest)


type Sgn
    = P
    | N
    | Z


multSign : number -> number -> Sgn
multSign x1 x2 =
    let
        sgn x =
            if x == 0 then
                Z

            else if x > 0 then
                P

            else
                N
    in
    case ( sgn x1, sgn x2 ) of
        ( Z, _ ) ->
            Z

        ( _, Z ) ->
            Z

        ( P, P ) ->
            P

        ( N, N ) ->
            P

        _ ->
            N



{- Style

   • Nested patterns can lead to very elegant, concise code
     - Avoid nested case expressionsif nestedpatterns are simpler
       and avoid unnecessary branches or let-expressions
         - Examples: unzip3 and nonDecreasing
     - A common idiom is matching against a tuple of datatypes to
       compare them
         - Examples: zip3 andmultsign

   • Wildcards are good style: use them instead of variables when
     you do not need the data
      - Example: multSign
-}
{- Nested patterns precisely
   (Most of) the full definition

   The semantics for pattern-matching takes a pattern p and a value v
   and decides (1) does it match and (2) if so, what variable bindings
   are introduced.

   Since patterns can nest, the definition is elegantly recursive, with a
   separate rule for each kind of pattern. Some of the rules:

   • If p is a variable x, the match succeeds and x is bound to v
   • If p is _, the match succeeds and no bindings are introduced
   • If p is (p1, ..., pn) and v is (v1, ..., vn), the match succeeds if and
     only if p1 matches v1, ..., pn matches vn. The bindings are the union of
     all bindings from the submatches
   • If p is C p1, the match succeeds if v is C v1 (i.e., the same constructor)
     and p1 matches v1. The bindings are the bindings from the submatch
   • ... (there are several other similar forms or patterns)

   Examples
     - Pattern a :: b :: c :: d matches all lists with >= 3 elements
     - Pattern a :: b :: c :: [] matches all lists with 3 elements
     - Pattern ((a, b), (c, d)) :: e matches all non-empty lists of pairs of pairs
-}
