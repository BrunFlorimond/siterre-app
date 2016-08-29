module Handler.ResultatsMelanges where

import Import

getResultatsMelangesR :: Handler Html
getResultatsMelangesR = do
  let handlerName = "ResultatsMelangesR" :: Text
  let title = "Listes des mélanges possibles" :: Text
  defaultLayout $ do
    $(widgetFile "sidebar/sidebar")
    $(widgetFile "resultats-melanges/resultats-melanges")
