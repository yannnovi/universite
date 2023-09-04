% $Id: INF2160-A03-TP1-enonce.pl,v 1.25 2003/10/23 16:14:09 sylvain Exp $
% Auteurs:
% Sylvain Trepanier (trepanier.sylvain.2@courrier.uqam.ca) TRES30117304
% Yann Bourdeau     (bourdeau.yann@courrier.uqam.ca)       BOUY06097202
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Predicats standard de manipulation de listes
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% conc(?Liste1, ?Liste2, ?ListeRec)
% ListeRec est la concatenation de Liste1 et de Liste2
conc([ ], L2, L2).
conc([X|L1], L2, [X|L3]) :- conc(L1, L2, L3).

% dans(+Liste,?Element)
% Element est dans Liste
dans([X|_],X):-!.
dans([_|L],X):-dans(L,X).

% dansrec(?Liste,?Ingredient).
% Succès si Ingrédient se trouve dans Liste. 
% La recherche se fait aussi dans des sous-listes si un des
% éléments de Liste est lui-même une liste
% Si on laisse l'ingrédient en variable, ne retourne que le 
% premier élément de la liste
%
% Exemple : 
% | -? dansrec([farine,tarte_aux_pommes,lait],lait).
% yes
% | -? dansrec([lait,farine,tarte_aux_pommes],sucre).
% no
% | -? dansrec([lait,farine,tarte_aux_pommes],X).
% X = lait ; 
% no
% | -? dansrec([farine,tarte_aux_pommes,[sucre,farine,lait]],lait).
% yes


dansrec([X|_],X):-!.
dansrec([X|_],Y):-dansrec(X,Y).
dansrec([_|L],X):-dansrec(L,X).



% diff(?Liste1, ?Liste2, ?Resultat)
% Resultat est la difference de Liste1 et Liste2
% Resultat ne contient pas de doublons ssi Liste1 n'en contient pas
%
% Exemples : 
%
% | -? diff([1,2,3],[4,5],L).
% L = [1,2,3] ? ;
% no
% | -? diff([1,2,3],[2,3],L).
% L = [1] ? ;
% no
% | -? diff([1,1,1],[1,1],L).
% L = [] ? ;
% no
% | -? diff([1,1,1],[2],L).
% L = [1,1,1] ? ;
% no 
% | -? diff([1,2,3],L,[2,3]).
% L = [1|_] ? ;
% no
%

diff([],_,[]).
diff([X|L],L1,R):- dans(L1,X), diff(L,L1,R),!.
diff([X|L],L1,[X|R]):- diff(L,L1,R).



% inter(?Liste1, ?Liste2, ?Resultat)
% Resultat est l'intersection de Liste1 et Liste2
% Resultat ne contient pas de doublons ssi Liste1 n'en contient pas
% 
% | ?- inter([2,2,2],[2],L).    
% L = [2,2,2] ? ;
% no
% | ?- inter([2],[2,2,2],L).    
% L = [2] ? ;
% no
% | ?- inter([2,3,4],[3,4,5],L).    
% L = [3,4] ? ;
% no
% | ?- inter([2,3,4],[5],L).    
% L = [] ? ;
% no
% | ?- inter([2,3,4],L,[2]).    
% L = [2|_] ? ;
% no

inter([],_,[]).
inter([X|L],L1,[X|R]):- dans(L1,X), inter(L,L1,R),!.
inter([_|L],L1,R):- inter(L,L1,R).



% union(?Liste1, ?Liste2, ?Resultat)
% Resultat est l'union de Liste1 et Liste2
% Resultat ne contient pas de doublons ssi Liste2 n'en contient pas
%
% Exemples :
%
% | ?- union([1,2,3],[4,5],L).
% L = [1,2,3,4,5] ? ;
% no
% | ?- union([1,2,3],[3,4],L).
% L = [1,2,3,4] ? ;
% no
% | ?- union([1,2,1],[1,3],L).
% L = [2,1,3] ? ;
% no
% | ?- union([1,2,3],[1,1,3],L).
% L = [2,1,1,3] ? ; 
% no
% | ?- union([1,2,3],L,[1,2,3,5]).
% L = [1,2,3,5] ? ;
% no

