module LectureNotes.Records exposing (..)


x : { bar : ( number, Bool ), baz : ( Bool, number ), foo : number }
x =
    { bar = ( 1 + 2, True && True ), baz = ( False, 9 ), foo = 7 }


myNiece : { name : String, id : number }
myNiece =
    { name = "Amelia", id = 41123 - 12 }


brainPart : { id : Bool, ego : Bool, superEgo : Bool }
brainPart =
    { id = True, ego = False, superEgo = False }



{- Records
   • Record values have fields (any name) holding values
    { f1 = v1, ..., fn = vn }
   • Record types have fields (any name) holding types
    { f1 : t1, ..., fn : tn }
   • The order of fields in a record value or type never matters
   • Building records:
    { f1 = e1, ..., fn = en }
   • Accessing pieces:
    e.myFieldName
   (Evaluation rules and type-checking as expected)
-}
{- Note:
   Tuples and records are both “each-of” types.
   • Tuples group values by position, e.g. (Int, Bool, String)
     - Access elements by position: #1, #2, etc. (ML style)
   • Records group values by named fields, e.g. { name : String, age : Int }
     - Access elements by field name: e.name, e.age

   In ML (as in the lecture), tuples can have many elements (up to 10 or more),
   but in Elm tuples are typically small (up to 3 elements),
   encouraging the use of records for larger collections of fields.
-}
