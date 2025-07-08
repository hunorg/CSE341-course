module LectureNotes.AnonymousFunctions exposing (..)


nTimes : (a -> a) -> number -> a -> a
nTimes f n x =
    if n == 0 then
        x

    else
        f (nTimes f (n - 1) x)


tripleNTimes : number -> number -> number
tripleNTimes n x =
    nTimes (\y -> 3 * y) n x



-- Anonymous functions let you define functions *without* naming them,
-- making your code cleaner and more focused when a function is only needed *once*,
-- typically as an argument to a higher-order function.
-- Unlike named functions (fun bindings), anonymous functions can't be recursive,
-- so use named functions if you need recursion.
-- Use anonymous functions to give minimal scope and avoid cluttering your program
-- with one-off helper function names.
