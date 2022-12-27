-- | The module of this name differs as between Windows and non-Windows builds.
-- This is the Windows version.
module System.Permissions
  ( setScriptPerms
  , osIsWindows
  , setFileExecutable
  ) where

-- | True if using Windows OS.
osIsWindows :: Bool
osIsWindows = True

setScriptPerms :: Monad m => FilePath -> m ()
setScriptPerms _ = pure ()

setFileExecutable :: Monad m => FilePath -> m ()
setFileExecutable _ = pure ()
