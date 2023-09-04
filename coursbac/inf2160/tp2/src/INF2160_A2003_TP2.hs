-- =======================================================================
-- INF2160 - Automne 2003
-- Travail pratique 2
-- Auteurs:
-- Sylvain Trepanier (trepanier.sylvain.2@courrier.uqam.ca) TRES30117304
-- Yann Bourdeau     (bourdeau.yann@courrier.uqam.ca)       BOUY06097202
-- =======================================================================

module INF2160_A2003_TP2 (ajusterQuantites, normaliserIngredients,
	condenserIngredients,insererRecette,chercherRecettes,
	condenserIngredientsRecettesNorm,elemRec,elemIngr) where

import List
import INF2160_A2003_Types
import Maybe     
-- =======================================================================
-- elemRec :: Recette -> [Recette] -> Bool
-- V�rifie si une recette de nom donn� existe dans une liste de recettes
--
-- Param�tres :
--	- La recette � trouver
--	- La liste des recettes
-- Retour : (Bool), R�sultat de la recherche
-- =======================================================================
elemRec _ [] = False
elemRec (RecetteBase nom1 q u liste) (RecetteBase nom2 _ _ _:reste)
	| nom1 == nom2 = True
	| otherwise = elemRec (RecetteBase nom1 q u liste) reste
elemRec (RecetteBase nom1 q u liste) (_:reste) = elemRec (RecetteBase nom1 q u liste) reste
elemRec (RecetteNorm nom1 q u liste) (RecetteNorm nom2 _ _ _:reste)
	| nom1 == nom2 = True
	| otherwise = elemRec (RecetteNorm nom1 q u liste) reste
elemRec (RecetteNorm nom1 q u liste) (_:reste) = elemRec (RecetteNorm nom1 q u liste) reste

-- =======================================================================
-- elemIngr :: IngredientRecette -> [IngredientRecette] -> Bool
-- V�rifie si un ingredient de nom donn� existe dans une liste de recettes
--
-- Param�tres :
--	- L'ingr�dient � trouver dans la liste
--	- La liste des ingr�dients
-- Retour : (Bool), R�sultat de la recherche
-- =======================================================================
elemIngr _ [] = False
elemIngr (IngredBase nom1 q u) (IngredBase nom2 _ _:reste)
	| nom1 == nom2 = True
	| otherwise = elemIngr (IngredBase nom1 q u) reste
elemIngr (IngredBase nom1 q u) (_:reste) = elemIngr (IngredBase nom1 q u) reste
elemIngr (IngredRec nom1 q u) (IngredRec nom2 _ _:reste)
	| nom1 == nom2 = True
	| otherwise = elemIngr (IngredRec nom1 q u) reste
elemIngr (IngredRec nom1 q u) (_:reste) = elemIngr (IngredRec nom1 q u) reste

-- =======================================================================
-- compareIng :: IngredientRecette -> IngredientRecette -> Ordering
-- Pr�dicat auxiliaire utilis� pour comparer deux ingr�dients de base pour les mettre en ordre. On utilisant le nom (string) comme comparaison
--
-- Param�tres :
--	- Le premier ingr�dient de base	
--	- Le second ingr�dient de base
-- Retour : 
--	- La valeur de type Ordering indiquant la relation entre les deux ingr�dients de base, donn�e par leur nom
-- =======================================================================
comparerIng (IngredBase nom1 _ _ ) (IngredBase nom2 _ _)
	| nom1 <= nom2 = LT
	| nom1 == nom2 = EQ
	| otherwise = GT


-- =======================================================================
-- chercherRecetteNorm :: Nom -> Unite -> [Recette] -> Recette
-- Cherche la version normalis�e d'une recette dont on sait que la version
-- non normalis�e existe
--
-- Param�tres :
--	- nom (Nom), le nom de la recette � trouver
--	- unite (Unite), l'unit� de mesure de la recette
-- 	- recettesNom ([Recette]), liste de recettes
-- Retour : (Recette), version normalis�e de la recette
-- Exception : Une version normalis�e de la recette n'existe pas
-- 		   dans la liste.
-- Exemples :
-- =======================================================================
chercherRecetteNorm nom unite (RecetteNorm nomR q uniteR liste:reste)
	| nom == nomR && unite == uniteR = RecetteNorm nomR q uniteR liste
	| otherwise = chercherRecetteNorm nom unite reste
