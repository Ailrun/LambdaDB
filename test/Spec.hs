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
    where list' n = list'' 5 n
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
  let ruleHelper k [] db = (findData k db) == DBNone None
      ruleHelper k (x:[]) db =
        let dbn = insertData k x db
            xFind = (findData k dbn)
        in xFind == x
      ruleHelper k (x:xs) db =
        let dbn = insertData k x db
            xFind = (findData k dbn)
        in xFind == x && ruleHelper k xs dbn
  in
    ruleHelper k vs initDB

main :: IO ()
main = quickCheck ruleInsertFind
