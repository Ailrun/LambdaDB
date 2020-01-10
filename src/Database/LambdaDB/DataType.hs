module Database.LambdaDB.DataType
  ( None(..),
    DBData(..),
    Key
  ) where

-- Hackage Libraries
import Data.Set

data None = None deriving (Eq, Ord, Show, Read)

data DBData = DBNone None
            | DBBool Bool
            | DBChar Char
            | DBString String
            | DBInt Int
            | DBInteger Integer
            | DBList [DBData]
            | DBSet (Set DBData)
            deriving (Eq, Ord)

instance Read DBData where
  readsPrec d r =
    readParen (d > app_prec)
    (\x -> [(DBNone None, t) |
            ("None", t) <- lex x]) r
    ++ readParen (d > app_prec)
    (\x -> [(DBBool b, t) |
            (b, t) <- readsPrec (app_prec + 1) x]) r
    ++ readParen (d > app_prec)
    (\x -> [(DBChar c, t) |
            (c, t) <- readsPrec (app_prec + 1) x]) r
    ++ readParen (d > app_prec)
    (\x -> [(DBString s, t) |
            (s, t) <- readsPrec (app_prec + 1) x]) r
    ++ readParen (d > app_prec)
    (\x -> [(DBInt i, t) |
            (i, t) <- readsPrec (app_prec + 1) x]) r
    ++ readParen (d > app_prec)
    (\x -> [(DBInteger ii, t) |
            (ii, s) <- readsPrec (app_prec + 1) x,
            ("i", t) <- lex s]) r
    ++ readParen (d > app_prec)
    (\x -> [(DBList l, t) |
            (l, t) <- readsPrec (app_prec + 1) x]) r
    where app_prec = 10

instance Show DBData where
  showsPrec d r = case r of
    DBNone None -> showString "None"
    DBBool b -> showsPrec d b
    DBChar c -> showsPrec d c
    DBString s -> showString s
    DBInt i -> showsPrec d i
    DBInteger ii -> showParen (d > app_prec)
                    $ showsPrec (app_prec+1) ii . showString "i"
    DBList l -> showsPrec d l
    DBSet s -> showsPrec d s
    where app_prec = 10

type Key = String

-- Is this needed?
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
