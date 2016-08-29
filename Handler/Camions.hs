module Handler.Camions where

import Import

getCamionsR :: Handler Html
getCamionsR = do
  let handlerName = "CamionsR" :: Text
  let title = "Créations des types de camions" :: Text
  defaultLayout $ do
    $(widgetFile "sidebar/sidebar")
    $(widgetFile "camions/camions")

postCamionsR :: Handler Html
postCamionsR = error "Not yet implemented: postCamionsR"
