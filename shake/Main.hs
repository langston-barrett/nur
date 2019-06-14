{-# LANGUAGE LambdaCase #-}

import Control.Monad
import System.Exit (ExitCode(..))

import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util

data ShakeFlags
  = SFPackage String
 deriving (Eq, Ord, Read, Show)

main :: IO ()
main =
  let buildDir = ".build"
      sOpts = (shakeOptions { shakeFiles = buildDir })
      sFlags = []
      galoisNix = "galois.nix"
  in shakeArgsWith sOpts sFlags $ \flags rawArgs -> return $ Just $ do
    want rawArgs

    ".build/*" %> \out -> do
      -- let nix figure out whether we should rerun
      alwaysRerun

      let pkg = takeBaseName out

      need [galoisNix]

      (Exit code, Stdout out, Stderr err) <-
        cmd "nix-build" [ galoisNix, "-A", "haskellPackages." ++ pkg ]

      -- Write a log when the build fails
      when (code /= ExitSuccess) $ liftIO $
        writeFile (".build/" ++ pkg ++ ".log") (unlines [out, err])


    phony "build" $ do
      need $ map (".build/"++) [ "saw-script" ] -- TODO more
