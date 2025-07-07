module Hw.Hw2Tests exposing (..)

import Hw.Hw2 exposing (..)


allExceptMaybeTests =
    let
        test1 =
            allExceptMaybe "a" [] == Nothing

        test2 =
            allExceptMaybe "a" [ "b", "c" ] == Nothing

        test3 =
            allExceptMaybe "a" [ "a", "b", "c" ] == Just [ "b", "c" ]

        test4 =
            allExceptMaybe "b" [ "a", "b", "c" ] == Just [ "a", "c" ]

        test5 =
            allExceptMaybe "c" [ "a", "b", "c" ] == Just [ "a", "b" ]

        test6 =
            allExceptMaybe "a" [ "a" ] == Just []

        test7 =
            allExceptMaybe "a" [ "a", "b", "a" ] == Just [ "b", "a" ]
    in
    [ test1, test2, test3, test4, test5, test6, test7 ]


getSubstitutionsTests =
    let
        test1 =
            getSubstitutions1 [ [ "Fred", "Fredrick" ] ] "Fred" == [ "Fredrick" ]

        test2 =
            getSubstitutions1
                [ [ "Fred", "Fredrick" ]
                , [ "Elizabeth", "Betty" ]
                , [ "Freddie", "Fred", "F" ]
                ]
                "Fred"
                == [ "Fredrick", "Freddie", "F" ]

        test3 =
            getSubstitutions1
                [ [ "Fred", "Fredrick" ]
                , [ "Jeff", "Jeffrey" ]
                , [ "Geoff", "Jeff", "Jeffrey" ]
                ]
                "Jeff"
                == [ "Jeffrey", "Geoff", "Jeffrey" ]
    in
    [ test1, test2, test3 ]


similarNamesTests =
    let
        test1 =
            similarNames [] { first = "Fred", middle = "W", last = "Smith" }
                == [ { first = "Fred", middle = "W", last = "Smith" } ]

        test2 =
            similarNames [ [ "Fred", "Fredrick" ] ] { first = "Fred", middle = "X", last = "Jones" }
                == [ { first = "Fred", middle = "X", last = "Jones" }
                   , { first = "Fredrick", middle = "X", last = "Jones" }
                   ]

        test3 =
            similarNames [ [ "Fred", "F" ], [ "William", "Bill", "Will" ] ]
                { first = "William", middle = "Q", last = "Smith" }
                == [ { first = "William", middle = "Q", last = "Smith" }
                   , { first = "Bill", middle = "Q", last = "Smith" }
                   , { first = "Will", middle = "Q", last = "Smith" }
                   ]

        test4 =
            similarNames [ [ "Alice", "Ali" ], [ "Robert", "Bob", "Rob" ] ]
                { first = "Alice", middle = "M", last = "Johnson" }
                == [ { first = "Alice", middle = "M", last = "Johnson" }
                   , { first = "Ali", middle = "M", last = "Johnson" }
                   ]

        test5 =
            similarNames [ [ "Elizabeth", "Liz", "Beth", "Betty" ] ]
                { first = "Elizabeth", middle = "", last = "Taylor" }
                == [ { first = "Elizabeth", middle = "", last = "Taylor" }
                   , { first = "Liz", middle = "", last = "Taylor" }
                   , { first = "Beth", middle = "", last = "Taylor" }
                   , { first = "Betty", middle = "", last = "Taylor" }
                   ]
    in
    [ test1, test2, test3, test4, test5 ]


testCards =
    { spade2 = { suit = Spade, rank = Num 2 }
    , heartA = { suit = Heart, rank = Ace }
    , clubK = { suit = Club, rank = King }
    , diamond5 = { suit = Diamond, rank = Num 5 }
    , spade1 = { suit = Spade, rank = Num 1 }
    , heartQ = { suit = Heart, rank = Queen }
    , clubA = { suit = Club, rank = Ace }
    }


removeCardTests =
    let
        list1 =
            [ testCards.spade1, testCards.heartQ, testCards.clubA ]

        list2 =
            [ testCards.spade1, testCards.spade1, testCards.heartQ ]

        list3 =
            [ testCards.heartQ, testCards.diamond5 ]
    in
    [ removeCard list1 testCards.spade1 == Just [ testCards.heartQ, testCards.clubA ]
    , removeCard list2 testCards.spade1 == Just [ testCards.spade1, testCards.heartQ ]
    , removeCard list3 testCards.spade1 == Nothing
    , removeCard [] testCards.heartQ == Nothing
    ]


