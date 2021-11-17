import System.Environment
import System.Process

main =
  getEnv "ghc" >>= \ghc ->
    case ghc of
      "8.8.3"  -> callProcess "cabal" ["test"
                  , "--constraint=aeson == 2.0.0.0"
                  , "--constraint=text == 1.2.4.0"
                  ]
      "9.0.1" -> callProcess "cabal" ["test"]
      _ -> callProcess "cabal" ["test"]
