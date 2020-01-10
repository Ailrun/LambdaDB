import Control.Monad

import Test.QuickCheck
import Database.LambdaDB

instance Arbitrary DBData where
  arbitrary = oneof [ liftM DBNone (return None),
                      liftM DBBool arbitrary,
                      liftM DBChar arbitrary,
                      liftM DBString arbitrary,
                      liftM DBInt arbitrary,
                      liftM DBInteger arbitrary,
                      liftM DBList (sized list')]
    where list' = list'' 5
          list'' 0 _ = return []
          list'' _ 0 = return []
          list'' n m = (:) <$> oneof [ liftM DBNone (return None),
                                    liftM DBBool arbitrary,
                                    liftM DBChar arbitrary,
                                    liftM DBString arbitrary,
                                    liftM DBInt arbitrary,
                                    liftM DBInteger arbitrary,
                                    liftM DBList (list'' n (m-1))] <*> list'' (n-1) m

ruleInsertFind :: Key -> [DBData] -> Bool
ruleInsertFind k vs =
  let ruleHelper key [] db = findData key db == DBNone None
      ruleHelper key [x] db =
        let dbn = insertData key x db
            xFind = findData key dbn
        in xFind == x
      ruleHelper key (x:xs) db =
        let dbn = insertData key x db
            xFind = findData key dbn
        in xFind == x && ruleHelper key xs dbn
  in
    ruleHelper k vs initDB

main :: IO ()
main = quickCheck ruleInsertFind
