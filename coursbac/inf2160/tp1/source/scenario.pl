% $Id: scenario.pl,v 1.3 2003/10/08 13:10:48 yann Exp $
% Scénario de correction pour le TP#1
% INF2160 - AUT 2003

% Chargement des fichiers nécessaires au scénario 
:- consult('c:\\yann\\inf2160\\tp1\\source\\INF2160-A03-TP1-enonce.pl').
:- consult('c:\\yann\\inf2160\\tp1\\source\\INF2160-A03-TP1-exemple.pl').      

% Mettre a off le flag "single_var_warnings" 
:- prolog_flag(single_var_warnings,_,off).                                                     

% Prédicats de test
% ----------------------------------------------------------------

% Version SICStus Prolog

testXX(M,P,1) :- nl, write(M), write(': '),
                 on_exception(Erreur,P,(write(Erreur),nl,fail)),
                 !, write('OK'), nl.
testXX(_,_,0) :- write('ERREUR'), nl.


testTP(Num) :- trXX(Num,_).


% Description des tests
% ----------------------------------------------------------------

trXX(1,N) :- testXX('#1 - union de listes disjointes sans repetition',
                     union([1,2,3],[4,5],[1,2,3,4,5]),
                     N).

trXX(2,N) :- testXX('#2 - union de listes non disjointes sans repetition',
                     union([1,2,3],[3,4],[1,2,3,4]),
                     N).

trXX(3,N) :- testXX('#3 - union de listes avec repetition dans L1',
                     (union([1,2,1],[1,3],L),
			   L = [2,1,3]),
                     N).

trXX(4,N) :- testXX('#4 - union de listes avec repetition dans L2',
			   (union([1,2,3],[1,1,3],L),
			   L = [2,1,1,3]),
                     N).

trXX(5,N) :- testXX('#5 - ajuste_quantites, multiplication par 2',
			   (ajuste_quantites([[oeuf,2,u],[sucre,125,g]],L,2),
			   L = [[oeuf,4,u],[sucre,250,g]]),
                     N).

trXX(6,N) :- testXX('#6 - ajuste_quantites, liste vide',
			   ajuste_quantites([],[],0.5),
                     N).

trXX(7,N) :- testXX('#7 - aplatit, liste d''ingredients de base',
			   (aplatit([[sucre,125,g],[oeuf,1,u]],L),
			   L = [[sucre,125,g],[oeuf,1,u]]),
                     N).

trXX(8,N) :- testXX('#8 - aplatit, liste d''ingredients incluant une recette',
			   (aplatit([[sucre,125,g],[caramel,250,ml]],L),
			   L = [[sucre,125,g],[eau,250.0,ml],[sucre,400.0,g]]),
                     N).

trXX(9,N) :- testXX('#9 - aplatit, liste incluant une recette et modification des qtes',
			   (aplatit([[sucre,125,g],[caramel,125,ml]],L),
			   L = [[sucre,125,g],[eau,125.0,ml],[sucre,200.0,g]]),
                     N).

trXX(10,N) :- testXX('#10 - aplatit, erreur d''unite (ingredient de base)',
			    \+ aplatit([[sucre,125,ml],[oeuf,1,u]],L),
                      N).

trXX(11,N) :- testXX('#11 - aplatit, erreur d''unite (ingredient recette)',
			    \+ aplatit([[sucre,125,g],[caramel,250,g]],L),
                      N).

trXX(12,N) :- testXX('#12 - aplatit, unite fantaisiste',
                      \+ aplatit([[sucre,40,kk],[eau,125.0,ml]],L),
                      N).

trXX(13,N) :- testXX('#13 - aplatit, ingredient inexistant',
                      \+ aplatit([[eau,125.0,ml],[epinards,400,ml]],L),
                      N).

trXX(14,N) :- testXX('#14 - elimine_doublons_recette, liste sans doublons',
			    (elimine_doublons_recette([[oeuf,1,u],[sucre,120,g]],L),
			     L=[[oeuf,1,u],[sucre,120,g]]),
                      N).

