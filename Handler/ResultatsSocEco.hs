module Handler.ResultatsSocEco where

import Import

getResultatsSocEcoR :: Handler Html
getResultatsSocEcoR = do
  let handlerName = "ResultatsSocEcoR" :: Text
  let title = "Résultats Socio-Economiques" :: Text
  defaultLayout $ do 
    $(widgetFile "sidebar/sidebar")
    $(widgetFile "resultats-soc-eco/resultats-soc-eco")
