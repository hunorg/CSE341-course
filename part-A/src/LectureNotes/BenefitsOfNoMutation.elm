module LectureNotes.BenefitsOfNoMutation exposing (..)

{- THE POWER OF IMMUTABILITY

   In Elm, data is immutable: once created, it CANNOT change. This enables safe and efficient list operations.

   UNDERSTANDING COPYING:
   "Copying" means creating a complete duplicate of data in new memory locations.
   For lists: Creating new nodes with identical values as the original.
-}


append : List a -> List a -> List a
append xs ys =
    case xs of
        [] ->
            -- SAFE: Reuses original list without copying
            -- Why safe? Original CANNOT change!
            ys

        x :: rest ->
            -- SAFE: Builds new heads and reuses tail
            -- Why safe? Original ys cannot change!
            x :: append rest ys



{-
   HOW APPEND WORKS FOR [2,4] AND [5,3,0]:
   1. Creates NEW NODES for new elements:
      - New node for 2
      - New node for 4

   2. REUSES ORIGINAL [5,3,0] without copying:
      - "No copying" = Doesn't duplicate existing elements
      - Uses the EXACT SAME [5,3,0] in memory

   3. Links them: [2] → [4] → [5,3,0]
      Result: [2,4,5,3,0]
-}
{-
   MUTABLE LANGUAGE DILEMMA (Python):

   UNSAFE APPROACH (no copying - shares memory):
      def append(xs, ys):
           if not xs:
               return ys   # Returns original list
           else:
               return [xs[0]] + append(xs[1:], ys)

      y = [5,3,0]
      z = append([2,4], y)  # z shares memory with y
      y[0] = 9              # Mutate original
      print(z)              # [2,4,9,3,0] → Corrupted!

   SAFE APPROACH (requires full copying):
      def append(xs, ys):
           ys_copy = ys.copy()  # COPYING: Creates new list with same values
           if not xs:
               return ys_copy
           else:
               return [xs[0]] + append(xs[1:], ys_copy)

      y = [5,3,0]
      z = append([2,4], y)  # z uses COPY of y
      y[0] = 9              # Mutate original
      print(z)              # [2,4,5,3,0] → Safe but slow

   ELM'S ADVANTAGE:
     • SAFETY: Like safe Python (no corruption)
     • EFFICIENCY: Like unsafe Python (no copying)
     • Achieves both through immutability

   KEY BENEFIT:
     Safe memory reuse without defensive copies
-}
{-
   THE CORE PROBLEM IN MUTABLE LANGUAGES:

   1. You create appended list z from x and y
   2. You use z in critical operations
      - Store in database
      - Send to client
      - Use in calculations
   3. Later, you change original y
   4. z CHANGES RETROACTIVELY!
      - Database now has wrong values
      - Client receives corrupted data
      - Calculations become inconsistent

   ELM'S SOLUTION:
     Immutability guarantees:
     • Once created, z remains [2,4,5,3,0] FOREVER
     • Changing y is IMPOSSIBLE
     • Historical data stays intact
-}
