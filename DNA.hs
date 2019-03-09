-- ---------------------------------------------------------------------
-- DNA Analysis 
-- CS300 Spring 2018
-- Due: 24 Feb 2018 @9pm
-- ------------------------------------Assignment 2------------------------------------
--
-- >>> YOU ARE NOT ALLOWED TO IMPORT ANY LIBRARY
-- Functions available without import are okay
-- Making new helper functions is okay
--
-- ---------------------------------------------------------------------
--
-- DNA can be thought of as a sequence of nucleotides. Each nucleotide is 
-- adenine, cytosine, guanine, or thymine. These are abbreviated as A, C, 
-- G, and T.
--
type DNA = [Char]
type RNA = [Char]
type Codon = [Char]
type AminoAcid = Maybe String
type Protein = [Char]

-- ------------------------------------------------------------------------
-- 				PART 1
-- ------------------------------------------------------------------------				

-- We want to calculate how alike are two DNA strands. We will try to 
-- align the DNA strands. An aligned nucleotide gets 3 points, a misaligned
-- gets 2 points, and inserting a gap in one of the strands gets 1 point. 
-- Since we are not sure how the next two characters should be aligned, we
-- try three approaches and pick the one that gets us the maximum score.
-- 1) Align or misalign the next nucleotide from both strands
-- 2) Align the next nucleotide from first strand with a gap in the second     
-- 3) Align the next nucleotide from second strand with a gap in the first    
-- In all three cases, we calculate score of leftover strands from recursive 
-- call and add the appropriate penalty.                                    

score :: DNA -> DNA -> Int
score [] [] = 0
score [] (y:ys) = length (y:ys)
score (x:xs) [] = length (x:xs)
--score (x:xs) (y:ys) = if (x == y) then max (3 + score xs ys) (max (1 + score (x:xs) ys) (1 + score xs (y:ys)) (2 + score xs ys)) else (max (1 + score x:xs ys) (1 + score xs y:ys) (2 + score xs ys))--case1 (max case2 case3 case4) else if (x /= y) then max case2 case3 case4 where
          --              case1 = 3 + score xs ys
          --              case2 = 1 + score x ys
          --              case3 = 1 + score xs y
          --              case4 = 2 + score xs ys
score (x:xs) (y:ys) = 3 + score xs ys             
{-
insertSpaces :: [Char] -> [Char] -> [Char] -> [Char]
insertSpaces (x:xs) (y:ys) 
    | length(x:xs) > length(y:ys) = (permutations (" " ++ x:xs)) (y:ys)
    | length(x:xs) < length(y:ys) = (x:xs) (permutations (" " ++ y:ys))
    | length(x:xs) == length(y:ys) = (x:xs) (y:ys) -}

-- -------------------------------------------------------------------------
--				PART 2
-- -------------------------------------------------------------------------
-- Write a function that takes a list of DNA strands and returns a DNA tree. 
-- For each DNA strand, make a separate node with zero score 
-- in the Int field. Then keep merging the trees. The merging policy is:
-- 	1) Merge two trees with highest score. Merging is done by making new
--	node with the smaller DNA (min), and the two trees as subtrees of this
--	tree
--	2) Goto step 1 :)
--

data DNATree = Node DNA Int DNATree DNATree | Nil deriving (Ord, Show, Eq)

makeDNATree :: [DNA] -> DNATree
makeDNATree = undefined

-- -------------------------------------------------------------------------
--				PART 3
-- -------------------------------------------------------------------------

