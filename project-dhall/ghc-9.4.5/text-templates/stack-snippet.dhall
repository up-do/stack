\(stackage-resolver : Optional Text) ->
  let resolver =
        merge
          { None = ""
          , Some =
              \(r : Text) ->
                ''

                resolver: ${r}''
          }
          stackage-resolver

  in  ''
      user-message: "WARNING: This stack project is generated."

      drop-packages:
        # See https://github.com/commercialhaskell/stack/pull/4712
        - cabal-install

      docker:
        enable: false
        repo: fpco/alpine-haskell-stack:9.2.7

      nix:
        # --nix on the command-line to enable.
        packages:
        - zlib
        - unzip

      flags:
        hackage-security:
          Cabal-syntax: true
        mintty:
          win32-2-13-1: false
        stack:
          developer-mode: true

      ghc-options:
        "$locals": -fhide-source-paths
      ${resolver}
      ''
