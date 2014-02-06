-----------------------------------------------------------------------------
--
-- Module      :  Language.PureScript.Names
-- Copyright   :  (c) Phil Freeman 2013
-- License     :  MIT
--
-- Maintainer  :  Phil Freeman <paf31@cantab.net>
-- Stability   :  experimental
-- Portability :
--
-- |
-- Data types for names
--
-----------------------------------------------------------------------------

{-# LANGUAGE DeriveDataTypeable #-}

module Language.PureScript.Names where

import Data.Data

-- |
-- Names for value identifiers
--
data Ident
  -- |
  -- An alphanumeric identifier
  --
  = Ident String
  -- |
  -- A symbolic name for an infix operator
  --
  | Op String
  -- |
  -- An escaped name
  --
  | Escaped String deriving (Eq, Ord, Data, Typeable)

instance Show Ident where
  show (Ident s) = s
  show (Op op) = '(':op ++ ")"
  show (Escaped s) = s

-- |
-- Proper names, i.e. capitalized names for e.g. module names, type//data constructors.
--
newtype ProperName = ProperName { runProperName :: String } deriving (Eq, Ord, Data, Typeable)

instance Show ProperName where
  show = runProperName

-- |
-- Module names
--
data ModuleName = ModuleName { runModuleName :: ProperName } deriving (Eq, Ord, Data, Typeable)

instance Show ModuleName where
  show (ModuleName name) = show name

-- |
-- A qualified name, i.e. a name with an optional module name
--
data Qualified a = Qualified (Maybe ModuleName) a deriving (Eq, Ord, Data, Typeable)

instance (Show a) => Show (Qualified a) where
  show (Qualified Nothing a) = show a
  show (Qualified (Just (ModuleName name)) a) = show name ++ "." ++ show a

-- |
-- Provide a default module name, if a name is unqualified
--
qualify :: ModuleName -> Qualified a -> (ModuleName, a)
qualify m (Qualified Nothing a) = (m, a)
qualify _ (Qualified (Just m) a) = (m, a)
