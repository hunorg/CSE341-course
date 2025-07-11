module LectureNotes.CurryingWrapup exposing (..)

{- More combining functions

   • What if you want to curry a tupled function or vice-versa?
   • What if a function's arguments are in the wrong order for the
     partial appplication you want?

   Naturally, it is easy to write higher-order wrapper functions
     - And their types are neat logical formulas
-}


curry : (( a, b ) -> c) -> a -> b -> c
curry f x y =
    f ( x, y )


uncurry : (a -> b -> c) -> ( a, b ) -> c
uncurry f ( x, y ) =
    f x y


otherCurry : (c -> b -> a) -> b -> c -> a
otherCurry f x y =
    f y x


range : ( number, number ) -> List number
range ( i, j ) =
    if i > j then
        []

    else
        i :: range ( i + 1, j )


countup : number -> List number
countup =
    curry range 1


xs : List number
xs =
    countup 7
