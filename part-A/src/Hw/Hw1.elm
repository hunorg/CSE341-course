module Hw.Hw1 exposing (..)

import Maybe.Extra exposing (..)
import Tuple3 exposing (..)


isOlder : ( Int, Int, Int ) -> ( Int, Int, Int ) -> Bool
isOlder ( y1, m1, d1 ) ( y2, m2, d2 ) =
    y1 < y2 || y1 == y2 && m1 < m2 || y1 == y2 && m1 == m2 && d1 < d2


numberInMonth : List ( Int, Int, Int ) -> Int -> Int
numberInMonth dates month =
    case dates of
        [] ->
            0

        d1 :: dates_ ->
            if second d1 == month then
                1 + numberInMonth dates_ month

            else
                numberInMonth dates_ month


numberInMonths : List ( Int, Int, Int ) -> List Int -> Int
numberInMonths dates months =
    case months of
        [] ->
            0

        m1 :: months_ ->
            numberInMonth dates m1 + numberInMonths dates months_


datesInMonth : List ( Int, Int, Int ) -> Int -> List ( Int, Int, Int )
datesInMonth dates month =
    case dates of
        [] ->
            []

        d1 :: dates_ ->
            if second d1 == month then
                d1 :: datesInMonth dates_ month

            else
                datesInMonth dates_ month


datesInMonths : List ( Int, Int, Int ) -> List Int -> List ( Int, Int, Int )
datesInMonths dates months =
    case months of
        [] ->
            []

        m1 :: months_ ->
            datesInMonth dates m1 ++ datesInMonths dates months_


getNth : List String -> Int -> String
getNth strings nth =
    case strings of
        [] ->
            ""

        s1 :: strings_ ->
            if nth < 1 then
                ""

            else if nth == 1 then
                s1

            else
                getNth strings_ (nth - 1)


dateToString : ( Int, Int, Int ) -> String
dateToString date =
    let
        months : List String
        months =
            [ "January "
            , "February "
            , "March "
            , "April "
            , "May "
            , "June "
            , "July "
            , "August "
            , "September "
            , "October "
            , "November "
            , "December "
            ]
    in
    getNth months (second date) ++ String.fromInt (third date) ++ ", " ++ String.fromInt (first date)


numberBeforeReachingSum : Int -> List Int -> Int
numberBeforeReachingSum sum ints =
    case ints of
        [] ->
            0

        i1 :: ints_ ->
            if (sum - i1) <= 0 then
                0

            else
                1 + numberBeforeReachingSum (sum - i1) ints_


whatMonth : Int -> Int
whatMonth day =
    let
        months : List Int
        months =
            [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]
    in
    numberBeforeReachingSum day months + 1


monthRange : Int -> Int -> List Int
monthRange d1 d2 =
    if d1 > d2 then
        []

    else
        whatMonth d1 :: monthRange (d1 + 1) d2


oldest : List ( Int, Int, Int ) -> Maybe ( Int, Int, Int )
oldest dates =
    case dates of
        [] ->
            Nothing

        d1 :: dates_ ->
            let
                oldestTail =
                    oldest dates_
            in
            case oldestTail of
                Nothing ->
                    Just d1

                Just val ->
                    if isOlder d1 val then
                        Just d1

                    else
                        oldestTail



-- CHALLENGE PROBLEMS:


removeDuplicates : List comparable -> List comparable
removeDuplicates xs =
    let
        isInList : comparable -> List comparable -> Bool
        isInList y ys =
            case ys of
                [] ->
                    False

                y1 :: ys_ ->
                    if y == y1 then
                        True

                    else
                        isInList y ys_
    in
    case xs of
        [] ->
            []

        x :: xs_ ->
            if isInList x xs_ then
                removeDuplicates xs_

            else
                x :: removeDuplicates xs_


numberInMonthsChallenge : List ( Int, Int, Int ) -> List Int -> Int
numberInMonthsChallenge dates months =
    numberInMonths dates (removeDuplicates months)


datesInMonthsChallenge : List ( Int, Int, Int ) -> List Int -> List ( Int, Int, Int )
datesInMonthsChallenge dates months =
    datesInMonths dates (removeDuplicates months)


isValidDate : ( Int, Int, Int ) -> Bool
isValidDate ( y, m, d ) =
    let
        isValidYear : Bool
        isValidYear =
            y > 0

        isValidMonth : Bool
        isValidMonth =
            m >= 1 && m <= 12

        isValidDay : Bool
        isValidDay =
            let
                daysInMonth : List Int
                daysInMonth =
                    let
                        daysInFebruary : Int
                        daysInFebruary =
                            if modBy 4 y == 0 && modBy 100 y /= 0 || modBy 400 y == 0 then
                                29

                            else
                                28
                    in
                    [ 31, daysInFebruary, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

                getAt : Int -> List a -> Maybe a
                getAt idx xs =
                    case xs of
                        [] ->
                            Nothing

                        x :: xs_ ->
                            if idx < 0 then
                                Nothing

                            else if idx == 0 then
                                Just x

                            else
                                getAt (idx - 1) xs_

                isValidMaximumDay =
                    case getAt (m - 1) daysInMonth of
                        Just x ->
                            d <= x

                        Nothing ->
                            False
            in
            d >= 1 && d <= 31 && isValidMaximumDay
    in
    isValidYear && isValidMonth && isValidDay
