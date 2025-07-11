module Hw.Hw3Tests exposing (..)

import Hw.Hw3 exposing (..)


onlyCapitalsTests =
    let
        test1 =
            onlyCapitals [ "Alice", "bob", "Zoe" ] == [ "Alice", "Zoe" ]

        test2 =
            onlyCapitals [ "x", "y", "z" ] == []

        test3 =
            onlyCapitals [] == []
    in
    [ test1, test2, test3 ]


longestString1Tests =
    let
        test1 =
            longestString1 [] == ""

        test2 =
            longestString1 [ "a", "bbb", "cc" ] == "bbb"

        test3 =
            longestString1 [ "a", "b", "c" ] == "a"
    in
    [ test1, test2, test3 ]


longestString2Tests =
    let
        test1 =
            longestString2 [] == ""

        test2 =
            longestString2 [ "a", "bbb", "cc" ] == "bbb"

        test3 =
            longestString2 [ "a", "b", "c" ] == "c"
    in
    [ test1, test2, test3 ]


longestString3Tests =
    let
        test1 =
            longestString3 [] == ""

        test2 =
            longestString3 [ "a", "bbb", "cc" ] == "bbb"

        test3 =
            longestString3 [ "a", "b", "c" ] == "a"
    in
    [ test1, test2, test3 ]


longestString4Tests =
    let
        test1 =
            longestString4 [] == ""

        test2 =
            longestString4 [ "a", "bbb", "cc" ] == "bbb"

        test3 =
            longestString4 [ "a", "b", "c" ] == "c"
    in
    [ test1, test2, test3 ]


longestCapitalizedTests =
    let
        test1 =
            longestCapitalized [] == ""

        test2 =
            longestCapitalized [ "apple", "Banana", "Cherry", "date" ] == "Banana"

        test3 =
            longestCapitalized [ "apple", "banana", "cherry" ] == ""
    in
    [ test1, test2, test3 ]


revStringTests =
    let
        test1 =
            revString "" == ""

        test2 =
            revString "a" == "a"

        test3 =
            revString "abc" == "cba"

        test4 =
            revString "Madam" == "madaM"

        test5 =
            revString "12345" == "54321"
    in
    [ test1, test2, test3, test4, test5 ]


firstAnswerTests =
    let
        f x =
            if x > 5 then
                Just (x * 2)

            else
                Nothing

        test1 =
            firstAnswer f [] == Nothing

        test2 =
            firstAnswer f [ 1, 2, 3 ] == Nothing

        test3 =
            firstAnswer f [ 3, 6, 2 ] == Just 12

        test4 =
            firstAnswer f [ 7, 8, 9 ] == Just 14
    in
    [ test1, test2, test3, test4 ]


allAnswersTests =
    let
        f1 n =
            if n > 0 then
                Just [ n, n * 2 ]

            else
                Nothing

        test1 =
            allAnswers f1 [] == Just []

        test2 =
            allAnswers f1 [ 1, 2, 3 ] == Just [ 1, 2, 2, 4, 3, 6 ]

        test3 =
            allAnswers f1 [ 1, -1, 3 ] == Nothing

        test4 =
            allAnswers f1 [ -1, -2 ] == Nothing
    in
    [ test1, test2, test3, test4 ]
