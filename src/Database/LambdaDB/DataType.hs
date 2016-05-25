module Database.LambdaDB.DataType
  ( DBData(..),
    DataType(..),
    None(..),
    Key
  ) where

-- Hackage Libraries
import Data.Set

data DBData = DBNone None
            | DBBool Bool
            | DBChar Char
            | DBInt Int
            | DBInteger Integer
            | DBList ([DBData])
            | DBSet (Set DBData)
            deriving (Eq, Ord, Read)

instance Show DBData where
  showsPrec d r = case r of
    DBNone None -> showString "None"
                   
    DBBool b -> showsPrec (d) b
                
    DBChar c -> showsPrec (d) c
                
    DBInt i -> showsPrec (d) i
               
    DBInteger ii -> showParen (d > app_prec)
                    $ showString "I" . showsPrec (app_prec+1) ii

    DBList l -> showsPrec d l

    DBSet s -> showsPrec d s
    where app_prec = 10

type Key = String

data None = None deriving (Eq, Ord, Show, Read)

class (Eq a, Read a, Show a) => DataType a where
  defaultValue :: a
  toDBData :: a -> DBData
  fromDBData :: DBData -> a

instance DataType None where
  defaultValue = None
  toDBData = DBNone
  fromDBData (DBNone _) = None

instance DataType Bool where
  defaultValue = True
  toDBData = DBBool
  fromDBData (DBBool x) = x

instance DataType Char where
  defaultValue = '\0'
  toDBData = DBChar
  fromDBData (DBChar x) = x

instance DataType Int where
  defaultValue = 0
  toDBData = DBInt
  fromDBData (DBInt x) = x

instance DataType Integer where
  defaultValue = 0
  toDBData = DBInteger
  fromDBData (DBInteger x) = x

instance (DataType a) => DataType [a] where
  defaultValue = []
  toDBData = DBList . fmap toDBData
  fromDBData (DBList x) = fmap fromDBData x

instance (DataType a, Ord a) => DataType (Set a) where
  defaultValue = empty
  toDBData = DBSet . Data.Set.map toDBData
  fromDBData (DBSet x) = Data.Set.map fromDBData x
