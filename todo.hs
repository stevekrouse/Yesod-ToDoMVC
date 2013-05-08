{-# LANGUAGE TypeFamilies, QuasiQuotes, MultiParamTypeClasses,
             TemplateHaskell, OverloadedStrings, CPP #-}

module ToDo where

import Yesod
import Settings (widgetFile)
{-
Imports for dealing with sessions

import Data.Aeson as A
import Control.Applicative ((<$>), (<*>))
import Control.Monad
import Data.Maybe
import Data.Text as T (pack, unpack)
import Data.ByteString.Lazy.Char8 as B (pack, unpack)
-}

data ToDo = ToDo

mkYesod "ToDo" [parseRoutes|
/ HomeR GET
|]

instance Yesod ToDo

getHomeR :: Handler RepHtml
getHomeR = defaultLayout $ do
             {-
             Having some fun storing and retriving data in sessions.
             Unfortunately, I wasn't able to get the Fay to work.
             To demostrate they work, I put them in a Hamlet file,
             entitled 'homepage_with_sessions.hamlet'. Rename it to
             'homepaeg.hamlet' to see that functionality.
             
             lift $ setSession "items" (T.pack $ B.unpack $ encode [Item 3 "shalom" True, Item 4 "chrisdone" False])
             items <- lift $ (fromJust <$> decode <$> B.pack <$> T.unpack <$>
                              fromJust <$> lookupSession "items" :: GHandler s m
                                                                    [Item])
             -}
             --JQuery
             addScriptRemote "http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"
             --Handlebars
             addScriptRemote "http://cdnjs.cloudflare.com/ajax/libs/handlebars.js/1.0.0-rc.3/handlebars.min.js"
             --My Fay file compiled and hosted
             addScriptRemote "http://f.cl.ly/items/0Y2C203Q18170u460Q1v/fay.js"
             $(widgetFile "homepage")            

{-
Data types and methods for parsing, storing and retriving todos from the session.

data Item = Item Int String Bool
          deriving (Show)

instance FromJSON Item where
  parseJSON (Object v) = Item <$>
                        v .: "id" <*>
                        v .: "title"  <*>
                        v .: "completed"
  parseJSON _          = mzero

instance ToJSON Item where
   toJSON (Item name age completed)
     = A.object ["id" .= name, "title" .= age, "completed" .= completed]

-}

main :: IO ()
main = warpDebug 3000 ToDo