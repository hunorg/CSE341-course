module LectureNotes.PolymorphicDatatypes exposing (..)

{- Finish the story

   • Claimed built-in maybes and lists are not needed/special
      - Other than special syntax for list constructors

   • But these datatype bindings are polymorphic type constructors
      - List Int and List String and List (List Int) are all types, not List
      - Functions might or might not be polymorphic
         • sumList : List Int -> Int
         • append :: List a -> List a -> List a

   • Good language design: Can define new polymorphic datatypes

-}
{- Defining polymoprhic datatypes

   • Syntax: put one or more type variables after datatype name

   type Maybe a = Nothing | Just a
   type MyList a = Empty | Cons a (List a)

   • Can use these type variables in constructor definitions

   • Binding then introduces a type constructor, not a type
      - Must say MyList Int or MyList String or MyList a
      - Not "plain" MyList
-}


sumList : List number -> number
sumList xs =
    case xs of
        [] ->
            0

        x :: xs_ ->
            x + sumList xs_


append : List a -> List a -> List a
append xs ys =
    case xs of
        [] ->
            ys

        x :: xs_ ->
            x :: append xs_ ys


type MyMaybe a
    = Nothing
    | Just a


type MyList a
    = Empty
    | Cons a (MyList a)


type Tree a b
    = Node (Tree a b) (Tree a b) a
    | Leaf b


tree1 : Tree String Int
tree1 =
    Node (Leaf 1) (Leaf 2) "root"


sumTree : Tree Int Int -> Int
sumTree tr =
    case tr of
        Leaf i ->
            i

        Node l r i ->
            i + sumTree l + sumTree r


sumLeaves : Tree a Int -> Int
sumLeaves tr =
    case tr of
        Leaf i ->
            i

        Node l r _ ->
            sumLeaves l + sumLeaves r


numLeaves : Tree a b -> Int
numLeaves tr =
    case tr of
        Leaf _ ->
            1

        Node l r _ ->
            numLeaves l + numLeaves r
