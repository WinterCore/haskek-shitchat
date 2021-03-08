{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Network.WebSockets as WS
import qualified Control.Concurrent.STM as STM;
import qualified Data.Text as T;
import Control.Monad (forever);
import System.Environment (getArgs)
import System.Exit
import System.IO

type Client = (String, WS.Connection)

type ServerState = [Client]

clientExists :: Client -> ServerState -> Bool
clientExists (name, _) = any ((== name) . fst)

main :: IO ()
main = do
    state <- STM.newTVarIO ([] :: ServerState)
    args <- getArgs
    case args of
        [ip, port] -> do
            putStrLn $ "Up and running on " ++ ip ++ ":" ++ port
            WS.runServer "127.0.0.1" 3000 (acceptClient state)
        _ -> do
            hPutStrLn stderr "Usage: haskek-shitchat <ip> <port>"
    return ()


acceptClient :: STM.TVar ServerState -> WS.PendingConnection -> IO ()
acceptClient state pending = do
    conn <- WS.acceptRequest pending
    WS.withPingThread conn 30 (return ()) $ do
        talk ("client", conn) state

talk :: Client -> STM.TVar ServerState -> IO ()
talk (user, conn) state = forever $ do
    msg <- WS.receiveData conn :: IO T.Text
    WS.sendTextData conn . T.tail . T.reverse $ msg
    return ()

