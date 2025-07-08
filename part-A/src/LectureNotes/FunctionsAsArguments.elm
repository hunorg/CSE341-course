module LectureNotes.FunctionsAsArguments exposing (..)

{- Functions as arguments

   • We can pass one function as an argument to another function
      - Not a new feature, just never thought to do it before

        f (g, ...) = ... g (...) ...
        h1 ... = ...
        h2 ... = ...
        ... f(h1, ...) ... f(h2, ...) ...

   • Elegant stategy for factoring out common code
      - Replace N similar functions with calls to 1 function where
        you pass in N different (short) functions as arguments
-}


incrementNTimesLame : number -> number -> number
incrementNTimesLame n x =
    if n == 0 then
        x

    else
        1 + incrementNTimesLame (n - 1) x


doubleNTimesLame : number -> number -> number
doubleNTimesLame n x =
    if n == 0 then
        x

    else
        2 * doubleNTimesLame (n - 1) x


nTimes : (a -> a) -> number -> a -> a
nTimes f n x =
    if n == 0 then
        x

    else
        f (nTimes f (n - 1) x)


increment : number -> number
increment x =
    x + 1


double : number -> number
double x =
    x + x


x1 : number
x1 =
    nTimes increment 4 7



-- increment (increment (increment (increment 7))) = 11


x2 : number
x2 =
    nTimes double 4 7



-- double (double (double (double 7))) = 112


addition : number -> number -> number
addition n x =
    nTimes increment n x


doubleNTimes : number -> number -> number
doubleNTimes n x =
    nTimes double n x


triple : number -> number
triple x =
    3 * x


tripleNTimes : number -> number -> number
tripleNTimes n x =
    nTimes triple n x
