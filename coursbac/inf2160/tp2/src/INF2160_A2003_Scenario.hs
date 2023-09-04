-- =======================================================================
-- INF2160 - Automne 2003
-- Travail pratique 2  -  Scénario d'exécution
-- =======================================================================

module INF2160_A2003_Scenario where

import List
import Maybe
import INF2160_A2003_Types
import INF2160_A2003_Data
import INF2160_A2003_TP2

bdRecettes1 = insererRecette recette1 bdRecettes0
bdRecettes2 = insererRecette recette2 bdRecettes1
bdRecettes3 = insererRecette recette3 bdRecettes2
bdRecettes4 = insererRecette recette4 bdRecettes3
bdRecettes5 = insererRecette recette5 bdRecettes4
bdRecettes6 = insererRecette recette6 bdRecettes5
bdRecettes7 = insererRecette recette7 bdRecettes6
bdRecettes8 = insererRecette recette8 bdRecettes7
bdRecettes  = insererRecette recette9 bdRecettes8

testXX message test n =
	if test then do
		putStr ("\n" ++ message ++ ": ")
		putStr "OK\n"
		return n
	else do
		putStr ("\n" ++ message ++ ": ")
		putStr "ERREUR\n"
		return 0

-- Description des tests
-- ----------------------------------------------------------------

trXX 1 n =
	testXX "Test 1 - Ajuster quantites, multiplication par 2"
	(ajusterQuantites [IngredBase "Oeuf" 2 Ute,IngredBase "Sucre" 125 Gr] 2 ==
	[IngredBase "Oeuf" 4 Ute,IngredBase "Sucre" 250 Gr]) n

trXX 2 n =
	testXX "Test 2 - Ajuster quantites, liste vide" (ajusterQuantites [] 0.5 == []) n

trXX 3 n =
	testXX "Test 3 - Normaliser liste d'ingredients de base"
	(normaliserIngredients [IngredBase "Sucre" 125 Gr,IngredBase "Oeuf" 1 Ute] bdRecettes ==
	Just [IngredBase "Sucre" 125.0 Gr,IngredBase "Oeuf" 1.0 Ute]) n

trXX 4 n =
	testXX "Test 4 - Normaliser liste d'ingredients contenant une recette"
	(normaliserIngredients [IngredBase "Sucre" 125 Gr,IngredRec "Caramel" 250 Ml] bdRecettes ==
	Just [IngredBase "Sucre" 125.0 Gr,IngredBase "Eau" 250.0 Ml,IngredBase "Sucre" 400.0 Gr]) n

trXX 5 n =
	testXX "Test 5 - Normaliser liste contenant une recette et modif quantites"
	(normaliserIngredients [IngredBase "Sucre" 125 Gr,IngredRec "Caramel" 125 Ml] bdRecettes ==
	Just [IngredBase "Sucre" 125.0 Gr,IngredBase "Eau" 125.0 Ml,IngredBase "Sucre" 200.0 Gr]) n

trXX 6 n =
	testXX "Test 6 - Normaliser liste contenant une recette inexistante"
	(isNothing (normaliserIngredients
	[IngredBase "Sucre" 125 Gr,IngredRec "Chocolat" 125 Ml] bdRecettes)) n

trXX 7 n =
	testXX "Test 7 - Condenser ingredients, liste sans doublon"
	(condenserIngredients [IngredBase "Oeuf" 1 Ute,IngredBase "Sucre" 120 Gr] ==
	[IngredBase "Oeuf" 1.0 Ute,IngredBase "Sucre" 120.0 Gr]) n

trXX 8 n =
	testXX "Test 8 - Condenser ingredients, liste avec doublons"
	(condenserIngredients
	[IngredBase "Lait" 125 Ml,IngredBase "Oeuf" 1 Ute,IngredBase "Oeuf" 2 Ute,
	IngredBase "Oeuf" 1 Ute,IngredBase "Sucre" 120 Gr] ==
	[IngredBase "Lait" 125.0 Ml,IngredBase "Oeuf" 4.0 Ute,IngredBase "Sucre" 120.0 Gr]) n

trXX 9 n =
	testXX "Test 9 - Condenser ingredients, liste avec ingredient en double mais associe a deux unites distinctes"
	(condenserIngredients
	[IngredBase "Sucre" 120 Gr,IngredBase "Sucre" 120 Ml] ==
	[IngredBase "Sucre" 120 Gr,IngredBase "Sucre" 120 Ml]) n

trXX 10 n =
	testXX "Test 10 - Insertion d'une nouvelle recette"
	(insererRecette (RecetteBase "Creme anglaise" 500 Ml [IngredBase "Lait" 500 Ml,
	IngredBase "Oeuf" 4 Ute,IngredBase "Sucre" 250 Gr,IngredBase "Farine" 5 Gr])
	bdRecettes == 
	([RecetteBase "Creme anglaise" 500.0 Ml [IngredBase "Lait" 500.0 Ml,IngredBase "Oeuf" 4.0 Ute,
	IngredBase "Sucre" 250.0 Gr,IngredBase "Farine" 5.0 Gr],
	RecetteNorm "Creme anglaise" 500.0 Ml [IngredBase "Farine" 5.0 Gr,IngredBase "Lait" 500.0 Ml,
	IngredBase "Oeuf" 4.0 Ute,IngredBase "Sucre" 250.0 Gr]] ++ bdRecettes)) n

trXX 11 n =
	testXX "Test 11 - Insertion d'une recette existante"
	(insererRecette recette1 bdRecettes == bdRecettes) n

trXX 12 n =
	testXX "Test 12 - Recherche de recettes, critere = ingred seul"
	(chercherRecettes (RecSeul "Pomme") bdRecettes == ["Tarte tatin","Tarte aux pommes"]) n

