{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

-- | Types used by @Stack.Storage@ modules.
module Stack.Types.Storage
  ( StoragePrettyException (..)
  ) where

import           Data.Text
import           Stack.Prelude

-- | Type representing \'pretty\' exceptions thrown by functions exported by
-- modules beginning @Stack.Storage@.
data StoragePrettyException
  = StorageMigrationFailure !Text !(Path Abs File) !SomeException
  deriving Typeable

-- | These exceptions are intended to be thrown only as \'pretty\' exceptions,
-- so their \'show\' functions can be simple.
instance Show StoragePrettyException where
  show (StorageMigrationFailure {}) = "StorageMigrationFailure"

instance Pretty StoragePrettyException where
  pretty (StorageMigrationFailure desc fp ex) =
    "[S-8835]"
    <> line
    <>     flow "Stack could not migrate the the database"
       <+> style File (fromString $ show desc)
       <+> flow "located at"
       <+> style Dir (pretty fp)
    <> "."
    <> blankLine
    <> flow "While migrating the database, Stack encountered the exception:"
    <> blankLine
    <> string exMsg
    <> blankLine
    <>     flow "Please report this as an issue at"
       <+> style Url "https://github.com/commercialhaskell/stack/issues"
    <> "."
    <> blankLine
    -- See https://github.com/commercialhaskell/stack/issues/5851
    <> if exMsg == winIOGHCRTSMsg
         then
           flow "This exception can be caused by a bug that arises if GHC's \
                \'--io-manager=native' RTS option is set using the GHCRTS \
                \environment variable. As a workaround try setting the option \
                \in the project's Cabal file, Stack's YAML configuration file \
                \or at the command line."
         else
           flow "As a workaround you may delete the database. This \
                \will cause the database to be recreated."
   where
    exMsg = show ex
    winIOGHCRTSMsg =
      "\\\\.\\NUL: hDuplicateTo: illegal operation (handles are incompatible)"

instance Exception StoragePrettyException