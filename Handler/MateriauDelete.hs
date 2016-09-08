module Handler.MateriauDelete where

import Import

deleteMateriauDeleteR :: MateriauPId -> Handler Html
deleteMateriauDeleteR materiauPId = do
  runDB $ delete materiauPId
  redirect $ MateriauR
