% Mineraux
% Il s'agit d'un système expert permettant l'identification de minéraux
% a partir de différentes caractéristiques. La plupart des minéraux
% font partie d'un groupe ou d'une famille ayant des caractéristiques 
% communes. 

main :- identify.

identify:-
  retractall(known(_,_,_)),   % clear stored information
  mineral(X),
  write('Ce mineral est : '),write(X),nl.
identify:-
  write('Je ne peux identifier ce mineral'),nl.

%Groupes de minéraux
groupe(sulfures):-
  eclat(metallique),
  magnetisme(absent),
  densite(forte),
  reactivite_acide(absente).
groupe(oxydes):-
  eclat(semi_metallique),
  forme(cubique).
groupe(oxydes):-
  eclat(vitreux),
  forme(cubique).
groupe(silicates):-
  eclat(vitreux),
  magnetisme(absent),
  densite(faible),
  reactivite_acide(absente).
groupe(silicates):-
  eclat(mat),
  magnetisme(absent),
  densite(faible),
  reactivite_acide(absente).
groupe(carbonates):-
  eclat(mat),
  trait(incolore),
  magnetisme(absent),
  reactivite_acide(forte),
  clivage(parfait),
  densite(faible).
groupe(carbonates):-
  eclat(mat),
  trait(incolore),
  magnetisme(absent),
  reactivite_acide(faible),
  clivage(parfait),
  densite(faible).
famille(phyllosilicates):-
  groupe(silicates),
  clivage(parfait),
  forme(feuillet).
  
%Les minéraux
mineral(diamant):-
  eclat(vitreux),
  trait(incolore),
  raye_par(non_rayable),
  couleur(incolore),
  forme(cubique),
  magnetisme(absent).
mineral(quartz) :-
  groupe(silicates),
  trait(incolore),
  raye_par(non_rayable),
  couleur(incolore),
  forme(hexagonal),
  eclat(vitreux).
mineral(quartz):-
  groupe(silicates),
  trait(incolore),
  raye_par(non_rayable),
  couleur(incolore),
  forme(xenomorphe),
  eclat(vitreux).
mineral(graphite):-
  trait(colore),
  raye_par(ongle),
  couleur(noir),
  eclat(semi-metallique),
  magnetisme(absent),
  forme(feuillet).
mineral(calcite):-
  groupe(carbonates),
  reactivite_acide(forte),
  raye_par(cuivre).
mineral(dolomite):-
  groupe(carbonates),
  reactivite_acide(faible),
  raye_par(cuivre),
  couleur(blanc).
mineral(amphibole):-
  groupe(silicates),
  trait(incolore),
  eclat(mat),
  raye_par(verre),
  couleur(noir),
  forme(aciculaire).
mineral(pyrite):-
  groupe(sulfures),
  trait(incolore),
  couleur(jaune),
  forme(cubique),
  raye_par(verre).
mineral(magnetite):-
  groupe(oxydes),
  trait(incolore),
  couleur(noir),
  forme(cubique),
  magnetisme(fort),
  raye_par(verre).
mineral(feldspath):-
  groupe(silicates),
  trait(incolore),
  eclat(mat),
  couleur(blanc),
  forme(prismatique),
  clivage(parfait),
  raye_par(verre),
  macles(present).
mineral(talc):-
  famille(phyllosilicates),
  trait(colore),
  eclat(mat),
  raye_par(ongle),
  couleur(vert).
mineral(chlorite):-
  famille(phyllosilicates),
  trait(colore),
  eclat(mat),
  raye_par(cuivre),
  couleur(vert).
mineral(biotite):-
  famille(phyllosilicates),
  trait(incolore),
  eclat(mat),
  raye_par(acier),
  couleur(noir).
mineral(ilmenite):-
  eclat(semi_metallique),
  trait(incolore),
  couleur(noir),
  magnetisme(faible),
  forme(cubique).
mineral(muscovite):-
  famille(phyllosilicates),
  trait(incolore),
  eclat(vitreux),
  couleur(incolore),
  raye_par(acier).


%Liste des différentes caractéristiques
eclat(X):- menuask(eclat,X,[metallique,semi_metallique,mat,vitreux]).
couleur(X):- menuask(couleur,X,[noir,vert,jaune,blanc,incolore]).
magnetisme(X):- menuask(magnetisme,X,[fort,faible,absent]).
forme(X):- menuask(forme,X,[cubique,prismatique,xenomorphe,feuillet]).
clivage(X):- menuask(clivage,X,[parfait,imparfait,absent]).
raye_par(X):- menuask(raye_par,X,[ongle,cuivre,acier,verre,non_rayable]).
macles(X):- ask(macles,X).
reactivite_acide(X):- menuask(reactivite_acide,X,[forte,faible,absente]).
densite(X):- menuask(densite,X,[forte,faible]).
trait(X):- menuask(trait,X,[colore,incolore]).  



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

% ask(Attribute,_):-
%   known(yes,Attribute,_),         % fail if we know its some other value.
%   !, fail.                        % the cut in clause #1 ensures that if
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
