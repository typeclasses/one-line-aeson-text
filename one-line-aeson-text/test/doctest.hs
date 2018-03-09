import Test.DocTest

main :: IO ()
main =
  doctest [ "-isrc", "src/Data/Aeson/OneLine.hs" ]