allSameColorTests =
    [ allSameColor [] == True
    , allSameColor [ testCards.spade1 ] == True
    , allSameColor [ testCards.spade1, testCards.clubK ] == True
    , allSameColor [ testCards.heartA, testCards.diamond5 ] == True
    , allSameColor [ testCards.spade1, testCards.heartA ] == False
    , allSameColor [ testCards.spade1, testCards.clubK, testCards.spade2 ] == True
    , allSameColor [ testCards.spade1, testCards.heartA, testCards.clubK ] == False
    ]


sumCardsTests =
    [ sumCards [] == 0
    , sumCards [ testCards.spade2 ] == 2
    , sumCards [ testCards.spade2, testCards.heartA ] == 13
    , sumCards [ testCards.clubK, testCards.diamond5 ] == 15
    , sumCards [ testCards.spade2, testCards.heartA, testCards.clubK, testCards.diamond5 ] == 28
    ]


scoreTests =
    let
        hand1 =
            [ testCards.spade2, testCards.heartA ]

        hand2 =
            [ testCards.clubK, testCards.diamond5 ]

        hand3 =
            [ testCards.heartA, testCards.clubA ]

        hand4 =
            [ testCards.spade1, testCards.clubK ]
    in
    [ score [] 10 == 5
    , score hand1 10 == 9
    , score hand2 20 == 5
    , score hand3 20 == 6
    , score hand4 10 == 1
    ]


officiateTests =
    let
        test1 =
            officiate
                [ testCards.spade2, testCards.heartA ]
                [ Draw, Draw ]
                10
                == Just 4

        test2 =
            officiate
                [ testCards.spade1, testCards.clubK ]
                [ Draw, Discard testCards.spade1, Draw ]
                10
                == Just 0

        test3 =
            officiate
                [ testCards.heartA, testCards.clubA ]
                [ Draw, Draw ]
                20
                == Just 4

        test4 =
            officiate
                [ testCards.diamond5, testCards.heartQ ]
                [ Draw, Discard testCards.heartQ ]
                15
                == Nothing

        test5 =
            officiate [] [ Draw ] 10 == Just 5

        test6 =
            officiate
                [ testCards.spade2, testCards.heartA ]
                [ Draw, Discard testCards.clubK ]
                10
                == Nothing
    in
    [ test1, test2, test3, test4, test5, test6 ]


scoreChallengeTests =
    [ scoreChallenge [] 21 == 10
    , scoreChallenge [ testCards.heartA ] 21 == 5
    , scoreChallenge [ testCards.heartA, testCards.clubK ] 21 == 0
    , scoreChallenge [ testCards.heartA, testCards.clubA ] 21 == 3
    , scoreChallenge [ testCards.heartA, testCards.clubA, testCards.diamond5 ] 21 == 4
    , scoreChallenge [ testCards.heartA, testCards.clubA, testCards.spade2, testCards.heartQ ] 21 == 7
    , scoreChallenge [ testCards.heartA, testCards.clubA, testCards.spade2, testCards.heartQ ] 19 == 5
    ]


officiateChallengeTests =
    let
        test1 =
            officiateChallenge
                [ testCards.spade2, testCards.heartA ]
                [ Draw, Draw ]
                10
                == Just 7

        test2 =
            officiateChallenge
                [ testCards.spade1, testCards.clubK ]
                [ Draw, Discard testCards.spade1, Draw ]
                10
                == Just 0

        test3 =
            officiateChallenge
                [ testCards.heartA, testCards.clubA ]
                [ Draw, Draw ]
                20
                == Just 6

        test4 =
            officiateChallenge
                [ testCards.diamond5, testCards.heartQ ]
                [ Draw, Discard testCards.heartQ ]
                15
                == Nothing

        test5 =
            officiateChallenge [] [ Draw ] 10 == Just 5

        test6 =
            officiateChallenge
                [ testCards.spade2, testCards.heartA ]
                [ Draw, Discard testCards.clubK ]
                10
                == Nothing
    in
    [ test1, test2, test3, test4, test5, test6 ]


carefulPlayerTests =
    let
        test1 =
            carefulPlayer
                [ testCards.spade2, testCards.heartA ]
                15
                == [ Draw, Draw ]

        test2 =
            carefulPlayer
                [ testCards.clubK, testCards.diamond5 ]
                13
                == [ Draw ]

        test3 =
            carefulPlayer
                [ testCards.heartA, testCards.spade2, testCards.clubK ]
                13
                == [ Draw ]

        test4 =
            carefulPlayer
                [ testCards.clubK ]
                13
                == [ Draw ]

        test5 =
            carefulPlayer
                [ testCards.clubK, testCards.heartQ ]
                20
                == [ Draw ]
    in
    [ test1, test2, test3, test4, test5 ]
