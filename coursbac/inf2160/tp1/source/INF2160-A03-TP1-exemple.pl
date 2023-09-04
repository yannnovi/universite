% $Id: INF2160-A03-TP1-exemple.pl,v 1.1 2003/09/29 20:27:33 yann Exp $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Recettes pour les tests
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	                         
:-insere_recette([roux_blanc,30,g],[[farine,15,g],[beurre,15,g]]).
:-insere_recette([bechamel,250,ml],[[lait,250,ml], [roux_blanc,30,g]]).
:-insere_recette([mornay,250,ml],[[bechamel,250,ml],[gruyere,100,g]]).
:-insere_recette([chou_fleur_gratin,1,u],[[chou_fleur,1,u], [mornay,250,ml], [gruyere,100,g]]).
:-insere_recette([pate_brisee,500,g], [[farine,300,g], [eau,60,ml], [beurre,150,g], [oeuf,1,u]]).
:-insere_recette([tarte_aux_pommes,1,u],[[pate_brisee,250,g], [pomme,8,u], [sucre,50,g], [cannelle,15,ml]]).
:-insere_recette([caramel,250,ml],[[sucre,400,g],[eau,250,ml]]).
:-insere_recette([tarte_tatin,1,u],[[pomme,8,u],[sucre,200,g],[beurre,30,g],[caramel,125,ml],[pate_brisee,250,g]]).
:-insere_recette([quiche_thon,1,u],[[pate_brisee,250,g],[oeuf,3,u],[creme,250,ml],[thon,100,g]]).

