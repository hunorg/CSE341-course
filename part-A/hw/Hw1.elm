module Hw1 exposing (..)

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

        d1 :: dr ->
            if second d1 == month then
                1 + numberInMonth dr month

            else
                numberInMonth dr month


numberInMonths : List ( Int, Int, Int ) -> List Int -> Int
numberInMonths dates months =
    case months of
        [] ->
            0

        m1 :: mr ->
            numberInMonth dates m1 + numberInMonths dates mr


getNth : List String -> Int -> String
getNth strings nth =
    case strings of
        [] ->
            ""

        s1 :: sr ->
            if nth < 1 then
                ""

            else if nth == 1 then
                s1

            else
                getNth sr (nth - 1)


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

        x :: xs ->
            if sum <= 1 then
                0

            else
                1 + numberBeforeReachingSum (sum - x) xs


whatMonth : Int -> Int
whatMonth day =
    let
        months : List Int
        months =
            [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]
    in
    numberBeforeReachingSum day months


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

        x :: xs ->
            let
                ans =
                    oldest xs
            in
            if isJust ans then
                if isOlder x (Maybe.withDefault ( 1, 1, 1 ) ans) then
                    ans

                else
                    Just x

            else
                Just x
