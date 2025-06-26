module LectureNotes.LetExpressions exposing (..)

{- Let-expressions: 3 questions

   • Syntax:
     let b1 b2 ... bn in e
     - Each bi is any binding, and e is any expression

   • Type-checking:
     - Type-check each bi and e in a static environment
       that includes the previous bindings
     - Type of whole let-expression is the type of e

   • Evaluation:
     - Evaluate each bi and e in a dynamic environment
       that includes the previous bindings
     - Result of whole let-expression is the result of evaluating e
-}


silly1 : number -> number
silly1 z =
    let
        x =
            if z > 0 then
                z

            else
                34

        y =
            x + z + 9
    in
    if x > y then
        x * 2

    else
        y * y


silly2 : number
silly2 =
    let
        x =
            1
    in
    (let
        y =
            2
     in
     y + x
    )
        + (let
            z =
                3
           in
           z + x
          )
