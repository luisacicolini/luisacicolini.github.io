import Text.Read (readMaybe)
import System.IO (readFile)
import Data.List.Split (splitOn)
import Data.List (sort)
import Data.ByteString (count)
import Data.Char (isLatin1)


processLines :: [String] -> [[Int]]
processLines = map (map read . splitOn " ")

monotoneRecord :: [Int] -> [Bool]
monotoneRecord [] = []
monotoneRecord [x] = [True]
monotoneRecord (x:y:xs) 
    | x > y = -1 : monotoneRecord (y : xs)
    | x < y = 1 : monotoneRecord (y : xs)
    | otherwise = 0 : monotoneRecord (y : xs)





isLevelSafe :: [Int] -> [Bool]
isLevelSafe xs = all (== x) (monotoneRecord xs) && all (== x) (isLevelSafeCondition xs)
  where
    isLevelSafeCondition (x:y:xs) = abs (x - y) >= 1 && abs (x - y) <= 3 ++ isLevelSafeCondition (y:xs)
    isLevelSafeCondition _ = True

problemDampener :: [Int] -> [Int]
problemDampener [] = []
problemDampener [x] = [x]
problemDampener xs
    | monotonicFails == 1 && levelSafeFails == 0 = removeAt (findFailIndex isMonotonic xs) xs
    | monotonicFails == 0 && levelSafeFails == 1 = removeAt (findFailIndex isLevelSafeCondition xs) xs
    | monotonicFails == 1 && levelSafeFails == 1 = xs -- Both fail exactly once; no action
    | monotonicFails > 1 || levelSafeFails > 1   = xs -- Multiple failures; no action
    | otherwise                                  = xs -- No failures; return unchanged
  where
    monotonicFails = countFails isMonotonic xs
    levelSafeFails = countFails isLevelSafeCondition xs

countFails :: ([Int] -> Bool) -> [Int] -> Int
countFails condition xs = length (filter (not . condition . (:[])) xs)

findFailIndex :: ([Int] -> Bool) -> [Int] -> Int
findFailIndex condition xs = head [i | (i, x) <- zip [0..] xs, not (condition [x])]

removeAt :: Int -> [a] -> [a]
removeAt i xs = take i xs ++ drop (i + 1) xs


countSafeLevels :: [[Int]] -> Int
countSafeLevels n = length (filter id (map isLevelSafe n))


main :: IO ()
main = do
    contents <- readFile "inputDec02.txt"
    let lists = processLines (lines contents)
    -- part one
    print (countSafeLevels lists)
    -- part two 



