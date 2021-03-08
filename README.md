# Websocket Chat Server in Haskell

## How to run locally
- Install [Haskell & Cabal](https://www.haskell.org/platform/)
- Clone this repo by running `https://github.com/WinterCore/haskek-shitchat.git`
- Change your current working directory to the project's `cd haskek-shitchat`
- Run `cabal run haskek-shitchat 0.0.0.0 3000`
- Connect to it by using a WebSockets client (something like `https://github.com/vi/websocat`) by using this address `ws://127.0.0.1:3000`
- Enjoy


### TODO
- Impelment basic chat (allow users to pick their username upon connection)
- Store the messages in some type of database
- Add a REST API for fetching messages.
- Add authentication?
- Add support for uploading files