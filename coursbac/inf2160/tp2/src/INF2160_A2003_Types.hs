module INF2160_A2003_Types (Nom,Unite(..),Ingredient(..),IngredientRecette(..),
	Recette(..),CritereRech(..),nomIngr,uniteIngr,nomIngrRec,quantiteRec,
	uniteIngrRec,nomRec,quantiteRec,uniteRec,ingredientsRec,estIngredBase,
	estIngredRec,estRecetteBase,estRecetteNorm) where

type Nom = String
type Quantite = Float
data Unite = Gr | Ml | Ute deriving (Eq, Enum, Ord, Read, Show, Bounded)
data Ingredient = Ingred Nom Unite deriving (Eq, Ord)
data IngredientRecette = IngredBase Nom Quantite Unite | IngredRec Nom Quantite Unite
				deriving (Eq, Ord)
data Recette =
	RecetteBase Nom Quantite Unite [IngredientRecette] |
	RecetteNorm Nom Quantite Unite [IngredientRecette] deriving Eq

data CritereRech = RecSeul Nom | RecSans CritereRech | RecEt CritereRech CritereRech |
	RecOu CritereRech CritereRech

nomIngr   (Ingred nom _) = nom
uniteIngr (Ingred _ unite) = unite

nomIngrRec      (IngredBase nom _ _) = nom
nomIngrRec      (IngredRec  nom _ _) = nom
quantiteIngrRec (IngredBase _ qte _) = qte
quantiteIngrRec (IngredRec  _ qte _) = qte
uniteIngrRec    (IngredBase _ _ unite) = unite
uniteIngrRec    (IngredRec  _ _ unite) = unite

estIngredBase   (IngredBase _ _ _) = True
estIngredBase    _                  = False
estIngredRec    (IngredRec _ _ _) = True
estIngredRec     _                  = False

nomRec         (RecetteBase nom _ _ _) = nom
nomRec         (RecetteNorm nom _ _ _) = nom
quantiteRec    (RecetteBase _ qte _ _) = qte
quantiteRec    (RecetteNorm _ qte _ _) = qte
uniteRec       (RecetteBase _ _ unite _) = unite
uniteRec       (RecetteNorm _ _ unite _) = unite
ingredientsRec (RecetteBase _ _ _ liste) = liste
ingredientsRec (RecetteNorm _ _ _ liste) = liste

estRecetteBase (RecetteBase _ _ _ _) = True
estRecetteBase  _                    = False
estRecetteNorm (RecetteNorm _ _ _ _) = True
estRecetteNorm  _                    = False

instance Show Ingredient where
	show (Ingred nom unite) = "Ingred " ++ nom ++ " " ++ show unite 

instance Show IngredientRecette where
	show (IngredBase n q u) = "IngredBase " ++ n ++ " " ++ show q ++ " " ++ show u
	show (IngredRec  n q u) = "IngredRec "  ++ n ++ " " ++ show q ++ " " ++ show u

instance Show Recette where
	show (RecetteBase n q u l) =
		"RecetteBase " ++ n ++ " " ++ show q ++ " " ++ show u ++ " " ++ show l
	show (RecetteNorm n q u l) =
		"RecetteNorm " ++ n ++ " " ++ show q ++ " " ++ show u ++ " " ++ show l