union([], E, E).
union([T|E1], E2, [T|Eu]) :- \+ dans(E2, T), !, union(E1, E2, Eu).
union([_|E1], E2, Eu) :- union(E1, E2, Eu).



% tri1(+ListeNonTriee,?ListeTriee)
% ListeTriee correspond au tri de ListeNonTriee sans elimination de doublons
% La comparaison adoptee est la comparaison lexicographique
% Predicat adapte de ceux dans le fichier predicats_listes.pl (Webct)
% Utilise le predicat auxiliaire coupe
tri1([X|L],Ltrie) :- coupe(X,L,Linf,Lsup),
                     tri1(Linf,Ltrie_inf),
                     tri1(Lsup,Ltrie_sup),
                     conc(Ltrie_inf,[X|Ltrie_sup],Ltrie).
tri1([],[]).

coupe(X,[Y|L],[Y|Linf],Lsup) :-
  Y @< X,!, coupe(X,L,Linf,Lsup).
coupe(X,[Y|L],Linf,[Y|Lsup]) :-
  coupe(X,L,Linf,Lsup).
coupe(_,[],[],[]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Base de faits
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ingredient(+Ingredient, +Unite normale).
% Declaration de l'ingredient et de l'unite dans laquelle il est mesure
% Unite doit etre u, g ou ml.
ingredient(pomme, u).
ingredient(chou_fleur, u).
ingredient(farine, g).
ingredient(eau, ml).
ingredient(lait, ml).
ingredient(beurre, g).
ingredient(gruyere, g).
ingredient(oeuf, u).
ingredient(sucre, g).
ingredient(cannelle, ml).
ingredient(thon,g).
ingredient(creme,ml).

% Recette([+Nom,+Qte,+U],+ListeIngredients).
% Nom : nom de la recette
% Qte, U : quantite obtenue et unite associee
% ListeIngredients : liste des ingredients de la recette, i.e. liste d'elements
% 	[NomIngredient,QteIngredient,UIngredient]
% La recette est telle que donnee dans le livre. Les ingredients
% peuvent donc etre des recettes.
% Predicat defini de facon dynamique sous forme de liste de faits via les
% predicats insere_recette, supprime_recette, maj_recette.
:-dynamic(recette/2).

% Recette_norm([+Nom,+Qte,+U],+ListeIngredients).
% Nom : nom de la recette
% Qte, U : quantite obtenue et unite associee
% ListeIngredients : liste des ingredients de la recette, i.e. liste d'elements
% 	[NomIngredient,QteIngredient,UIngredient]
% Version normalisee de la recette. Les ingredients ne peuvent etre que des ingredients de base.
% Predicat defini de facon dynamique sous forme de liste de faits inseres via le
% predicats insere_recette, supprime_recette, maj_recette.
:-dynamic(recette_norm/2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Modifications de la base de connaissances
%
% NB: les exemples d'execution sont donnes en supposant
% que les requetes d'insertion en fin de fichier ont ete
% executeees
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ajuste_quantites(+ListeIngredients1, ?ListeIngredients2, +Coeff)
% Les deux premiers arguments sont des listes d'ingredients [Nom, Qte, U]
% La seconde liste est obtenue en appliquant la formule Qte2=Qte1*Coeff
% Permet d'adapter les quantites specifiees dans une recette si on veut en
% faire 2 fois plus par exemple (Coeff=2 alors)
%
% Exemples :
%
% | ?- ajuste_quantites([[oeuf,2,u],[sucre,125,g]],L,2).
% L = [[oeuf,4,u],[sucre,250,g]] ? ;
% no
% | ?- ajuste_quantites([[chou_fleur,1,u],[creme,250,ml],[beurre,30,g]],L,0.5).
% L = [[chou_fleur,0.5,u],[creme,125.0,ml],[beurre,15.0,g]] ? ;
% no

ajuste_quantites([],[],_).
ajuste_quantites([[Nom,Quantite,Unite]|R],[[Nom,NouvQuantite,Unite]|L],Q) :- ingredient(Nom,Unite), NouvQuantite is Quantite * Q, ajuste_quantites(R,L,Q),!.


% aplatit(+ListeIngredients1, ?ListeIngredients2)
% Le premier argument est une liste d'ingredients [Nom, Qte, U] ou certains
% ingredients peuvent etre une recette
% Le second argument est une liste d'ingredients [Nom, Qte, U] ou tous les
% ingredients sont des ingredients de base (avec repetition eventuelle du
% meme ingredient dans la liste)
% Effet de bord : verifie que les ingredients (de base et recettes) sont
% exprimes dans la bonne unite
%
% Exemples :
%
% | ?- aplatit([[sucre,125,g],[oeuf,1,u]],L).
% L = [[sucre,125,g],[oeuf,1,u]] ? ;
% no
% | ?- aplatit([[sucre,125,g],[caramel,250,ml]],L).
% L = [[sucre,125,g],[eau,250.0,ml],[sucre,400.0,g]] ? ;
% no
% | ?- aplatit([[sucre,125,g],[caramel,125,ml]],L).
% L = [[sucre,125,g],[eau,125.0,ml],[sucre,200.0,g]] ? ;
% no
% | ?- aplatit([[sucre,125,ml],[oeuf,1,u]],L).
% no
% | ?- aplatit([[sucre,125,g],[caramel,250,g]],L).
% no 7

aplatit([],[]).
aplatit([[Nom,Quantite,Unite]|Reste],[[Nom,Quantite,Unite]|L]):- ingredient(Nom,Unite), aplatit(Reste,L),!.
aplatit([[Nom,Quantite,Unite]|Reste],L) :- recette([Nom,RecetteQuantite,Unite],ListeRecette),
                                           RecetteQuantiteAjuste is Quantite / RecetteQuantite,
                                           aplatit(ListeRecette,ListeRecetteAplatie),
                                           ajuste_quantites(ListeRecetteAplatie,ListeRecetteAjuste,RecetteQuantiteAjuste),
                                           conc(ListeRecetteAjuste,Reste,ListeIngre),aplatit(ListeIngre,L),!.
 

%
%
% Predicat a definir
%
%

% elimine_doublons_recette(+ListeIngredients1, ?ListeIngredients2)
% Le premier argument est une liste d'ingredients [Nom, Qte, U] triee par Nom
% Le second argument est une liste d'ingredients [Nom, Qte, U] ou chaque Nom
% apparait au plus une fois dans la liste
% Une sequence [Nom, Qte1, U],[Nom, Qte2, U] dans ListeIngredients1 est remplacee
% par [Nom, Qte1+Qte2, U] dans ListeIngredients2
%
% Exemples :
%
% | ?- elimine_doublons_recette([[oeuf,1,u],[sucre,120,g]],L).
% L = [[oeuf,1,u],[sucre,120,g]] ? ;
% no
% | ?- elimine_doublons_recette([[oeuf,1,u],[sucre,120,g],[sucre,100,g]],L).
% L = [[oeuf,1,u],[sucre,220,g]] ? ;
% no
% | ?- elimine_doublons_recette([[oeuf,1,u],[sucre,120,g],[sucre,120,g]],L).
% L = [[oeuf,1,u],[sucre,240,g]] ? ;
% no
% | ?- elimine_doublons_recette([[sucre,120,g],[sucre,120,ml]],L).
% L = [[sucre,120,g],[sucre,120,ml]] ? ;
% no 
% | ?- elimine_doublons_recette([[lait,125,ml],[oeuf,1,u],[oeuf,2,u],[oeuf,1,u],[sucre,120,g]],L).

% L = [[lait,125,ml],[oeuf,4,u],[sucre,120,g]] ? ;
% no
elimine_doublons_recette([],[]).
elimine_doublons_recette([[Nom,Quantite,Unite]|Reste],L ) :- elimine_doublons_recette([Nom,Quantite,Unite],Reste,L).
elimine_doublons_recette([Nom,Quantite,Unite],[[NomSuivant,QuantiteSuivante,UniteSuivante]|Reste],L) :-
                           ingredient(Nom,Unite),
                           Nom = NomSuivant, Unite=UniteSuivante,NouvelleQuantite is Quantite + QuantiteSuivante,
                           elimine_doublons_recette([Nom,NouvelleQuantite,Unite],Reste,L).
elimine_doublons_recette([Nom,Quantite,Unite],[[NomSuivant,QuantiteSuivante,UniteSuivante]|Reste],[[Nom,Quantite,Unite]|L]) :-
			   ingredient(Nom,Unite),ingredient(NomSuivant,UniteSuivante),
                           ((Nom \= NomSuivant) ; (Unite \= UniteSuivante)),elimine_doublons_recette([NomSuivant,QuantiteSuivante,UniteSuivante],Reste,L).
elimine_doublons_recette([Nom,Quantite,Unite],[],[[Nom,Quantite,Unite]]) :- ingredient(Nom,Unite),!.


% insere_recette([+Recette, +Qte, +U], +Ingredients_livre)
% Insere une nouvelle recette dans la base de connaissance (predicat recette)
% en inserant egalement sa representation normalisee (predicat recette_norm)
% Verifie au prealable que la recette n'existe pas deja, et normalise la recette :
% 1) Verifie que l'unite de la recette est valide
% 2) Les recettes servant d'ingredients sont remplacees par leurs ingredients de base 
%	(et on verifie le fait que les ingredients sont tous exprimes dans leur unite respective)
% 3) La liste d'ingredients de base est triee et les ingredients n'y apparaissent qu'une fois
%
% Exemples :
%
% | ?- insere_recette([creme_anglaise,500,ml],[[lait,500,ml],[oeuf,4,u],[sucre,250,g],[farine,5,g]]).
% yes
% | ?- insere_recette([tarte_aux_prune,1,u],[[pate_brisee,250,g],[prunes,1000,g],[sucre,100,g]]).
% no
% | ?- insere_recette([roux_brun,30,g],[[farine,1,cs],[beurre,15,g]]).
% no
% | ?- insere_recette([roux_brun,30,g],[[farine,15,ml],[beurre,15,ml]]).
% no
% | ?- insere_recette([creme_anglaise,500,ml],[[lait,500,ml],[oeuf,4,u],[sucre,250,g],[farine,5,g]]).
% no 
% | ?- recette([creme_anglaise,X,Y],Z).
% X = 500,
% Y = ml,
% Z = [[lait,500,ml],[oeuf,4,u],[sucre,250,g],[farine,5,g]] ? ; 
% no
% | ?- recette_norm([creme_anglaise,X,Y],Z).
% X = 500,
% Y = ml,
% Z = [[farine,5,g],[lait,500,ml],[oeuf,4,u],[sucre,250,g]] ? ;
% no
insere_recette([],[]).
insere_recette([NomRecette,QuantiteRecette,UniteRecette],ListeIngredient) :- ingredient(_,UniteRecette),
            \+ recette([NomRecette,_,_],_),\+ recette_norm([NomRecette,_,_],_),
            aplatit(ListeIngredient,ListeApplatie),
            tri1(ListeApplatie,ListeTrie),
            elimine_doublons_recette(ListeTrie,ListeResultat),
            tri1(ListeResultat,ListeResultatTrie), 	
	    assertz(recette([NomRecette,QuantiteRecette,UniteRecette],ListeIngredient)),
            assertz(recette_norm([NomRecette,QuantiteRecette,UniteRecette],ListeResultatTrie)).