chercherRecetteNorm nom unite (_:reste) = chercherRecetteNorm nom unite reste


-- =======================================================================
-- ajusterQuantites :: [IngredientRecette] -> Float -> [IngredientRecette]
--
-- Param�tres :
--       - Liste des ingredients: La liste des ingredients a etre normalise
--       - c : Coefficent d'ajustement des ingredients. Chaque ingredients
--             vas etre multiplier par ce coefficient.
-- Retour : Liste des ingredient ajuste.
-- Exemples :
--      ajusterQuantites [IngredBase "Tomate" 1 Gr, IngredBase "raisin" 1 Gr] 2
-- =======================================================================
-- Si la liste vide, retourne une liste vide.
ajusterQuantites [] _ = []
-- Prends un element de la liste, ajuste sa quantite et retourne l'element. Il a appel a ajusterQuantiter
-- pour traiter les elements restant.
ajusterQuantites (IngredBase nom1 q u : reste) c = (IngredBase nom1 (q * c) u):ajusterQuantites reste c
ajusterQuantites (IngredRec nom1 q u : reste)  c = (IngredRec nom1 (q * c) u):ajusterQuantites reste c

-- =======================================================================
-- normaliserIngredients :: [IngredientRecette] -> [RecetteNorm] -> [IngredientRecette]
--
-- Param�tres :
--      - [ListeIngredientDepart]: Liste d'ingredient a normalise.
--      = [ListeRecetteNorm]: Liste des recettes normalises.
-- Retour: Liste des ingredients normalises.
-- Exemples :
--       normaliserIngredients [IngredBase "Tomate" 1 Gr,IngredRec "table" 1 Gr,
--                              IngredBase "Raisin" 1 Gr] 
--                             [RecetteNorm "table" 2 Gr [IngredBase "vitre" 4 Gr,
--                              IngredBase "bois" 4 Gr]]
-- =======================================================================
-- Si la liste est vide, retourne une liste vide.
normaliserIngredients [] _ = Just []

-- Si l'ingredient courant dans la liste est un ingredient de base, simplement l'ajouter a la liste.
normaliserIngredients (IngredBase nom1 q u:reste) listeRecette = if isNothing cond  then Nothing
                                                                 else Just( (IngredBase nom1 q u) : fromJust cond) where
                                                                 cond = normaliserIngredients reste listeRecette

-- Si l'ingredient est une recette, cherche la recette normalise a ajoute tous les ingredients a la liste de retours.
normaliserIngredients (IngredRec nom q u:reste) listeRecette 
        | elemRec (RecetteNorm nom q u []) listeRecette  = Just (ajusterQuantites listeingr (q /z) ++ fromJust (normaliserIngredients reste listeRecette))
        | otherwise = Nothing
        where
        z = quantiteRec (chercherRecetteNorm nom u listeRecette )
        listeingr = ingredientsRec (chercherRecetteNorm nom u  listeRecette )
        

-- =======================================================================
-- elemIngrUnite :: IngredientRecette -> [IngredientRecette] -> Bool
-- V�rifie si un ingredient de nom donn� et unite existe dans une liste de recettes
--
-- Param�tres :
--	- L'ingr�dient � trouver dans la liste
--	- La liste des ingr�dients
-- Retour : (Bool), R�sultat de la recherche
-- =======================================================================
elemIngrUnite _ [] = False
elemIngrUnite (IngredBase nom1 q u) (IngredBase nom2 _ u2:reste)
	| (nom1 == nom2) && (u == u2) = True
	| otherwise = elemIngr (IngredBase nom1 q u) reste
elemIngrUnite (IngredBase nom1 q u) (_:reste) = elemIngr (IngredBase nom1 q u) reste
elemIngrUnite (IngredRec nom1 q u) (IngredRec nom2 _ u2:reste)
	| (nom1 == nom2) && (u == u2) = True
	| otherwise = elemIngr (IngredRec nom1 q u) reste
elemIngrUnite (IngredRec nom1 q u) (_:reste) = elemIngr (IngredRec nom1 q u) reste


