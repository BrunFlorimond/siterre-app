module AgregP where

import Database.Persist.TH
import Prelude

data AgregP = AppendP | ArithmeticP | GeometricP | HarmonicP | QuadraticP deriving (Eq,Show,Read)
derivePersistField "AgregP"
