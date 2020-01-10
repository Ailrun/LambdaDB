module Database.LambdaDB.DBType
  ( DB(..)
  , initDB
  , insertData
  , findData
  ) where

import Database.LambdaDB.DataType

newtype DB
  = Lambda
    { unLambda::Key -> DBData
    }

initDB :: DB
initDB = Lambda $ const $ DBNone None

insertData :: Key -> DBData -> DB -> DB
insertData key value db
  = Lambda
    $ \x -> if x == key
            then value
            else unLambda db x

findData :: Key -> DB -> DBData
findData = flip unLambda