trXX(15,N) :- testXX('#15 - elimine_doublons_recette, liste avec doublons',
			    (elimine_doublons_recette([[lait,125,ml],[oeuf,1,u],[oeuf,2,u],[oeuf,1,u],[sucre,120,g]],L),
			     L = [[lait,125,ml],[oeuf,4,u],[sucre,120,g]]),
                       N).

trXX(16,N) :- testXX('#16 - elimine_doublons_recette, liste avec ingredient en double mais associe a deux unites distinctes',
			    (elimine_doublons_recette([[sucre,120,g],[sucre,120,ml]],L),
			     L = [[sucre,120,g],[sucre,120,ml]]),
                       N).

trXX(17,N) :- testXX('#17 - insertion d''une nouvelle recette',
			    (insere_recette([creme_anglaise,500,ml],[[lait,500,ml],[oeuf,4,u],[sucre,250,g],[farine,5,g]]),
			    recette_norm([creme_anglaise,XN,YN],ZN),
			    XN = 500,
			    YN = ml,
			    ZN = [[farine,5,g],[lait,500,ml],[oeuf,4,u],[sucre,250,g]],
			    recette([creme_anglaise,X,Y],Z),
			    X = 500,
			    Y = ml,
			    Z = [[lait,500,ml],[oeuf,4,u],[sucre,250,g],[farine,5,g]]),
                      N).

trXX(18,N) :- testXX('#18 - insertion d''une recette existante',
			    \+ insere_recette([creme_anglaise,500,ml],[[lait,500,ml],[oeuf,4,u],[sucre,250,g],[farine,5,g]]),
                      N).

trXX(19,N) :- testXX('#19 - insertion d''une recette : unite fantaisiste (ingredient)',
			    \+ insere_recette([roux_brun,30,g],[[farine,1,cs],[beurre,15,g]]),
                      N).

trXX(20,N) :- testXX('#20 - insertion d''une recette : unite fantaisiste (recette)',
			    \+ insere_recette([roux_brun,30,kk],[[farine,15,g],[beurre,15,g]]),
                      N).

trXX(21,N) :- testXX('#21 - insertion d''une recette : unite incorrecte (ingredient)',
			    \+ insere_recette([roux_brun,30,g],[[farine,15,ml],[beurre,15,g]]),
                      N).

trXX(22,N) :- testXX('#22 - suppression d''une recette existante',
			    ( supprime_recette(creme_anglaise),
			    \+ recette([creme_anglaise|_],_),
			    \+ recette_norm([creme_anglaise|_],_)),
                      N).

trXX(23,N) :- testXX('#23 - suppression d''une recette inexistante',
                      \+ supprime_recette(creme_anglaise),
                      N).

trXX(24,N) :- testXX('#24 - maj d''une recette inexistante',
                      \+ maj_recette([omelette_thon,1,u],[[oeuf,6,u],[thon,150,g]]),
                      N).

trXX(25,N) :- testXX('#25 - maj d''une recette existante',
                      ( maj_recette([caramel,500,ml],[[sucre,800,g],[eau,500,ml]]),
                      recette([caramel,X,Y],L),
			    L = [[sucre,800,g],[eau,500,ml]],
			    X = 500,
			    Y = ml,
			    recette_norm([caramel,XN,YN],LN),
			    LN = [[eau,500,ml],[sucre,800,g]],
			    XN = 500,
			    YN = ml),
                      N).

trXX(26,N) :- testXX('#26 - recherche de recettes : critere = ing',
			    (cherche_recette(pomme,L),
			    L = [tarte_aux_pommes,tarte_tatin]),
                      N).

trXX(27,N) :- testXX('#27 - recherche de recettes : critere = ing1 ou ing2',
                      (cherche_recette(oeuf:farine,L),
			    L = [roux_blanc,bechamel,mornay,chou_fleur_gratin,pate_brisee,tarte_aux_pommes,tarte_tatin,quiche_thon]),
                      N).

