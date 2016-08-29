module Handler.Carte where

import Import

getCarteR :: Handler Html
getCarteR = do
  let handlerName = "CarteR" :: Text
  let title = "Spécification des trajets" :: Text
  defaultLayout $ do
    $(widgetFile "sidebar/sidebar")
    $(widgetFile "carte/carte")

postCarteR :: Handler Html
postCarteR = error "Not yet implemented: postCarteR"
