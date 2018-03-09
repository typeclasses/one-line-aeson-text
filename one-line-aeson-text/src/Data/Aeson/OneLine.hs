module Data.Aeson.OneLine
    ( renderValue
    , renderObject
    , renderArray
    ) where

-- aeson
import qualified Data.Aeson.Text        as Aeson
import qualified Data.Aeson.Types       as Aeson

-- base
import qualified Data.Foldable          as Foldable
import           Prelude                hiding ((+))

-- text
import           Data.Text              (Text)
import qualified Data.Text              as Text
import qualified Data.Text.Lazy         as LText
import qualified Data.Text.Lazy.Builder as LText

-- unordered-containers
import qualified Data.HashMap.Lazy      as HashMap

(+) :: Text -> Text -> Text
(+) = Text.append

commaSeparate :: [Text] -> Text
commaSeparate = Text.intercalate (Text.pack ", ")

-- | Show an aeson value is a one-line format with a single
-- space after each comma and colon, which should be suitable
-- for human reading as long as the value isn't too large.
--
-- >>> import Data.Aeson
--
-- >>> :{
-- >>> val = object [ Text.pack "name" .= Text.pack "Alonzo"
-- >>>              , Text.pack "age" .= 3 ]
-- >>> :}
--
-- >>> (putStrLn . Text.unpack . renderValue) val
-- {"age": 3, "name": "Alonzo"}

renderValue :: Aeson.Value -> Text
renderValue val =
    case val of
        -- For objects and arrays, we customize the rendering.
        Aeson.Object x -> renderObject x
        Aeson.Array  x -> renderArray x

        -- For the rest of the constructors, we
        -- render the value just like Aeson does.
        x              -> renderTerse x

-- | Show an aeson value the way the aeson library does it, in a
-- terse style not intended for human reading.

renderTerse :: Aeson.Value -> Text
renderTerse =
    LText.toStrict . LText.toLazyText . Aeson.encodeToTextBuilder

renderObject :: Aeson.Object -> Text
renderObject obj =
    Text.pack "{" + x + Text.pack "}"
    where
        x = commaSeparate (f <$> HashMap.toList obj)
        f (k, v) = renderTerse (Aeson.String k) +
                   Text.pack ": " + renderValue v

renderArray :: Aeson.Array -> Text
renderArray arr =
    Text.pack "[" + x + Text.pack "]"
    where
        x = commaSeparate (renderValue <$> Foldable.toList arr)
