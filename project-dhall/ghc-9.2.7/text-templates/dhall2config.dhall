\(stackage-resolver : Text) ->
\(ghc-version : Text) ->
  let project-dhall2config = ../../../updo/text-templates/dhall2config.dhall

  in  ''
      ${project-dhall2config stackage-resolver ghc-version}
      ${./cabal-snippet.dhall}
      ''
