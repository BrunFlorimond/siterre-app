module MateriauCarac where

import qualified Data.Map           as M

import Carac

data CaracValeur = Id String | Val Double deriving (Eq,Show)
type Materiau = M.Map Carac CaracValeur
type TupleCarac = [(Carac,Double)]