insere_recette([Recette,_,_], _) :- recette([Recette,_,_],_), write('Cette recette existe deja!'),fail,!.
insere_recette([_,_,Unite], _) :- \+ ingredient(_,Unite), write('Cette unite de mesure est invalide!'),fail,!.



% supprime_recette(+Recette)
% supprime la recette dont le nom est Recette
%
% Exemples (apres avoir execute ceux de insere_recette) :
%
% | ?- supprime_recette(creme_anglaise).
% yes
% | ?- supprime_recette(tarte_abricots).
% no
% | ?- supprime_recette(creme_anglaise).
% no
% | ?- recette([creme_anglaise,_,_],_).
% no
% | ?- recette_norm([creme_anglaise,_,_],_).
% no


supprime_recette(Recette) :- retract(recette_norm([Recette,_,_],_)), retract(recette([Recette,_,_],_)) , !.
supprime_recette(_) :- write('Cette recette n\'existe pas!'),fail.


% maj_recette([+Recette, +Qte, +U], +Ingredients_livre)
% met a jour la definition d'une recette existant deja dans la base de connaissances
% les arguments sont definis de la meme facon que pour insere_recette
%
% Exemples :
%
% | ?- maj_recette([omelette_thon,1,u],[[oeuf,6,u],[thon,150,g]]).
% no
% | ?- maj_recette([caramel,500,ml],[[sucre,800,g],[eau,500,ml]]).
% yes
% | ?- recette([caramel,X,Y],L).
% L = [[sucre,800,g],[eau,500,ml]],
% X = 500,
% Y = ml ? ;
% no
% | ?- recette_norm([caramel,X,Y],L).
% L = [[eau,500,ml],[sucre,800,g]],
% X = 500,
% Y = ml ? ;
% no

