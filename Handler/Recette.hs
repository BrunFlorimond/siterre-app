module Handler.Recette where

import Import

getRecetteR :: Handler Html
getRecetteR = do
  let handlerName = "RecetteR" :: Text
  let title = "Application de la méthode de mélange" :: Text
  defaultLayout $ do
    $(widgetFile "sidebar/sidebar")
    $(widgetFile "recette/recette")
    

postRecetteR :: Handler Html
postRecetteR = error "Not yet implemented: postRecetteR"
