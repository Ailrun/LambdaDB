module Lib
  ( dbInit,
    dbProc,
    dbTerm
  ) where

import Control.Monad
import Control.Monad.Trans.Class
import Control.Monad.Trans.Maybe
import Database.LambdaDB
import GHC.Stats

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
        if com == ""
        then mzero
        else runCorrectCommand (reads com)
      go newdb
      where
        runCorrectCommand [] = do
          lift . putStrLn $ "Command Error"
          mzero
        runCorrectCommand ((c, ""):_) = runCommand c
        runCorrectCommand (_:cs) = runCorrectCommand cs

        runCommand ComQuit = mzero
        runCommand ComStatus = lift . dbStatus $ db
        runCommand (ComInsert k v) = lift . dbInsert k v $ db
        runCommand (ComDelete k) = do
          lift . print $ k
          lift . dbInsert k (DBNone None) $ db
        runCommand (ComFind k) = lift . dbFind k $ db

dbStatus :: DB -> IO DB
dbStatus db = do
  putStrLn "On running"
  isRtsStatsEnabled <- getRTSStatsEnabled
  when isRtsStatsEnabled $ do
    rtsStats <- getRTSStats
    putStr "CPU TIME: "
    print $ cpu_ns rtsStats
    putStr "MEMORY USAGE: "
    print $ max_live_bytes rtsStats
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
