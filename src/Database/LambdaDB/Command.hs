module Database.LambdaDB.Command
  ( Command(..)
  ) where

import Data.Char

import Database.LambdaDB.DataType

data Command = ComError
             | ComQuit
             | ComStatus
             | ComInsert Key DBData
             | ComFind Key
             deriving (Show)

instance Read Command where
  readsPrec d r =
    readParen (d > app_prec)
    (\x -> [(ComQuit, t) |
            (s, t) <- lex x,
            "quit" <- [map toLower s]]) r
    ++
    readParen (d > app_prec)
    (\x -> [(ComStatus, t) |
            (s, t) <- lex x,
            "status" <- [map toLower s]]) r
    ++
    readParen (d > app_prec)
    (\x -> [(ComInsert k (read y), w) |
            (s, t) <- lex x,
            "insert" <- [map toLower s],
            (k, u) <- lex t,
            (y, w) <- lex u]) r
    ++
    readParen (d > app_prec)
    (\x -> [(ComFind k, u) |
             (s, t) <- lex x,
             "find" <- [map toLower s],
             (k, u) <- lex t]) r
    where app_prec = 10
