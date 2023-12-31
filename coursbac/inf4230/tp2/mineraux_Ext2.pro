% mineraux extension #2

:- op(400,yfx,'#').

main :- identify.

% Demande les questions � L'utilisateur et mets les solution possible dans
% un setof. Ensuite le set est tri� en ordre pour enlever les doublon de
% solutions qui ont une probabilit� diff�rente.
identify:- retractall(known(_,_,_)),   % clear stored information
  setof(X#PROB,mineral(X,PROB),L),
  tri2(L,V),
  elimine_doublon(V,Z),
  write('Les possibilites sont:'),nl,
  affiche(Z).

% conc(?Liste1, ?Liste2, ?ListeRec)
% ListeRec est la concatenation de Liste1 et de Liste2
% Tir� du TP1 de inf2160 automne 2003.
conc([ ], L2, L2).
conc([X|L1], L2, [X|L3]) :- conc(L1, L2, L3).

% tri1(+ListeNonTriee,?ListeTriee)
% ListeTriee correspond au tri de ListeNonTriee sans elimination de doublons
% La comparaison adoptee est la comparaison lexicographique
% Utilise le predicat auxiliaire coupe
% Tir� du TP1 de inf2160 automne 2003.
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

% tri1(+ListeNonTriee,?ListeTriee)
% ListeTriee correspond au tri de ListeNonTriee sans elimination de doublons
% La comparaison adoptee est la comparaison lexicographique
% Utilise le predicat auxiliaire coupe
% Tir� du TP1 de inf2160 automne 2003.
% modification de tri1 pour mettre en ordre d�croissant
tri2([X|L],Ltrie) :- coupe2(X,L,Linf,Lsup),
                     tri2(Linf,Ltrie_inf),
                     tri2(Lsup,Ltrie_sup),
                     conc(Ltrie_inf,[X|Ltrie_sup],Ltrie).
tri2([],[]).

coupe2(X,[Y|L],[Y|Linf],Lsup) :-
  Y @> X,!, coupe2(X,L,Linf,Lsup).
coupe2(X,[Y|L],Linf,[Y|Lsup]) :-
  coupe2(X,L,Linf,Lsup).
coupe2(_,[],[],[]).


% elimine_doublon(+ListeAvecDoublon,?ListeSansDoublon)
% Ce pr�dicat �l�mine les doublon de la liste (format nom#prob), Il garde
% seulement le premier �l�ment et enl�ve tous les �l�ments qui suivents qui ont
% le m�me nom.
elimine_doublon([],[]).
elimine_doublon([],_):-!.
elimine_doublon([Nom#Prob|Reste],L):- elimine_doublon(Nom,Prob,Reste,L).
elimine_doublon(NomAvant,ProbAvant,[Nom#_|Reste],L) :- NomAvant=Nom,
                                                elimine_doublon(Nom,ProbAvant,Reste,L).
elimine_doublon(NomAvant,ProbAvant,[Nom#Prob|Reste],[NomAvant#ProbAvant|L]) :- \+ NomAvant == Nom,
                                                elimine_doublon(Nom,Prob,Reste,L).
elimine_doublon(NomAvant,ProbAvant,[Nom#Prob],[NomAvant#ProbAvant,Nom#Prob]) :- \+ NomAvant == Nom.						
elimine_doublon(NomAvant,ProbAvant,[Nom#_],[NomAvant#ProbAvant]) :- NomAvant == Nom.
elimine_doublon(NomAvant,ProbAvant,[],[NomAvant#ProbAvant]).

%Affiche le resultat, c'est � dire chaque min�ral et sa probabilit�.
affiche([Nom#Prob|Reste]):- write(Nom),write('  '),V is Prob*100.0 ,write(V),write('%'),nl,affiche(Reste).
affiche([]):-!.


%:- %plusgrand(V,prob,nom,reste)
%			              e=[prob#nom],
%                                      Z=[e|Z].
                                           
plusgrand(V,prob,nom,[probg#nomg|resteg]):- nomg=nom,
                                        probg>prob,
					V is probg,
					plusgrand(V,probg,nom,resteg).
					
plusgrand(A,B,C,[_|liste]):-plusgrand(A,B,C,liste).
plusgrand(_,_,_,[]):-!.
%  , PROB > 0.1,
%  write('CE MINERAL PEUT ETRE : '),write(X),write(' AVEC PROBABILITE : '), write(PROB),nl,fail.


%Base de connaissances pour les min�raux, bas�e sur la r�gle de Bayes.
vitreux(diamant,Y) :- Y = 1.  % Y = Probabilit� d'avoir une caract�ristique �tant donn� un min�ral 
vitreux(quartz,Y) :- Y = 1.
acier(chalcopyrite,Y) :- Y = 1.  
verre(pyrite,Y) :- Y = 1.  
non_rayable(diamant,Y)  :- Y = 1.  
non_rayable(quartz,Y)  :- Y = 1.
metallique(pyrite,Y) :- Y = 1.
metallique(chalcopyrite,Y) :- Y = 1.

vitreux(Z) :- Z = 0.5.		% Z = Probabilit� qu'un min�ral quelconque ait une de ces caract�ristiques
metallique(Z) :- Z = 0.5.
acier(Z) :- Z = 0.3.
non_rayable(Z) :- Z = 0.3.
verre(Z) :- Z = 0.5.

diamant(W) :- W = 0.01.   % W = Probabilit� d'avoir un min�ral(c'est son abondance)
quartz(W) :- W = 0.3.
pyrite(W) :- W = 0.3.
chalcopyrite(W) :- W = 0.1.

mineral(diamant,X) :- eclat(vitreux),vitreux(diamant,Y1), vitreux(Z1),diamant(W),PROB1 is Y1*W/Z1,
	raye_par(non_rayable),non_rayable(Z2),non_rayable(diamant,Y2), PROB2 is Y2*W/Z2,L=[PROB1,PROB2],tri1(L,[X|_]).
%,premier(R,X).

mineral(quartz,X) :- eclat(vitreux),vitreux(quartz,Y1), vitreux(Z1),quartz(W),PROB1 is Y1*W/Z1,
	raye_par(non_rayable),non_rayable(Z2),non_rayable(quartz,Y2), PROB2 is Y2*W/Z2,L=[PROB1,PROB2],tri1(L,[X|_]).


mineral(pyrite,X) :- eclat(metallique),metallique(pyrite,Y1), metallique(Z1),pyrite(W),PROB1 is Y1*W/Z1,
	raye_par(verre),verre(Z2),verre(pyrite,Y2), PROB2 is Y2*W/Z2,L=[PROB1,PROB2],tri1(L,[X|_]).

mineral(chalcopyrite,X) :- eclat(metallique),metallique(chalcopyrite,Y1), metallique(Z1),chalcopyrite(W),PROB1 is Y1*W/Z1,
	raye_par(acier),acier(Z2),acier(chalcopyrite,Y2), PROB2 is Y2*W/Z2,L=[PROB1,PROB2],tri1(L,[X|_]).


premier([X|Reste],X).



%AJOUTE INCONNU DANS LES REPONSES AUSSI POUR L'INCERTITUDE
    
eclat(X):- menuask(eclat,X,[metallique,semi_metallique,mat,vitreux]).
couleur(X):- menuask(couleur,X,[noir,vert,jaune,blanc,incolore]).
magnetisme(X):- menuask(magnetisme,X,[fort,faible,absent,inconnu]).
forme(X):- menuask(forme,X,[cubique,prismatique,xenomorphe,feuillet,inconnu]).
clivage(X):- menuask(clivage,X,[parfait,imparfait,absent,inconnu]).
raye_par(X):- menuask(raye_par,X,[ongle,cuivre,acier,verre,non_rayable,inconnu]).
macles(X):- ask(macles,X).
reactivite_acide(X):- menuask(reactivite_acide,X,[forte,faible,absente,inconnu]).
densite(X):- menuask(densite,X,[forte,faible,inconnu]).
trait(X):- menuask(trait,X,[colore,incolore,inconnu]).  



% "ask" is responsible for getting information from the user, and remembering
% the users response.  If it doesn't already know the answer to a question
% it will ask the user.  It then asserts the answer.  It recognizes two
% cases of knowledge: 1) the attribute-value is known to be true,
%                     2) the attribute-value is known to be false.

% This means an attribute might have mulitple values.  A third test to
% see if the attribute has another value could be used to enforce
% single valued attributes. (This test is commented out below)

% For this system the menuask is used for attributes which are single
% valued

% "ask" only deals with simple yes or no answers.  a "yes" is the only
% yes value.  any other response is considered a "no".

ask(Attribute,Value):-
  known(yes,Attribute,Value),     % succeed if we know its true
  !.                              % and dont look any further
ask(Attribute,Value):-
  known(_,Attribute,Value),       % fail if we know its false
  !, fail.

ask(Attribute,_):-
 known(yes,Attribute,_),         % fail if we know its some other value.
   !, fail.                        % the cut in clause #1 ensures that if
                                    % we get here the value is wrong.
ask(A,V):-
  write(A:V),                     % if we get here, we need to ask.
  write('? (yes or no): '),
  read(Y),                        % get the answer
  asserta(known(Y,A,V)),          % remember it so we dont ask again.
  Y = yes.                        % succeed or fail based on answer.

% "menuask" is like ask, only it gives the user a menu to to choose
% from rather than a yes on no answer.  In this case there is no
% need to check for a negative since "menuask" ensures there will
% be some positive answer.

menuask(Attribute,Value,_):-
  known(yes,Attribute,Value),     % succeed if we know
  !.
menuask(Attribute,_,_):-
  known(yes,Attribute,_),         % fail if its some other value
  !, fail.

menuask(Attribute,AskValue,Menu):-
  nl,write('What is the value for '),write(Attribute),write('?'),nl,
  display_menu(Menu),
  write('Enter the number of choice> '),
  read(Num),nl,
  pick_menu(Num,AnswerValue,Menu),
  asserta(known(yes,Attribute,AnswerValue)),
  AskValue = AnswerValue.         % succeed or fail based on answer

display_menu(Menu):-
  disp_menu(1,Menu), !.             % make sure we fail on backtracking

disp_menu(_,[]).
disp_menu(N,[Item | Rest]):-            % recursively write the head of
  write(N),write(' : '),write(Item),nl, % the list and disp_menu the tail
  NN is N + 1,
  disp_menu(NN,Rest).

pick_menu(N,Val,Menu):-
  integer(N),                     % make sure they gave a number
  pic_menu(1,N,Val,Menu), !.      % start at one
pick_menu(Val,Val,_).             % if they didn't enter a number, use
                                  % what they entered as the value

pic_menu(_,_,none_of_the_above,[]).  % if we've exhausted the list
pic_menu(N,N, Item, [Item|_]).       % the counter matches the number
pic_menu(Ctr,N, Val, [_|Rest]):-
  NextCtr is Ctr + 1,                % try the next one
  pic_menu(NextCtr, N, Val, Rest).
