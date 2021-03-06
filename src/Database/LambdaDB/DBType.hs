module Database.LambdaDB.DBType
  (
    DB(..),
    initDB,
    insertData,
    findData
  ) where

-- Custom Libraries
import Database.LambdaDB.DataType

newtype DB = Lambda {unLambda::Key -> DBData}

initDB :: DB
initDB = Lambda
         $ \_ -> DBNone None

insertData :: Key -> DBData -> DB -> DB
insertData key value db = Lambda
                          $ \x -> if x == key then
                                    value
                                  else
                                    unLambda db x

findData :: Key -> DB -> DBData
findData key db = unLambda db key
