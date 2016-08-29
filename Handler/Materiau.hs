module Handler.Materiau where

import Import

getMateriauR :: Handler Html
getMateriauR = do
  let handlerName = "MateriauR" :: Text
  let title = "Création de matériaux" :: Text
  defaultLayout $ do
    $(widgetFile "sidebar/sidebar")
    $(widgetFile "materiau/materiau")

postMateriauR :: Handler Html
postMateriauR = error "Not yet implemented: postMateriauR"
