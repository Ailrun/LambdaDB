import Control.Monad

import Test.QuickCheck
import Database.LambdaDB

main :: IO ()
main = quickCheck ruleInsertFind

ruleInsertFind :: Key -> [DBData] -> Bool
ruleInsertFind k vs =
    ruleHelper k vs initDB
  where
    ruleHelper key [] db = findData key db == DBNone None
    ruleHelper key [x] db =
      let dbn = insertData key x db
          xFind = findData key dbn
      in xFind == x
    ruleHelper key (x:xs) db =
      let dbn = insertData key x db
          xFind = findData key dbn
      in xFind == x && ruleHelper key xs dbn

instance Arbitrary DBData where
  arbitrary = go (sized (list 5))
    where
      list 0 _ = return []
      list _ 0 = return []
      list n m = (:) <$> go (list n (m - 1)) <*> list (n-1) m

      go arbitraryList
        = oneof
          [ liftM DBNone (return None)
          , liftM DBBool arbitrary
          , liftM DBChar arbitrary
          , liftM DBString arbitrary
          , liftM DBInt arbitrary
          , liftM DBInteger arbitrary
          , liftM DBList arbitraryList
          ]
