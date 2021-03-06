module Game.Storyline.Update exposing (update)

import Core.Dispatch as Dispatch exposing (Dispatch)
import Utils.Update as Update
import Game.Models as Game
import Game.Storyline.Models exposing (..)
import Game.Storyline.Messages exposing (..)
import Game.Storyline.Missions.Messages as Missions
import Game.Storyline.Missions.Update as Missions
import Game.Storyline.Emails.Messages as Emails
import Game.Storyline.Emails.Update as Emails


type alias UpdateResponse =
    ( Model, Cmd Msg, Dispatch )


update : Game.Model -> Msg -> Model -> UpdateResponse
update game msg model =
    case msg of
        Toggle ->
            onToggle model

        MissionsMsg msg ->
            onMission game msg model

        EmailsMsg msg ->
            onEmail game msg model


onToggle : Model -> UpdateResponse
onToggle model =
    let
        model_ =
            { model | enabled = (not model.enabled) }
    in
        Update.fromModel model_


onMission : Game.Model -> Missions.Msg -> Model -> UpdateResponse
onMission game msg model =
    Update.child
        { get = .missions
        , set = (\missions model -> { model | missions = missions })
        , toMsg = MissionsMsg
        , update = (Missions.update game)
        }
        msg
        model


onEmail : Game.Model -> Emails.Msg -> Model -> UpdateResponse
onEmail game msg model =
    Update.child
        { get = .emails
        , set = (\emails model -> { model | emails = emails })
        , toMsg = EmailsMsg
        , update = (Emails.update game)
        }
        msg
        model