-- =======================================================================
-- condenserIngredients :: [IngredientRecette] -> [IngredientRecette]
--
-- Param�tres :
--         -[IngredientRecette] : Liste des ingredients trie en ordre croissant.
-- Retour : [IngredientRecette], Liste d'ingredient avec les doublons enlever.
-- Exception : Une version normalis�e de la recette n'existe pas
-- 		   dans la liste.
-- Exemples :
--         condenserIngredients [IngredBase "tomate" 1 Gr, IngredBase "raisin" 1 Gr,
--                               IngredBase "tomate" 1 Gr]
-- =======================================================================
-- Si une liste vite retourne une liste vide
condenserIngredients [] = []
-- Determine si un ingredient est un doublon, quand c'est un doublon appele condenserIngredient 2.
condenserIngredients (IngredBase nom1 q u : reste)
        | elemIngrUnite (IngredBase nom1 q u) reste = condenserIngredients2 (IngredBase nom1 q u) reste
        | otherwise = (IngredBase nom1 q u):condenserIngredients reste
        
condenserIngredients (IngredRec nom1 q u : reste)
        | elemIngrUnite (IngredRec nom1 q u) reste = condenserIngredients2 (IngredRec nom1 q u) reste
        | otherwise = (IngredRec nom1 q u):condenserIngredients reste

  
-- Additionne la quantite a la quantite deja existante pour l'ingredient. Verifie si il existe
-- encore d'autre doublons dans la liste.
condenserIngredients2 (IngredBase _ q _) (IngredBase nom q2 u:reste)
        | elemIngrUnite(IngredBase nom q u ) reste =  condenserIngredients2(IngredBase nom (q +q2) u) reste 
        | otherwise = (IngredBase nom (q+q2) u) : condenserIngredients reste

condenserIngredients2 (IngredRec _ q _) (IngredBase nom q2 u:reste)
        | elemIngrUnite(IngredRec nom q u ) reste =  condenserIngredients2(IngredRec nom (q +q2) u) reste 
        | otherwise = (IngredRec nom (q+q2) u) : condenserIngredients reste
        

-- =======================================================================
-- insererRecette :: Recette -> [Recette] -> [Recette]
-- Sert � ins�rer une nouvelle recette dans la banque de donn�es des recettes
--
-- Param�tres : 
--	- La recette � ajouter
--	- La liste des recettes de notre livre de recette
-- Retour : 
--	- Notre liste des recettes avec la nouvelle recette ajout� sous sa version de base et sa version normalis�e
-- Exceptions : 
--	- La recette n'est pas ajout�e si elle existe d�j�
-- Exemples : 
--	- insererRecette (RecetteBase "Creme anglaise" 500 Ml [IngredBase "Lait" 500 Ml,
--	  IngredBase "Oeuf" 4 Ute,IngredBase "Sucre" 250 Gr,IngredBase "Farine" 5 Gr])
-- =======================================================================
--Si la liste des recettes est vide, ajouter la recette et sa version normalis�e qu'on calcule
insererRecette recette [] = [recette,(RecetteNorm (nomRec recette) (quantiteRec recette) (uniteRec recette) listeIng)]
	where listeIng =  condenserIngredients (sortBy comparerIng (fromJust(normaliserIngredients (ingredientsRec recette) [])))

--Sinon, on v�rifie d'abord si la recette existe
insererRecette recette recettes

	--Si oui, on retourne la liste des recettes sans l'avoir ajout�e
	| elemRec recette recettes = recettes

	--sinon on ajoute la recette et sa version normalis�e. Pour normaliser, on normalise d'abord tous les ingr�dients, on trie
	--la liste d'ingr�dients normalis�e selon la fonction comparerIng puis on condense la liste pour �viter les doublons
	| otherwise = [recette,(RecetteNorm (nomRec recette) (quantiteRec recette) (uniteRec recette) listeIng)]  ++ recettes
	where listeIng = condenserIngredients (sortBy comparerIng (fromJust(normaliserIngredients (ingredientsRec recette) recettes)) ) 


-- =======================================================================
-- chercherRecettes :: CritereRech -> [Recette] -> [Nom]
-- Sert � rechercher la liste des recette correspondant � certains crit�res
--
-- Param�tres : 
--	- Le crit�re de recherche
--	- La liste des recettes de notre livre de recette
-- Retour : 
--	- La liste des recettes de notre livre de recettes qui correspondent au crit�res
-- Exemples :
--	- chercherRecettes (RecSeul "Pomme") bdRecettes
--	- chercherRecettes (RecOu (RecSeul "Oeuf") (RecSeul "Farine")) bdRecettes
-- =======================================================================
chercherRecettes _ [] = []

