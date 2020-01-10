module Database.LambdaDB.DataType
  ( None(..)
  , DBData(..)
  , Key

  , defaultValue
  , toDBData
  , fromDBData
  ) where

import Data.Set

data None
  = None
  deriving
    ( Eq
    , Ord
    , Show
    , Read
    )

data DBData
  = DBNone None
  | DBBool Bool
  | DBChar Char
  | DBString String
  | DBInt Int
  | DBInteger Integer
  | DBList [DBData]
  | DBSet (Set DBData)
  deriving
    ( Eq
    , Ord
    )

instance Read DBData where
  readsPrec d r
    = foldMap
      (\p -> readParen (d > appPrec) p r)
      [ \x -> [ (DBNone None, t)
              | ("None", t) <- lex x
              ]
      , \x -> [ (DBBool b, t)
              | (b, t) <- readsPrec appPrec1 x
              ]
      , \x -> [ (DBChar c, t)
              | (c, t) <- readsPrec appPrec1 x
              ]
      , \x -> [ (DBString s, t)
              | (s, t) <- readsPrec appPrec1 x
              ]
      , \x -> [ (DBInt i, t)
              | (i, t) <- readsPrec appPrec1 x
              ]
      , \x -> [ (DBInteger ii, t)
              | (ii, s) <- readsPrec appPrec1 x,
                ("i", t) <- lex s
              ]
      , \x -> [ (DBList l, t)
              | (l, t) <- readsPrec appPrec1 x
              ]
      ]

instance Show DBData where
  showsPrec _ (DBNone None) = showString "None"
  showsPrec d (DBBool b) = showsPrec d b
  showsPrec d (DBChar c) = showsPrec d c
  showsPrec _ (DBString s) = showString s
  showsPrec d (DBInt i) = showsPrec d i
  showsPrec d (DBInteger ii)
    = showParen (d > appPrec)
      $ showsPrec appPrec1 ii . showString "i"
  showsPrec d (DBList l) = showsPrec d l
  showsPrec d (DBSet s) = showsPrec d s

appPrec :: Int
appPrec = 10
appPrec1 :: Int
appPrec1 = 11

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
  fromDBData _ = error "fromDBData: invalid DB data"

instance DataType Bool where
  defaultValue = True
  toDBData = DBBool
  fromDBData (DBBool x) = x
  fromDBData _ = error "fromDBData: invalid DB data"

instance DataType Char where
  defaultValue = '\0'
  toDBData = DBChar
  fromDBData (DBChar x) = x
  fromDBData _ = error "fromDBData: invalid DB data"

instance DataType Int where
  defaultValue = 0
  toDBData = DBInt
  fromDBData (DBInt x) = x
  fromDBData _ = error "fromDBData: invalid DB data"

instance DataType Integer where
  defaultValue = 0
  toDBData = DBInteger
  fromDBData (DBInteger x) = x
  fromDBData _ = error "fromDBData: invalid DB data"

instance (DataType a) => DataType [a] where
  defaultValue = []
  toDBData = DBList . fmap toDBData
  fromDBData (DBList x) = fmap fromDBData x
  fromDBData _ = error "fromDBData: invalid DB data"

instance (DataType a, Ord a) => DataType (Set a) where
  defaultValue = empty
  toDBData = DBSet . Data.Set.map toDBData
  fromDBData (DBSet x) = Data.Set.map fromDBData x
  fromDBData _ = error "fromDBData: invalid DB data"
