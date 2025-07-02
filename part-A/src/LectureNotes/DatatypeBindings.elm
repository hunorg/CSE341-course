module LectureNotes.DatatypeBindings exposing (..)

{- A "strange"(?) and totally awesome (!) way to make one-of types:
   - A datatype binding
-}


type MyType
    = TwoInts Int Int
    | Str String
    | Pizza



{- • Adds a new type MyType to the environment
   • Adds constructors to the environment: TwoInts, Str, Pizza
   • A constructor is (among other things), a function that makes
     values of the new type (or is a value of the new type):
      - TwoInts : Int -> Int -> MyType
      - Str : String -> MyType
      - Pizza : MyType
-}


a : MyType
a =
    Str "hi"


b : String -> MyType
b =
    Str


c : MyType
c =
    Pizza


d : MyType
d =
    TwoInts (1 + 2) (3 + 4)


e : MyType
e =
    a



{- • Any value of type MyType is made from one of the constructors
   • The value contains:
     - A "tag" for "which constructor" (e.g., TwoInts)
     - The correspoinding data (e.g., 7 9))
   • Examples:
     - TwoInts (3 + 4) (5 + 4) evaluates to TwoInts 7 9
     - Str (if True then "hi" else "bye") evaluates to Str "hi"
     - Pizza is a value
-}
{- Using them

   So we know how to build datatype values; need to access them

   There are two aspects to accessing a datatype value
   1. Check what variant it is (what constructor made it)
   2. Extract the data (if that variant has any)

-}
