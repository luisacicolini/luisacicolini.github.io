-- We need to first find the digits of a number. Define the functions

-- toDigits :: Integer -> [Integer]
-- toDigitsRev :: Integer -> [Integer]

-- toDigits should convert positive Integers to a list of digits. (For 0 or
-- negative inputs, toDigits should return the empty list.) toDigitsRev
-- should do the same, but with the digits reversed.

getLsb :: Int -> [Int] 
getLsb n = [(n `div` 10)] ++ [n `mod` 10]

getLsbRev :: Int -> [Int] 
getLsbRev n = [n `mod` 10] ++ [(n `div` 10)]

toDigits :: Int -> [Int]
toDigits n 
    | n <= 0 = []
    | otherwise = getLsb n
    
toDigitsRev :: Int -> [Int]
toDigitsRev n 
    | n <= 0 = []
    | otherwise = getLsbRev n

-- Once we have the digits in the proper order, we need to double every other one. Define a function

-- doubleEveryOther :: [Integer] -> [Integer]

-- Remember that doubleEveryOther should double every other number beginning from the right, that is, the second-to-last, fourth-to-last

doubleEveryOther :: [Int] -> Int -> [Int]
doubleEveryOther [] y = []
doubleEveryOther [x] y = [x]
doubleEveryOther (f:s:rest) y 
    | y == 0 = doubleEveryOther (reverse (f:s:rest)) 1
    | otherwise = [f] ++ [s**2] ++ (doubleEveryOther rest 1)



