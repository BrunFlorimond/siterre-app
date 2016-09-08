module Handler.CamionsDelete where

import Import

deleteCamionsDeleteR :: CamionId -> Handler Html
deleteCamionsDeleteR camionId = do
   runDB $ delete camionId
   redirect $ CamionsR