trXX(28,N) :- testXX('#28 - recherche de recettes : critere = ing1 et ing2',
                      (cherche_recette(sucre&farine,L),
			    L = [tarte_aux_pommes,tarte_tatin]),
                      N).

trXX(29,N) :- testXX('#29 - recherche de recettes : critere = non ing',
                      (cherche_recette(~sucre,L),
			    L = [roux_blanc,bechamel,mornay,chou_fleur_gratin,pate_brisee,quiche_thon]),
                      N).

trXX(30,N) :- testXX('#30 - recherche de recettes : critere complexe avec parentheses',
                      (cherche_recette((oeuf:farine)& ~sucre,L),
			    L = [roux_blanc,bechamel,mornay,chou_fleur_gratin,pate_brisee,quiche_thon]),
                      N).

% Mettre a on le flag "single_var_warnings" 
:- prolog_flag(single_var_warnings,_,on).             


% Impression et calcul du résultat
% ----------------------------------------------------------------

testTP :- nl,
  write('\n\nTESTS POUR union/3\n==================================================================\n'),
  trXX(1,N1),
  trXX(2,N2),
  trXX(3,N3),
  trXX(4,N4),
  Nm is N1+N2+N3+N4,
  nl,write('NOTE POUR CETTE PARTIE: '),write(Nm),write('/4'),nl,nl,

  write('\n\nTESTS POUR ajuste_quantites/3\n==================================================================\n'),
  trXX(5,N5),
  trXX(6,N6),
  Nn is N5+N6,
  nl,write('NOTE POUR CETTE PARTIE: '),write(Nn),write('/2'),nl,nl,

  write('\n\nTESTS POUR aplatit/2\n==================================================================\n'),
  trXX(7,N7),
  trXX(8,N8),
  trXX(9,N9),
  trXX(10,N10),
  trXX(11,N11),
  trXX(12,N12),
  trXX(13,N13),
  No is N7+N8+N9+N10+N11+N12+N13,
  nl,write('NOTE POUR CETTE PARTIE: '),write(No),write('/7'),nl,nl,

  write('\n\nTESTS POUR elimine_doublons_recette/2\n==================================================================\n'),
  trXX(14,N14),
  trXX(15,N15),
  trXX(16,N16),
  Np is N14+N15+N16,
  nl,write('NOTE POUR CETTE PARTIE: '),write(Np),write('/3'),nl,nl,

  write('\n\nTESTS POUR insere_recette/2\n==================================================================\n'),
  trXX(17,N17),
  trXX(18,N18),
  trXX(19,N19),
  trXX(20,N20),
  trXX(21,N21),
  Nq is N17+N18+N19+N20+N21,
  nl,write('NOTE POUR CETTE PARTIE: '),write(Nq),write('/5'),nl,nl,

  write('\n\nTESTS POUR supprime_recette/1\n==================================================================\n'),
  trXX(22,N22),
  trXX(23,N23),
  Nr is N22+N23,
  nl,write('NOTE POUR CETTE PARTIE: '),write(Nr),write('/2'),nl,nl,

  write('\n\nTESTS POUR maj_recette/2\n==================================================================\n'),
  trXX(24,N24),
  trXX(25,N25),
  Ns is N24+N25,
  nl,write('NOTE POUR CETTE PARTIE: '),write(Ns),write('/2'),nl,nl,

  write('\n\nTESTS POUR cherche_recette/2\n==================================================================\n'),
  trXX(26,N26),
  trXX(27,N27),
  trXX(28,N28),
  trXX(29,N29),
  trXX(30,N30),
  Nt is N26+N27+N28+N29+N30,
  nl,write('NOTE POUR CETTE PARTIE: '),write(Nt),write('/5'),nl,nl,

  nl,write('NOTE FINALE: '),N is (Nm+Nn+No+Np+Nq+Nr+Ns+Nt),
  write(N),write('/30'),nl.



:- testTP.                                           

