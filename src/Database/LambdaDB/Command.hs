module Database.LambdaDB.Command
  ( Command(..)
  ) where

import Data.Char
import Database.LambdaDB.DataType

data Command
  = ComQuit
  | ComStatus
  | ComInsert Key DBData
  | ComDelete Key
  | ComFind Key
  deriving
    ( Show
    )

instance Read Command where
  readsPrec d r
    = foldMap
      (\p -> readParen (d > appPrec) p r)
      [ \x -> [ (ComQuit, t)
              | (s, t) <- lex x,
                "quit" <- [map toLower s]
              ]
      , \x -> [ (ComStatus, t)
              | (s, t) <- lex x,
                "status" <- [map toLower s]
              ]
      , \x -> [(ComInsert k v, w) |
               (s, t) <- lex x,
               "insert" <- [map toLower s],
               (k, u) <- lex t,
               (v, w) <- reads u]
      , \x -> [ (ComDelete k, u)
              | (s, t) <- lex x,
                "delete" <- [map toLower s],
                (k, u) <- lex t
              ]
      , \x -> [ (ComFind k, u)
              | (s, t) <- lex x,
                "find" <- [map toLower s],
                (k, u) <- lex t
              ]
      ]

appPrec :: Int
appPrec = 10
