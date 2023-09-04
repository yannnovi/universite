-------------------------------------------------------------------------------
-- $Id: Listes_tab.ads,v 1.1 2003/07/15 14:55:28 yann Exp $
-------------------------------------------------------------------------------
-- Sujet : Module de gestion de listes 
--         Partie implantation � �crire
-- Date  : Mai 2003
-- Cours : inf2110 - travail pratique no.1
-- Note  : le module ne retourne aucune exception au programme client
--         Le param�tre Succes retournera � faux dans le cas de l'insucces
--         du traitement du service.
------------------------------------------------------------------------------- 
GENERIC
  Max_Elements : Natural := 100;                              -- Nombre d'�lements max. dans la liste
  TYPE Type_Element IS Private;                               -- Type de l'enregistrement a gerer
  TYPE Type_Cle IS Private;                                   -- Type de la cle de l'enregistrement
  WITH Function LaCle (Item : Type_Element) Return Type_Cle;  -- Fonction qui retourne la valeur de la cle
  WITH Function "<"  (Gauche,Droite : Type_Cle) Return Boolean;  -- Importation de l'operateur < pour comparer des cles

PACKAGE Listes_Tab is
  
  Type Liste is private;                                      -- Type prive
    
  Procedure Creer_Liste (L : In Out Liste);
  
  -------------------------------------------------------------------
  -- Ant  : la liste L peut deja contenir des elements a detruire
  -- Cons : la liste L est � l'etat vide
  -------------------------------------------------------------------
  
  Function Liste_Vide (L : in Liste) Return Boolean;
  
  -------------------------------------------------------------------
  -- Ant  : la liste L doit �tre definie
  -- Cons : Retourne la valeur TRUE si la liste est vide ou False
  --        si la liste contient au moins un element
  -------------------------------------------------------------------
  
  Procedure Detruire_liste (L : in out Liste);
  
  -------------------------------------------------------------------
  -- Ant  : la liste L doit �tre definie
  -- Cons : Tous les elements de la liste sont detruits et l'etat
  --        de la liste est indefini
  -------------------------------------------------------------------

  Function Nombre_Elements (L : in Liste) Return Natural;
 
  -------------------------------------------------------------------
  -- Ant  : la liste L doit �tre definie
  -- Cons : retourne le nombre d'�l�ments de la liste
  -------------------------------------------------------------------   
  
  --
  -- Services de gestion d'�lements
  --
  
  Procedure Inserer_en_Ordre  (L       : in out Liste;    -- Liste
                               Element : In Type_Element; -- l'element � inserer
                               Succes  : out Boolean);    -- Succes de l'operation

  -------------------------------------------------------------------
  -- Ant  : la liste L doit �tre definie
  -- Cons : l'element est ins�r� dans la liste selon la valeur de la 
  --        cle de l'element. Succes retourne False, si un probleme 
  --        est survenu lors de l'insertion. Il ne peut y avoir 2 
  --        elements ayant la m�me valeur de cl�.
  -------------------------------------------------------------------
                      
  Procedure Modifier (L       : in out Liste;    -- Liste
                      Element : in Type_Element; -- l'element � modifier
                      Succes  : Out Boolean);    -- Succes de l'operation

  -------------------------------------------------------------------
  -- Ant  : la liste L doit �tre definie                                  
  -- Cons : Le contenu de l'�l�ment d�j� pr�sent dans la liste 
  --        a �t� remplac�e par l'�lement en param�tre. Si l'�l�ment
  --        n'est pas dans la liste, succes retourne False.
  -- Note : dans cette version, la valeur de la cl� n'est pas modifiable
  -------------------------------------------------------------------
                                            
  Procedure Obtenir (L       : in  Liste;        -- Liste
                     Cle     : in  Type_cle;     -- Cle de l'�lement
                     Element : out Type_Element; -- Element retourne
                     Succes  : out Boolean);     -- Succes de l'operation
 
  -------------------------------------------------------------------
  -- Ant  : la liste L doit �tre definie
  -- Cons : on retourne l'�lement correspondant � la cl� fournie.
  --        Succes retourne False, si aucun element n'est trouv� 
  -------------------------------------------------------------------
                    
  Procedure Retirer (L      : in out Liste;      -- Liste
                     Cle    : in Type_Cle;       -- Cle de l'�l�ment � retirer
                     Succes : out Boolean);      -- Succes de l'operation
  
  -------------------------------------------------------------------
  -- Ant  : la liste L doit �tre definie
  -- Cons : l'element correspondant � la cl� est retir� de la liste 
  --        Succes retourne False si l'�lement n'est pas trouve 
  -------------------------------------------------------------------

  Function Premier (L : in Liste) Return Type_Cle;

  -------------------------------------------------------------------
  -- Ant  : la liste L doit �tre definie et non vide
  -- Cons : La cl� du premier �l�ment de la liste est retourn�e 
  -------------------------------------------------------------------

  Function Dernier (L : in Liste) Return Type_Cle;

  -------------------------------------------------------------------
  -- Ant  : la liste L doit �tre definie et non vide
  -- Cons : La cl� du dernier �l�ment de la liste est retourn�e 
  -------------------------------------------------------------------    

  Procedure Successeur (L            : in  Liste;     -- Liste
                        Cle_Entree   : in  Type_Cle;  -- Cl� en entr�e
                        Cle_Suivante : Out Type_Cle;  -- Cl� de l'�lement suivant
                        Succes       : Out Boolean);  -- Succes de l'operation

  -------------------------------------------------------------------
  -- Ant  : la liste L doit �tre definie
  -- Cons : Si l'�lement correspondant � la cle_entree existe,
  --        la cle de l'�lement suivant sera retournee.
  --        Succes retourne False si l'�lement n'a pas de successeur 
  -------------------------------------------------------------------

  Procedure Predecesseur (L             : in  Liste;     -- Liste
                          Cle_Entree    : in  Type_Cle;  -- Cl� en entr�e
                          Cle_Precedente: Out Type_Cle;  -- Cl� de l'�lement precedent
                          Succes        : Out Boolean);  -- Succes de l'operation

  -------------------------------------------------------------------
  -- Ant  : la liste L doit �tre definie
  -- Cons : Si l'�lement correspondant � la cle_entree existe,
  --        la cle de l'�lement precedent sera retournee.
  --        Succes retourne False si l'�lement n'a pas de predecesseur 
  -------------------------------------------------------------------  

  Procedure Sauvegarder (L : In Liste;       -- Liste � sauvegarder    
                         Nom    : In String;            -- Nom du fichier
                         Succes : Out Boolean);         -- Succes de l'operation


  ---------------------------------------------------------------------
  -- Sauvegarder les �lements de la liste sur un fichier binaire
  -- � acc�s s�quentiel
  --
  -- Cons : Les �lements de la liste sont sauvegard�s
  --        Succes retourne � TRUE si le traitement s'est bien d�roul�
  --        Succes retourne FALSE si une erreur est survenue
  ---------------------------------------------------------------------                                

  Procedure Recuperer(L    : Out Liste;         -- Liste � r�cuperer    
                      Nom     : In String;            -- Nom du fichier
                      Succes  : Out Boolean);         -- Succes de l'operation


  ---------------------------------------------------------------------
  -- Recuperer les �lements de la liste  d'un fichier binaire
  -- � acc�s s�quentiel
  --
  -- Cons : Les �lements de la liste sont recup�r�s dans la liste.
  --        La liste est cr��e et son contenu pr�alable est perdu
  --        Succes retourne � TRUE si le traitement s'est bien d�roul�
  --        Succes retourne FALSE si une erreur est survenue
  ---------------------------------------------------------------------

PRIVATE
    Type Type_tableau is Array (1..Max_elements) Of Type_Element;
    Type Liste is record
                    Tab         : Type_Tableau;
                    Nb_elements : Natural := 0;
                  end record;
END Listes_Tab;