--Sinon, on traite s�par�ment pour chaque crit�re de recherche diff�rent. Dans chaque cas, on v�rifie la condition, i.e.
--Si la condition est remplie on ajoute la recette � la liste � retourner, sinon on ne l'ajoute pas. 
chercherRecettes (RecSeul critere) (RecetteNorm nom quantite unite listeIng:reste)
	| elemIngr (IngredBase critere quantite unite) listeIng =  [nom] ++ chercherRecettes (RecSeul critere) reste
	| otherwise = chercherRecettes (RecSeul critere) reste


--Si on a une recette de base, on ne cherche pas dedans pour rien
chercherRecettes critere (RecetteBase _ _ _ _:reste) = chercherRecettes critere reste

--L'intersection des deux listes de recettes produites selon les crit�res donne un ET
chercherRecettes (RecEt critere1 critere2) recettes =
	intersect liste1 liste2
	where 
	liste1 = chercherRecettes critere1 recettes	
	liste2 = chercherRecettes critere2 recettes	

--L'union des deux listes produites selon les criteres donne un OU
chercherRecettes (RecOu critere1 critere2) recettes = 
	union liste1 liste2
	where 
	liste1 = chercherRecettes critere1 recettes
	liste2 = chercherRecettes critere2 recettes

--Pour chercher sans, on prend la liste de tous les noms de recettes en �liminant les doublons (nub)
--Puis on fait la diff�rence entre cette liste et la liste de recettes correspondant � critere
chercherRecettes(RecSans critere) recettes =
	liste1 \\ liste2
	where 
	liste1 = nub (map nomRec recettes)
	liste2 = chercherRecettes critere recettes



-- =======================================================================
-- chercherRecetteNormSansUnite Nom -> [Recette] -> [IngredientRecette]
-- Pr�dicat auxiliaire utilis� pour chercher la recette normalis�e de nom donn�e en param�tre
--
-- Param�tres :
--	- Le nom de la recette � rechercher
--	- La liste des recettes
-- Retour : 
--	- La liste normalis�e des ingr�dients de la recette cherch�e
-- Exemples : 
--	- chercherRecetteNormSansUnite "mornay" recettes
-- =======================================================================
chercherRecetteNormSansUnite nom (RecetteNorm nomR q uniteR liste:reste)
	| nom == nomR = RecetteNorm nomR q uniteR liste
	| otherwise = chercherRecetteNormSansUnite nom reste
chercherRecetteNormSansUnite nom (_:reste) = chercherRecetteNormSansUnite nom reste


-- =======================================================================
-- condenserIngredientsRecettesNorm :: [Nom] -> [Recette] -> [IngredientRecette]
-- Permet de conna�tre la liste compl�te des ingr�dients n�cessaires pour r�aliser la 
-- liste des recettes donn�e. Les ingr�dients sont normalis�s et un seul ingr�dient n'apparait
-- qu'une fois avec la quantit� totale n�cessaire de cet ingr�dient pour faire toutes les recettes
--
-- Param�tres :
--	- La liste des noms des recettes � condenser
--	- La liste des recettes
-- Retour : 
--	- La liste des ingr�dients de base n�cessaire � faire toutes les recettes donn�es
-- Exemples :
--	- condenserIngredientsRecettesNorm ["Caramel","Pate brisee","Tarte aux pommes"] bdRecettes
-- =======================================================================
condenserIngredientsRecettesNorm [] recettes= []

--Si la premi�re recette de la liste existe dans la liste des recettes, on peut proc�der
--D'abord, on cherche les ingr�dients normalis�s de la premi�re recette de la liste, puis on concat�ne cette liste avec la liste des ingr�dients normalis�s des autres recettes
--Puis on trie cette liste r�sultante selon le nom avec la function sortBy (n�cessaire d'�tre tri� pour condenserIngredients)
--Finalement, on passe cette liste � condenserIngredients qui s'occupe de condenser les ingr�dients qui se r�p�tent
	
condenserIngredientsRecettesNorm (premierNom:reste) recettes	
	| elemRec (RecetteNorm premierNom 0 Gr []) recettes = condenserIngredients (sortBy comparerIng (ingredientsRec (chercherRecetteNormSansUnite premierNom recettes) ++ condenserIngredientsRecettesNorm reste recettes))
	| otherwise = condenserIngredientsRecettesNorm reste recettes
