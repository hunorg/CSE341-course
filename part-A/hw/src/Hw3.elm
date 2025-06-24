module Hw3 exposing (..)


type Pattern
    = Wildcard
    | Variable String
    | UnitP
    | ConstP Int
    | TupleP (List Pattern)
    | ConstructorP String Pattern


type Valu
    = Const Int
    | Unit
    | Tuple (List Valu)
    | Constructor String Valu


g f1 f2 ptrn =
    let
        r =
            g f1 f2
    in
    case ptrn of
        Wildcard ->
            f1 ()

        Variable x ->
            f2 x

        TupleP ps ->
            List.foldl (\p i -> r p + i) 0 ps

        ConstructorP _ pt ->
            r pt

        _ ->
            0


onlyCapitals : List String -> List String
onlyCapitals xs =
    let
        isUpper : String -> Bool
        isUpper s =
            case String.toList s of
                [] ->
                    False

                y :: _ ->
                    Char.isUpper y
    in
    List.filter isUpper xs


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
        (\e a ->
            let
                sl1 =
                    String.length e

                sl2 =
                    String.length a
            in
            if f sl1 sl2 then
                e

            else
                a
        )
        ""


longestString3 : List String -> String
longestString3 =
    longestStringHelper (\f s -> f > s)


longestString4 : List String -> String
longestString4 =
    longestStringHelper (\f s -> f >= s)


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

        x :: xss ->
            if f x == Nothing then
                firstAnswer f xss

            else
                f x



-- firstAnswer returns Maybe b cause there are no exceptions in ELM


allAnswers : (a -> Maybe (List b)) -> List a -> Maybe (List b)
allAnswers f xs =
    let
        aux : (a -> Maybe (List b)) -> List a -> List b -> Maybe (List b)
        aux e z acc =
            case z of
                [] ->
                    Just acc

                zs :: zss ->
                    case e zs of
                        Just val ->
                            Just
                                (val
                                    ++ acc
                                    ++ (case aux e zss acc of
                                            Just vall ->
                                                vall

                                            Nothing ->
                                                []
                                       )
                                )

                        _ ->
                            Nothing
    in
    aux f xs []



-- g gives back a number
-- f1 determines default value
-- variable x is a string to wich I apply f2 to convert it into an int
-- tuple ps goes trough all patterns and based on that patten is a wildc or variable, converts it into a nr and sums it
-- you have a list of patterns, the wildcard patterns became default values,
-- the patterns that aren't wildcards are being matched with the help of the f2


countWildcards : Pattern -> Int
countWildcards pt =
    g (\() -> 1) (\_ -> 0) pt


countWildAndVariableLengths : Pattern -> Int
countWildAndVariableLengths pt =
    g (\() -> 1) (\s -> String.length s) pt + countWildcards pt


countSomeVar : ( String, Pattern ) -> Int
countSomeVar ( s, p ) =
    g (\() -> 0)
        (\z ->
            if s == z then
                1

            else
                0
        )
        p


checkPat : Pattern -> Bool
checkPat ptrn =
    let
        stringCollector p =
            let
                acc =
                    []
            in
            case p of
                Wildcard ->
                    acc

                Variable x ->
                    acc ++ [ x ]

                TupleP ps ->
                    List.foldl (\pt i -> stringCollector pt ++ i) acc ps

                ConstructorP _ ptn ->
                    stringCollector ptn ++ acc

                _ ->
                    acc

        doesRepeat xs hist =
            let
                listExists : (a -> Bool) -> List a -> Bool
                listExists f l =
                    case l of
                        [] ->
                            False

                        x :: xss ->
                            if f x then
                                True

                            else
                                listExists f xss
            in
            let
                memberOf s1 l =
                    listExists (\x -> x == s1) l
            in
            case xs of
                [] ->
                    True

                x :: xss ->
                    if memberOf x hist then
                        False

                    else
                        case xss of
                            [] ->
                                True

                            _ ->
                                doesRepeat xss (x :: hist)
    in
    doesRepeat (stringCollector ptrn) []


match : ( Valu, Pattern ) -> Maybe (List ( String, Valu ))
match ( v, p ) =
    case p of
        Wildcard ->
            Just []

        Variable s ->
            case v of
                Const _ ->
                    Just [ ( s, v ) ]

                Unit ->
                    Just [ ( s, v ) ]

                _ ->
                    Nothing

        UnitP ->
            if v == Unit then
                Just []

            else
                Nothing

        ConstP n ->
            case v of
                Const m ->
                    if n == m then
                        Just []

                    else
                        Nothing

                _ ->
                    Nothing

        TupleP ps ->
            case v of
                Tuple vs ->
                    if List.length ps == List.length ps then
                        let
                            listPairZip : List a -> List b -> List ( a, b )
                            listPairZip l1 l2 =
                                case l1 of
                                    [] ->
                                        []

                                    x :: xs ->
                                        case l2 of
                                            [] ->
                                                []

                                            x1 :: xs1 ->
                                                if List.length l1 == List.length l2 then
                                                    ( x, x1 ) :: listPairZip xs xs1

                                                else
                                                    []
                        in
                        allAnswers (\( x, y ) -> match ( x, y )) (listPairZip vs ps)

                    else
                        Nothing

                _ ->
                    Nothing

        ConstructorP s1 ptrn ->
            case v of
                Constructor s2 v2 ->
                    if s1 == s2 then
                        match ( v2, ptrn )

                    else
                        Nothing

                _ ->
                    Nothing


firstMatch : Valu -> List Pattern -> Maybe (List ( String, Valu ))
firstMatch v ps =
    firstAnswer (\p -> match ( v, p )) ps
