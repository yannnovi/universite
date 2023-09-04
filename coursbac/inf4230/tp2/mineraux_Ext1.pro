% mineraux extension #1

:- op(400,yfx,'#').

main :- identify.

% Demande les questions ˆ L'utilisateur et mets les solutions possibles dans
% un setof. Ensuite le set est trié en ordre pour enlever les doublon de
% solutions qui ont une probabilité différente.
identify :- retractall(known(_,_,_)),   % clear stored information
  setof(X#PROB,mineral(X,PROB),L),
  tri1(L,V),
  elimine_doublon(V,Z),
  write('Les possibilites sont:'),nl,
  affiche(Z).

% conc(?Liste1, ?Liste2, ?ListeRec)
% ListeRec est la concatenation de Liste1 et de Liste2
% Tiré du TP1 de inf2160 automne 2003.
conc([ ], L2, L2).
conc([X|L1], L2, [X|L3]) :- conc(L1, L2, L3).

% tri1(+ListeNonTriee,?ListeTriee)
% ListeTriee correspond au tri de ListeNonTriee sans elimination de doublons
% La comparaison adoptee est la comparaison lexicographique
% Utilise le predicat auxiliaire coupe
% Tiré du TP1 de inf2160 automne 2003.
tri1([X|L],Ltrie) :- coupe(X,L,Linf,Lsup),
                     tri1(Linf,Ltrie_inf),
                     tri1(Lsup,Ltrie_sup),
                     conc(Ltrie_inf,[X|Ltrie_sup],Ltrie).
tri1([],[]).

coupe(X,[Y|L],[Y|Linf],Lsup) :-
  Y @> X,!, coupe(X,L,Linf,Lsup).
coupe(X,[Y|L],Linf,[Y|Lsup]) :-
  coupe(X,L,Linf,Lsup).
coupe(_,[],[],[]).

% elimine_doublon(+ListeAvecDoublon,?ListeSansDoublon)
% Ce prédicat élémine les doublon de la liste (format nom#prob), Il garde
% seulement le premier élément et enlve tous les éléments qui suivents qui ont
% le même nom.
elimine_doublon([],[]).
elimine_doublon([],_):-!.
elimine_doublon([Nom#Prob|Reste],L):- elimine_doublon(Nom,Prob,Reste,L).
elimine_doublon(NomAvant,ProbAvant,[Nom#_|Reste],L) :- NomAvant=Nom,
                                                elimine_doublon(Nom,ProbAvant,Reste,L).
elimine_doublon(NomAvant,ProbAvant,[Nom#Prob|Reste],[NomAvant#ProbAvant|L]) :- \+ NomAvant == Nom,
                                                elimine_doublon(Nom,Prob,Reste,L).
elimine_doublon(NomAvant,ProbAvant,[Nom#Prob],[NomAvant#ProbAvant,Nom#Prob]) :- \+ NomAvant == Nom.						
elimine_doublon(NomAvant,ProbAvant,[Nom#_],[NomAvant#ProbAvant]) :-  NomAvant = Nom.						
elimine_doublon(NomAvant,ProbAvant,[],[NomAvant#ProbAvant]).

%Affiche le resultat, c'est ˆ dire chaque minéral et sa probabilité.
affiche([Nom#Prob|Reste]):- write(Nom),write('  '),V is Prob,write(V),nl,affiche(Reste).
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

%Base de connaissances sur les minéraux, basée sur le principe des facteurs de confiance. 
%On retourne la probabilité d'avoir un minéral donné étant donné une caractéristique ou un série de caractéristiques
mineral(diamant,X):-
  raye_par(non_rayable), 
  X = 30.
mineral(diamant,X):-
  eclat(vitreux), 
  X = 10.
mineral(diamant,X):-
  raye_par(non_rayable), 
  forme(cubique),
  X = 50.
mineral(diamant,X):-
  raye_par(non_rayable), 
  forme(cubique),
  eclat(vitreux),
  X = 90.
mineral(quartz,X):-
  raye_par(non_rayable), 
  X = 30.
mineral(magnetite,X):-
  magnetisme(fort), 
  X = 50.
mineral(magnetite,X):- 
  magnetisme(fort),
  couleur(noir),
  X = 90.
mineral(calcite,X):-
  reactivite_acide(forte), 
  X = 80.
mineral(dolomite,X):-
  reactivite_acide(faible), 
  X = 80.
mineral(amphibole,X):-
  forme(aciculaire),
  X = 30.
mineral(amphibole,X):-
  couleur(noir),forme(aciculaire),X = 50.
mineral(pyrite,X):-
  couleur(jaune),
  X = 30.
mineral(pyrite,X):-
  couleur(jaune),
  eclat(metallique),
  X = 50.
mineral(pyrite,X):-
  couleur(jaune),
  forme(cubique),
  eclat(metallique),
  X = 80.



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
