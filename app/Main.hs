module Main where

import Lib

main :: IO ()
main = do
  d <- dbInit
  dbProc d
  dbTerm
