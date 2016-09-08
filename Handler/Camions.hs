module Handler.Camions where

import Import
import Yesod.Form.Bootstrap3

title = "Gestion des camions" :: Text
handlerName = "CamionsR" :: Text

getCamionsR :: Handler Html
getCamionsR = do
  camionList <- listDeCamions
  (widget,enctype) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm nouveauCamionForm
  defaultLayout $ do
    $(widgetFile "sidebar/sidebar")
    $(widgetFile "camions/camions")

postCamionsR :: Handler Html
postCamionsR = do
  camionList <- listDeCamions
  ((res,widget),enctype) <- runFormPost $ renderBootstrap3 BootstrapBasicForm nouveauCamionForm
  case res of
    FormSuccess camion -> do
     _ <- runDB $ insert camion
     redirect $ CamionsR
    _ -> do
      defaultLayout $ do
          $(widgetFile "sidebar/sidebar")
          $(widgetFile "camions/camions")
  
nouveauCamionForm :: AForm Handler Camion
nouveauCamionForm = Camion
                <$> areq textField   (bfs ("Nom" :: Text)) Nothing
                <*> areq sup0 (bfs ("Consommation (l/100 km)" :: Text)) Nothing
                <*> areq sup0 (bfs ("Tonnage maximum (tonnes)" :: Text)) Nothing
                <*> areq sup0 (bfs ("Volume maximum (m3)" :: Text)) Nothing
                <*> areq sup0 (bfs ("Prix (€/jour)" :: Text)) Nothing
      where errorMessage :: Text
            errorMessage = "Ce paramètre doit être supérieur à 0"
            sup0 = checkBool (> 0) errorMessage doubleField

listDeCamions = runDB $ selectList [] []

camionWidget :: Entity Camion -> Widget
camionWidget (Entity camionId camion) = toWidget $(widgetFile "camions/camionWidget")

                
