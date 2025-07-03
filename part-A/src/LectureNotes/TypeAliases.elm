module LectureNotes.TypeAliases exposing (..)

{- Creating new types

   • A datatype binding introduces a new type name
     - Disctinct from all existing types
     - Only way to create values of the new type is the constructors

   • A type alias is a new kind of binding

      type alias aname = t

       - Just creates another name for a type
       - The type and the name are interchangeable in every way
-}


type Suit
    = Club
    | Diamond
    | Heart
    | Spade


type Rank
    = Jack
    | Queen
    | King
    | Ace
    | Num Int


type alias Card =
    ( Suit, Rank )


type alias NameRecord =
    { studentNum : Maybe Int
    , first : String
    , middle : Maybe String
    , last : String
    }


isQueenOfSpades : Card -> Bool
isQueenOfSpades ( suit, rank ) =
    suit == Spade && rank == Queen


c1 : ( Suit, Rank )
c1 =
    ( Diamond, Ace )


c2 : Card
c2 =
    ( Heart, Ace )



-- can call isQueenOfSpades on c1 or c2
{- and once we learn more about pattern-matching, we can leave the type off
   function arguments too - here is a teaser we cannot explain quite yet:
-}


isQueenOfSpades2 c =
    case c of
        ( Spade, Queen ) ->
            True

        _ ->
            False



{- Why have this?

   For now, type synonyms just a convenience for talking about types
     - Exmaple (where Suit and Rank already defined):
        type alias Card = (Suit, Rank)
     - Write a function of type
        Card -> Bool
     - Okay if REPL says your function has type
        (Suit, Rank) -> Bool

   Convenient, but does not let us "do" anything new

   Later in course will see another use related to modularity

-}