-- Even you would have realized it is hard to debug and figure out the tree
-- in the form in which it currently is displayed. Lets try to neatly print 
-- the DNATree. Each internal node should show the 
-- match score while leaves should show the DNA strand. In case the DNA strand 
-- is more than 10 characters, show only the first seven followed by "..." 
-- The tree should show like this for an evolution tree of
-- ["AACCTTGG","ACTGCATG", "ACTACACC", "ATATTATA"]
--
-- 20
-- +---ATATTATA
-- +---21
--     +---21
--     |   +---ACTGCATG
--     |   +---ACTACACC
--     +---AACCTTGG
--
-- Make helper functions as needed. It is a bit tricky to get it right. One
-- hint is to pass two extra string, one showing what to prepend to next 
-- level e.g. "+---" and another to prepend to level further deep e.g. "|   "
{-
draw :: DNATree -> [Char]
draw = undefined

-- ---------------------------------------------------------------------------
--				PART 4
-- ---------------------------------------------------------------------------
--
--
-- Our score function is inefficient due to repeated calls for the same 
-- suffixes. Lets make a dictionary to remember previous results. First you
-- will consider the dictionary as a list of tuples and write a lookup
-- function. Return Nothing if the element is not found. Also write the 
-- insert function. You can assume that the key is not already there.
type Dict a b = [(a,b)]

lookupDict :: (Eq a) => a -> Dict a b -> Maybe b
lookupDict = undefined

insertDict :: (Eq a) => a -> b -> (Dict a b)-> (Dict a b)
insertDict = undefined

-- We will improve the score function to also return the alignment along
-- with the score. The aligned DNA strands will have gaps inserted. You
-- can represent a gap with "-". You will need multiple let expressions 
-- to destructure the tuples returned by recursive calls.

alignment :: String -> String -> ((String, String), Int)
alignment = undefined

-- We will now pass a dictionary to remember previously calculated scores 
-- and return the updated dictionary along with the result. Use let 
-- expressions like the last part and pass the dictionary from each call
-- to the next. Also write logic to skip the entire calculation if the 
-- score is found in the dictionary. You need just one call to insert.
type ScoreDict = Dict (DNA,DNA) Int

scoreMemo :: (DNA,DNA) -> ScoreDict -> (ScoreDict,Int)
scoreMemo = undefined
-- In this part, we will use an alternate representation for the 
-- dictionary and rewrite the scoreMemo function using this new format.
-- The dictionary will be just the lookup function so the dictionary 
-- can be invoked as a function to lookup an element. To insert an
-- element you return a new function that checks for the inserted
-- element and returns the old dictionary otherwise. You will have to
-- think a bit on how this will work. An empty dictionary in this 
-- format is (\_->Nothing)

type Dict2 a b = a->Maybe b
insertDict2 :: (Eq a) => a -> b -> (Dict2 a b)-> (Dict2 a b)
insertDict2 = undefined

type ScoreDict2 = Dict2 (DNA,DNA) Int

scoreMemo2 :: (DNA,DNA) -> ScoreDict2 -> (ScoreDict2,Int)
scoreMemo2 = undefined
-}
-- ---------------------------------------------------------------------------
-- 				PART 5
-- ---------------------------------------------------------------------------

-- Now, we will try to find the mutationDistance between two DNA sequences.
-- You have to calculate the number of mutations it takes to convert one 
-- (start sequence) to (end sequence). You will also be given a bank of 
-- sequences. However, there are a couple of constraints, these are as follows:

-- 1) The DNA sequences are of length 8
-- 2) For a sequence to be a part of the mutation distance, it must contain 
-- "all but one" of the neuclotide bases as its preceding sequence in the same 
-- order AND be present in the bank of valid sequences
-- 'AATTGGCC' -> 'AATTGGCA' is valid only if 'AATTGGCA' is present in the bank
-- 3) Assume that the bank will contain valid sequences and the start sequence
-- may or may not be a part of the bank.
-- 4) Return -1 if a mutation is not possible
-- mutationDistance "AATTGGCC" "TTTTGGCA" ["AATTGGAC", "TTTTGGCA", "AAATGGCC" "TATTGGCC", "TTTTGGCC"] == 3
-- mutationDistance "AAAAAAAA" "AAAAAATT" ["AAAAAAAA", "AAAAAAAT", "AAAAAATT", "AAAAATTT"] == 2


mutationDistance :: DNA -> DNA -> [DNA] -> Int
mutationDistance (x:xs) (y:ys) bank
                | elem (y:ys) bank == False = -1
    {-}            | otherwise = 
nextMutation :: DNA -> [DNA] -> DNA
nextMutation :: (x:xs) (y:ys)
                    |-} 
-- ---------------------------------------------------------------------------
-- 				PART 6
-- ---------------------------------------------------------------------------
--
-- Now, we will write a function to transcribe DNA to RNA. 
-- The difference between DNA and RNA is of just one base i.e.
-- instead of Thymine it contains Uracil. (U)
--
transcribeDNA :: DNA -> RNA
transcribeDNA (x:xs) = undefined
        --    | x == 'T' = 'U' : transcribeDNA xs
          --  | otherwise = x : transcribeDNA xs
