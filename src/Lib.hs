module Lib
  ( dbInit,
    dbProc,
    dbTerm
  ) where

import Control.Monad
import Control.Monad.Trans.Class
import Control.Monad.Trans.Maybe
import Database.LambdaDB

dbInit :: IO DB
dbInit = do
  putStrLn "Initiate DB ..."
  return initDB

dbProc :: DB -> IO ()
dbProc db = void . runMaybeT $ do
  lift . putStrLn $ "DB is now running"
  go db
  where
    go db = do
      com <- lift getLine
      newdb <-
        case com of
          "" -> return db
          _ ->
            case reads com of
              (ComQuit, _):_ -> mzero
              (ComStatus, _):_ -> lift . dbStatus $ db
              (ComInsert k v, _):_ -> lift . dbInsert k v $ db
              (ComDelete k, _):_ -> do
                lift. print $ k
                lift. dbInsert k (DBNone None) $ db
              (ComFind k, _):_ -> lift . dbFind k $ db
              _ -> do
                lift . putStrLn $ "Command Error"
                return db
      go newdb

dbStatus :: DB -> IO DB
dbStatus db = do
  putStrLn "On running"
  return db

dbInsert :: Key -> DBData -> DB -> IO DB
dbInsert k v db = do
  let newdb = insertData k v db
  putStrLn "OK"
  return newdb

dbFind :: Key -> DB -> IO DB
dbFind k db = do
  print . findData k $ db
  return db

dbTerm :: IO ()
dbTerm = putStrLn "Terminate DB"
