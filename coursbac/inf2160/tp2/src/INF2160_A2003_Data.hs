-- =======================================================================
-- INF2160 - Automne 2003
-- Travail pratique 2  -  Données pour l'exécution
-- =======================================================================

module INF2160_A2003_Data (bdRecettes0, recette1, recette2, recette3, recette4,
	recette5, recette6, recette7, recette8, recette9) where

import INF2160_A2003_Types

bdRecettes0 :: [Recette]

bdRecettes0 =
	[RecetteBase "Fufu" 500 Gr [IngredBase "Eau" 200 Ml, IngredBase "Farine" 35 Gr],
	RecetteNorm "Fufu" 500 Gr [IngredBase "Eau" 200 Ml, IngredBase "Farine" 35 Gr]]

recette1 = RecetteBase "Roux blanc" 30 Gr [IngredBase "Farine" 15 Gr, IngredBase "Beurre" 15 Gr]
recette2 = RecetteBase "Bechamel" 250 Ml [IngredBase "Lait" 250 Ml, IngredRec "Roux blanc" 100 Gr]
recette3 = RecetteBase "Mornay" 250 Ml [IngredRec "Bechamel" 250 Ml, IngredBase "Gruyere" 100 Gr]
recette4 = RecetteBase "Chou fleur gratin" 1 Ute [IngredBase "Chou fleur" 1 Ute, IngredRec
		"Mornay" 250 Ml, IngredBase "Gruyere" 100 Gr]
recette5 = RecetteBase "Pate brisee" 500 Gr [IngredBase "Farine" 300 Gr, IngredBase "Eau" 60 Ml,
		IngredBase "Beurre" 150 Gr, IngredBase "Oeuf" 1 Ute]
recette6 = RecetteBase "Tarte aux pommes" 1 Ute [IngredRec "Pate brisee" 250 Gr, IngredBase
		"Pomme" 8 Ute, IngredBase "Sucre" 50 Gr, IngredBase "Cannelle" 15 Ml]
recette7 = RecetteBase "Caramel" 250 Ml [IngredBase "Sucre" 400 Gr, IngredBase "Eau" 250 Ml]
recette8 = RecetteBase "Tarte tatin" 1 Ute [IngredBase "Pomme" 8 Ute, IngredBase "Sucre" 200 Gr,
		IngredBase "Beurre" 30 Gr, IngredRec "Caramel" 125 Ml, IngredRec "Pate brisee" 250 Gr]
recette9 = RecetteBase "Quiche thon" 1 Ute [IngredRec "Pate brisee" 250 Gr, IngredBase "Oeuf" 3 Ute,
		IngredBase "Creme" 250 Ml, IngredBase "Thon" 100 Gr]