-- Next, we will translate RNA into proteins. A codon is a group of 3 neuclotides 
-- and forms an aminoacid. A protein is made up of various amino acids bonded 
-- together. Translation starts at a START codon and ends at a STOP codon. The most
-- common start codon is AUG and the three STOP codons are UAA, UAG and UGA.
-- makeAminoAcid should return Nothing in case of a STOP codon.
-- Your translateRNA function should return a list of proteins present in the input
-- sequence. 
-- Please note that the return type of translateRNA is [String], you should convert
-- the abstract type into a concrete one.
-- You might wanna use the RNA codon table from 
-- https://www.news-medical.net/life-sciences/RNA-Codons-and-DNA-Codons.aspx
-- 
--
makeAminoAcid :: Codon -> AminoAcid
makeAminoAcid "UAA" = Nothing
makeAminoAcid "UAG" = Nothing
makeAminoAcid "UGA" = Nothing
makeAminoAcid "AUG" = Just "Met"
makeAminoAcid "UUU" = Just "Phe"
makeAminoAcid "UUC" = Just "Phe"
makeAminoAcid "UUA" = Just "Leu"
makeAminoAcid "UUG" = Just "Leu"
makeAminoAcid "CUU" = Just "Leu"
makeAminoAcid "CUC" = Just "Leu"
makeAminoAcid "CUA" = Just "Leu"
makeAminoAcid "CUG" = Just "Leu"
makeAminoAcid "AUU" = Just "Ile"
makeAminoAcid "AUC" = Just "Ile"
makeAminoAcid "AUA" = Just "Ile"
makeAminoAcid "GUU" = Just "Val"
makeAminoAcid "GUC" = Just "Val"
makeAminoAcid "GUA" = Just "Val"
makeAminoAcid "GUG" = Just "Val"
makeAminoAcid "UCU" = Just "Ser"
makeAminoAcid "UCC" = Just "Ser"
makeAminoAcid "UCA" = Just "Ser"
makeAminoAcid "UCG" = Just "Ser"
makeAminoAcid "CCU" = Just "Pro"
makeAminoAcid "CCC" = Just "Pro"
makeAminoAcid "CCA" = Just "Pro"
makeAminoAcid "CCG" = Just "Pro"
makeAminoAcid "ACU" = Just "Thr"
makeAminoAcid "ACC" = Just "Thr"
makeAminoAcid "ACA" = Just "Thr"
makeAminoAcid "ACG" = Just "Thr"
makeAminoAcid "GCU" = Just "Ala"
makeAminoAcid "GCC" = Just "Ala"
makeAminoAcid "GCA" = Just "Ala"
makeAminoAcid "GCG" = Just "Ala"
makeAminoAcid "UAU" = Just "Tyr"
makeAminoAcid "UAC" = Just "Tyr"
makeAminoAcid "CAU" = Just "His"
makeAminoAcid "CAC" = Just "His"
makeAminoAcid "CAA" = Just "Gln"
makeAminoAcid "CAG" = Just "Gln"
makeAminoAcid "AAU" = Just "Asn"
makeAminoAcid "AAC" = Just "Asn"
makeAminoAcid "AAA" = Just "Lys"
makeAminoAcid "AAG" = Just "Lys"
makeAminoAcid "GAU" = Just "Asp"
makeAminoAcid "GAC" = Just "Asp"
makeAminoAcid "GAA" = Just "Glu"
makeAminoAcid "GAG" = Just "Glu"
makeAminoAcid "UGU" = Just "Cys"
makeAminoAcid "UGC" = Just "Cys"
makeAminoAcid "UGG" = Just "Trp"
makeAminoAcid "CGU" = Just "Arg"
makeAminoAcid "CGC" = Just "Arg"
makeAminoAcid "CGA" = Just "Arg"
makeAminoAcid "CGG" = Just "Arg"
makeAminoAcid "AGU" = Just "Ser"
makeAminoAcid "AGC" = Just "Ser"
makeAminoAcid "AGA" = Just "Arg"
makeAminoAcid "AGG" = Just "Arg"
makeAminoAcid "GGU" = Just "Gly"
makeAminoAcid "GGC" = Just "Gly"
makeAminoAcid "GGA" = Just "Gly"
makeAminoAcid "GGG" = Just "Gly"

codonify :: Int -> [a] -> [[a]]
codonify _ [] = []
codonify n l
  | n > 0 = (take n l) : (codonify n (drop n l))

realVal :: Maybe [Char] -> [Char] 
realVal Nothing = "STOP"
realVal (Just x) = x

removeHeader :: [String] -> [String]
removeHeader (x:xs) = if (x == "Met") then x:xs else removeHeader xs

removeTail :: [String] -> [String]
removeTail (x:xs) = take (lengthToStop (x:xs)) (x:xs)

lengthToStop :: [String] -> Int
lengthToStop (x:xs)
  | x == "STOP" = 1
  | otherwise =  1 + lengthToStop xs
translateRNA :: RNA -> [String]
translateRNA [] = ["Nothing"]
translateRNA (x:xs) = removeTail (removeHeader (map realVal (map makeAminoAcid (codonify 3 (x:xs)))))
