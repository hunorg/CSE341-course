module Hw2 exposing (..)


allExceptMaybe : String -> List String -> Maybe (List String)
allExceptMaybe s ss =
    case ss of
        [] ->
            Nothing

        s1 :: ssr ->
            if s == s1 then
                Just ssr

            else
                case allExceptMaybe s ssr of
                    Just ys ->
                        Just (s1 :: ys)

                    _ ->
                        Nothing


getSubstitutions1 : List (List String) -> String -> List String
getSubstitutions1 subs s =
    case subs of
        [] ->
            []

        sl :: slr ->
            case allExceptMaybe s sl of
                Nothing ->
                    getSubstitutions1 slr s

                Just vmik ->
                    vmik ++ getSubstitutions1 slr s


getSubstitutions2 : List (List String) -> String -> List String
getSubstitutions2 subsArg s =
    let
        aux subs result =
            case subs of
                sl :: slr ->
                    case allExceptMaybe s sl of
                        Nothing ->
                            aux slr result

                        Just vmik ->
                            aux slr (result ++ vmik)

                [] ->
                    result
    in
    aux subsArg []


type alias FullName =
    { first : String
    , last : String
    , middle : String
    }


similarNames : List (List String) -> FullName -> List FullName
similarNames sssl fulln =
    let
        substitutions =
            getSubstitutions2 sssl fulln.first

        aux : List String -> List FullName
        aux subs =
            case subs of
                [] ->
                    []

                sub1 :: subsr ->
                    { first = sub1, last = fulln.last, middle = fulln.middle } :: aux subsr
    in
    fulln :: aux substitutions


type Suit
    = Spade
    | Club
    | Heart
    | Diamond


type Rank
    = Jack
    | Queen
    | King
    | Ace
    | Num Int


type alias Card =
    { suit : Suit
    , rank : Rank
    }


type Color
    = Black
    | Red


type Move
    = Draw
    | Discard Card


cardColor c =
    case c.suit of
        Spade ->
            Black

        Club ->
            Black

        _ ->
            Red


cardValue : Card -> Int
cardValue c =
    case c.rank of
        Num x ->
            x

        Ace ->
            11

        _ ->
            10


removeCard : List Card -> Card -> Maybe (List Card)
removeCard lc c =
    case lc of
        [] ->
            Nothing

        c1 :: csr ->
            if c1 == c then
                Just csr

            else
                case removeCard csr c of
                    Just csrr ->
                        Just (c1 :: csrr)

                    _ ->
                        Nothing


allSameColor : List Card -> Bool
allSameColor cs =
    case cs of
        [] ->
            True

        _ :: [] ->
            True

        c1 :: cn :: csr ->
            cardColor c1 == cardColor cn && allSameColor csr


sumCards : List Card -> Int
sumCards cs =
    let
        aux csa result =
            case csa of
                [] ->
                    result

                c1 :: csr ->
                    aux csr (result + cardValue c1)
    in
    aux cs 0


score : List Card -> Int -> Int
score cs goal =
    let
        preliminaryScore =
            if sumCards cs > goal then
                3 * (sumCards cs - goal)

            else
                goal - sumCards cs
    in
    if allSameColor cs then
        preliminaryScore // 2

    else
        preliminaryScore


officiate : List Card -> List Move -> Int -> Maybe Int
officiate csArg mvs gl =
    let
        aux cs hcs moves goal =
            case moves of
                [] ->
                    Just (score hcs gl)

                Draw :: mvsr ->
                    case cs of
                        [] ->
                            Just (score hcs gl)

                        c1 :: csr ->
                            if sumCards (c1 :: hcs) > goal then
                                Just (score hcs gl)

                            else
                                aux csr (c1 :: hcs) mvsr gl

                (Discard c) :: mvsr ->
                    case removeCard hcs c of
                        Just hcsRmvd ->
                            aux cs hcsRmvd mvsr goal

                        _ ->
                            Nothing
    in
    aux csArg [] mvs gl
