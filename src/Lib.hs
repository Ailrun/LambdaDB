module Lib
  ( dbInit,
    dbProc,
    dbTerm
  ) where

-- Standard libraries
import Data.Data

import Control.Monad
import Control.Monad.Trans.Class
import Control.Monad.Trans.Maybe

-- Custom libraries
import Database.LambdaDB

dbInit :: IO DB
dbInit = do
  putStrLn "Initiate DB ..."
  return initDB

dbProc :: DB -> IO ()
dbProc d = void . runMaybeT $ do
  lift . putStrLn $ "DB is now running"
  void . g $ d
  return ()
  where g db = do
          com <- lift getLine
          newdb <- case com of
                  "" -> lift . return $ db
                  _ ->
                    case (read com) of
                      ComQuit -> mzero
                      ComStatus -> lift . dbStatus $ db
                      ComInsert -> lift . dbInsert $ db
                      ComFind -> lift . dbFind $ db
                      _ -> do
                        lift . putStrLn $ "Command Error"
                        return db
          g newdb

dbStatus :: DB -> IO DB
dbStatus db = do
  putStrLn "On running"
  return db

dbInsert :: DB -> IO DB
dbInsert db = do
  putStrLn "Input Insert Key:"
  k <- getLine
  putStrLn "Input Insert Value:"
  v <- getLine
  return . insertData k (read v::DBData) $ db

dbFind :: DB -> IO DB
dbFind db = do
  putStrLn "Input Find Key:"
  k <- getLine
  putStrLn . show . findData k $ db
  return db

dbTerm :: IO ()
dbTerm = putStrLn "Terminate DB"
