module Requests.Topics exposing (..)

import Driver.Websocket.Channels exposing (..)
import Game.Account.Models as Account
import Game.Servers.Shared as Servers


type Topic
    = WebsocketTopic Channel String
    | HttpTopic String


login : Topic
login =
    HttpTopic "account/login"


register : Topic
register =
    HttpTopic "account/register"


logout : Topic
logout =
    WebsocketTopic RequestsChannel "account.logout"


accountResync : Account.ID -> Topic
accountResync id =
    WebsocketTopic (AccountChannel id) "bootstrap"


serverResync : Servers.CId -> Topic
serverResync cid =
    WebsocketTopic (ServerChannel cid) "bootstrap"



-- logs


logsSync : Servers.CId -> Topic
logsSync cid =
    WebsocketTopic (ServerChannel cid) "log.index"



-- meta


metaSync : Servers.CId -> Topic
metaSync cid =
    WebsocketTopic (ServerChannel cid) "meta.index"



-- processes


processesSync : Servers.CId -> Topic
processesSync cid =
    WebsocketTopic (ServerChannel cid) "processes.index"



-- filesytem


fsSync : Servers.CId -> Topic
fsSync cid =
    WebsocketTopic (ServerChannel cid) "file.index"


fsDelete : Servers.CId -> Topic
fsDelete cid =
    WebsocketTopic (ServerChannel cid) "file.delete"


fsMove : Servers.CId -> Topic
fsMove cid =
    WebsocketTopic (ServerChannel cid) "file.move"


fsRename : Servers.CId -> Topic
fsRename cid =
    WebsocketTopic (ServerChannel cid) "file.rename"


fsCreate : Servers.CId -> Topic
fsCreate cid =
    WebsocketTopic (ServerChannel cid) "file.create"


fsDownload : Servers.CId -> Topic
fsDownload cid =
    WebsocketTopic (ServerChannel cid) "file.download"



-- Public FTP


pftpEnable : Servers.CId -> Topic
pftpEnable cid =
    WebsocketTopic (ServerChannel cid) "pftp.server.enable"


pftpDisable : Servers.CId -> Topic
pftpDisable cid =
    WebsocketTopic (ServerChannel cid) "pftp.file.add"


pftpFileRemove : Servers.CId -> Topic
pftpFileRemove cid =
    WebsocketTopic (ServerChannel cid) "pftp.file.remove"


{-| For downloading from public ftp, always a Gateway CID
-}
pftpDownload : Servers.CId -> Topic
pftpDownload cid =
    WebsocketTopic (ServerChannel cid) "pftp.file.download"



-- Player Actions


bruteforce : Servers.CId -> Topic
bruteforce cid =
    WebsocketTopic (ServerChannel cid) "cracker.bruteforce"


browse : Servers.CId -> Topic
browse cid =
    WebsocketTopic (ServerChannel cid) "network.browse"


emailReply : Account.ID -> Topic
emailReply id =
    WebsocketTopic (AccountChannel id) "email.reply"
