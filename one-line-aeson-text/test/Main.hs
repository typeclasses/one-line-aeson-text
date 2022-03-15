module Main (main) where

import Data.Aeson
import qualified Data.Aeson.Key as Key
import Data.Aeson.OneLine

import Data.Text (Text)
import qualified Data.Text as Text

import System.Exit

main :: IO ()
main =
    if renderValue val == txt
    then return ()
    else die "Failure"

val :: Value
val = object [ Key.fromString "name" .= Text.pack "Alonzo"
             , Key.fromString "age" .= (3 :: Integer) ]

txt :: Text
txt = Text.pack "{\"age\": 3, \"name\": \"Alonzo\"}"
