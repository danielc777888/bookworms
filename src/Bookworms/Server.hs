{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}

module Bookworms.Server where

import Bookworms.Log (logDebug, logError, logInfo, logWarn)
import Control.Monad.Except
import Control.Monad.Reader
import Data.Aeson
import Data.Aeson.Types
import Data.Attoparsec.ByteString
import Data.ByteString (ByteString)
import Data.List
import Data.Maybe
import Data.String.Conversions
import Data.Time.Calendar
import GHC.Generics
import Lucid
import Network.HTTP.Media ((//), (/:))
import Network.Wai
import Network.Wai.Handler.Warp
import Prelude.Compat
import Servant
import Servant.Types.SourceT (source)
import System.Directory
import Text.Blaze
import qualified Text.Blaze.Html
import Text.Blaze.Html.Renderer.Utf8
import Prelude ()

type UserAPI1 = "users" :> Get '[JSON] [User]

data User = User
  { name :: String
  , age :: Int
  , email :: String
  , registrationDate :: Day
  , isAdmin :: Bool
  }
  deriving (Eq, Show, Generic)

instance ToJSON User

users1 :: [User]
users1 =
  [ User "Isaac Newton" 372 "isaac@newton.co.uk" (fromGregorian 1683 3 1) True
  , User "Albert Einstein" 136 "ae@mc2.org" (fromGregorian 1905 21 1) False
  ]

server1 :: Server UserAPI1
server1 = do
  liftIO $ logDebug "Hello World!"
  liftIO $ logInfo "Hello World! 2222"
  liftIO $ logDebug "Hello World! 3333"
  liftIO $ logWarn "Hello World! 4444"
  liftIO $ logError "Hello World! 5555"
  liftIO $ logDebug "Hello World! 6666"
  return users1

userAPI :: Proxy UserAPI1
userAPI = Proxy

app1 :: Application
app1 = serve userAPI server1

runServer :: IO ()
runServer = run 8081 app1
