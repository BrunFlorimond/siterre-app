module Carac where

import Database.Persist.TH
import Prelude

data Carac = Nom
  | Ph
  | Granu4
  | Granu50
  | MacroPo
  | Mo
  | Azote
  | Polsen
  | Cec
  | ReserveU
  | Densite
  | Calcite deriving (Eq,Ord,Show,Read)


derivePersistField "Carac"
