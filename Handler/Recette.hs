module Handler.Recette where

import Import
import Yesod.Form.Bootstrap3
import Carac
import AgregP

handlerName :: Text
handlerName = "RecetteR"

title :: Text
title = "Application de la méthode de mélange"

getRecetteR :: Handler Html
getRecetteR = do
  elementList <- listElements
  let listElText = getInfosRecetteP elementList
  (formRecette,enctype) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm nouveauElRecette
  defaultLayout $ do
    $(widgetFile "sidebar/sidebar")
    $(widgetFile "recette/recette")
    

postRecetteR :: Handler Html
postRecetteR = do
  elementList <- listElements
  let listElText = getInfosRecetteP elementList
  ((res,formRecette),enctype) <- runFormPost $ renderBootstrap3 BootstrapBasicForm nouveauElRecette
  case res of
    FormSuccess agreg -> do
      _ <- runDB $ insertBy agreg
      redirect $ RecetteR
    _ -> do
      defaultLayout $ do
          $(widgetFile "sidebar/sidebar")
          $(widgetFile "recette/recette")
 
nouveauElRecette :: AForm Handler RecetteP
nouveauElRecette = do RecetteP
  <$>  areq (selectFieldList caracP) (bfs ("Caractéristique technique du matériau" :: Text)) Nothing
  <*>  areq (selectFieldList agregP) (bfs ("Méthode de mélange de la caractéristique" :: Text)) Nothing

caracP :: [(Text,Carac)]
caracP = [("PH",Ph),("Granulométrie inférieur à 4mm (%)",Granu4),("Granulométrie supérieur à 50mm (%)",Granu50),("Macro-porosité",MacroPo),("Masse organique (%)",Mo),("Azote",Azote),("Polsen",Polsen),("CEC",Cec),("Reserve Utile (mm)",ReserveU),("Densité",Densite),("Calcite",Calcite)]

agregP :: [(Text,AgregP)]
agregP = [("Moyenne arithmetique", ArithmeticP),("Moyenne géométrique", GeometricP),("Moyenne harmonique", HarmonicP),("Moyenne quadratique", QuadraticP)]

revLookup :: Eq b => b -> [(a,b)] -> Maybe a
revLookup el xs = Prelude.lookup el (Prelude.map swap xs)

listElements = runDB $ selectList [] []

elementWidget :: (Maybe Text,Maybe Text,RecettePId) -> Widget
elementWidget (car,ag,elId) = toWidget $(widgetFile "recette/elementWidget")

getInfosRecetteP :: [Entity RecetteP] -> [(Maybe Text,Maybe Text,RecettePId)]
getInfosRecetteP xs = Prelude.map go xs
  where go :: Entity RecetteP -> (Maybe Text,Maybe Text,RecettePId)
        go (Entity recettePId agreg) = (a,b,recettePId)
          where a = revLookup (recettePCarac agreg) caracP
                b = revLookup (recettePAgregP agreg) agregP
