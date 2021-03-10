import System.Environment
import System.Process

main =
  getEnv "ghc" >>= \ghc ->
    case ghc of
      "8.8.3"  -> callProcess "cabal" ["test"
                  , "--constraint=aeson == 1.4.4.0"
                  , "--constraint=text == 1.2.4.0"
                  , "--constraint=unordered-containers == 0.2.10.0"
                  ]
      "9.0.1" -> callProcess "cabal" ["test"
                  , "--constraint=aeson == 1.5.*"
                  ]
      _ -> callProcess "cabal" ["test"]
