import Text.Read (readMaybe)
import System.IO (readFile)
import Data.List.Split (splitOn)
import Data.List (sort)


processLines :: [String] -> ([Int], [Int])
processLines lines = 
    ( [read i1 :: Int | (i1, _) <- map (\line -> 
                    let [i1, i2] = splitOn "," line in (i1, i2)) lines],
      [read i2 :: Int | (_, i2) <- map (\line -> 
                    let [i1, i2] = splitOn "," line in (i1, i2)) lines]
    )

countOccurrences :: [Int] -> [Int] -> [Int]
countOccurrences l1 l2 = map (\x -> x * length (filter (== x) l2)) l1

main :: IO ()
main = do
    contents <- readFile "inputDec01.txt"
    let (l1, l2) = processLines (lines contents)
    -- part one
    let sl1 = sort l1
    let sl2 = sort l2
    -- why does abs . uncurry (-) not work?
    let sumZipList = sum (zipWith (\x y -> abs (x - y)) sl1 sl2) 
    print sumZipList
    -- part two
    let occurrences = countOccurrences sl1 sl2
    print (sum occurrences)
    

