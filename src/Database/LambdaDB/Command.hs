module Database.LambdaDB.Command
  ( Command(..)
  ) where

import Data.Char

data Command = ComError | ComQuit | ComStatus | ComInsert | ComFind

validComList :: [Command]
validComList = [ComQuit, ComStatus, ComInsert, ComFind]

comToString :: Command -> String
comToString com = case com of
  ComQuit -> "quit"
  ComStatus -> "status"
  ComInsert -> "insert"
  ComFind -> "find"
  _ -> ""

instance Read Command where
  readsPrec d r =
    (foldl (\acc c -> (readParen (d > app_prec)
                       (\x -> [(c, t) |
                               (s, t) <- lex x,
                               l <- [map toLower s],
                               l == comToString c]) r) ++ acc)
     [] validComList)
    ++
    (readParen (d > app_prec)
     (\x -> [(ComError, t) |
             (s, t) <- lex x ,
             l <- [map toLower s],
             l `notElem` (map comToString validComList)]) r)
    where app_prec = 10
