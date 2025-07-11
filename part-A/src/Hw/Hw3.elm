module Hw.Hw3 exposing (..)


type Pattern
    = Wildcard
    | Variable String
    | UnitP
    | ConstP Int
    | TupleP (List Pattern)
    | ConstructorP ( String, Pattern )


type Valu
    = Const Int
    | Unit
    | Tuple (List Valu)
    | Constructor ( String, Valu )


g : (() -> Int) -> (String -> Int) -> Pattern -> Int
g f1 f2 p =
    let
        r : Pattern -> Int
        r =
            g f1 f2
    in
    case p of
        Wildcard ->
            f1 ()

        Variable x ->
            f2 x

        TupleP ps ->
            List.foldl (\subP acc -> r subP + acc) 0 ps

        ConstructorP ( _, subP ) ->
            r subP

        _ ->
            0


onlyCapitals : List String -> List String
onlyCapitals xs =
    let
        startsWithUpper : String -> Bool
        startsWithUpper s =
            case String.toList s of
                [] ->
                    False

                y :: _ ->
                    Char.isUpper y
    in
    List.filter startsWithUpper xs


longestString1 : List String -> String
longestString1 xs =
    List.foldl
        (\x y ->
            if String.length x > String.length y then
                x

            else
                y
        )
        ""
        xs


longestString2 : List String -> String
longestString2 xs =
    List.foldl
        (\x y ->
            if String.length x >= String.length y then
                x

            else
                y
        )
        ""
        xs


longestStringHelper : (Int -> Int -> Bool) -> List String -> String
longestStringHelper f =
    List.foldl
        (\x y ->
            let
                lenX =
                    String.length x

                lenY =
                    String.length y
            in
            if f lenX lenY then
                x

            else
                y
        )
        ""


longestString3 : List String -> String
longestString3 =
    longestStringHelper (\lenX lenY -> lenX > lenY)


longestString4 : List String -> String
longestString4 =
    longestStringHelper (\lenX lenY -> lenX >= lenY)


longestCapitalized : List String -> String
longestCapitalized =
    onlyCapitals >> longestString3


revString : String -> String
revString =
    String.toList >> List.reverse >> String.fromList


firstAnswer : (a -> Maybe b) -> List a -> Maybe b
firstAnswer f xs =
    case xs of
        [] ->
            Nothing

        x :: xs_ ->
            if f x == Nothing then
                firstAnswer f xs_

            else
                f x



-- firstAnswer returns Maybe b cause there are no exceptions in Elm


allAnswers : (a -> Maybe (List b)) -> List a -> Maybe (List b)
allAnswers f xs =
    let
        aux ys acc =
            case ys of
                [] ->
                    Just acc

                y :: ys_ ->
                    case f y of
                        Just zs ->
                            aux ys_ (acc ++ zs)

                        _ ->
                            Nothing
    in
    aux xs []



{-
   The function g takes two functions and a pattern as arguments.
   The first function (f1) is applied to each Wildcard pattern,
   and the second function (f2) is applied to each Variable pattern’s name.
   g returns a number that combines the results of these applications
   over the entire pattern.
-}


countWildcards : Pattern -> Int
countWildcards =
    g (\() -> 1) (\_ -> 0)


countWildAndVariableLengths : Pattern -> Int
countWildAndVariableLengths =
    g (\() -> 1) (\s -> String.length s)


countSomeVar : ( String, Pattern ) -> Int
countSomeVar ( s, p ) =
    g (\() -> 0)
        (\var ->
            if s == var then
                1

            else
                0
        )
        p


checkPat : Pattern -> Bool
checkPat pat =
    let
        stringCollector : Pattern -> List String
        stringCollector p =
            case p of
                Variable x ->
                    [ x ]

                TupleP ps ->
                    List.foldl (\subP collected -> stringCollector subP ++ collected) [] ps

                ConstructorP ( _, ptn ) ->
                    stringCollector ptn

                _ ->
                    []

        hasRepeats : List a -> Bool
        hasRepeats xs =
            case xs of
                [] ->
                    False

                x :: xs_ ->
                    if List.any (\y -> y == x) xs_ then
                        True

                    else
                        hasRepeats xs_
    in
    stringCollector pat |> hasRepeats |> not


match : ( Valu, Pattern ) -> Maybe (List ( String, Valu ))
match ( v, p ) =
    case p of
        Wildcard ->
            Just []

        Variable name ->
            Just [ ( name, v ) ]

        UnitP ->
            if v == Unit then
                Just []

            else
                Nothing

        ConstP x ->
            case v of
                Const y ->
                    if x == y then
                        Just []

                    else
                        Nothing

                _ ->
                    Nothing

        TupleP ps ->
            case v of
                Tuple vs ->
                    if List.length ps == List.length vs then
                        let
                            listPairZip : List a -> List b -> List ( a, b )
                            listPairZip xs ys =
                                case ( xs, ys ) of
                                    ( x :: xs_, y :: ys_ ) ->
                                        ( x, y ) :: listPairZip xs_ ys_

                                    _ ->
                                        []
                        in
                        allAnswers (\( x, y ) -> match ( x, y )) (listPairZip vs ps)

                    else
                        Nothing

                _ ->
                    Nothing

        ConstructorP ( s1, ptrn ) ->
            case v of
                Constructor ( s2, v2 ) ->
                    if s1 == s2 then
                        match ( v2, ptrn )

                    else
                        Nothing

                _ ->
                    Nothing


firstMatch : Valu -> List Pattern -> Maybe (List ( String, Valu ))
firstMatch v ps =
    firstAnswer (\p -> match ( v, p )) ps
