module Bookworms.Log (
  logDebug,
  logInfo,
  logWarn,
  logError,
) where

logDebug :: String -> IO ()
logDebug s = do
  putStr "\ESC[97m" -- white
  putStrLn s

logInfo :: String -> IO ()
logInfo s = do
  putStr "\ESC[94m" -- blue
  putStrLn s

logWarn :: String -> IO ()
logWarn s = do
  putStr "\ESC[93m" -- yellow
  putStrLn s

logError :: String -> IO ()
logError s = do
  putStr "\ESC[91m" -- red
  putStrLn s
