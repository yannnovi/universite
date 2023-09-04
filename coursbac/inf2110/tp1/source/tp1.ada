------------------------------------------------------------------------------
--$Id: tp1.ada,v 1.1 2003/07/15 14:55:28 yann Exp $
------------------------------------------------------------------------------
-- Programme de gestion de cours et d'etudiant.
--
-- Auteur: Yann Bourdeau
-- Courriel: bourdeau.yann@courrier.uqam.ca
-- cours: INF2110-10
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Liste des modules utilises.
------------------------------------------------------------------------------
with Ada.Text_IO; use Ada.text_io;          
with ada.characters.Handling;
with Ada.Strings.Fixed;
with ada.Strings.Maps.Constants;
WITH lecture;
WITH Listes_tab;

------------------------------------------------------------------------------
-- Procedure principal du programme. 
-- NIVEAU : 1
------------------------------------------------------------------------------
procedure GestionUQAM is
   ---------------------------------------------------------------------------
   -- Definition des constantes
   ---------------------------------------------------------------------------
   MAX_LONG_COURS_CODE : constant := 7; -- Longueur du code cours.
   MAX_LONG_COURS_HORAIRE: constant:= 20; -- Longueur maximum de la chaine
                                         -- de l'horaire.
   MAX_LONG_ETUDIANT_MATRICULE: constant:= 4; -- longueur maximum de la
                                             -- matricule.
   MAX_LONG_ETUDIANT_PRENOM: constant:= 30; -- Longueur maximum du prenom de 
                                           -- l'etudiant.                                             
   MAX_LONG_ETUDIANT_NOM: constant:= 30; -- Longueur maximum du nom de 
                                         -- l'etudiant.                                             
   MAX_INSCRIPTION_PAR_ETUDIANT: constant:= 25; -- Maximum de cours inscrit
                                                -- par etudiant.
                                                                                              
   ---------------------------------------------------------------------------
   -- Definition des types.
   ---------------------------------------------------------------------------
   
   -- Enumeration de la session (ete, hiver, automne)
   type Session_Cours is (hiver, ete, automne);
   
   -- Enumeration de l'etat du cours
   TYPE Etat_Cours is (actif, annule);
   
   -- Enumeration du lieu du cours
   TYPE Lieu_Cours is (Montreal, Quebec, Toronto);
   
   -- Enumeration des notes du cours.
   TYPE Note_Cours is (A,B,C,D,E,Z);
   
   -- Definition du type codeCours
   TYPE Code_Cours is new String ( 1 .. MAX_LONG_COURS_CODE);
   
   -- Definition du type matricule etudiant
   TYPE Matricule_Etudiant is new String( 1.. MAX_LONG_ETUDIANT_MATRICULE);
   
   -- Cle de l'enregistrement cours.
   TYPE Cle_Cours is 
   record
      Code: Code_Cours; -- Code du cours
      Session: Session_Cours; -- Session du cours
   end record;
   
   -- L'enregistrement contient la definition d'une inscription      
   TYPE EnregistrementInscription is
   record
      CodeCours  : Code_Cours;
                                 -- Contient le code du cours.
      Session    : Session_Cours;-- Contient la session du cours.
      Note       : Note_Cours;   -- Contient la note du cours.
      Statut     : Etat_Cours;   -- Contient le statut du cours.                                     
   end record;

   ---------------------------------------------------------------------------
   -- Fonction qui compare deux cle, pour savoir si la premiere est plus petite
   -- Miveau : Function "callback" pour module de liste.
   -- PARAMETRE: Gauche: (in) Cle qui devrais etre inferieur.
   --            Droite: (in) Cle qui devrais etre superieur.
   -- Retourne : VRAI  => Si la cle de gauche est inferieur.
   --            FAUX  => Si la cle de droite est superieur.
   ---------------------------------------------------------------------------
   FUNCTION CoursPlusPetit (Gauche,Droite: Cle_Cours) return boolean is
   begin

      if (Gauche.Code< Droite.Code) then
         RETURN true;
      elsif (Gauche.Code = Droite.Code) then
         if (Gauche.Session< Droite.Session) then
            RETURN TRUE;
         ELSE 
            RETURN FALSE;
         end if;
      else
         RETURN false;
      end if;
   end CoursPlusPetit;
   
   --------------------------------------------------------------------------
   -- fonction qui retourne la cle d'un enregistrement de type cours.
   -- Miveau : Function "callback" pour module de liste.
   -- PARAMETRE: Item: (in) enregistrement du cours.
   -- RETOUNE: La Cle.   
   --------------------------------------------------------------------------
   function RetourneCleInscription(Item: EnregistrementInscription) return Cle_Cours is
      -- Declaration des variables.
      Cle: Cle_Cours; -- Cle du cours
   begin
      Cle.Code := Item.CodeCours;
      Cle.Session := Item.Session;
      RETURN Cle;
   end RetourneCleInscription;

   
   -- Instanciation de module generique.
   -- Pour la liste des inscription.
   PACKAGE Liste_Inscription       is new Listes_tab(100, 
                                               EnregistrementInscription,
                                               Cle_Cours,
                                               RetourneCleInscription,
                                               CoursPlusPetit);
                                               

   -- L'enregistrement contient la definition d'un cours
   TYPE EnregistrementCours is
   record
      CodeCours  : Code_Cours;
                                 -- Contient le code du cours
      Session    : Session_Cours;-- Contient la session du cours
      Etat       : Etat_Cours;   -- Contient si le cours est actif ou annule.
      MaxPlace   : Positive;      -- Nombre maximum de place disponible dans le cours
      NumInscrits: natural;      -- Nombre d'inscription au cours.
      HoraireCours: String (1 .. MAX_LONG_COURS_HORAIRE); 
                                 -- L'horaire du cours.
      Lieu       : Lieu_Cours;   -- Lieu du cours.
      --Inscription: Liste;        -- Liste des inscriptions au cours.
   end record;
   
   -- L'enregistrement contient la definition d'un etudiant.
   TYPE EnregistrementEtudiant is
   record
      Matricule   : Matricule_Etudiant;
                                 -- Matricule de l'etudiant.
      Prenom      : String (1.. MAX_LONG_ETUDIANT_PRENOM);
                                 -- Prenom de l'etudiant.
      Nom         : String (1.. MAX_LONG_ETUDIANT_NOM);
                                 -- Nom de l'etudiant.
      Inscription : Liste_Inscription.Liste;   
                                 -- Tableau des inscription.                        
   end record;

   --------------------------------------------------------------------------
   -- fonction qui retourne la cle d'un enregistrement de type cours.
   -- Miveau : Function "callback" pour module de liste.
   -- PARAMETRE: Item: (in) enregistrement du cours.
   -- RETOUNE: La Cle.   
   --------------------------------------------------------------------------
   function RetourneCleCours(Item: EnregistrementCours) return Cle_Cours is
      -- Declaration des variables.
      Cle: Cle_Cours; -- Cle du cours
   begin
      Cle.Code :=  Item.CodeCours;
      Cle.Session := Item.Session;
      RETURN Cle;
   end RetourneCleCours;
   
   --------------------------------------------------------------------------
   -- fonction qui retourne la cle d'un enregistrement de type etudiant.
   -- Miveau : Function "callback" pour module de liste.
   -- PARAMETRE: Item: (in) enregistrement de l'etudiant.
   -- RETOUNE: La Cle.   
   --------------------------------------------------------------------------
   function RetourneCleEtudiant(Item: EnregistrementEtudiant) return Matricule_Etudiant is
   begin
      RETURN Item.Matricule;
   end RetourneCleEtudiant;

   ---------------------------------------------------------------------------
   -- Fonction qui compare deux cle, pour savoir si la premiere est plus petite
   -- Miveau : Function "callback" pour module de liste.
   -- PARAMETRE: Gauche: (in) Cle qui devrais etre inferieur.
   --            Droite: (in) Cle qui devrais etre superieur.
   -- Retourne : VRAI  => Si la cle de gauche est inferieur.
   --            FAUX  => Si la cle de droite est superieur.
   ---------------------------------------------------------------------------
   FUNCTION EtudiantPlusPetit (Gauche,Droite: Matricule_Etudiant) return boolean is
   begin

      if (Gauche<Droite) then
         RETURN true;
      end if;
      RETURN false;
   end EtudiantPlusPetit;
   
   ---------------------------------------------------------------------------
   -- Instanciation des modules generiques
   ---------------------------------------------------------------------------
   -- Pour la liste des cours.
   PACKAGE Liste_Cours       is new Listes_tab(100, 
                                               EnregistrementCours,
                                               cle_Cours,
                                               RetourneCleCours,
                                               CoursPlusPetit);

   -- Pour la liste des etudiants.                                               
   PACKAGE Liste_Etudiant    is new Listes_tab(100,
                                              EnregistrementEtudiant,
                                              Matricule_Etudiant,
                                              RetourneCleEtudiant,
                                              EtudiantPlusPetit);
                                              
   --- Entrees/Sorties des valeurs de types énumératifs ------
   package ES_Enum_SessionCours is new Enumeration_IO(Session_Cours);
   package ES_Enum_LieuCours is new Enumeration_IO(Lieu_Cours);
   package ES_Enum_EtatCours is new Enumeration_IO(Etat_Cours);
   PACKAGE ES_Enum_NoteCours is new Enumeration_IO(Note_Cours );

   ---------------------------------------------------------------------------
   -- Fonction qui retourne un code cours a partir d'une chaine
   -- NIVEAU 6:
   -- PARAMETRE: Chaine: (IN) Code du cours en format STRING.
   -- RETOURNE: Le code du cours en format Code_Cours
   ---------------------------------------------------------------------------
   FUNCTION TransformeChaineEnCodeCours(ChaineCodeCours: in String) return Code_Cours is
   -- Declaration des variables
   CodeCours : Code_Cours; -- Code cours a retourner.
   begin
      FOR i in ChaineCodeCours'Range loop
         CodeCours(i):=ChaineCodeCours(i);
      end loop;
      RETURN CodeCours;
   end TransformeChaineEnCodeCours;
   
   ---------------------------------------------------------------------------
   -- Fonction qui retourne un matricule a partir d'une chaine
   -- NIVEAU 6:
   -- PARAMETRE: Chaine: (IN) Matricule etudiant en format STRING.
   -- RETOURNE: Le matricule etudiant en format Matricule_etudiant
   ---------------------------------------------------------------------------
   FUNCTION TransformeChaineEnMatriculeEtudiant(ChaineMatricule: in String) return Matricule_Etudiant is
   -- Declaration des variables
   Matricule : Matricule_Etudiant; -- Matricule Etudiant a retourner.
   begin
      FOR i in ChaineMatricule'Range loop
         Matricule(i):=ChaineMatricule(i);
      end loop;
      RETURN Matricule;
   end TransformeChaineEnMatriculeEtudiant;   
   
   ---------------------------------------------------------------------------
   -- Fonction qui retourne une chaine a partir d'un code cours.
   -- NIVEAU 6:
   -- PARAMETRE: CodeCours: (IN) Code du cours.
   -- RETOURNE: Le code du cours en format String
   ---------------------------------------------------------------------------
   FUNCTION TransformeCodeCoursEnChaine(CodeCours: Code_cours) return String is
   -- Declaration des variables
   ChaineCodeCours : String(1..MAX_LONG_COURS_CODE); -- chaine Code cours a retourner.
   begin
      FOR i in ChaineCodeCours'Range loop
         ChaineCodeCours(i):=CodeCours(i);
      end loop;
      RETURN ChaineCodeCours;
   end TransformeCodeCoursEnChaine;   

   ---------------------------------------------------------------------------
   -- Fonction qui retourne une chaine a partir d'un matricule etudiant.
   -- NIVEAU 6:
   -- PARAMETRE: Matricule: (IN) Matricule Etudiant.
   -- RETOURNE: Le Matricule en format String
   ---------------------------------------------------------------------------
   FUNCTION TransformeMatriculeEnChaine(Matricule: Matricule_Etudiant) return String is
   -- Declaration des variables
   ChaineMatricule: String(1..MAX_LONG_ETUDIANT_MATRICULE); -- chaine Matricule a retourner.
   begin
      FOR i in ChaineMatricule'Range loop
         ChaineMatricule(i):=MAtricule(i);
      end loop;
      RETURN ChaineMatricule;
   end TransformeMatriculeEnChaine;   

   ---------------------------------------------------------------------------
   -- Fonction qui lis une session au clavier
   -- NIVEAU 6:
   -- PARAMETRE: Question: (IN) La question poser a l'utilisateur.
   -- RETOURNE: La session du cours.
   ---------------------------------------------------------------------------
   FUNCTION LireSession(Question: in String) return Session_Cours is
   --Declaration des variables.
      Session: Session_Cours:=ete; -- Session lus au clavier
      car: character; -- Contient le choix entrer par l'utilisateur.
   begin
      car := lecture.LireCaractere("123","Session du cours (1-Ete, 2-hiver, 3-automne):");
      CASE car IS
         WHEN '1' =>
            Session:= ete;
            
         WHEN '2' =>
            Session:= hiver;
            
         WHEN '3' =>
            Session := automne;
            
         WHEN others =>
            null;
      END CASE;

      RETURN Session;
   end LireSession;
   
   ---------------------------------------------------------------------------
   -- Fonction qui lis le lieu d'un cours au clavier.
   -- NIVEAU 6:
   -- PARAMETRE: Question: (IN) La question poser a l'utilisateur.
   -- RETOURNE: La lieu du cours.
   ---------------------------------------------------------------------------
   FUNCTION LireLieu(Question: in String) return Lieu_Cours is
   --Declaration des variables.
      Lieu: Lieu_Cours:=Montreal; -- Lieu lus au clavier
      car: character; -- Contient le choix entrer par l'utilisateur.
   begin
      car := lecture.LireCaractere("123","Lieu du cours (1-Montreal, 2-Quebec, 3-Toronto):");
      CASE car IS
         WHEN '1' =>
            Lieu:=Montreal;
            
         WHEN '2' =>
            Lieu:=Quebec;
            
         WHEN '3' =>
            Lieu:=Toronto;
            
         WHEN others =>
            null;
      END CASE;
      
      RETURN Lieu;
   end LireLieu;   

   ---------------------------------------------------------------------------
   -- Procedure qui trouve l'etudiant a partir du matricule lus au clavier.
   -- NIVEAU: 6
   -- PARAMETRE: ListeEtudiant: (IN) La liste d'etudiants.
   --            Etudiant: (out) L'etudiant trouver.
   --            Quitter: (out) VRAI => Transaction annuler par l'utilisateur.
   --                           FAUX => L'etudiant a ete trouve.
   ---------------------------------------------------------------------------
   procedure LireEtudiantExistant(ListeEtudiant: in Liste_etudiant.liste;
                                  Etudiant: out EnregistrementEtudiant;
                                   Quitter: out boolean) is
      -- Declaration des variables.
      succes: boolean; -- Determine si la fonction a reussis.
      Car: Character; -- Reponse lus au clavier pour savoir si l'utilisateur veut continuer.
   begin                                 
      quitter:=false;
      -- Lis matricule etudiant au clavier
      loop
         
         Etudiant.Matricule := TransformeChaineEnMatriculeEtudiant(Ada.Strings.Fixed.Translate(
                              Lecture.LireChaine("    ","Entrez le matricule etudiant:"),
                              Ada.Strings.Maps.Constants.Upper_Case_Map));
                              
         -- Retrouve l'etudiant
         Liste_etudiant.Obtenir (ListeEtudiant,Etudiant.Matricule,Etudiant,succes);
         
         IF not succes THEN
            put_line("Le matricule n'existe pas.");
            
            Car := ada.characters.handling.To_Upper(Lecture.LireCaractere("OoNn","Continuer (O/N):"));
            if(Car = 'N') then
               quitter := true;
            end if;
            
         END IF;

         EXIT when succes or quitter;
      end loop;   
   end LireEtudiantExistant;

   ---------------------------------------------------------------------------
   -- Procedure qui trouve un cours a partir de la cle cours lus au clavier.
   -- NIVEAU: 6
   -- PARAMETRE: ListeCours: (IN) La liste des cours.
   --            Cours: (out) Le cours trouve.
   --            Quitter: (out) VRAI => Transaction annuler par l'utilisateur.
   --                           FAUX => Le cours a ete trouve.
   ---------------------------------------------------------------------------
   PROCEDURE LireCoursExistant(ListeCours: in Liste_cours.liste;
                               Cours: out EnregistrementCours;
                               Quitter: out boolean  ) is                                   
      -- Declaration des variables temporaire.
      CleCours: Cle_Cours; -- Contient la cle du cours demander                               
      succes: boolean;  -- Determine si la fonction a reussis ou pas.
      Car: Character; -- Reponse lus au clavier pour savoir si l'utilisateur veut continuer.
   begin
         quitter:= false;
         loop
            -- lis la session.
            CleCours.Session := LireSession("Session du cours(ete, hiver, automne):");

            
            -- Lis le cours.
            CleCours.Code := TransformeChaineEnCodeCours(
                              Ada.Strings.Fixed.Translate(
                                 Lecture.LireChaine("AAANNNN","Entrez le code cours (AAANNNN):"),
                                          Ada.Strings.Maps.Constants.Upper_Case_Map));                                                                                 
            
            -- Valide si le cours existe.                                       
            Liste_Cours.Obtenir(ListeCours,CleCours,Cours,succes);
            
            IF not succes THEN
               put_line("Le cours n'existe pas.");
               Car := ada.characters.handling.To_Upper(Lecture.LireCaractere("OoNn","Continuer (O/N):"));
               if(Car = 'N') then
                  quitter := true;
               end if;            
            END IF;
            
            EXIT when succes or quitter;
         end loop;            

   end LireCoursExistant;
   
   ---------------------------------------------------------------------------
   -- Procedure qui effectue la transaction de creer un nouveau cours.
   -- Gestion cours
   -- NIVEAU: 5
   -- PARAMETRE: ListeCour: (IN OUT) Liste des cours.
   ---------------------------------------------------------------------------   
   procedure EffectuerTransactionCreerNouveauCours(ListeCours: in out Liste_cours.liste) is
   -- Declaration des variables
   Cours: EnregistrementCours; -- Contient le cours creer.
   TempCours: EnregistrementCours; -- Enregistrement temporaire qui sert a verifier si
                                   -- le cours existe deja.
   succes: boolean; -- Determine si la procedure a reussis.                                   
   quitter: boolean := false; -- Determine si l'utilisateur veut continuer en cas d'erreur.
   Car: Character; -- Reponse lus au clavier pour savoir si l'utilisateur veut continuer.
   CoursAnnule: boolean := false; -- Determine si le cours a ete annule.
   begin
      put_line("Creer un nouveau cours.");
      put_line("-----------------------");
      loop
         -- Lis le cours au clavier
         Cours.CodeCours := TransformeChaineEnCodeCours(Ada.Strings.Fixed.Translate(Lecture.LireChaine("AAANNNN","Entrez le code cours (AAANNNN):"),Ada.Strings.Maps.Constants.Upper_Case_Map));

         -- Lis la session
         Cours.Session:=LireSession("Session du cours(ete, hiver, automne):");

         --Verifie si le cours existe deja
         Liste_cours.Obtenir (ListeCours,RetourneCleCours(Cours),TempCours,Succes);
         
         -- Verifie si le cours n'as pas deja ete annule!            
         IF succes THEN
            IF TempCours.Etat = annule THEN
               CoursAnnule := true;
               succes := false;
            END IF;
         END IF;
         
         -- Quitte si le cours n'est pas trouve
         EXIT when not succes;

         -- Demande a l'usager si il veut continuer.
         put_line("Le cours existe deja.");         
         new_line;
         Car := ada.characters.handling.To_Upper(Lecture.LireCaractere("OoNn","Continuer (O/N):"));
         if(Car = 'N') then
            quitter := true;
         end if;
         
         -- Termine la transaction si l'utilisateur ne veut plus entrer le cours.                           
         EXIT when quitter;
      end loop;        
       
      IF not quitter THEN
         Cours.Etat:=actif;
         Cours.MaxPlace:=Lecture.LirePositive("Nombre de place disponible:");
         Cours.NumInscrits := 0;                 
         Cours.HoraireCours:=Lecture.LireChaine("                    ","Entrez l'horaire du cours (format libre):");
         Cours.Lieu := LireLieu("Lieu du cours(Montreal, Quebec, Toronto):");
         
         
         IF NOT CoursAnnule THEN
            -- Insere le cours dans la liste.                                  
            Liste_cours.Inserer_en_Ordre(ListeCours,Cours,Succes);
         ELSE            
            -- Si le cours existe deja pcq annule, le remplacer.
            Liste_Cours.Modifier(ListeCours,Cours,Succes);
         END IF;
         
      else         
         succes:=false;
      end if;         
      
      IF NOT quitter THEN

         IF succes THEN
            put_line("Le cours a ete ajouter.");
         else         
            put_line("ERREUR: Impossible d'ajouter le cours.");
         END IF;
   
         Lecture.AttendreTouche;
      END IF;
   end EffectuerTransactionCreerNouveauCours;
   
   ---------------------------------------------------------------------------
   -- Procedure qui effectue la transaction d'annuler un cours
   -- Gestion cours
   -- NIVEAU: 5
   -- PARAMETRE: ListeEtudiant: (IN OUT) Liste des etudiants.
   --            ListeCours:    (IN OUT) Liste des cours.
   ---------------------------------------------------------------------------   
   procedure EffectuerTransactionAnnulerCours(ListeCours:    in out Liste_cours.liste;
                                              ListeEtudiant: in out Liste_etudiant.liste) is
      -- Declaration des variables.
      Cours: EnregistrementCours; -- Contient l'enregistrement du cours.
      Etudiant: EnregistrementEtudiant; -- Contient l'etudiant.
      Inscription: EnregistrementInscription; -- Contient l'inscription.
      Quitter: Boolean; -- Determine si l'utilisateur veux terminer la transaction.                                              
      car: character; -- Contient la reponse de l'utilisateur.
      Succes: Boolean := true; --Determine si la derniere fonction a reussis.
   begin
      put_line("Annuler cours.");
      put_line("--------------");
      LireCoursExistant(ListeCours,Cours,Quitter);
      IF NOT quitter THEN
         Car := ada.characters.handling.To_Upper(Lecture.LireCaractere("OoNn","Annulation du cours (O/N):"));
         IF (Car = 'O') THEN
            Cours.Etat:=annule;
            
            IF Cours.NumInscrits>0 THEN
               -- Mets le nombre d'inscription a 0.
               Cours.NumInscrits := 0;
               
               --Mets a jour le cours.
               Liste_cours.Modifier (ListeCours,Cours,Succes);
               IF not succes THEN
                  put_line("ERREUR: Impossible de mettre a jour le cours.");
               END IF;
               
               --enleve les etudiants inscrits.
               Etudiant.Matricule:=Liste_etudiant.Premier(ListeEtudiant);
               loop
                  Liste_Etudiant.Obtenir(ListeEtudiant,Etudiant.Matricule,Etudiant,succes);
                  
                  IF succes THEN
                     -- Verifie si il est inscrit au cours.
                     Liste_Inscription.Obtenir(Etudiant.Inscription,RetourneCleCours(Cours),Inscription,succes);
                     
                     IF succes THEN
                        -- Modifie l'inscription
                        Inscription.Statut:=annule;
                        Liste_Inscription.Modifier(Etudiant.Inscription,Inscription,succes);
                        
                        IF succes THEN

                           -- Modifie l'etudiant.
                           Liste_Etudiant.Modifier(ListeEtudiant,Etudiant,succes);
                           
                           IF NOT succes THEN
                              put_line("ERREUR: Impossible de modifier l'etudiant.");
                           END IF;
                        ELSE                           
                           put_line("ERREUR: Impossible de modifier l'inscription.");
                        END IF;
                        put_line("Le cours a ete annule.");    
                     END IF;
                  END IF;
                  
                  -- Passe a l'etudiant suivant.
                  Liste_Etudiant.Successeur (ListeEtudiant,Etudiant.Matricule,Etudiant.Matricule,Succes);
                  
                  -- Quitte si aucune autre etudiant.
                  EXIT WHEN NOT succes;
               end loop;
            ELSE
               -- personne d'inscrit, enleve le cours.
               Liste_Cours.Retirer(ListeCours,RetourneCleCours(Cours),Succes);
               IF NOT succes THEN
                  put_line("ERREUR: Impossible d'annuler le cours.");
               ELSE
                  put_line("Le cours a ete annule.");
               END IF;
            END IF;
            
         END IF;
      END IF;
      
      IF NOT quitter THEN
         Lecture.AttendreTouche;
      END IF;
      
   end EffectuerTransactionAnnulerCours;
   
   ---------------------------------------------------------------------------
   -- Procedure qui effectue la transaction de lister les cours
   -- Gestion cours
   -- NIVEAU: 5
   -- PARAMETRE: ListeCour: (IN) Liste des cours.
   ---------------------------------------------------------------------------               
   procedure EffectuerTransactionListerLesCours(ListeCours: in Liste_cours.liste) is
      -- Declaration des variables.
      Cle : Cle_Cours; -- Cle (code_cours) de l'enregistrement courant.
      Cours: EnregistrementCours; -- Enregistrement du cours.
      Succes: Boolean := true; --Determine si la derniere fonction a reussis.
      Espace: String(1..30) :="                              ";
               -- Contient le "padding" entre champs.
   begin
      put_line("Liste des cours");
      put_line("Code    Session   Etat      Lieu       Nombre de place    Inscription");
      put_line("===============================================================================");
      
      if ( not Liste_Cours.Liste_Vide ( ListeCours)) then
         Cle:=Liste_Cours.Premier (ListeCours);
         
         -- Enumere tous les cours.
         loop
            Liste_Cours.Obtenir (ListeCours,Cle,Cours,Succes);
            IF not succes THEN
               put_line("ERREUR: Impossible d'obtenir le cours.");
            END IF;
            
            IF Succes THEN
               -- Affiche le cours
               put(TransformeCodeCoursEnChaine(Cours.CodeCours) & " ");
               ES_Enum_EtatCours.put(Cours.Etat);
               -- Mets le nombre  d'espace blanc necessaire entre
               -- les deux champs
               put(Espace(1..10-Etat_Cours'image(Cours.etat)'last));
               
               ES_Enum_SessionCours.put(Cours.Session);
               put(Espace(1..10-Session_Cours'image(Cours.Session)'last));
               
               ES_Enum_LieuCours.put(Cours.Lieu);
               put(Espace(1..10-Lieu_Cours'image(Cours.Lieu)'last));
               
               put(Integer'Image(Cours.MaxPlace));
               put(Espace(1..19-Integer'image(Cours.MaxPlace)'last));
               
               put_line(Integer'Image(Cours.NumInscrits));
               
               Liste_Cours.Successeur(ListeCours,Cle,Cle,Succes);
               
               IF not succes THEN
                    if not (Liste_Cours.Dernier (ListeCours) = Cle) then
                        put_line("ERREUR: Impossible de trouver l'enregistrement suivant.");
                    end if;
               END IF;
               
            END IF;
            
            EXIT when not succes;
            
         end loop;

      else
         put_line("Aucun cours disponible.");
      end if;
      Lecture.AttendreTouche;
   end EffectuerTransactionListerLesCours;
   
   ---------------------------------------------------------------------------
   -- Procedure qui effectue la transaction de lister les inscriptions
   -- Gestion cours
   -- NIVEAU: 5
   -- PARAMETRE: ListeCours:    (IN ) Liste des cours. 
   --            ListeEtudiant: (IN ) Liste des etudiants.
   ---------------------------------------------------------------------------   
   procedure EffectuerTransactionListerLesInscriptions(ListeCours: in Liste_cours.liste;
                                                       ListeEtudiant: in Liste_etudiant.liste) is
      -- Declaration des variables.
      Cours: EnregistrementCours; -- Contient le cours.
      Etudiant: EnregistrementEtudiant; -- Contient l'etudiant.
      Inscription: EnregistrementInscription; -- Contient l'inscription.
      Quitter: boolean; -- Determine si l'utilisateur veut annuler la transaction.                                                       
      InscriptionTrouver: boolean:=false; -- Indique si au moins une inscription a ete trouver.
      succes: boolean; --Indique si la function a reussis.
   begin
      LireCoursExistant(ListeCours,Cours,Quitter);
      IF NOT quitter THEN
         put_line("Liste des inscriptions.");
         put_line("Matricule Prenom                             Nom                               ");
         put_line("===============================================================================");
         
         -- Determine si la liste des etudiant est vide
         if not Liste_Etudiant.Liste_Vide(ListeEtudiant) then

            -- Trouve le premier etudiant.
            Etudiant.Matricule:= Liste_Etudiant.Premier(ListeEtudiant);
            loop
               -- Obtient l'etudiant
               Liste_Etudiant.Obtenir(ListeEtudiant,Etudiant.Matricule,Etudiant,succes);
               
               IF succes THEN
                  -- Trouve l'inscription au cours.
                  Liste_Inscription.Obtenir(Etudiant.Inscription,RetourneCleCours(Cours),Inscription,succes);
                  
                  IF succes and Inscription.statut = actif THEN
                     -- l'inscription existe.
                     InscriptionTrouver:=true;
                     -- Affiche l'inscription
                     put(TransformeMatriculeEnChaine(Etudiant.Matricule) );
                     put("      ");
                     put(Etudiant.prenom);
                     put("     ");
                     put_line(Etudiant.nom);                     
                  END IF;
                  
                  -- Passe au prochain etudiant.
                  Liste_Etudiant.Successeur (ListeEtudiant,Etudiant.Matricule,Etudiant.Matricule,Succes);
                  
               ELSE
                  put_line("ERREUR: Impossible d'obtenir l'etudiant.");
               END IF;
               EXIT when not succes;
               
            end loop;
            IF NOT InscriptionTrouver THEN
               put_line("Aucune inscription.");
            END IF;
         else
            put_line("Aucune inscription.");
         end if;
      END IF;
      
      IF NOT quitter THEN
         Lecture.AttendreTouche;
      END IF;
      
   end EffectuerTransactionListerLesInscriptions;
   
   ---------------------------------------------------------------------------
   -- Procedure qui effectue la transaction de creer un nouveau dossier
   -- Gestion etudiants
   -- NIVEAU: 5
   -- PARAMETRE: ListeEtudiant: (IN OUT) Liste des etudiants.
   ---------------------------------------------------------------------------   
   procedure EffectuerTransactionCreerNouveauDossier(ListeEtudiant: in out Liste_etudiant.liste) is
      -- Declacration des variables.
      Etudiant: EnregistrementEtudiant; -- L'etudiant creer.
      FiltreNom: String(1..Etudiant.Nom'Last); -- Filtre du nom pour la lecture
                                               -- de la chaine
      FiltrePrenom: String(1..Etudiant.Prenom'Last); -- Filtre du prenom pour
                                                     -- la lecture de la chaine.
      MatriculeCreer: boolean:= false; -- Determine si le matricule a ete creer.                                                     
      succes: boolean; -- Determine si la fonction a reussis.
      ChaineId: String(1..10) :="0123456789"; -- Constante qui contient les nombres
                                              -- a ajouter au matricule.
     
   begin
      -- Initialise les filtres a des espaces blanc (pour accepter n'importe quelle caracteres).
      FOR i in FiltreNom'Range loop
         FiltreNom(i):=' ';
      end loop;
      
      FOR i in FiltrePrenom'Range loop
         FiltrePrenom(i):=' ';
      end loop;

      put_line("Creer un nouveau dossier.");
      put_line("-------------------------");
      
      -- Creer la liste des inscriptions.
      Liste_Inscription.Creer_Liste(Etudiant.Inscription);
      
      -- Lis les deux chaines.                                              
      Etudiant.Nom:=Lecture.LireChaine(FiltreNom,"Entrez nom:");
      
      Etudiant.Prenom:=Lecture.LireChaine(FiltrePrenom,"Entrez prenom:");
      
      -- Genere le matricule.
      
      -- Copie les 3 premieres lettres du nom
      FOR i in 1..3 loop
         Etudiant.Matricule(i):=ada.characters.handling.To_Upper(Etudiant.nom(i));
      end loop;
      
      -- Mets le caracter unique a la fin du nom.
      FOR i in 1..10 loop
         IF not MatriculeCreer THEN
            Etudiant.Matricule(4):= ChaineId(i) ;
            
            -- Essaye d'ajouter l'etudiant.
            Liste_etudiant.Inserer_en_Ordre  (ListeEtudiant,Etudiant,Succes); 
            IF succes THEN
               MatriculeCreer := true;
            END IF;
            
         END IF;
      end loop;
      
      IF MatriculeCreer THEN
         put("L'etudiant ");
         put(TransformeMatriculeEnChaine(Etudiant.Matricule));
         put_line(" a ete ajoute.");
      ELSE
         -- Detruire la liste d'inscription
         Liste_Inscription.Detruire_liste(Etudiant.Inscription);
         put_line("ERREUR: Impossible d'ajouter l'etudiant.");
      END IF;
      Lecture.AttendreTouche;   
   end EffectuerTransactionCreerNouveauDossier;
   
   ---------------------------------------------------------------------------
   -- Procedure qui effectue la transaction de consulter un dossier
   -- Gestion etudiants
   -- NIVEAU: 5
   -- PARAMETRE: ListeEtudiant: (IN) Liste des etudiants.
   ---------------------------------------------------------------------------   
   procedure EffectuerTransactionConsulterUnDossier(ListeEtudiant: in Liste_etudiant.liste) is
      -- Declarations des variables.
      Etudiant: EnregistrementEtudiant; -- Contient l'etudiant a consulter.
      succes: boolean; -- Determine si la procedure a reussis.
      Cle: Cle_Cours; -- Contient la cle du cours.
      Inscription: EnregistrementInscription;-- Contient l'inscription a afficher.
      Quitter: Boolean :=false; -- Determine si l'utilisateur veut annuler la transaction.
      Espace: String(1..30) :="                              ";
               -- Contient le "padding" entre champs.      
   begin
      put_line("Consulter un dossier.");
      put_line("---------------------");

      
      -- Lis le matricule.
      LireEtudiantExistant(ListeEtudiant,Etudiant,Quitter);
      
      IF not quitter THEN
         -- Trouve l'enregistrement.                                                                      
         Liste_etudiant.Obtenir (ListeEtudiant,Etudiant.Matricule,Etudiant,Succes);
         
         -- Affiche l'information
         IF succes THEN
            new_line(2);
            put("Matricule: ");
            put_line(TransformeMatriculeEnChaine(Etudiant.Matricule) );
            put("Nom: ");
            put_line(Etudiant.Nom);
            put("Prenom: ");
            put_line(Etudiant.Prenom);
            put_line("Inscription");
            put_line("Cours   session     Statut         Note");
            put_line("===============================================================================");
            IF not   Liste_Inscription.Liste_Vide (Etudiant.Inscription) THEN
               -- Trouve le premier enregistrement.
               Cle:=Liste_Inscription.Premier(Etudiant.Inscription);
               loop
                  -- Charge l'enregistrement.
                  Liste_Inscription.Obtenir (Etudiant.Inscription,Cle,Inscription,succes);
                  
                  IF succes THEN
                     -- affiche l'enregistrement
                     put(TransformeCodeCoursEnChaine(Inscription.CodeCours) & " ");
                     ES_Enum_SessionCours.put(Inscription.Session);
                     
                     -- Mets le nombres d'espace blanc necessaire entre
                     -- les deux champs
                     put(Espace(1..12-Session_Cours'image(Inscription.Session)'last));
                     
                     ES_Enum_EtatCours.put(Inscription.Statut);
                     put(Espace(1..15-Etat_Cours'image(Inscription.Statut)'last));
                     
                     ES_Enum_NoteCours.put(Inscription.Note);
                     new_line;
                     
                     -- Passe au prochaine enregistrement.
                     Liste_Inscription.Successeur (Etudiant.Inscription,Cle,Cle,Succes);
                  ELSE
                     put_line("ERREUR: Impossible d'obtenir l'inscription.");
                  END IF;
                  
                  EXIT when not succes;
                  
               end loop;
            ELSE            
               put_line("Aucune inscription.");
            END IF;
            new_line;
            put_line("La note Z indique un resultat non disponible");
         ELSE
            put_line("Impossible d'obtenir le dossier.");
         END IF;
      END IF;
      
      IF NOT quitter THEN
         Lecture.AttendreTouche;            
      END IF;
      
   end EffectuerTransactionConsulterUnDossier;
   
   ---------------------------------------------------------------------------
   -- Procedure qui effectue la transaction d'ajouter une inscription
   -- Gestion etudiants
   -- NIVEAU: 5
   -- PARAMETRE: ListeEtudiant: (IN OUT) Liste des etudiants.
   --            ListeCours:    (IN OUT) Liste des cours.
   ---------------------------------------------------------------------------   
   procedure EffectuerTransactionAjouterInscription(ListeEtudiant: in out Liste_etudiant.liste;
                                                    ListeCours:    in out Liste_cours.liste)  is
      -- Declarations des variables.
      Etudiant: EnregistrementEtudiant; -- Contient l'etudiant.
      Cours: EnregistrementCours; -- Contient le cours.
      Inscription: EnregistrementInscription; -- Contient l'inscription.
      Quitter: Boolean := false; -- Determine si l'utilisateur annule la transaction.
      succes: boolean; -- Determine si une fonction a reussis.
      car: character; -- Contient la reponse de l'utilisateur.
   begin

      put_line("Ajouter une inscription.");
      put_line("------------------------");
      
      
      -- Lis le matricule.
      LireEtudiantExistant(ListeEtudiant,Etudiant,Quitter);
      
      IF not quitter THEN
         LireCoursExistant(ListeCours,Cours,Quitter);
      END IF;
      
      IF not quitter THEN
         Car := ada.characters.handling.To_Upper(Lecture.LireCaractere("OoNn","Inscription au cours (O/N):"));   
      END IF;
      
      IF not quitter and car ='O' THEN
         -- Verifie si il y a de la place disponible
         IF Cours.NumInscrits + 1 <= Cours.MaxPlace THEN
            --Verifie si le cours est actif.
            IF Cours.Etat = actif THEN
            
               -- Incremente le nombre d'inscrits.
               Cours.NumInscrits := Cours.NumInscrits + 1;
               
               -- Creer l'enregistrement inscription.                                              
               Inscription.CodeCours := Cours.CodeCours;
               Inscription.Session := Cours.Session;
               Inscription.Note := Z;
               Inscription.Statut:= actif;
               
               -- Ajoute l'inscription dans la liste d'inscription de l'etudiant
               Liste_Inscription.Inserer_en_Ordre(Etudiant.Inscription,Inscription,Succes);
               
               -- Verifie si l'inscription existante est pas annule!
               IF NOT succes then
                  -- Lire l'inscription.
                  Liste_Inscription.Obtenir(Etudiant.Inscription,RetourneCleInscription(Inscription),Inscription,Succes);
                  IF succes THEN

                     -- Si l'inscription est annule, remettre actif et la sauvegarder.
                     IF Inscription.statut /= actif THEN
                        Inscription.statut := actif;
                        Liste_Inscription.Modifier (Etudiant.Inscription,Inscription,succes);
                     ELSE                        
                        succes := false;
                     END IF;
                     
                  END IF;
                  
               END IF;
               
               IF succes THEN
                    -- Mets a jour l'etudiant.
                  Liste_Etudiant.Modifier(ListeEtudiant,Etudiant,succes);
                  IF succes THEN
                     -- mets a jours le cours.
                    Liste_cours.Modifier (ListeCours,Cours,succes);  
                    IF succes THEN
                       put_line("Inscription faite.");
                    ELSE
                       put_line("ERREUR: impossible de modifier le cours.");
                    END IF;
                  ELSE
                     put_line("ERREUR: Impossible de modifier l'etudiant.");       
                  END IF;
               ELSE
                  put_line("ERREUR: Impossible d'ajouter l'inscription.");
               END IF;
            ELSE               
               put_line("Cours annule.");
            END IF;
         ELSE
            put_line("Aucune place disponible.");
         END IF;
      ELSE         
         put_line("L'inscription n'as pas ete faite.");
      END IF;
      
      IF Not quitter THEN
         Lecture.AttendreTouche;            
      END IF;
      
   end EffectuerTransactionAjouterInscription;
   
   ---------------------------------------------------------------------------
   -- Procedure qui effectue la transaction d'annuler une inscription
   -- Gestion etudiants
   -- NIVEAU: 5
   -- PARAMETRE: ListeEtudiant: (IN OUT) Liste des etudiants.
   --            ListeCours:    (IN OUT) Liste des cours.
   ---------------------------------------------------------------------------   
   procedure EffectuerTransactionAnnulerInscription(ListeEtudiant: in out Liste_etudiant.liste;
                                                    ListeCours:    in out Liste_cours.liste) is
      -- Declarations des variables
      Etudiant: EnregistrementEtudiant; -- Contient l'etudiant.                                           
      Cours: EnregistrementCours; --Contient le cours.
      Inscription: EnregistrementInscription; -- Contient l'inscription.
      Quitter: Boolean := false; -- Determine si l'utilisateur annule la transaction.
      succes: boolean; -- Determine si une fonction a reussis.
      car: character; -- Contient la reponse de l'utilisateur.
   begin
      put_line("Annuler une inscription.");
      put_line("------------------------");

      -- Lis le matricule.
      LireEtudiantExistant(ListeEtudiant,Etudiant,Quitter);
      IF NOT quitter THEN
         LireCoursExistant(ListeCours,Cours,Quitter);
      END IF;
      
      IF NOT quitter THEN
         -- Verifie que l'etudiant est inscrit au cours.
         Liste_Inscription.Obtenir (Etudiant.Inscription,RetourneCleCours(Cours),Inscription,Succes);
         IF succes THEN

            -- Verifie que le cours est toujours actif.
            IF (Inscription.Statut = actif ) THEN
               Car := ada.characters.handling.To_Upper(Lecture.LireCaractere("OoNn","Annulation du cours (O/N):"));
               IF (Car = 'O') THEN
                     -- Diminue le nombre d'inscription au cours.
                     Inscription.Statut:=annule;
                     Cours.NumInscrits:=Cours.NumInscrits - 1;
                     
                     -- Mets a jour l'inscription
                     Liste_inscription.Modifier (Etudiant.Inscription,Inscription,succes);
                     IF succes THEN
                        -- Mets a jour l'etudiant
                        Liste_Etudiant.Modifier(ListeEtudiant,Etudiant,succes);
                        IF succes THEN
                           -- mets a jour le cours.
                           Liste_cours.Modifier(ListeCours,Cours,succes);
                           IF succes THEN
                              put_line("Cours annuler.");
                           ELSE
                              put_line("ERREUR: Impossible de mettre a jour le cours.");
                           END IF;
                        ELSE
                           put_line("ERREUR: Impossible de mettre a jour l'etudiant.");
                        END IF;
                     ELSE
                        put_line("ERREUR: Impossible de mettre a jour l'inscription.");
                     END IF;
               ELSE
                  put_line("Transaction annule.");
               END IF;
               
            ELSE
               put_line("L'inscription est deja annule.");
            END IF;
            
         ELSE
            put_line("Aucune inscription pour ce cours.");
         END IF;
      END IF;
      
      IF NOT Quitter THEN
         Lecture.AttendreTouche;
      END IF;
      
   end EffectuerTransactionAnnulerInscription;

   ---------------------------------------------------------------------------
   -- Procedure qui effectue la transaction cours choisis par l'utilisateur
   -- NIVEAU: 4
   -- PARAMETRE: Transaction (IN): Le caractere qui contient la transaction
   --            ListeCour: (IN OUT) Liste des cours.
   --            ListeEtudiant: (IN OUT) Liste des etudiants.
   ---------------------------------------------------------------------------   
   PROCEDURE EffectuerTransactionCours(Transaction: in character;
                                          ListeCours: in out Liste_cours.liste;
                                          ListeEtudiant: in out Liste_etudiant.liste)
                                           is
   begin
      CASE Transaction IS
         WHEN 'C' =>
            EffectuerTransactionCreerNouveauCours(ListeCours);
         WHEN 'A' =>
            EffectuerTransactionAnnulerCours(ListeCours,ListeEtudiant);
         WHEN 'L' =>
            EffectuerTransactionListerLesCours(ListeCours);
         WHEN 'I' =>
            EffectuerTransactionListerLesInscriptions(ListeCours,ListeEtudiant);
         WHEN others =>
            null;
      END CASE;
   end EffectuerTransactionCours;
   
   ---------------------------------------------------------------------------
   -- Procedure qui effectue la transaction etudiant choisis par l'utilisateur
   -- NIVEAU: 4
   -- PARAMETRE: Transaction (IN): Le caractere qui contient la transaction
   --            ListeCour: (IN OUT) Liste des cours.
   --            ListeEtudiant: (IN OUT) Liste des etudiants.
   ---------------------------------------------------------------------------   
   procedure EffectuerTransactionEtudiant(Transaction: in character;
                                          ListeCours: in out Liste_cours.liste;
                                          ListeEtudiant: in out Liste_etudiant.liste
                                          ) is
   begin
      CASE Transaction IS
         WHEN 'C' =>
            EffectuerTransactionCreerNouveauDossier(ListeEtudiant);
         WHEN 'O' =>
            EffectuerTransactionConsulterUnDossier(ListeEtudiant);
         WHEN 'A' =>
            EffectuerTransactionAjouterInscription(ListeEtudiant,ListeCours);
         WHEN 'U' =>
            EffectuerTransactionAnnulerInscription(ListeEtudiant,ListeCours);
         WHEN others =>
            null;
      END CASE;
   end EffectuerTransactionEtudiant;
   
   ---------------------------------------------------------------------------
   -- Procedure qui affiche le menu de gestion des cours.
   -- NIVEAU: 4
   -- Aucun parametre
   ---------------------------------------------------------------------------
   procedure AfficherMenuGestionCours is
   begin
      new_line(2);
      put_line("******** MENU DE GESTION DES COURS **********");
      put_line("* C - Creer un nouveau cours.               *");
      put_line("* A - Annuler un cours.                     *");
      put_line("* L - Lister les cours.                     *");
      put_line("* I - Lister les inscription.               *");
      put_line("* Q - Quitter le menu de gestion des cours. *");
      put_line("*********************************************");
   end AfficherMenuGestionCours;
   
   ---------------------------------------------------------------------------
   -- Procedure qui affiche le menu de gestion des etudiants.
   -- NIVEAU: 4
   -- Aucun parametre
   ---------------------------------------------------------------------------
   procedure AfficherMenuGestionEtudiant is
   begin
      new_line(2);
      put_line("********* MENU DE GESTION DES ETUDIANTS *********");
      put_line("* C - Creer un nouveau dossier.                 *");
      put_line("* O - Consulter un dossier.                     *");
      put_line("* A - Ajouter une inscription.                  *");
      put_line("* U - Annuler une inscription.                  *");
      put_line("* Q - Quitter le menu de gestion des etudiants. *");
      put_line("*************************************************");
   end AfficherMenuGestionEtudiant;
   
   ---------------------------------------------------------------------------
   -- Procedure qui gere le menu de cours
   -- NIVEAU: 3
   -- PARAMETRE: ListeCour: (IN OUT) Liste des cours.
   --            ListeEtudiant: (IN OUT) Liste des etudiants.
   ---------------------------------------------------------------------------
   PROCEDURE EffectuerGestionCours(ListeCour: in out Liste_cours.liste;
                                   ListeEtudiant: in out Liste_etudiant.liste) is
      TransactionCours: character; -- Contient la transaction choisi par 
                                   -- l'utilisateur.
   begin
      loop
         AfficherMenuGestionCours;
         
         -- Lire la transaction choisi par l'utilisateur.
         TransactionCours:=ada.characters.handling.To_Upper(lecture.LireCaractere("caliqCALIQ","Choix(C,A,L,I,Q):"));         
         
         -- Sort de la boucle si l'utilisateur choisis de quitter.         
         EXIT when TransactionCours = 'Q';
         
         EffectuerTransactionCours(TransactionCours,ListeCour,ListeEtudiant);
         
      end loop;
   end EffectuerGestionCours;
   
   ---------------------------------------------------------------------------
   -- Procedure qui gere le menu des etudiants
   -- NIVEAU: 3
   -- PARAMETRE: ListeCour: (IN OUT) Liste des cours.
   --            ListeEtudiant: (IN OUT) Liste des etudiants.
   ---------------------------------------------------------------------------                                                                              
   PROCEDURE EffectuerGestionEtudiant(ListeCour: in out Liste_cours.liste;
                                      ListeEtudiant: in out Liste_etudiant.liste) is
      TransactionEtudiant: character; -- Contient la transaction choisi par
                                      -- l'utilisateur.
   begin
      loop
         AfficherMenuGestionEtudiant;
         
         -- Lire la transaction choisi par l'utilisateur.
         TransactionEtudiant:=ada.characters.handling.To_Upper(lecture.LireCaractere("COAUQcoauq","Choix(C,O,A,U,Q):"));         
         
         -- Sort de la boucle si l'utilisateur choisis de quitter.
         EXIT when TransactionEtudiant = 'Q';
         
         EffectuerTransactionEtudiant(TransactionEtudiant,ListeCour,ListeEtudiant);
         
      end loop;
   end EffectuerGestionEtudiant;
   
   ---------------------------------------------------------------------------
   -- Procedure qui effectue la transaction principal choisie par
   -- l'utilisateur.
   -- NIVEAU: 2
   -- Parametre: Transaction (IN): La transaction entrer par l'utilisateur.
   --            ListeCour: (IN OUT) Liste des cours.
   --            ListeEtudiant: (IN OUT) Liste des etudiants.
   ---------------------------------------------------------------------------
   PROCEDURE EffectuerTransactionPrincipal(Transaction: in character;
                                           ListeCour: in out Liste_cours.liste;
                                           ListeEtudiant: in out Liste_etudiant.liste) is
   begin
      CASE Transaction IS
         WHEN 'C' =>
            EffectuerGestionCours(listeCour,ListeEtudiant);
         WHEN 'E' =>
            EffectuerGestionEtudiant(ListeCour,ListeEtudiant);
         WHEN others =>
            null;
      END CASE;
   end EffectuerTransactionPrincipal;
                                                          
   ---------------------------------------------------------------------------
   -- Procedure que affiche le menu principal
   -- NIVEAU: 2
   -- Aucun parametre.
   ---------------------------------------------------------------------------
   PROCEDURE AfficherMenuPrincipal is
   begin 
      new_line(2);
      put_line("******* MENU PRINCIPAL *******");
      put_line("* C - Gestion des cours.     *");
      put_line("* E - Gestion des etudiants. *");
      put_line("* Q - Quitter programme.     *");
      put_line("******************************");
   end AfficherMenuPrincipal;
   
   ---------------------------------------------------------------------------
   -- Procedure que fait l'initialisation du programme
   --  1- Affiche en-tete.
   --  2- Creer les listes.
   --  3- Lis les fichiers des listes.
   -- NIVEAU: 2
   -- PARAMETRE: ListeCour: (IN OUT) Liste des cours.
   --            ListeEtudiant: (IN OUT) Liste des etudiants.
   ---------------------------------------------------------------------------
   PROCEDURE InitialisationProgramme(ListeCour: in out Liste_cours.liste;
                                     ListeEtudiant: in out Liste_etudiant.liste) is
   -- Declaration des variables.
   Succes: boolean; -- Determine si la fonction appeler a reussis.                                     
   begin   
      -- Affiche l'en-tete du programme.
      put_line("Gestion de cours et d'etudiant");
      put_line("Auteur: Yann Bourdeau");

      -- Creer les deux listes.
      Liste_cours.Creer_Liste(ListeCour);
      Liste_etudiant.Creer_Liste(ListeEtudiant);
   
      
      -- Charge les listes.
      liste_cours.Recuperer(ListeCour,"cours.bin",Succes);
      if ( not Succes) then
         put_line("Impossible de lire cours.bin.");
      end if;         
      
      liste_etudiant.recuperer(listeEtudiant,"etudiant.bin",succes);
      if(not succes) then
         put_line("Impossible de lire etudiant.bin.");
      end if;
      
   end InitialisationProgramme;
   
   ---------------------------------------------------------------------------
   -- Procedure que fait la termination du programme
   --  1 - Sauvegarde les fichiers des listes.
   --  2 - Detruire les listes.
   -- NIVEAU: 2
   -- PARAMETRE: ListeCour: (IN OUT) Liste des cours.
   --            ListeEtudiant: (IN OUT) Liste des etudiants.
   ---------------------------------------------------------------------------
   PROCEDURE TerminationProgramme(ListeCour: in out  Liste_cours.liste;
                                  ListeEtudiant: in out Liste_etudiant.liste) is
   -- Declaration des variables.
   Succes: boolean; -- Determine si la fonction appeler a reussis.                                     
   Etudiant: EnregistrementEtudiant; -- Contient l'etudiant obtenus.
   SuccesEtudiant: boolean; --Determine si les procedurs de liste etudiantes
                            -- ont reussis.
                               
   begin
      liste_cours.Sauvegarder(ListeCour,"cours.bin",succes);
      IF (not succes) THEN
         put_line("Impossible de sauvegarder cours.bin.");
      END IF;
      
      liste_etudiant.sauvegarder(ListeEtudiant,"etudiant.bin",succes);
      IF (not succes) THEN
         put_line("Impossible de sauvegarder etudiant.bin");
      END IF;
      
      -- Parcoure la liste des etudiants pour liberes les listes 
      -- d'inscription.
      IF not liste_etudiant.Liste_Vide(ListeEtudiant) THEN
         -- La liste des etudiants n'est pas vide.
         
         -- Trouve le premier
         Etudiant.Matricule:=liste_etudiant.Premier (ListeEtudiant);
         loop
            -- retrouve l'enregistrement
            liste_etudiant.Obtenir (ListeEtudiant,Etudiant.Matricule,Etudiant,SuccesEtudiant);
            
            if SuccesEtudiant then
               -- Detruire la liste
               Liste_Inscription.Detruire_Liste(Etudiant.Inscription);
               
               -- Passe au prochaine enregistrement
               Liste_Etudiant.Successeur (ListeEtudiant,Etudiant.matricule,Etudiant.Matricule,SuccesEtudiant);
            end if;               
            
            EXIT when not SuccesEtudiant;
            
         end loop;
      END IF;
      
      -- Libere les deux listes.
      Liste_cours.Detruire_liste(ListeCour);
      Liste_etudiant.Detruire_liste(ListeEtudiant);
   
      put_line ("Au revoir!");
   end TerminationProgramme;
   
   ---------------------------------------------------------------------------
   -- Definition des variables.
   ---------------------------------------------------------------------------
   TransactionPrincipal: Character; --Transaction principal entrer par l'utilisateur
   ListeCour: Liste_cours.liste; -- Contient la liste des cours
   ListeEtudiant: Liste_etudiant.liste; -- Contient la liste des etudiants.
	
begin
   InitialisationProgramme(ListeCour,ListeEtudiant);
         
   loop
      AfficherMenuPrincipal;
    
     -- lis la transaction choisi par l'utilisateur
      TransactionPrincipal:=ada.characters.handling.To_Upper(lecture.LireCaractere("CEQceq","Choix(C,E,Q):"));
      
      -- Sort de la boucle si l'utilisateur choisis de quitter.
      EXIT when TransactionPrincipal = 'Q';
      
      EffectuerTransactionPrincipal(TransactionPrincipal,ListeCour,ListeEtudiant);
      
   end loop;
   
   TerminationProgramme(ListeCour,ListeEtudiant);
   
exception
   when others => put_Line("Exception inconnus. Fin du programme.");

end GestionUQAM;   
