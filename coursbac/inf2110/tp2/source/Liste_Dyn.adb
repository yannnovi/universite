------------------------------------------------------------------------------
--$Id: Liste_Dyn.adb,v 1.3 2003/07/17 15:03:02 yann Exp $
------------------------------------------------------------------------------
-- Module qui fait la gestion de liste dynamique.
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
WITH Unchecked_deallocation;

PACKAGE body Liste_Dyn is

   Type Noeud is record
      Suivant: PtrNoeud;
      Element: Type_Element;
   end record;
   
   PACKAGE ES_Type_Element_Bin_Seq is new ada.sequential_IO(Type_Element);
   
   PROCEDURE Liberer_Noeud IS New Unchecked_deallocation (Noeud, PtrNoeud);       

   ------------------------------------------------------------------------------
   -- Cette procedure Libere une liste chaine.
   -- NIVEAU: 2
   -- PARAMETRE: (IN) L:  Liste a etre liberer.
   ------------------------------------------------------------------------------
   PROCEDURE LibereMemoireListe(Courant: in out PtrNoeud) is
      Suivant: PtrNoeud; -- Pointeur sur le noeud suivant.
   begin
      WHILE Courant /= NULL LOOP
         Suivant := Courant.Suivant;
         Liberer_Noeud(Courant);
         Courant:=Suivant;
      END LOOP;
   end;
   
   
   ------------------------------------------------------------------------------
   -- Cette procedure initilise une liste.
   -- NIVEAU: 1
   -- PARAMETRE: (IN) L:  Liste a etre initialise.
   ------------------------------------------------------------------------------
   Procedure Creer_Liste (L : In Out Liste) is
   begin
      IF L.Tete /= NULL THEN
         LibereMemoireListe(L.Tete);
         L.Remorque:=null;
         L.Nb_elements := 0;            
      END IF;
      
      l.Tete := new Noeud;
      l.Remorque:= l.Tete;
      l.Tete.Suivant := null;
      
      l.Nb_elements := 0;
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
      IF l.Nb_elements < 1 THEN
         RETURN true;
      ELSE 
         RETURN false;
      END IF;
   END Liste_Vide;
   
   ------------------------------------------------------------------------------
   -- Cette procedure detruis la liste.
   -- NIVEAU: 1
   -- Parametre: (IN) L: Liste a detruire.
   ------------------------------------------------------------------------------
   Procedure Detruire_liste (L : in out Liste) is
   Begin
      IF L.Tete /= NULL THEN
         LibereMemoireListe(L.Tete);
         L.Remorque:=null;
         L.Nb_elements := 0;            
      END IF;
   End Detruire_liste;
   
   ------------------------------------------------------------------------------
   -- Cette procedure retourne le nombre d'element contenus dans la liste.
   -- NIVEAU: 1
   -- Parametre: (IN) L: Liste a retourne le nombre d'element.
   ------------------------------------------------------------------------------
   Function Nombre_Elements (L : in Liste) Return Natural is
   begin
      RETURN l.Nb_elements;
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
                                
      pCourant: PtrNoeud; -- Pointeur sur le noeud courant.
      trouve: boolean := false; -- Determine si une element plus grand a ete trouve.
      pNoeud: PtrNoeud; -- Pointeur sur le nouveau noeud.
   begin

      succes := true;         
      pCourant := l.Tete;
      
      -- Cherche le premiere position plus grande.                                                       
      WHILE (pCourant /= l.Remorque) and (not trouve) LOOP
         IF LaCle(pCourant.Element) < LaCle(Element) THEN
            pCourant:= pCourant.Suivant;
         ELSE
            trouve := true;
         END IF;
      END LOOP;
      
      -- Allocation du nouveau noeud.                                  
      pNoeud := new Noeud;
      pNoeud.Suivant := null;
      
      IF not TROUVE THEN
         -- Si aucune element trouve plus grand, insere a la fin.
         l.Remorque.Element := Element;
         l.Remorque.Suivant := pnoeud;
         l.Remorque := pnoeud;
      ELSE
         -- Sinon insere au debut.
         pNoeud.Element := pCourant.Element;
         pNoeud.Suivant := pCourant.Suivant;
         pCourant.Element := element;
         pCourant.Suivant := pNoeud;
      END IF;
      
      l.Nb_elements := l.Nb_elements + 1;   
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
                       
      pCourant: PtrNoeud;  -- Pointeur sur le noeud courant.                       
      trouve : boolean:= false; -- Determine si l'enregistrement a ete trouve.
   begin
      Succes := false;
      pCourant := l.Tete;
      
      -- Cherche l'element.
      WHILE (pCourant /= l.Remorque) and (not trouve)  LOOP

         IF LaCle(pCourant.Element) = LaCle(Element) THEN
            trouve := true;
         ELSE   
            pCourant := pCourant.Suivant;
         END IF;
         
      END LOOP;
      
      -- Si l'element a ete trouve, modifie le.
      IF trouve THEN
         pCourant.Element := Element;
         succes := true;
      END IF;
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
      pCourant: PtrNoeud;-- Pointeur sur le noeud courant.                                             
   begin

      pCourant := l.Tete;
      succes := false;
      
      -- Checher l'element.
      WHILE (pCourant /= l.Remorque) and ( not succes) LOOP

         IF LaCle(pCourant.Element) = Cle THEN
            -- Trouve!
            Element := pCourant.Element;
            succes := true;
         ELSE            
            pCourant := pCourant.Suivant;
         END IF;
         
      END LOOP;
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
                      
      pCourant: PtrNoeud; -- Pointeur sur le noeud courant.                       
      pSuivant: PtrNoeud; -- Pointeur sur le noeud suivant le courant.                       
   begin

      succes := false;
      
      pCourant := l.Tete;
      
      -- Cherche l'element a retirer!                      
      WHILE pCourant /= l.Remorque and not succes LOOP

         IF LaCle(pCourant.Element) = Cle THEN
            -- Trouver
            Succes := true;
            pSuivant := pCourant.Suivant;
            pCourant.all := pSuivant.all;
            
            IF pSuivant = l.Remorque THEN
               l.Remorque := pCourant;
            END IF;
            
            Liberer_Noeud(pSuivant);
         END IF;
         
      END LOOP;
      
   end Retirer;
                      
   ------------------------------------------------------------------------------
   -- Cette fonction retourne la cle du premier element.
   -- NIVEAU: 1
   -- PARAMETRE: L : (IN) Liste qui contient l'enregistrement a etre retourner.
   -- RETOURN: CLE: La cle du premier element de la liste.
   ------------------------------------------------------------------------------
   Function Premier (L : in Liste) Return Type_Cle is
   begin
      return LaCle (l.Tete.Element);
   end Premier;
     
   ------------------------------------------------------------------------------
   -- Cette fonction retourne la cle du dernier element de la liste.
   -- NIVEAU: 1
   -- PARAMETRE: L : (IN) Liste qui contient l'enregistrement a etre retourner.
   -- RETOURN: CLE: La cle du dernier element de la liste.
   ------------------------------------------------------------------------------
   Function Dernier (L : in Liste) Return Type_Cle is
      pCourant: PtrNoeud; -- Pointeur sur le noeud courant.                       
   begin

      pCourant := l.Tete;
      
      -- Vas au dernier element.
      WHILE pCourant.suivant /= l.Remorque LOOP
         pCourant := pCourant.Suivant;
      END LOOP;
      
      RETURN LaCle(pCourant.Element);
      
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
                           
      pCourant: PtrNoeud; -- Pointeur sur le noeud courant.                       
      
   begin
      succes := false;
      
      pCourant := l.Tete;
      
      -- Vas a l'element suivant la cle specifie.
      WHILE (pCourant /= l.Remorque) and (not succes ) LOOP

         IF LaCle(pCourant.Element) = Cle_entree THEN
            -- Trouve
            
            -- Si l'element suivant n'est pas la remorque!
            IF pCourant.Suivant /= l.Remorque THEN
               -- OK!
               succes := true;
               Cle_suivante := LaCle(pCourant.Suivant.Element);   
            END IF;
         END IF;
         
         pCourant := pCourant.Suivant;
         
      END LOOP;
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
                           
   pCourant: PtrNoeud; -- Pointeur sur le noeud courant.                                               
                           
   begin

      succes := false;
      
      -- Si non liste vide.
      if (l.Tete /= l.Remorque) then

         pCourant := l.Tete;
         
         -- Vas a l'element chercher.
         WHILE (pCourant.Suivant /= l.Remorque) and (not succes )  LOOP
            -- Verifie si element = cle.
            IF LaCle(pCourant.Suivant.Element) = Cle_entree THEN
               succes := true;
               Cle_Precedente := LaCle(pCourant.Element);
            END IF;
            pCourant := pCourant.Suivant;
         END LOOP;
         
      end if;
      
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
      pCourant: PtrNoeud; -- Pointeur sur le noeud courant.                                               
   begin
      succes:=true;                                    
      
      ES_Type_Element_Bin_Seq.Create(Fichier,ES_Type_Element_Bin_Seq.Out_File,Nom);
      
      pCourant := l.Tete;
      
      WHILE pCourant /= l.Remorque LOOP
         ES_Type_Element_Bin_Seq.Write(Fichier, pCourant.Element);
         pCourant := pCourant.Suivant;
      END LOOP;
      
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
      pNoeud: PtrNoeud; -- Pointeur sur le noeud a ajouter.
   begin
      succes := true;
      
      IF L.Tete /= NULL THEN
         LibereMemoireListe(L.Tete);
         L.Remorque:=null;
         L.Nb_elements := 0;            
      END IF;

      pNoeud := new Noeud;
      pNoeud.Suivant := NULL;
      L.Tete := pNoeud;

      ES_Type_Element_Bin_Seq.Open (Fichier, ES_Type_Element_Bin_Seq.In_File,Nom);

     while not ES_Type_Element_Bin_Seq.End_Of_File(Fichier) loop
         L.Nb_elements:=L.Nb_elements+1;
         ES_Type_Element_Bin_Seq.Read(Fichier,pNoeud.Element);
         
         pNoeud.Suivant := new noeud;
         pNoeud := pNoeud.Suivant;
            
      end loop;
      
      ES_Type_Element_Bin_Seq.Close(Fichier);
      
      l.Remorque := pNoeud;
      
     exception
      WHEN others => succes := false;
	  			     l.Remorque := pNoeud; -- Etre sur que la liste soit initialise.
      
   end Recuperer;


end Liste_Dyn;