maj_recette([Recette,Qte,Unite],Ingredients_livre) :- supprime_recette(Recette),insere_recette([Recette,Qte,Unite],Ingredients_livre).
maj_recette(_,_) :- write('Erreur, recette inexistante!'),fail.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Requetes sur la base de connaissances
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Definition des operateurs servant a ecrire des conditions de recherche
% ~A : cherche les recettes ne satisfaisant pas le critere A
% A & B : cherche les recettes satisfaisant les criteres A et B
% A : B : cherche les recettes satisfaisant les criteres A ou B
% Un critere est 
%	1) soit une expression definie au moyen des operateurs precedants et de parentheses
% 	2) soit un critere simple
% Un critere simple est le nom d'un ingredient de base
% Une recette satisfait un critere simple si elle contient l'ingredient en question
:- op(950,fy,~).
:- op(960,yfx,&).
:- op(970,yfx,:).
:- op(700,xfx,:=).



% Cherche_recette(+Critere, ?Liste_recettes)
% Liste_recettes est la liste de toutes les recettes (donnees par leur nom)
% satisfaisant Critere (voir ci-dessus).
% Pour ameliorer la performance, on se sert exclusivement des definitions normalisees
% des recettes.
%
% Exemples (bases sur la BC constituee ci-dessous) :
%
% | ?- cherche_recette(pomme,L).
% L = [tarte_aux_pommes,tarte_tatin] ? ;
% no
% | ?- cherche_recette(oeuf:farine,L).
% L = [roux_blanc,bechamel,mornay,chou_fleur_gratin,pate_brisee,tarte_aux_pommes,tarte_tatin,quiche_thon] ? ;
% no
% | ?- cherche_recette(~sucre,L).
% L = [roux_blanc,bechamel,mornay,chou_fleur_gratin,pate_brisee,quiche_thon] ? ;
% no
% | ?- cherche_recette(sucre&farine,L).
% L = [tarte_aux_pommes,tarte_tatin] ? ;
% no
% | ?- cherche_recette((oeuf:farine)& ~sucre,L).
% L = [roux_blanc,bechamel,mornay,chou_fleur_gratin,pate_brisee,quiche_thon] ? ;
% no
% | ?- cherche_recette(caramel,L).
% no 

cherche_recette(Critere,L) :- ingredient(Critere,_), 
			      findall(Recette,(recette_norm([Recette,_,_],ListeIngredients),dansrec(ListeIngredients,Critere)),L).

cherche_recette(X&Y,L) :- cherche_recette(X, L1),
			cherche_recette(Y, L2),
			inter(L1,L2,L). 

cherche_recette(X:Y,L) :- cherche_recette(X, L1),
			cherche_recette(Y, L2),
			union(L1,L2,L). 

cherche_recette(~X,L):- cherche_recette(X,RecettesContenantIngredient), 
			findall(Recette,recette_norm([Recette,_,_],_),ListeToutesRecettes),
			diff(ListeToutesRecettes, RecettesContenantIngredient, L).


		      



