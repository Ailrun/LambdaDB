module Main where

import Lib

main :: IO ()
main = do
  dbInit
  dbProc
  dbTerm
