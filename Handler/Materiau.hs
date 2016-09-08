module Handler.Materiau where

import Import
import Carac
import AgregP
import Yesod.Form.Bootstrap3

handlerName :: Text
handlerName = "MateriauR"
title :: Text
title = "Création de matériaux" :: Text

re :: [RecetteP]
re = [(RecetteP Granu4 ArithmeticP),(RecetteP Ph GeometricP)]

getMateriauR :: Handler Html
getMateriauR = do
  recettes <- listRecette
  materiaux <- listMateriau
  (formWidget,enctype) <- generateFormPost $ listForm (Prelude.map entityVal recettes)
  defaultLayout $ do
  $(widgetFile "sidebar/sidebar")
  $(widgetFile "materiau/materiau")

postMateriauR :: Handler Html
postMateriauR =  do
  recettes <- listRecette
  materiaux <- listMateriau
  ((x,formWidget),enctype)  <- runFormPostNoToken $ listForm (Prelude.map entityVal recettes)
  case x of
    (FormSuccess mat) -> do
      _ <- runDB $ insert mat
      redirect $ MateriauR
    _ -> do
      defaultLayout $ do
      $(widgetFile "sidebar/sidebar")
      $(widgetFile "materiau/materiau")
      
listForm :: [RecetteP] -> Html -> MForm Handler (FormResult MateriauP, Widget)
listForm xs h = do
  (nomRes,nomView) <- mreq textField nom Nothing
  carac <- mapM (\(RecetteP c _) -> mreq (selectFieldList caracP) disabled (Just c)) xs
  value <- mapM (\(RecetteP _ _) -> mreq doubleField val Nothing) xs
  (valueMinRes, valueMinView) <- mreq (check validatePercent intField) (minmax "Min") (Just 0)
  (valueMaxRes, valueMaxView) <- mreq (check validatePercent intField) (minmax "Max") (Just 100)
  let labels = getLabels xs
  let (caracResults,caracViews) = Prelude.unzip carac
  let (valueResults,valueViews) = Prelude.unzip value
  let results = (Prelude.zip caracResults valueResults)
  let views = Prelude.zip3 caracViews  valueViews labels
  let materiauRes = MateriauP <$> nomRes <*> (sequenceA $ Prelude.map sequenceTuple2 results) <*> valueMinRes <*> valueMaxRes 
  let formWidget = $(widgetFile "materiau/materiauForm")
  return (materiauRes,formWidget)
  where disabled = FieldSettings "Caracteristique" Nothing Nothing Nothing [("class","hidden form-control")]
        nom = FieldSettings "Nom du materiau" Nothing Nothing Nothing [("class","input-nom-materiau form-control")]
        val = FieldSettings "Valeur" Nothing Nothing Nothing [("class","input-valeur-carac form-control")]
        minmax string = FieldSettings string Nothing Nothing Nothing [("class","input-valeur-carac form-control")]
        validatePercent y | y < 0 = Left ("La proportion doit etre supérieure ou égale à 0" :: Text)
                          | y > 100 = Left ("La proportion doit etre inférieure ou égale à 0" :: Text)
                          | otherwise = Right y

-- A importer
caracP :: [(Text,Carac)]
caracP = [("PH",Ph),("Granulométrie inférieur à 4mm (%)",Granu4),("Granulométrie supérieur à 50mm (%)",Granu50),("Macro-porosité",MacroPo),("Masse organique (%)",Mo),("Azote",Azote),("Polsen",Polsen),("CEC",Cec),("Reserve Utile (mm)",ReserveU),("Densité",Densite),("Calcite",Calcite)]

--A importer
revLookup :: Eq b => b -> [(a,b)] -> Maybe a
revLookup el xs = Prelude.lookup el (Prelude.map swap xs)

sequenceTuple2 :: Applicative f => (f a,f b) -> f (a,b)
sequenceTuple2 = uncurry $ liftA2 (,)

--listRecette :: HandlerT site IO [Entity RecetteP]
listRecette = runDB $ selectList [] []

listMateriau = runDB $ selectList [] []

materiauWidget :: Entity MateriauP -> Widget
materiauWidget (Entity materiauId materiauP) = toWidget $(widgetFile "materiau/materiauWidget")

getLabels :: [RecetteP] -> [Maybe Text]
getLabels xs = Prelude.map (flipRevLookup caracP) listCarac 
  where listCarac = Prelude.map recettePCarac xs
        flipRevLookup = flip revLookup
 
