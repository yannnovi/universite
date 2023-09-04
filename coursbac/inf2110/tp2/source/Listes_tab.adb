------------------------------------------------------------------------------
--$Id: Listes_tab.adb,v 1.1 2003/07/16 01:40:45 yann Exp $
------------------------------------------------------------------------------
-- Module qui fait la gestion de liste.
--
-- Auteur: Yann Bourdeau
-- Courriel: bourdeau.yann@courrier.uqam.ca
-- cours: INF2110-10
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Liste des modules utilisees.
------------------------------------------------------------------------------
with Ada.Text_IO;           
use Ada.Text_IO;
with Ada.Sequential_IO;

PACKAGE body Listes_Tab is

   PACKAGE ES_Type_Element_Bin_Seq is new ada.sequential_IO(Type_Element);
   
   ------------------------------------------------------------------------------
   -- Cette procedure initilise une liste.
   -- NIVEAU: 1
   -- PARAMETRE: (IN) L:  Liste a etre initialise.
   ------------------------------------------------------------------------------
   Procedure Creer_Liste (L : In Out Liste) is
   begin
      L.Nb_elements:=0;
   end Creer_Liste;
   
   ------------------------------------------------------------------------------
   -- Cette procedure determine si une liste est vide.
   -- NIVEAU: 1
   -- PARAMETRE: (IN) L: Liste a etre verifier
   -- RETOURNE: TRUE  => La liste est vide.
   --           FALSE => La liste est non vide.
   ------------------------------------------------------------------------------
   Function Liste_Vide (L : in Liste) Return Boolean is
   BEGIN
      if(L.Nb_elements = 0) then
         RETURN TRUE;
      else
         RETURN FALSE;
      end if;
   END Liste_Vide;
   
   ------------------------------------------------------------------------------
   -- Cette procedure detruis la liste.
   -- NIVEAU: 1
   -- Parametre: (IN) L: Liste a detruire.
   ------------------------------------------------------------------------------
   Procedure Detruire_liste (L : in out Liste) is
   Begin
      L.Nb_elements :=0;
   End Detruire_liste;
   
   ------------------------------------------------------------------------------
   -- Cette procedure retourne le nombre d'element contenus dans la liste.
   -- NIVEAU: 1
   -- Parametre: (IN) L: Liste a retourne le nombre d'element.
   ------------------------------------------------------------------------------
   Function Nombre_Elements (L : in Liste) Return Natural is
   begin
      RETURN L.Nb_elements;
   end Nombre_Elements;
   
   ------------------------------------------------------------------------------
   -- Cette procedure insere un element en ordre dans la liste.
   -- NIVEAU: 1
   -- Parametre: (IN OUT)L: Liste qui vas contenir le nouveau element.
   --            (IN) Element: Element a ajouter.
   --            (OUT) succes: TRUE  => Operation a ete un succes.
   --                          FALSE => erreur. 
   ------------------------------------------------------------------------------
   Procedure Inserer_en_Ordre  (L       : in out Liste;    
                                Element : In Type_Element; 
                                Succes  : out Boolean) is
      -- Declaration des variables.
      ExisteDeja : boolean := false;                             
   begin
      -- Si le tableau est vide, inserer a la premiere position.   
      if(l.Nb_elements = 0) then
         L.tab(1):=Element;
         l.Nb_Elements := L.Nb_Elements + 1;
         succes := true;
      else
         Succes:= false;
         FOR i in 1..L.Nb_elements loop
         -- Parcoure la liste jusqu'a ce que la cle de l'element soit
         -- inferier a celle dans le tableau.
      
            IF (not succes and not ExisteDeja) THEN
      
               -- Verifie si elle n'existe deja pas.
               if ( LaCle(L.Tab(i)) = LaCle(Element)) then
                  ExisteDeja := true;
               end if;
               
               -- Agrandie le tableau de 1.                                              
               IF (LaCle(Element)<(LaCle(L.tab(i) ) )) THEN
      
                  FOR z in reverse i..L.Nb_elements loop
                     L.tab(z+1):=l.tab(z);
                  end loop;
                  
                  L.tab(i):=Element;
                  L.Nb_Elements:=L.Nb_Elements+1;
                  succes := true;
                  
               END IF;
            END IF;
         end loop;
         
         -- Verifie si l'element n'as pas ete inserer puisque le dernier 
         IF not succes and (LaCle(l.tab(l.Nb_elements)) < LaCle(Element) )THEN
            l.Nb_elements:=l.Nb_Elements+1;
            l.Tab(l.Nb_elements):=Element;
            Succes:=true;
         END IF;
     end if;
     exception
      WHEN others => succes := false;
   end Inserer_en_Ordre;
   
   ------------------------------------------------------------------------------
   -- Cette procedure permet de modifier un enregistrement existant.
   -- NIVEAU: 1
   -- PARAMETRE: L: (IN OUT) Liste qui contient l'enregistrement a etre modifie.
   --            Element: (IN) Element a etre modifie.
   --            Succes: (OUT) VRAI => L'element a ete modifie.
   --                          FAUX => L'element n'as pas ete modifie.
   ------------------------------------------------------------------------------
   Procedure Modifier (L       : in out Liste;    
                       Element : in Type_Element; 
                       Succes  : Out Boolean) is
   begin
      Succes:= false;
      
      FOR i in 1..L.Nb_Elements loop
         IF (Not succes) and (LaCle(l.Tab(i)) = LaCle(Element) ) THEN
            succes := true;
            l.tab(i):=Element;
         END IF;
      end loop;

     exception
      WHEN others => succes := false;
      
   end Modifier;
     
   ------------------------------------------------------------------------------
   -- Cette procedure retourne un element de la liste.
   -- NIVEAU: 1
   -- PARAMETRE: L: (IN) Liste qui contient l'enregistrement a etre retourne.
   --            Cle: (IN) Cle de l'enregistrement a etre retourne.
   --            Element: (OUT) Contient l'element retourne.
   --            Succes: (OUT) VRAI => Si l'element a etre trouve.
   --                          FAUX => L'element n'as pas ete trouve.
   ------------------------------------------------------------------------------
   Procedure Obtenir (L       : in  Liste;        
                      Cle     : in  Type_cle;     
                      Element : out Type_Element; 
                      Succes  : out Boolean) is     
   begin
      succes:= false;
      
      FOR i in 1..L.Nb_Elements loop
         IF (not succes) and (LaCle(l.tab(i)) = Cle ) THEN
            Succes:= true;
            Element:=l.tab(i);
         END IF;
      end loop;

     exception
      WHEN others => succes := false;
      
   end Obtenir;
                      
   ------------------------------------------------------------------------------
   -- Cette procedure permet de retirer un element de la liste.
   -- NIVEAU: 1
   -- PARAMETRE: L: (IN OUT) Liste qui contient l'enregistrement a etre enlever.
   --            Cle: (IN) Cle de l'enregistrement a etre enlever.
   --            Succes: (OUT) VRAI => Si l'enregistrement a ete enlever.
   --                          FAUX => Si l'enregistrement n'as pas ete enlever.
   ------------------------------------------------------------------------------
   Procedure Retirer (L      : in out Liste;      
                      Cle    : in Type_Cle;       
                      Succes : out Boolean) is
   begin
      succes:=false;
      FOR i in 1..L.Nb_Elements loop
   
         IF (not succes) and ( LaCle(l.Tab(i))=cle) THEN
   
            FOR z in i..L.Nb_Elements-1 loop
               L.Tab(z):=l.Tab(z+1);
            end loop;
            
            succes:= true;
            L.Nb_Elements:=L.Nb_Elements-1;
            
         END IF;
      end loop;

     exception
      WHEN others => succes := false;
      
   end Retirer;
                      
   ------------------------------------------------------------------------------
   -- Cette fonction retourne la cle du premier element.
   -- NIVEAU: 1
   -- PARAMETRE: L : (IN) Liste qui contient l'enregistrement a etre retourner.
   -- RETOURN: CLE: La cle du premier element de la liste.
   ------------------------------------------------------------------------------
   Function Premier (L : in Liste) Return Type_Cle is
   begin
      --IF (l.Nb_Elements >0 ) THEN
         RETURN LaCle(L.tab(1));
      --END IF;
   end Premier;
     
   ------------------------------------------------------------------------------
   -- Cette fonction retourne la cle du dernier element de la liste.
   -- NIVEAU: 1
   -- PARAMETRE: L : (IN) Liste qui contient l'enregistrement a etre retourner.
   -- RETOURN: CLE: La cle du dernier element de la liste.
   ------------------------------------------------------------------------------
   Function Dernier (L : in Liste) Return Type_Cle is
   begin
      --IF (l.Nb_elements >0 ) THEN
         RETURN LaCle(l.tab(l.Nb_Elements));
      --END IF;
   end Dernier;
     
   ------------------------------------------------------------------------------
   -- Cette procedure retourne la cle de l'enregistrement suivant celui specifie
   -- par la cle.
   -- NIVEAU: 1
   -- PARAMETRE: L : (IN) Liste qui contient les enregistrements.
   --            Cle_Entree: (IN) Cle de l'enregistrement a trouver.
   --            Cle_Suivante: (OUT) Cle de l'enregistrement qui suit celui
   --                                qui a ete trouve.
   --            Succes: (OUT) VRAI => L'enregistrement a ete trouve.
   --                          FAUX => L'enregistrement n'as pas ete trouve.
   ------------------------------------------------------------------------------
   Procedure Successeur (L            : in  Liste;     
                           Cle_Entree   : in  Type_Cle;  
                           Cle_Suivante : Out Type_Cle;  
                           Succes       : Out Boolean) is
   begin
      succes := false;
      FOR i in 1..L.Nb_Elements loop
   
         IF (NOT succes) and (LaCle(l.tab(i)) = Cle_Entree) THEN
   
            if ( i + 1 <= l.Nb_Elements) then
   
               succes:=true;
               Cle_Suivante := LaCle(L.Tab(i+1));
               
            end if;
         END IF;
      end loop;
     exception
      WHEN others => succes := false;
      
   end Successeur;
     
   ------------------------------------------------------------------------------
   -- Cette procedure retourne la cle de l'enregistrement qui precede celui
   -- specifie.
   -- NIVEAU: 1
   -- PARAMETRE: L : (IN) Liste qui contient les enregistrement.
   --            Cle_Entree:(IN) Cle de l'enregistrement a trouver.
   --            Cle_Precedente:(OUT) Cle de l'enregistrement qui precede celui
   --                                 qui a ete specifie.
   --            Succes: (OUT) VRAI => L'enregistrement a ete trouver.
   --                          FAIX => L'enregistrement n'as pas ete trouver.
   ------------------------------------------------------------------------------
   Procedure Predecesseur (L             : in  Liste;     
                           Cle_Entree    : in  Type_Cle;  
                           Cle_Precedente: Out Type_Cle;  
                           Succes        : Out Boolean) is  
   begin
      succes:= false;
      FOR i in 1..L.Nb_Elements loop
   
         IF (Not succes) and (LaCle(L.Tab(i)) = Cle_Entree) THEN
   
            IF (i-1 > 0) THEN
               succes:=true;
               Cle_Precedente := LaCle(l.Tab(i-1));
            END IF;
            
         END IF;
      end loop;
     exception
      WHEN others => succes := false;
      
   end Predecesseur;
     
   ------------------------------------------------------------------------------
   -- Procedure qui sauvegarde la liste dans un fichier.
   -- NIVEAU: 1
   -- Parametre: (IN) Liste: liste a sauvegarder.
   --            (IN) Nom: Nom du fichier qui vas contenir la liste
   --            (OUT) Succes: VRAI => Le fichier a ete sauvegarder.
   --                          FAUX => Le fichier n'as pas ete sauvegarder.
   ------------------------------------------------------------------------------
   Procedure Sauvegarder (L : In Liste;      
                         Nom    : In String;      
                         Succes : Out Boolean) is
      -- Declaration des variables.
      Fichier: ES_Type_Element_Bin_Seq.File_Type; -- Definition du fichier                         
   begin
      
      succes:=true;                                    
      
      ES_Type_Element_Bin_Seq.Create(Fichier,ES_Type_Element_Bin_Seq.Out_File,Nom);
      
      For i in 1..L.Nb_elements loop
         ES_Type_Element_Bin_Seq.Write(Fichier, l.Tab(I));
      End loop;
      
      ES_Type_Element_Bin_Seq.Close(Fichier);
      
     exception
      WHEN others => succes := false;
      
   end Sauvegarder;
     
   ------------------------------------------------------------------------------
   -- Procedure qui recupere la liste dans un fichier.
   -- NIVEAU: 1
   -- PARAMETRE: Liste: (IN) Liste qui vas contenir les elements lus.
   --            Nom: (IN) Nom du fichier qui contient la liste.
   --            (OUT) Succes: VRAI => Le fichier a ete lus.
   --                          FAUX => Le fichier n'as pas ete lus.
   ------------------------------------------------------------------------------
   Procedure Recuperer(L    : Out Liste;        
                       Nom     : In String;        
                       Succes  : Out Boolean) is
      -- Declaration des variables.
      Fichier: ES_Type_Element_Bin_Seq.File_Type; -- Definition du fichier                         
   begin
      succes := true;
      L.Nb_elements:=0;
      ES_Type_Element_Bin_Seq.Open (Fichier, ES_Type_Element_Bin_Seq.In_File,Nom);
      
      while not ES_Type_Element_Bin_Seq.End_Of_File(Fichier) loop
         L.Nb_elements:=L.Nb_elements+1;
         ES_Type_Element_Bin_Seq.Read(Fichier,l.Tab(L.Nb_elements));
      end loop;
      
      ES_Type_Element_Bin_Seq.Close(Fichier);
      
     exception
      WHEN others => succes := false;
      
   end Recuperer;

end Listes_Tab;
