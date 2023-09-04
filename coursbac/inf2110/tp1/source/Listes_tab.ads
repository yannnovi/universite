-------------------------------------------------------------------------------
-- $Id: Listes_tab.ads,v 1.1 2003/07/15 14:55:28 yann Exp $
-------------------------------------------------------------------------------
-- Sujet : Module de gestion de listes 
--         Partie implantation à écrire
-- Date  : Mai 2003
-- Cours : inf2110 - travail pratique no.1
-- Note  : le module ne retourne aucune exception au programme client
--         Le paramètre Succes retournera à faux dans le cas de l'insucces
--         du traitement du service.
------------------------------------------------------------------------------- 
GENERIC
  Max_Elements : Natural := 100;                              -- Nombre d'élements max. dans la liste
  TYPE Type_Element IS Private;                               -- Type de l'enregistrement a gerer
  TYPE Type_Cle IS Private;                                   -- Type de la cle de l'enregistrement
  WITH Function LaCle (Item : Type_Element) Return Type_Cle;  -- Fonction qui retourne la valeur de la cle
  WITH Function "<"  (Gauche,Droite : Type_Cle) Return Boolean;  -- Importation de l'operateur < pour comparer des cles

PACKAGE Listes_Tab is
  
  Type Liste is private;                                      -- Type prive
    
  Procedure Creer_Liste (L : In Out Liste);
  
  -------------------------------------------------------------------
  -- Ant  : la liste L peut deja contenir des elements a detruire
  -- Cons : la liste L est à l'etat vide
  -------------------------------------------------------------------
  
  Function Liste_Vide (L : in Liste) Return Boolean;
  
  -------------------------------------------------------------------
  -- Ant  : la liste L doit être definie
  -- Cons : Retourne la valeur TRUE si la liste est vide ou False
  --        si la liste contient au moins un element
  -------------------------------------------------------------------
  
  Procedure Detruire_liste (L : in out Liste);
  
  -------------------------------------------------------------------
  -- Ant  : la liste L doit être definie
  -- Cons : Tous les elements de la liste sont detruits et l'etat
  --        de la liste est indefini
  -------------------------------------------------------------------

  Function Nombre_Elements (L : in Liste) Return Natural;
 
  -------------------------------------------------------------------
  -- Ant  : la liste L doit être definie
  -- Cons : retourne le nombre d'éléments de la liste
  -------------------------------------------------------------------   
  
  --
  -- Services de gestion d'élements
  --
  
  Procedure Inserer_en_Ordre  (L       : in out Liste;    -- Liste
                               Element : In Type_Element; -- l'element à inserer
                               Succes  : out Boolean);    -- Succes de l'operation

  -------------------------------------------------------------------
  -- Ant  : la liste L doit être definie
  -- Cons : l'element est inséré dans la liste selon la valeur de la 
  --        cle de l'element. Succes retourne False, si un probleme 
  --        est survenu lors de l'insertion. Il ne peut y avoir 2 
  --        elements ayant la même valeur de clé.
  -------------------------------------------------------------------
                      
  Procedure Modifier (L       : in out Liste;    -- Liste
                      Element : in Type_Element; -- l'element à modifier
                      Succes  : Out Boolean);    -- Succes de l'operation

  -------------------------------------------------------------------
  -- Ant  : la liste L doit être definie                                  
  -- Cons : Le contenu de l'élément déjà présent dans la liste 
  --        a été remplacée par l'élement en paramètre. Si l'élément
  --        n'est pas dans la liste, succes retourne False.
  -- Note : dans cette version, la valeur de la clé n'est pas modifiable
  -------------------------------------------------------------------
                                            
  Procedure Obtenir (L       : in  Liste;        -- Liste
                     Cle     : in  Type_cle;     -- Cle de l'élement
                     Element : out Type_Element; -- Element retourne
                     Succes  : out Boolean);     -- Succes de l'operation
 
  -------------------------------------------------------------------
  -- Ant  : la liste L doit être definie
  -- Cons : on retourne l'élement correspondant à la clé fournie.
  --        Succes retourne False, si aucun element n'est trouvé 
  -------------------------------------------------------------------
                    
  Procedure Retirer (L      : in out Liste;      -- Liste
                     Cle    : in Type_Cle;       -- Cle de l'élément à retirer
                     Succes : out Boolean);      -- Succes de l'operation
  
  -------------------------------------------------------------------
  -- Ant  : la liste L doit être definie
  -- Cons : l'element correspondant à la clé est retiré de la liste 
  --        Succes retourne False si l'élement n'est pas trouve 
  -------------------------------------------------------------------

  Function Premier (L : in Liste) Return Type_Cle;

  -------------------------------------------------------------------
  -- Ant  : la liste L doit être definie et non vide
  -- Cons : La clé du premier élément de la liste est retournée 
  -------------------------------------------------------------------

  Function Dernier (L : in Liste) Return Type_Cle;

  -------------------------------------------------------------------
  -- Ant  : la liste L doit être definie et non vide
  -- Cons : La clé du dernier élément de la liste est retournée 
  -------------------------------------------------------------------    

  Procedure Successeur (L            : in  Liste;     -- Liste
                        Cle_Entree   : in  Type_Cle;  -- Clé en entrée
                        Cle_Suivante : Out Type_Cle;  -- Clé de l'élement suivant
                        Succes       : Out Boolean);  -- Succes de l'operation

  -------------------------------------------------------------------
  -- Ant  : la liste L doit être definie
  -- Cons : Si l'élement correspondant à la cle_entree existe,
  --        la cle de l'élement suivant sera retournee.
  --        Succes retourne False si l'élement n'a pas de successeur 
  -------------------------------------------------------------------

  Procedure Predecesseur (L             : in  Liste;     -- Liste
                          Cle_Entree    : in  Type_Cle;  -- Clé en entrée
                          Cle_Precedente: Out Type_Cle;  -- Clé de l'élement precedent
                          Succes        : Out Boolean);  -- Succes de l'operation

  -------------------------------------------------------------------
  -- Ant  : la liste L doit être definie
  -- Cons : Si l'élement correspondant à la cle_entree existe,
  --        la cle de l'élement precedent sera retournee.
  --        Succes retourne False si l'élement n'a pas de predecesseur 
  -------------------------------------------------------------------  

  Procedure Sauvegarder (L : In Liste;       -- Liste à sauvegarder    
                         Nom    : In String;            -- Nom du fichier
                         Succes : Out Boolean);         -- Succes de l'operation


  ---------------------------------------------------------------------
  -- Sauvegarder les élements de la liste sur un fichier binaire
  -- à accès séquentiel
  --
  -- Cons : Les élements de la liste sont sauvegardés
  --        Succes retourne à TRUE si le traitement s'est bien déroulé
  --        Succes retourne FALSE si une erreur est survenue
  ---------------------------------------------------------------------                                

  Procedure Recuperer(L    : Out Liste;         -- Liste à récuperer    
                      Nom     : In String;            -- Nom du fichier
                      Succes  : Out Boolean);         -- Succes de l'operation


  ---------------------------------------------------------------------
  -- Recuperer les élements de la liste  d'un fichier binaire
  -- à accès séquentiel
  --
  -- Cons : Les élements de la liste sont recupérés dans la liste.
  --        La liste est créée et son contenu préalable est perdu
  --        Succes retourne à TRUE si le traitement s'est bien déroulé
  --        Succes retourne FALSE si une erreur est survenue
  ---------------------------------------------------------------------

PRIVATE
    Type Type_tableau is Array (1..Max_elements) Of Type_Element;
    Type Liste is record
                    Tab         : Type_Tableau;
                    Nb_elements : Natural := 0;
                  end record;
END Listes_Tab;
