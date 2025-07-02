module LectureNotes.BuildingCompoundTypes exposing (..)

{- Already know:
   • Have various base types like Int, Bool, String, etc.
   • Ways to build (nested) compound types: tuples, lists, maybes
-}
{- First: 3 most important type building blocks in any language
   • "Each of": A t value contains values of each of t1 t2 ... tn
   • "One of": A t value contains values of one of t1 t2 ... tn
   • "selft reference": A t value can refer to other t values

   Remarkable: A lot of data can be described with just these building blocks

   Note: These are not the common names for these concepts
-}
{- Examples:
   • Tuples build each-of types
     - (Int, Bool) contains and Int and a Bool
   • Maybes build one-of types
     - Maybe Int contains an Int or it contains no data
   • Lists use all three building blocks
     - List Int contains an Int and another List Int or it contains no data
   • And of course we can nest compound types
     - Maybe (Maybe (Int, Int), List (List Int))
-}
{- Coming soon:
   • Another way to build each-of types in Elm:
     - Records: have named fields
     - Connection to tuples and idea of syntactic sugar

   • A way to build and use our own one-of types in Elm:
     - For example, a type that contains an Int or a String
     - Will lead to pattern-matching, one of Elm's coolest and
       strangest-to-Jave-programmers features

     Note: Although pattern matching is introduced later, we've already
     used it to process lists. Unlike in ML, Elm's List.head and List.tail
     return Maybe values, so we need pattern matching just to access a list's
     head and tail safely.

   • Later in course: How OOP does one-of types
     - Key contrast with procedural and functional programming
-}


hello =
    "hello"
