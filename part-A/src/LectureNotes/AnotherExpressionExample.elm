module LectureNotes.AnotherExpressionExample exposing (..)

import LectureNotes.UsefulDatatypes exposing (..)



-- Let's define maxConstant : Exp -> Int
-- Good example of combining several topics as we program:
-- Case expressions
-- Local helper functions
-- Avoiding repeated recursion
-- Simpler solution by using library functions


maxConstant : Exp -> Int
maxConstant e =
    case e of
        Constant i ->
            i

        Negate e1 ->
            maxConstant e1

        Add e1 e2 ->
            max (maxConstant e1) (maxConstant e2)

        Multiply e1 e2 ->
            max (maxConstant e1) (maxConstant e2)


textExp : Exp
textExp =
    Add (Constant 19) (Negate (Constant 4))


nineteen : Int
nineteen =
    maxConstant textExp
