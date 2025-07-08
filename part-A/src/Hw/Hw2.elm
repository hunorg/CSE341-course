module Hw.Hw2 exposing (..)


allExceptMaybe : String -> List String -> Maybe (List String)
allExceptMaybe s ss =
    case ss of
        [] ->
            Nothing

        x :: xs ->
            if s == x then
                Just xs

            else
                case allExceptMaybe s xs of
                    Just ys ->
                        Just (x :: ys)

                    _ ->
                        Nothing


getSubstitutions1 : List (List String) -> String -> List String
getSubstitutions1 subs s =
    case subs of
        [] ->
            []

        sub :: subs_ ->
            case allExceptMaybe s sub of
                Just ys ->
                    ys ++ getSubstitutions1 subs_ s

                Nothing ->
                    getSubstitutions1 subs_ s


getSubstitutions2 : List (List String) -> String -> List String
getSubstitutions2 subsArg s =
    let
        aux : List (List String) -> List String -> List String
        aux subs acc =
            case subs of
                sub :: subs_ ->
                    case allExceptMaybe s sub of
                        Just ys ->
                            aux subs_ (acc ++ ys)

                        Nothing ->
                            aux subs_ acc

                [] ->
                    acc
    in
    aux subsArg []


type alias FullName =
    { first : String
    , last : String
    , middle : String
    }


similarNames : List (List String) -> FullName -> List FullName
similarNames subs fullName =
    let
        variants : List String
        variants =
            getSubstitutions2 subs fullName.first

        aux : List String -> List FullName -> List FullName
        aux strings acc =
            case strings of
                [] ->
                    acc

                s :: strings_ ->
                    aux strings_ ({ fullName | first = s } :: acc)
    in
    fullName :: aux variants []


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


cardColor : Card -> Color
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
removeCard cs c =
    case cs of
        [] ->
            Nothing

        card :: cs_ ->
            if card == c then
                Just cs_

            else
                case removeCard cs_ c of
                    Just ys ->
                        Just (card :: ys)

                    _ ->
                        Nothing


allSameColor : List Card -> Bool
allSameColor cs =
    case cs of
        [] ->
            True

        _ :: [] ->
            True

        c :: c_ :: cs_ ->
            cardColor c == cardColor c_ && allSameColor (c_ :: cs_)


sumCards : List Card -> Int
sumCards csArg =
    let
        aux cs acc =
            case cs of
                [] ->
                    acc

                c :: cs_ ->
                    aux cs_ (acc + cardValue c)
    in
    aux csArg 0


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
        max 0 (preliminaryScore // 2)

    else
        preliminaryScore


officiate : List Card -> List Move -> Int -> Maybe Int
officiate csArg movesArg goal =
    let
        aux cs held moves =
            case moves of
                [] ->
                    Just (score held goal)

                Draw :: moves_ ->
                    case cs of
                        [] ->
                            Just (score held goal)

                        c :: cs_ ->
                            if sumCards (c :: held) > goal then
                                Just (score held goal)

                            else
                                aux cs_ (c :: held) moves_

                (Discard c) :: moves_ ->
                    case removeCard held c of
                        Just held_ ->
                            aux cs held_ moves_

                        _ ->
                            Nothing
    in
    aux csArg [] movesArg



-- CHALLENGE PROBLEMS:


allPossibleSums : List Card -> List Int
allPossibleSums csArg =
    let
        addToAll : List Int -> Int -> List Int
        addToAll xs y =
            case xs of
                [] ->
                    []

                x :: xs_ ->
                    x + y :: addToAll xs_ y

        aux cs acc =
            case cs of
                [] ->
                    acc

                c :: cs_ ->
                    if c.rank == Ace then
                        aux cs_ (addToAll acc 1) ++ aux cs_ (addToAll acc 11)

                    else
                        aux cs_ (addToAll acc (cardValue c))
    in
    aux csArg [ 0 ]


scoreChallenge : List Card -> Int -> Int
scoreChallenge csArg goal =
    let
        toScore : Int -> Int
        toScore sum =
            let
                preliminaryScore =
                    if sum > goal then
                        3 * (sum - goal)

                    else
                        goal - sum
            in
            if allSameColor csArg then
                max 0 (preliminaryScore // 2)

            else
                preliminaryScore

        allScores sums =
            case sums of
                [] ->
                    []

                sum :: sums_ ->
                    toScore sum :: allScores sums_
    in
    case List.minimum (allScores (allPossibleSums csArg)) of
        Just bestScore ->
            bestScore

        Nothing ->
            0


officiateChallenge : List Card -> List Move -> Int -> Maybe Int
officiateChallenge csArg movesArg goal =
    let
        aux cs held moves =
            case moves of
                [] ->
                    Just (scoreChallenge held goal)

                Draw :: moves_ ->
                    case cs of
                        [] ->
                            Just (scoreChallenge held goal)

                        c :: cs_ ->
                            let
                                allSumsGreaterThanGoal sums =
                                    List.all (\x -> x > goal) sums
                            in
                            if allSumsGreaterThanGoal (allPossibleSums (c :: held)) then
                                Just (scoreChallenge held goal)

                            else
                                aux cs_ (c :: held) moves_

                (Discard c) :: moves_ ->
                    case removeCard held c of
                        Just held_ ->
                            aux cs held_ moves_

                        _ ->
                            Nothing
    in
    aux csArg [] movesArg


carefulPlayer : List Card -> Int -> List Move
carefulPlayer csArg goal =
    let
        aux cs held moves =
            case cs of
                [] ->
                    moves

                c :: cs_ ->
                    let
                        shouldStop : Bool
                        shouldStop =
                            score held goal == 0

                        shouldDraw : Bool
                        shouldDraw =
                            sumCards (c :: held) <= goal && goal - sumCards held > 10

                        shouldDiscardAndDraw : List Card -> Maybe ( Card, List Card )
                        shouldDiscardAndDraw heldCards =
                            case heldCards of
                                [] ->
                                    Nothing

                                cardToDiscard :: heldCards_ ->
                                    if sumCards (c :: heldCards_) <= goal && score (c :: heldCards_) goal == 0 && goal - sumCards heldCards_ > 10 then
                                        Just ( cardToDiscard, heldCards_ )

                                    else
                                        shouldDiscardAndDraw heldCards_
                    in
                    if shouldStop then
                        moves

                    else if shouldDraw then
                        aux cs_ (c :: held) (moves ++ [ Draw ])

                    else
                        case shouldDiscardAndDraw held of
                            Just ( cardToDiscard, newHeld ) ->
                                aux cs_ (c :: newHeld) (moves ++ [ Discard cardToDiscard, Draw ])

                            Nothing ->
                                moves
    in
    aux csArg [] []
