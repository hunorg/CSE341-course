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


countWildcardsTests =
    let
        test1 =
            countWildcards Wildcard == 1

        test2 =
            countWildcards (Variable "x") == 0

        test3 =
            countWildcards (TupleP [ Wildcard, Variable "y", Wildcard ]) == 2

        test4 =
            countWildcards (ConstructorP ( "Just", Wildcard )) == 1

        test5 =
            countWildcards
                (ConstructorP
                    ( "Pair"
                    , TupleP
                        [ Variable "a"
                        , ConstructorP ( "Box", Wildcard )
                        ]
                    )
                )
                == 1
    in
    [ test1, test2, test3, test4, test5 ]


countWildAndVariableLengthsTests =
    let
        test1 =
            countWildAndVariableLengths Wildcard == 1

        test2 =
            countWildAndVariableLengths (Variable "x") == 1

        test3 =
            countWildAndVariableLengths (Variable "abc") == 3

        test4 =
            countWildAndVariableLengths (TupleP [ Wildcard, Variable "hi", Wildcard ]) == 1 + 2 + 1

        test5 =
            countWildAndVariableLengths
                (ConstructorP
                    ( "Just"
                    , TupleP
                        [ Variable "long", Wildcard ]
                    )
                )
                == 4
                + 1
    in
    [ test1, test2, test3, test4, test5 ]


countSomeVarTests =
    let
        test1 =
            countSomeVar ( "x", Wildcard ) == 0

        test2 =
            countSomeVar ( "x", Variable "x" ) == 1

        test3 =
            countSomeVar ( "x", Variable "y" ) == 0

        test4 =
            countSomeVar
                ( "z"
                , TupleP [ Variable "z", Variable "a", Variable "z" ]
                )
                == 2

        test5 =
            countSomeVar
                ( "id"
                , ConstructorP
                    ( "Node"
                    , TupleP [ Variable "id", ConstructorP ( "Leaf", Variable "id" ) ]
                    )
                )
                == 2
    in
    [ test1, test2, test3, test4, test5 ]


checkPatTests =
    let
        test1 =
            -- No variables at all
            checkPat Wildcard == True

        test2 =
            -- One variable
            checkPat (Variable "x") == True

        test3 =
            -- Two different variables
            checkPat (TupleP [ Variable "x", Variable "y" ]) == True

        test4 =
            -- Two of the same variable
            checkPat (TupleP [ Variable "x", Variable "x" ]) == False

        test5 =
            -- Nested pattern with duplicate variable
            checkPat (ConstructorP ( "C", TupleP [ Variable "a", ConstructorP ( "D", Variable "a" ) ] )) == False

        test6 =
            -- Deeply nested distinct variables
            checkPat
                (ConstructorP
                    ( "Just"
                    , TupleP
                        [ Variable "a"
                        , ConstructorP ( "Box", TupleP [ Variable "b", Variable "c" ] )
                        ]
                    )
                )
                == True
    in
    [ test1, test2, test3, test4, test5, test6 ]
