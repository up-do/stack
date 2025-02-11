{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Stack.Types.VersionedDownloadInfo
  ( VersionedDownloadInfo (..)
  ) where

import           Data.Aeson.Types ( FromJSON (..) )
import           Data.Aeson.WarningParser
                   ( WithJSONWarnings (..), (..:), withObjectWarnings )
import           Stack.Prelude
import           Stack.Types.DownloadInfo
                   ( DownloadInfo, parseDownloadInfoFromObject )

data VersionedDownloadInfo = VersionedDownloadInfo
  { vdiVersion :: Version
  , vdiDownloadInfo :: DownloadInfo
  }
  deriving Show

instance FromJSON (WithJSONWarnings VersionedDownloadInfo) where
  parseJSON = withObjectWarnings "VersionedDownloadInfo" $ \o -> do
    CabalString version <- o ..: "version"
    downloadInfo <- parseDownloadInfoFromObject o
    pure VersionedDownloadInfo
      { vdiVersion = version
      , vdiDownloadInfo = downloadInfo
      }
