{-# LANGUAGE LambdaCase #-}

import Control.Monad
import Data.List
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
      io = liftIO

      -- inNixShell pure nixpkgsURL ps command =
      --   cmd "nix-shell" [ "-p"
      --                   , unwords [ "with import (fetchTarball"
      --                             , nixpkgsURL -- TODO: make a Maybe
      --                             , ") { }; haskellPackages.cabal2nix"
      --                             ]
      --                   , if pure then "--pure" else ""
      --                   , "--run"
      --                   , unwords command
      --                   ]
  in shakeArgsWith sOpts sFlags $ \flags rawArgs -> return $ Just $ do
    want rawArgs

    ".build/*" %> \out -> do
      -- let nix figure out whether we should rerun
      alwaysRerun

      let pkg = takeBaseName out

      need [galoisNix]

      (Exit code, Stdout out, Stderr err) <-
        cmd "nix-build" [ galoisNix
                        , "-A"
                        , "haskellPackages." ++ pkg
                        , "--out-link"
                        , ".build/" ++ pkg
                        ]

      -- Write a log when the build fails
      when (code /= ExitSuccess) $ do
        let logFile = concat [".build/", pkg]
        io $ writeFile (logFile ++ ".log") (unlines [out, err])

        -- A condensed log with just the causes of failure
        Stdout grepOut <-
          cmd "grep" [ "--extended-regexp"
                     , "--context=5"
                     , "(error|fail)"
                     , logFile ++ ".log"
                     ]
        io $ writeFile (logFile ++ ".fail.log") grepOut

    "overlays/pkgs/haskell/updates/*.nix" %> \out -> do
      io $ putStrLn "Owner?"
      owner <- io $ getLine
      let pkg = takeBaseName out
      let unstableURL = "https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz"
      let pkgURL = concat ["https://github.com/", owner, "/", pkg, ".git"]
      Stdout nixShellOut <-
        cmd "nix-shell" [ "-p"
                        , unwords [ "with import (fetchTarball"
                                  , unstableURL
                                  , ") { }; haskellPackages.cabal2nix"
                                  ]
                        , "-p"
                        , "nix-prefetch-git"
                        , "-p"
                        , "nix-prefetch-hg"
                        , "--run"
                        , unwords ["cabal2nix", pkgURL]
                        ]

      io $ writeFile out nixShellOut

    phony "build" $ do
      need $ map (".build/"++) [ "saw-script" ] -- TODO more
