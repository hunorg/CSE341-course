module LectureNotes.NestedFunctions exposing (..)

{- Any Binding:
   • According to our rules for let-expressions, we can define functions
     inside any let-expression:
       let b1 b2 ... bn in e
   • This is a natural idea, and often good style
-}


countUpFrom1 : number -> List number
countUpFrom1 x =
    let
        count : number -> List number
        count from =
            if from == x then
                [ x ]

            else
                from :: count (from + 1)
    in
    count 1



{- Functions can use bindings in the environment where they are defined:
   • Bindings from "outer" environments
     - Such as parameters to the outer function
   • Earlier bindings in the let-expression
-}
{- Nested functions: style
   • Good style to define helper functions inside the functions they help if they are:
     - Unlikely to be useful elsewhere
     - Likely to be misused if available elsewhere
     - Likely to be changed or removed later
   • A fundamental trade-off in code design: reusing code saves effort
     and avoids bugs, but makes the reused code harder to change later
-}
