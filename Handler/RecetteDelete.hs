module Handler.RecetteDelete where

import Import

deleteRecetteDeleteR :: RecettePId -> Handler Html
deleteRecetteDeleteR elementId = do
  runDB $ delete elementId
  redirect $ RecetteR