trXX 13 n =
	testXX "Test 13 - Recherche de recettes, critere = ingred1 ou ingred2"
	(chercherRecettes (RecOu (RecSeul "Oeuf") (RecSeul "Farine")) bdRecettes ==
	["Quiche thon","Tarte tatin","Tarte aux pommes","Pate brisee","Chou fleur gratin",
	"Mornay","Bechamel","Roux blanc","Fufu"]) n

trXX 14 n =
	testXX "Test 14 - Recherche de recettes, critere = ingred1 Et ingred2"
	(chercherRecettes (RecEt (RecSeul "Oeuf") (RecSeul "Farine")) bdRecettes ==
	["Quiche thon","Tarte tatin","Tarte aux pommes","Pate brisee"] ) n

trXX 15 n =
	testXX "Test 15 - Recherche de recettes, critere = non ingred"
	(chercherRecettes (RecSans (RecSeul "Pomme")) bdRecettes ==
	["Quiche thon","Caramel","Pate brisee","Chou fleur gratin","Mornay","Bechamel",
	"Roux blanc","Fufu"]) n

trXX 16 n =
	testXX "Test 16 - Recherche de recettes, critere complexe"
	(chercherRecettes (RecEt (RecEt (RecSeul "Oeuf") (RecSeul "Farine"))
	(RecSans (RecSeul "Pomme"))) bdRecettes == ["Quiche thon","Pate brisee"]) n

trXX 17 n =
	testXX "Test 17 - Trouver et condenser ingrédients, liste de noms de recette vide"
	(condenserIngredientsRecettesNorm [] bdRecettes == []) n

trXX 18 n =
	testXX "Test 18 - Trouver et condenser ingrédients, une recette sans ingr-recette au départ"
	(condenserIngredientsRecettesNorm ["Caramel"] bdRecettes ==
	[IngredBase "Eau" 250.0 Ml,IngredBase "Sucre" 400.0 Gr]) n

trXX 19 n =
	testXX "Test 19 - Trouver et condenser ingrédients, une recette avec ingr-recette au départ"
	(condenserIngredientsRecettesNorm ["Mornay"] bdRecettes ==
	[IngredBase "Beurre" 50.0 Gr,IngredBase "Farine" 50.0 Gr,IngredBase "Gruyere" 100.0 Gr,
	IngredBase "Lait" 250.0 Ml]) n

trXX 20 n =
	testXX "Test 20 - Trouver et condenser ingrédients, plusieurs recettes avec ingred communs"
	(condenserIngredientsRecettesNorm ["Caramel","Pate brisee","Tarte aux pommes"]
	bdRecettes ==
	[IngredBase "Beurre" 225.0 Gr,IngredBase "Cannelle" 15.0 Ml,IngredBase "Eau" 340.0 Ml,
	IngredBase "Farine" 450.0 Gr,IngredBase "Oeuf" 1.5 Ute,IngredBase "Pomme" 8.0 Ute,
	IngredBase "Sucre" 450.0 Gr]) n

-- Calcul et impression du résultat
-- ----------------------------------------------------------------
testTP = do
	 putStr "\n\nTESTS POUR AJUSTER QUANTITES\n==================================================================\n"
	 n1 <- trXX 1 1
	 n2 <- trXX 2 1
	 putStr ("\nNOTE POUR CETTE PARTIE: " ++ show (n1 + n2) ++ "/2.0\n")
	 putStr "\n\nTESTS POUR NORMALISER INGREDIENTS\n==================================================================\n"
	 n3 <- trXX 3 1
	 n4 <- trXX 4 1
	 n5 <- trXX 5 1
	 n6 <- trXX 6 1
	 putStr ("\nNOTE POUR CETTE PARTIE: " ++ show (n3+n4+n5+n6) ++ "/4.0\n")
	 putStr "\n\nTESTS POUR CONDENSER INGREDIENTS\n==================================================================\n"
	 n7 <- trXX 7 1
	 n8 <- trXX 8 1
	 n9 <- trXX 9 0.5
	 putStr ("\nNOTE POUR CETTE PARTIE: " ++ show (n7+n8+n9) ++ "/2.5\n")
	 putStr "\n\nTESTS POUR INSERER RECETTE\n==================================================================\n"
	 n10 <- trXX 10 1.5
	 n11 <- trXX 11 1
	 putStr ("NOTE POUR CETTE PARTIE: " ++ show (n10+n11) ++ "/2.5\n")
	 putStr "\n\nTESTS POUR RECHERCHE RECETTES\n==================================================================\n"
	 n12 <- trXX 12 0.5
	 n13 <- trXX 13 0.5
	 n14 <- trXX 14 0.5
	 n15 <- trXX 15 0.5
	 n16 <- trXX 16 1
	 putStr ("NOTE POUR CETTE PARTIE: " ++ show (n12+n13+n14+n15+n16) ++ "/3.0\n")
	 putStr "\n\nTESTS POUR TROUVER RECETTES ET CONDENSER INGREDIENTS\n==================================================================\n"
	 n17 <- trXX 17 0.5
	 n18 <- trXX 18 0.5
	 n19 <- trXX 19 0.5
	 n20 <- trXX 20 0.5
	 putStr ("NOTE POUR CETTE PARTIE: " ++ show (n17+n18+n19+n20) ++ "/2.0\n")
	 putStr "\n\n***************=================***************\n"
	 putStr ("\n\nNOTE FINALE: " ++ show (n1+n2+n3+n4+n5+n6+n7+n8+n9+n10+n11+n12+n13+n14+n15+n16+n17+n18+n19+n20) ++ "/16.0\n")
