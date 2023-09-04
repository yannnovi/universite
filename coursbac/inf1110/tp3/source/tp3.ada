--$Id: tp3.ada,v 1.1 2003/07/15 15:05:27 yann Exp $
--
-- Auteur: Yann Bourdeau
-- Club Video UQAM: Programme qui permet de gerer un club video.
--
--$Log: tp3.ada,v $
--Revision 1.1  2003/07/15 15:05:27  yann
--Sauvegarde du backup
--
--Revision 1.11  2003/04/16 03:08:40  yannb
--> Ajout de plusieurs commentaires.
-- Modified Files:
-- 	tp3.ada
--
--Revision 1.10  2003/04/14 02:01:41  yannb
-->Correction des sorties des listes de film en retard, transaction du client, location du client.
-- Modified Files:
--      tp3.ada
--
--Revision 1.9  2003/04/13 22:30:51  yannb
-->Gere les exceptions comme il faut.
-- Modified Files:
--      tp3.ada
--
--Revision 1.8  2003/04/13 22:29:52  yannb
--> Correction du probleme de skip_line dans la fonction lirechaine.
--> Enlever plusieurs skip_line inutile.
--> Corriger le probleme d'utilisation de l'index a -1 dans fonction TransactionLocation et TransactionRetour.
-- Modified Files:
--    tp3.ada
--
--Revision 1.7  2003/04/12 18:48:25  yannb
-->Mets en majuscule le code client et le code film lus dans locations.txt lors du traitement en lot.
--Modified Files:
--      tp3.ada
--
--Revision 1.6  2003/04/12 18:19:50  yannb
-->Calcule le montant du retard avec la date de retour et non la date de location.
--Modified Files:
--    tp3.ada
--
--Revision 1.5  2003/04/11 19:33:20  yannb
-->Ajout du traitement en lot de resultats.txt
-- Modified Files:
--    tp3.ada
--
--Revision 1.4  2003/04/11 18:46:16  yannb
-->Implementer toute les transactions.
-- Modified Files:
--      tp3.ada
--
--Revision 1.3  2003/04/11 05:28:54  yannb
-->Ajout de la transaction qui verifie la disponibilite d'un film.
--Modified Files:
--    tp3.ada
--
--Revision 1.2  2003/04/11 02:26:09  yannb
--> Implementer la lection de clients.bin et films.bin.
--> Implementer la transaction d'ajout de client.
--> Implementer la transaction de lister tous les client.
--> Implementer la transaction de lister tous les films.
--> Implementer le trie des listes de client et de films.
-- Modified Files:
--    source/tp3.ada
--
--Revision 1.1  2003/04/10 21:48:35  yannb
-->Premiere revision de TP3.ada
-- Added Files:
--      tp3.ada
--

-- Package qui sont utiliser par le programme.
with Ada.Text_IO;           
use Ada.Text_IO;
with Ada.Sequential_IO;
with ada.characters.Handling;
with Ada.Strings.Fixed;
with ada.Strings.Maps.Constants;

-- Procedure principal du programme.
procedure ClubUQAM is

  -- Declaration des constantes.
  MAX_FILMS   : constant := 300;  -- nombre maximal de films différents du club.
  MAX_CLIENTS : constant := 300;  -- nombre maximal de clients.
  MAX_COPIES  : constant := 30;  -- nombre maximal de copies par film.
  MAX_LOCATION: constant := 100; -- Nombre maximal de location d'un client.
  MAX_LONG_MSGERREUR :constant := 54; -- Nombre maximal de caractere pour un message d'erreur dans locations.txt

  MAX_LONG_NOM_PRENOM     : constant := 15; -- nombre max de carac. pour un nom ou prenom
  MAX_LONG_CODE           : constant := 8; -- nombre max de carac. pour un code 
  MAX_LONG_TITRE          : constant := 20; -- nombre max de carac. pour un titre
  MAX_LONG_ADRESSE        : constant := 25; -- nombre max de carac. pour une adresse
  
   
 -- Definition des types.
  type Categorie_Film is (ACTION,DRAME,COMEDIE,HORREUR); -- Categorie des films.
  
  type Categorie_Public is (HUIT_ET_PLUS, TREIZE_ET_PLUS, SEIZE_ET_PLUS, DIX_HUIT_ET_PLUS, GENERAL);
  
  type Film_Etat is (NON_DEFECTUEUX, DEFECTUEUX);
  
  type Date is 
  record
     Jour   : Integer range 1 .. 31;
     Mois   : Integer range 1..12;
     Annee  : Integer range 2001 .. 2003;
  end record;
   
  type Film_Copie is 
  record
      Etat               : Film_Etat ;
      DateLocation       : Date ;
      DateRetoursPrevus  : Date ;
      CodeClient         : String ( 1 .. MAX_LONG_CODE);
      disponible         : Boolean ;
     end record ;
     
   
   subtype Interval_Copie is Integer range 1.. MAX_COPIES;
   type Tableau_Copie is array ( Interval_Copie ) of Film_Copie;
 
   type Liste_Copie is record
      NombreCopiesUtilise      : Interval_Copie;     
      LesCopies                : Tableau_Copie;                          
   end record; -- T_liste_Copies
   
 type Film is 
     record
      CodeFilm               : String ( 1 .. MAX_LONG_CODE);
      TitreFilm              : String ( 1 .. MAX_LONG_TITRE );
      NomActeur              : String ( 1 .. MAX_LONG_NOM_PRENOM );
      NomRealisateur         : String ( 1 .. MAX_LONG_NOM_PRENOM );
      TypeFilm               : Categorie_Film ;    
      NombreCopies           : natural; 
      ListeCopie             : Liste_Copie;
      CoutLocation           : Float;
      PublicCible            : Categorie_Public ;  
   end record; 


  type Tableau_Film is array ( 1 .. MAX_FILMS ) of Film;

  type Liste_Film is record
    NombreFilms      : natural range 0 .. MAX_FILMS := 0;  
    LesFilms         : Tableau_Film;          
  end record; 

 type Location is 
   record
         CodeFilm     : String ( 1 .. max_long_code);
         DateLocation : Date;
         Retourne     : Boolean; 
         DateRetour   : Date; 
   end record; 

 subtype Interval_Location is Integer range 0 .. MAX_LOCATION;

 type Tableau_Location is array ( 1..MAX_LOCATION ) of Location;
 
 type Liste_Locations is 
   record
      NombreLocations  : Interval_Location := 0; 
      LesLocations     : Tableau_Location; 
   end record; 

 type Client is 
    record
      Nom             : String ( 1 .. max_long_nom_prenom );
      Prenom          : String ( 1 .. max_long_nom_prenom );
      CodeClient      : String ( 1 .. max_long_code);
      Adresse         : String ( 1 .. max_long_adresse );
      Locations       : Liste_Locations; 
   end record; -- T_client

  subtype Interval_Client is Integer range 0 .. MAX_CLIENTS;

  type Tableau_Clients is array (1.. MAX_CLIENTS ) of client;

  type Liste_Client is 
    record
      NombreClient : Interval_Client := 0;
      LesClients   : Tableau_Clients; 
   end record; 
                              
                              
   -- Instanciation de paquetages generiques
   PACKAGE ES_Film_Bin_Seq is new ada.sequential_IO(Film);
   PACKAGE ES_Client_Bin_Seq is new ada.sequential_IO(Client);
   package ES_D_Float is new Float_IO(float);
   package ES_D_Natural is new Integer_IO(Natural);
   package ES_D_Entier is new Integer_IO (Integer);

  --- Entrees/Sorties des valeurs de types énumératifs ------
  package ES_Enum_Type is new Enumeration_IO(Categorie_Film);
  package ES_Enum_Public is new Enumeration_IO(Categorie_Public);
                
                
   PROCEDURE AttendreTouche is
   -- Cette procedure attends apres une touche
   begin
      put_line("Appuyez sur 'ENTER' pour continuer!");
      skip_line;
   end AttendreTouche;
   
   PROCEDURE LireFichierFilm(ListeFilm: out Liste_Film) is
   -- Cette procedure lis en memoire le fichier client.bin.
   -- ListFilm (OUT): Vas contenir la liste des films.
   FichierFilm: ES_Film_Bin_Seq.File_Type;  -- Structure du fichier films.bin
   begin

      ES_film_bin_Seq.Open (FichierFilm, ES_Film_Bin_Seq.In_File,"films.bin");
      
      put("Chargement de films.bin");
      ListeFilm.NombreFilms:=0;
      
      while not ES_film_bin_Seq.End_Of_File(FichierFilm) loop
         ListeFilm.NombreFilms:= ListeFilm.NombreFilms + 1;
         ES_Film_Bin_Seq.Read(FichierFilm,ListeFilm.LesFilms(ListeFilm.NombreFilms));
         put(".");
      end loop;
      
      new_line;
      
      ES_film_bin_Seq.Close(FichierFilm);
      
      Exception
      When Name_Error => Put_Line("Fichier 'films.bin' introuvable."); 
                         New_Line(2);
                         AttendreTouche;
      
   end LireFichierFilm;
   
   PROCEDURE LireFichierClient(ListeClient: out Liste_Client) is
   -- Cette procedure lis en memoire le fichier client.bin.
   -- ListFilm (OUT): Vas contenir la liste des films.
   --Declaration des variables.
   FichierClient: ES_Client_Bin_Seq.File_Type;  
   begin
      ES_Client_bin_Seq.Open (FichierClient, ES_Client_Bin_Seq.In_File,"clients.bin");
      
      put("Chargement de clients.bin");
      while not ES_Client_bin_Seq.End_Of_File(FichierClient) loop
         ListeClient.NombreClient:=ListeClient.NombreClient + 1;
         ES_Client_Bin_Seq.Read(FichierClient,ListeClient.LesClients(ListeClient.NombreClient));
         put(".");
      end loop;
      
      new_line;
      
      ES_Client_bin_Seq.Close(FichierClient);
      
      Exception
      When Name_Error => Put_Line("Fichier 'clients.bin' introuvable."); 
                         New_Line(2);
                         AttendreTouche;
      
   end LireFichierClient;
   
   PROCEDURE TrierLocation(ListeLocations: in out liste_locations) is
   -- Cette procedure trie un table de location de client en ordre de code film
   -- ListeLocations (IN OUT): Listes des locations d'un client.
   TempLocation: Location; -- Variable temporaire qui sert a contenir une location.
   begin
      FOR i in 1 ..(ListeLocations.NombreLocations - 1) loop
         FOR j in 1..(ListeLocations.NombreLocations -1) loop
            if((ListeLocations.LesLocations(j).CodeFilm>ListeLocations.LesLocations(j+1).CodeFilm)) then
               TempLocation:=ListeLocations.LesLocations(j+1);
               ListeLocations.LesLocations(j+1):=ListeLocations.LesLocations(j);
               ListeLocations.LesLocations(j):=TempLocation;
            end if;
         end loop;
  end loop;
   end TrierLocation;
   
   PROCEDURE TrierFilm(ListeFilm: in out Liste_Film) is
   -- Cette procedure trie le tableau des films en ordre de code film.
   -- ListFilm (IN OUT): Contient la liste des films qui vont etre trier.                                                   
   TempFilm: Film;  -- Variable temporaire qui sert a contenir un film.
   begin
      FOR i in 1..(ListeFilm.NombreFilms -1 ) loop
         FOR Index1 in 1..(ListeFilm.NombreFilms -1) loop
            if(ListeFilm.LesFilms(Index1).CodeFilm > ListeFilm.LesFilms(Index1+1).CodeFilm) then
               TempFilm := ListeFilm.LesFilms(Index1+1);
               ListeFilm.LesFilms(Index1+1) := ListeFilm.LesFilms(Index1);
               ListeFilm.LesFilms(Index1) := TempFilm;
            end if;
         end loop;
         
      end loop;
   end TrierFilm;

   PROCEDURE TrierClient(ListeClient: in out Liste_Client) is
   -- Cette procedure trie le tableau des films en ordre de code film.
   -- ListFilm (IN OUT): Contient la liste des films qui vont etre trier.                                                   
   TempClient: Client; -- Variable temporaire qui sert a contenir un client.
   begin
      
      FOR i in 1..(ListeClient.NombreClient-1) loop
         FOR Index1 in 1..(ListeClient.NombreClient-1) loop
            if(ListeClient.LesClients(Index1).CodeClient > ListeClient.LesClients(Index1+1).CodeClient) then
               TempClient := ListeClient.LesClients(Index1+1);
               ListeClient.LesClients(Index1+1) := ListeClient.LesClients(Index1);
               ListeClient.LesClients(Index1) := TempClient;
            end if;
         end loop;
         
      end loop;
      
      FOR i in 1..(ListeClient.NombreClient) loop
         TrierLocation(ListeClient.LesClients(i).Locations);
      end loop;
   end TrierClient;
   
   procedure LireFichierFilmClient(ListeFilm: out Liste_Film; ListeClient: out Liste_Client) is
   -- Cette procedure lis en memoire les fichier client.bin et film.bin
   -- ListFilm (OUT): Vas contenir la liste des films.
   -- ListClient (OUT): Vas contenir la liste des clients
   begin
      LireFichierFilm(ListeFilm);
      LireFichierClient(ListeClient);
      TrierFilm(ListeFilm);
      TrierClient(ListeClient);
   end LireFichierFilmClient;
   
   PROCEDURE SauverFichierFilm(ListeFilm: in Liste_Film) is
   -- Cette procedure sauve le fichier qui contient la liste des films.
   -- ListeFilm (IN): Liste des films dans l'inventaire a sauvegarder.
   FichierFilm: ES_Film_Bin_Seq.File_Type;   -- Variable qui vas contenir la definition du fichier films.bin
   begin
       put("Sauvegarde de films.bin");
       ES_Film_bin_seq.Create(FichierFilm,ES_film_bin_seq.Out_File,"films.bin");
       For i in 1..(ListeFilm.NombreFilms) loop
            ES_Film_Bin_seq.Write(FichierFilm, ListeFilm.LesFilms(i));
            put(".");
       End loop;
       ES_Film_Bin_seq.Close(FichierFilm);
       new_line;
   end SauverFichierFilm;
   
   PROCEDURE SauverFichierClient(ListeClient: in Liste_Client) is
   -- Cette procedure sauve le fichier qui contient la liste des clients.
   -- ListeClient (IN): Liste des client du club a sauvegarder.
   FichierClient: ES_Client_Bin_Seq.File_type; -- Variable qui vas contenir la definition du fichier client.bin
   begin
       put("Sauvegarde de clients.bin");
       ES_Client_Bin_Seq.Create(FichierClient,ES_Client_Bin_Seq.out_file,"clients.bin");
       For i in 1..(ListeClient.NombreClient) loop
           ES_Client_Bin_seq.Write(FichierClient, ListeClient.LesClients(i));
           put(".");
       End loop;
       ES_Client_Bin_Seq.Close(FichierClient);
       new_line;
   end SauverFichierClient;
   
   PROCEDURE SauverFichiersFilmClient(ListeFilm: in Liste_Film; ListeClient: in Liste_Client) is
   -- Cette procedure sauve dans les fichiers la liste des clients et films.
   -- ListeFilm (IN): Liste des films dans l'inventaire a sauvegarder.
   -- ListeClient (IN): Liste des client du club a sauvegarder.
   begin
      SauverFichierFilm(ListeFilm);
      SauverFichierClient(ListeClient);
   end SauverFichiersFilmClient;
   
   PROCEDURE AfficherMenu is
   -- Cette procedure affiche le menu principal
   begin
      new_line(2);
      put_line("A - Abonnement");
      put_line("N - Ajout de film");
      put_line("L - Location");
      put_line("R - Retour de location");
      put_line("V - Disponibilite d'un film");
      put_line("C - Liste des transactions d'un client");
      put_line("O - Liste des films loues par un client");
      put_line("S - Liste des films non disponible");
      put_line("T - Liste des films selon un type");
      put_line("E - Liste des films en retard");
      put_line("5 - Liste des clients loues au moins 5 films");
      put_line("F - Liste des tous les films");
      put_line("I - Liste de tous les clients");
      put_line("Q - Quitter");
      new_line;
   end AfficherMenu;
   
   function LireCaractere(ListeCaracteres: in String; Question: in string) return character is
   -- Lis un caractere et fait la validation du caractere a partir d'une chaine de caractere.
   -- Parametre: in: ListeCaractere: Liste des caractere valide.
   -- Parametre: in: Question: Question qui est pose a l'usager.
   -- retourne: character: Le caractere lus.
   -- declaration des variables
    Caractere: Character; -- Caractere lus a partir du clavier.
    begin
      principal: loop 
         begin
            put(Question);
            Get(Caractere);
            skip_line;
            new_line;
            
            for i in ListeCaracteres'range loop
               if(ListeCaracteres(i) = Caractere) then
                  exit Principal;
               end if;
            end loop;
            
            put_line("Caractere invalide");
            
            new_line;
         
         exception       
            when Data_Error =>
               Put_line("erreur de saisie de donnees.");
            new_line;
            skip_line;
         end;
         
      end loop principal;
      
      return caractere;
      
   end LireCaractere;
   
   function LireChaine(Question: in string; LongueurMaximumChaine: in Natural) return string is
   -- Lis une chaine de caractere.
   -- Question (IN): Le "prompt" a afficher a l'usager.
   -- LongueurMaximumChaine (IN): Longueur maximal de la chaine a retourne.
   Chaine : String( 1.. LongueurMaximumChaine); -- Chaine qui vas contenir la chaine lus au clavier
   LongueurChaine : Natural; -- Longueur de la chaine lus au clavier
   begin

      put(Question);
      Get_Line(Chaine, LongueurChaine);
      
      -- remplis le reste de la chaine avec des espace blanc
      For i in LongueurChaine+1..Chaine'Last loop 
          Chaine(i) := ' ';
      End loop; 
      
      --Si la chaine est >= a la grandeur maximum de la chaine.
      --Il faut faire un skip_line pour enlever les caracteres
      --  du buffer de lecture.
      if(LongueurChaine>=Chaine'Last) then
         skip_line;
      end if;
      
      RETURN Chaine;
   end LireChaine;
   
   function LireNatural(Question: in String) return natural is
   -- Lis un nombre naturel sur la ligne de commande.
   -- Parametre: Question (IN): Question qui est pose a l'usager.
   -- retourne: natural: nombre lus sur la ligne de commande.
   Nombre: Natural := 0; -- Nombre qui est lus sur le clavier.
   begin
      loop
         begin

            put(Question);
            ES_D_Natural.get(Nombre);
            
            skip_line;
            
            exit when (Nombre >= 0); 
            
            Put_Line("Le nombre doit etre positif.");
            new_line;
            
         exception
            when Data_error =>
               Put_line("erreur de saisie de donnees.");
               new_line;
               skip_line;
               
         end;
      end loop;
      return Nombre;
   end LireNatural;
   
   function LireFloat(Question: in string) return float is
   -- Lis un reel sur la ligne de commande.
   -- Parametre: in : Question : Question qui est pose a l'usager.
   -- Retourne: float: nombre lus sur la ligne commande.
   Nombre: float :=0.0; --Nombre qui est lus sur le clavier.
   begin
      loop
      begin
            put(Question);
            eS_D_Float.get(Nombre);
            skip_line;
            
            exit when (Nombre >= 0.0); 
            Put_Line("Le nombre doit etre positif.");
            new_line;
            
         exception
            when Data_error =>
               Put_line("erreur de saisie de donnees.");
               new_line;
               skip_line;
         end;
      end loop;
      
      return Nombre;
   end LireFloat;

   function LireTypeFilm(Question: in string) return Categorie_Film is
   -- Lis un type de film au clavier.
   -- Parametre: in : Question : Question qui est pose a l'usager.
   -- Retourne: Categorie_Film: Categorie qui est lus sur le clavier.
   TypeFilm : Categorie_Film; -- Categorie qui est lus sur le clavier.
   begin
       Loop
          Begin   

            put(Question);
            ES_Enum_Type.Get(TypeFilm);
            
            Exit;
            
            Exception
               When data_error => skip_line; 
                                  Put_Line("Type invalide.");
                                  new_line;
            End;
      End loop;
      RETURN TypeFilm;
   end LireTypeFilm;

   function LirePublicFilm(Question: in string) return Categorie_Public is
   -- Lis une categorie de public au clavier.
   -- Parametre: in : Question : Question qui est pose a l'usager.
   -- Retourne: Categorie_Public: Categorie qui est lus sur le clavier.
   PublicFilm : Categorie_Public;
   begin
       Loop
          Begin   

            put(Question);
            ES_Enum_Public.Get(PublicFilm);
            
            Exit;
            Exception
               When data_error => skip_line; 
                                  Put_Line("Public invalide.");
                                  new_line;
            End;
      End loop;
      RETURN PublicFilm;
   end LirePublicFilm;
   
   FUNCTION LireDate(Question: in string) return Date is
   -- Lis un date au clavier.
   -- Parametre: in : Question : Question qui est pose a l'usager.
   -- Retourne la date qui est lus sur le clavier.
   D: Date;
   Begin
      loop
         begin
            put(Question);
            ES_D_Entier.Get(D.jour);
            ES_D_Entier.Get(D.mois);
            ES_D_Entier.Get(D.annee); 
            skip_line;
            exit;
            Exception
               When data_error | constraint_error=> skip_line; 
                                  Put_Line("Date invalide.");
                                  new_line;
         end ;
      end loop;
      RETURN D;
   end LireDate;
   
   function DateSuperieur(D1,D2: IN Date) return Boolean is
   -- Compare la date D1 a D2
   -- D1, D2 (IN): Les deux dates a compares.
   -- Retourne: Bolean: VRAI : Si le date D1 est superieur a D2.
     Reponse : Boolean := True;
     Begin
       if D1.Annee < D2.Annee then
           Reponse := false;
       elsif D1.Annee = D2.Annee then
          if D1.Mois < D2.Mois then
             Reponse := false;
          elsif D1.Mois = D2.Mois then
             if D1.Jour < D2.Jour then
                Reponse := false;
             elsif D1.Jour = D2.Jour then
                 Reponse := false;
             end if;
          end if;
       end if;
       return reponse;
   End DateSuperieur;
      
   function DateInterval(D1,D2: IN Date) return Integer is  
   --- Calcul le nombre de jour entre D1 et D2
   -- D1,D2 (IN): Les deux date qui servent a determiner l'inteval.
   -- Retourne: Integer: Le nombre de jour entre les deux dates.
     N : Integer := 0;
   Begin
     if DateSuperieur(D2,D1) then  
       if D1.annee = D2.annee then
          if D1.mois < D2.mois then
             N := N + (D2.mois-D1.mois)*30;
          end if;
          if D1.jour < D2.jour then
             N := N + (D2.jour - D1.jour);
          end if;
       else
          N := (30 - D1.jour) + (12 - D1.mois) + D2.jour + 30*(D2.mois-1);
       end if;    
     end if;
     return N;      
   End DateInterval;
                
   FUNCTION TrouverEnregistrementVideDansTableauClient(ListeClient: in Liste_Client) return integer is
   -- Trouve l'index du prochain enregistrement vide
   -- ListeClient (IN) : Contient la liste des clients.
   -- retourne: Integer : L'index de l'enregistrement ou -1 si il y a pas de place
   begin
      if(ListeClient.NombreClient < ListeClient.LesClients'last) then
         RETURN ListeClient.NombreClient+1;
      else
         RETURN -1;
      end if;
   end TrouverEnregistrementVideDansTableauClient;
   
   FUNCTION TrouveIndexCopieFilmVide(ListeCopie: in Liste_Copie) return integer is
   -- Trouve l'index du premier enregistrement non utilise dans une liste de copie.
   -- ListeCopie (IN) : Contient la liste des copies d'un film.
   -- retourne: Integer : L'index de l'enregistrement ou -1 si il y a pas de place
   IndexCopie: integer := -1;
   begin
      FOR i in 1..ListeCopie.NombreCopiesUtilise loop
         if(ListeCopie.LesCopies(i).Disponible) then
            IndexCopie := i;
            exit;
         end if;
      end loop;
      RETURN IndexCopie;
   end TrouveIndexCopieFilmVide;

   FUNCTION TrouveIndexLocationClientVide(ListeLocation: in Liste_Locations) return integer is
   -- Trouve l'index du premier enregistrement non utilise dans la liste de location.
   -- ListeLocations (IN) : Contient la liste des locations d'un client.
   -- retourne: Integer : L'index de l'enregistrement ou -1 si il y a pas de place
   IndexLocation: integer := -1;
   begin
      if( ListeLocation.NombreLocations + 1< ListeLocation.LesLocations'Last) then
         IndexLocation := ListeLocation.NombreLocations + 1;      
      end if;
      RETURN IndexLocation;
   end TrouveIndexLocationClientVide;
   
   FUNCTION TrouverEnregistrementVideDansTableauFilm(ListeFilm: in Liste_Film) return integer is
   -- Trouve l'index du prochain enregistrement de film non utilise .
   -- ListeFiln (IN) : Contient la liste des films.
   -- retourne: Integer : L'index de l'enregistrement ou -1 si il y a pas de place
   begin
      if(ListeFilm.NombreFilms < ListeFilm.LesFilms'Last) then
         RETURN ListeFilm.NombreFilms+1;
      else
         RETURN -1;
      end if;
   end TrouverEnregistrementVideDansTableauFilm;
   
   FUNCTION TrouveFilm(ListeFilm: Liste_Film; CodeFilm : String) return integer is
   -- Trouve un film avec le code de film dans la liste de film.
   -- ListeFiln (IN) : Contient la liste des films.
   -- retourne: Integer : L'index de l'enregistrement ou -1 si il y n'existe pas.
   Index: integer := -1;
   begin
      FOR i in 1..ListeFilm.NombreFilms loop
         if(ListeFilm.LesFilms(i).CodeFilm = CodeFilm) then
            Index := i;
            exit;
         end if;
      end loop;
      
      RETURN Index;
   end TrouveFilm;
   
   FUNCTION TrouveClient(ListeClient: Liste_Client; CodeClient : String) return integer is
   -- Trouve un client avec le code client dans la liste de client.
   -- ListeClient (IN) : Contient la liste des clients.
   -- retourne: Integer : L'index de l'enregistrement ou -1 si il y n'existe pas.
   Index: integer := -1;
   begin
      FOR i in 1..ListeClient.NombreClient loop
         if(ListeClient.LesClients(i).CodeClient = CodeClient) then
            Index := i;
            exit;
         end if;
      end loop;
      
      RETURN Index;
   end TrouveClient;

   FUNCTION FilmDisponible(LeFilm: in Film) return boolean is
   -- Function qui determine si un film est disponible.
   -- LeFilm (IN):  L'enregisitrement du film a determiner si il est disponible.
   -- retourne : boolean: VRAI -> Le film disponible.
   --                     FAUX -> Le film est non disponible.
   Disponible : boolean := false;
   begin
         FOR i in 1..LeFilm.ListeCopie.NombreCopiesUtilise loop
            IF (LeFilm.ListeCopie.LesCopies(i).Disponible) THEN
               Disponible:=true;
               exit;
            END IF;
         end loop;
      RETURN Disponible;
   end FilmDisponible;
   
   procedure LireCodeClient(ListeClient: in Liste_Client;CodeClient: out String;Quitter: out boolean;IndexClient: out integer)is
   -- Cette procedure lis un code client sur le clavier et determine si l'usager veut continuer si le code client n'existe pas.
   -- Parametre: ListeClient (IN): La liste de tous les clients.
   --            CodeClient (OUT): Le code client a trouver.
   --            Quitter (OUT): Determine si l'usager ne veut plus entrer de code client et quitter la saisie.
   --            IndexClient(OUT): L'index de l'enregistrement du client trouver a partir du code client saisie.
   Car: Character;
   begin
      IndexClient:=-1;
      loop      
            CodeClient := Ada.Strings.Fixed.Translate(LireChaine("Code Client:",CodeClient'Last), Ada.Strings.Maps.Constants.Upper_Case_Map);
            IndexClient := TrouveClient(ListeClient,CodeClient);
            EXIT when (IndexClient>0);
            put("Le client n'existe pas.");
            new_line;
            Car := ada.characters.handling.To_Upper(LireCaractere("OoNn","Continuer (O/N):"));
            if(Car = 'N') then
               Quitter := true;
               exit;                
            end if;
         end loop;
   end LireCodeClient;   
            
   PROCEDURE LireCodeFilm(ListeFilm: Liste_Film;CodeFilm: out string;Quitter: out boolean;IndexFilm: out integer) is
   -- Cette procedure lis un code film sur le clavier et determine si l'usager veut continuer quand le code film n'existe pas.
   -- Parametre: ListeFilm (IN): Liste de tous les films.
   --            CodeFilm (OUT): Code client saisie au clavier.
   --            Quitter (OUT): Determine si l'usager ne veut plus entrer de code film et quitter la saisie.
   --            IndexFilm(OUT): L'index de l'enregistrement du film trouver a partir du code film saisie.
   Car: Character;
   begin
      loop
         CodeFilm :=Ada.Strings.Fixed.Translate(LireChaine("Code Film:",CodeFilm'Last), Ada.Strings.Maps.Constants.Upper_Case_Map);
         IndexFilm := TrouveFilm(ListeFilm,CodeFilm);
         EXIT when (IndexFilm > 0 );
         put("Le film n'existe pas.");
         new_line;
         Car := ada.characters.handling.To_Upper(LireCaractere("OoNn","Continuer (O/N):"));
         if(Car = 'N') then
            Quitter := true;
            exit;                
         end if;
      end loop;
   end LireCodeFilm;             
   
   FUNCTION CreerCode(Nom: String;Prenom :String;NumSeq:Integer) return string is
   -- Genere un code client a partir d'un nom, prenom et d'un numero sequentiel
   -- Parametre : Nom : Contient le nom du client.
   --             Prenom : Contient le prenom du client.
   --             NumSeq : Numero sequentiel.
   -- Retourne : String: Chaine qui contient le code creer.
   CodeClient: string( 1.. MAX_LONG_CODE); -- Code du client generer.
   NumeroSeq: string( 1..4) := "    "; -- Le numero de Sequence convertis en chaine.
   TempNum : integer; -- Variable temporaire.
   
   begin
      CodeClient(1..3):=Nom(1..3);
      CodeClient(4):=Prenom(1);
      
      -- donne une valeur minimum de 1000 pour le numero sequentiel
      -- Cela simplifie le code.
      TempNum := NumSeq + 1000; 
      
      CodeClient(5..8):=Integer'Image(TempNum)(2..5);
      CodeClient:=Ada.Strings.Fixed.Translate(CodeClient, Ada.Strings.Maps.Constants.Upper_Case_Map);
      
      return CodeClient;
   end CreerCode;

   function CopieChaine(Source: String;LongueurDestination: Natural) return String is
   -- Function qui copie une chaine de n'importe quelle taille dans un autre chaine
   -- Parametre: Source: Chaine de caractere source.
   --            Longueur Destination: La longueur maximal de la chaine destination
   -- Retourn: string: La chaine destination.
   Dest: String(1..LongueurDestination);
   Max: Natural:=0;
   begin
      -- Remplis la destination d'espace
      FOR i in Dest'Range loop
         Dest(i):=' ';
      end loop;
      
      -- Prends le nombre de caracteres a copier.
      if (Dest'Last>Source'Last) then
         Max:=Source'Last;
      else
         Max:=Dest'Last;
      end if;
      
      -- Copie les caracteres.
      FOR i in 1..Max loop
         Dest(i):=Source(i);
      end loop;
      RETURN Dest;
   end CopieChaine;
   
   PROCEDURE FaireLocation(ListeFilm: in out Liste_Film;ListeClient: in out Liste_Client;CodeFilm,CodeClient:in String;DateLocation,DateRetour:in Date;MsgErreur: out String) is
   -- Cette procedure ajoute l'enregistrement de location dans les copie du film et les location du client
   -- Parametre: ListFilm (IN OUT): Liste de tous les films.
   --            ListeClient (IN OUT): Liste de tous les client.
   --            CodeFilm (IN): Code film de la location.
   --            CodeClient (IN): Code client de la location.
   --            DateLocation (IN): Date de location.
   --            DateRetours (IN): Date de retours prevus.
   --            MsgErreur (OUT): Contient un message d'erreur si l'ajout n'est pas un success.
   IndexClient,IndexFilm,IndexCopie,IndexLocation: integer := -1;
   begin
      IndexFilm:=TrouveFilm(ListeFilm,CodeFilm);
      if( IndexFilm>0) then
         IndexClient:=TrouveClient(ListeClient,CodeClient);
         if (indexClient>0) then
            IndexCopie:=TrouveIndexCopieFilmVide(ListeFilm.LesFilms(IndexFilm).ListeCopie);
            if(IndexCopie>0) then
               IndexLocation:=TrouveIndexLocationClientVide(ListeClient.LesClients(IndexClient).Locations);
               if(IndexLocation>0) then
                  -- Ajoute la location dans la liste de copie du film.
                  ListeFilm.LesFilms(IndexFilm).ListeCopie.LesCopies(IndexCopie).DateLocation:=DateLocation;
                  ListeFilm.LesFilms(IndexFilm).ListeCopie.LesCopies(IndexCopie).DateRetoursPrevus:=DateRetour;
                  ListeFilm.LesFilms(IndexFilm).ListeCopie.LesCopies(IndexCopie).CodeClient:=CodeClient;
                  ListeFilm.LesFilms(IndexFilm).ListeCopie.LesCopies(IndexCopie).Disponible:=false;
               
                  -- Ajoute la location dans la liste de location du client.
                  ListeClient.LesClients(IndexClient).Locations.LesLocations(IndexLocation).CodeFilm:=CodeFilm;
                  ListeClient.LesClients(IndexClient).Locations.LesLocations(IndexLocation).DateLocation:=DateLocation;
                  ListeClient.LesClients(IndexClient).Locations.LesLocations(IndexLocation).DateRetour:=DateRetour;
                  ListeClient.LesClients(IndexClient).Locations.LesLocations(IndexLocation).Retourne:=false;
                  ListeClient.LesClients(IndexClient).Locations.NombreLocations := ListeClient.LesClients(IndexClient).Locations.NombreLocations+1;
                  
                  TrierLocation(ListeClient.LesClients(IndexClient).Locations);
                  
                  MsgErreur:=CopieChaine("La location a ete faite.",MsgErreur'Last);
               else
                  MsgErreur:=CopieChaine("ERREUR! Le client a atteint le maximum de location.",MsgErreur'Last);
               end if;
            else
               MsgErreur:=CopieChaine("ERREUR! Le film n'est pas disponible.",MsgErreur'Last);
            end if;
         else
            MsgErreur:=CopieChaine("ERREUR! Le client n'existe pas.",MsgErreur'Last);
         end if;
      else
         MsgErreur:=CopieChaine("ERREUR! Le film n'existe pas.",MsgErreur'Last);
      end if;         
   end FaireLocation;

   PROCEDURE EnleveLocationClient(LeClient: in out Client;CodeFilm: string;Cout: float;Retard: out float;DateRetour : date;trouve : out boolean ) is
   -- Cette procedure enleve une location de la liste de location du client et calcule le tarif du retard.
   -- Parametre: LeClient (IN OUT): Enregistrement du client qui fait un retours de locations.
   --            CodeFilm (IN): Code du film retourne.
   --            Cout (IN): Cout journalier du retard du film.
   --            Retard (OUT): Tarif a etre charger a l'utilisateur.
   --            DateRetour (IN): Date du retour.
   --            Trouve (OUT): VRAI -> Locations enlever de la liste du client.
   --                          FAUX -> Le client n'avais pas cette location.
   begin
      trouve :=false;
      Retard:=0.0;
      FOR i in 1..LeClient.Locations.NombreLocations loop
         if(LeClient.Locations.LesLocations(i).CodeFilm=CodeFilm) then
            trouve:=true;
            retard:=float(DateInterval(LeClient.locations.LesLocations(i).DateRetour,DateRetour))*Cout;
            LeClient.Locations.LesLocations(i).DateRetour:=DateRetour;
            LeClient.locations.LesLocations(i).retourne:=true;
            exit;
         end if;
      end loop;
   end EnleveLocationClient;

   procedure EnleveLocationFilm(LeFilm: in out Film;CodeClient: in string ) is
   -- Enleve une location de la liste de location d'un client.
   -- Parametre: LeFilm (IN OUT): Enregistrement du film a enlever.
   --            CodeClient (IN): Code du client de la location.
   begin
      FOR i in 1..LeFilm.ListeCopie.NombreCopiesUtilise loop
         if(LeFilm.ListeCopie.LesCopies(i).CodeClient = CodeClient ) then
            LeFilm.ListeCopie.LesCopies(i).disponible:=true;
            exit;
         end if;
     end loop;
   end EnleveLocationFilm;
   
   PROCEDURE TransactionListeFilm(ListeFilm: in Liste_film) is
   -- Affiche la liste de tous les films.
   -- parametre ListFilm: (in) Liste_Film: Liste des films dans l'inventaire.
   begin
      new_line(2);
      put_line("Liste des films.");
      put_line("-----------------------------------------------------------------------------");
      put_line("Code     Titre");
      FOR i in 1..(ListeFilm.NombreFilms) loop
         put(ListeFilm.LesFilms(i).CodeFilm);
         put(" ");
         put(ListeFilm.LesFilms(i).TitreFilm);
         new_line;
      end loop;
      put_line("-----------------------------------------------------------------------------");
      AttendreTouche;
   end TransactionListeFilm;
   
   PROCEDURE TransactionListeClient(ListeClient: in Liste_Client) is
   -- Affiche la liste de tous les clients.
   -- parametre ListClient: (in) Liste_Client: Liste des client du club video.
   begin
      new_line(2);
      put_line("Liste des clients");
      put_line("-----------------------------------------------------------------------------");
      put_line("Code     Nom             Prenom");
      FOR i in 1..(ListeClient.NombreClient) loop
         put(ListeClient.LesClients(i).CodeClient);
         put(" ");
         put(ListeClient.LesClients(i).Nom);
         put(" ");
         put(ListeClient.LesClients(i).Prenom);
         new_line;
      end loop;
      put_line("-----------------------------------------------------------------------------");
      AttendreTouche;
   end TransactionListeClient;
   
   PROCEDURE TransactionAjoutAbonnement(ListeClient: in out Liste_Client) is
   --Cette procedure ajoute un client dans la liste de client
   -- ListeClient (IN OUT): La liste de client du club video.
   IndexClient : Integer := -1;
   begin
      IndexClient:= TrouverEnregistrementVideDansTableauClient(ListeClient);
      if(IndexClient > 0) then
         ListeClient.LesClients(IndexClient).Nom := LireChaine("Nom:",ListeClient.LesClients(IndexClient).Nom'Last);
         ListeClient.LesClients(IndexClient).Prenom := LireChaine("Prenom:",ListeClient.LesClients(IndexClient).Prenom'Last);
         ListeClient.LesClients(IndexClient).Adresse := LireChaine("Adresse:",ListeClient.LesClients(IndexClient).Adresse'Last);
         ListeClient.LesClients(IndexClient).CodeClient := CreerCode(ListeClient.LesClients(IndexClient).Nom,ListeClient.LesClients(IndexClient).Prenom,IndexClient);
         
         Listeclient.LesClients(IndexClient).locations.NombreLocations:=0;
         
         ListeClient.NombreClient:= ListeClient.NombreClient +1;
         
         TrierClient(ListeClient);
         
         put_line("Client ajoute.");
      else
         put_line("Aucune place disponible.");
      end if;
      
      AttendreTouche;
   end TransactionAjoutAbonnement;
   
   procedure TransactionAjoutFilm(ListeFilm : in out Liste_Film) is
   -- Cette procedure ajoute un film a la liste de film.
   -- ListeFilm (IN OUT): La liste de film du club video.
   IndexFilm : integer := -1;
   begin
      IndexFilm := TrouverEnregistrementVideDansTableauFilm(ListeFilm);
      if(IndexFilm > 0) then
         ListeFilm.LesFilms(IndexFilm).TitreFilm:=LireChaine("Titre:",ListeFilm.LesFilms(IndexFilm).TitreFilm'Last);
         ListeFilm.LesFilms(IndexFilm).NomActeur:=LireChaine("Acteur:",ListeFilm.LesFilms(IndexFilm).NomActeur'Last);
         ListeFilm.LesFilms(IndexFilm).NomRealisateur := LireChaine("Realisateur:",ListeFilm.LesFilms(IndexFilm).NomRealisateur'Last);
         
         loop
            ListeFilm.LesFilms(IndexFilm).NombreCopies := LireNatural("Nombre de copie:");
            
            EXIT when ((ListeFilm.LesFilms(IndexFilm).NombreCopies <= MAX_COPIES) and then (ListeFilm.LesFilms(IndexFilm).NombreCopies >0 ) );
            
            if(ListeFilm.LesFilms(IndexFilm).NombreCopies = 0) then
               put("Il doit avoir au moins une copie");
            else
               put("Le maximum est de ");
               put(integer'Image(MAX_COPIES));
               put(" copies.");
            end if;
            
            new_line;
            
         end loop;
         
         ListeFilm.LesFilms(IndexFilm).CoutLocation := LireFloat("Cout de location:");
         ListeFilm.LesFilms(IndexFilm).CodeFilm := CreerCode(ListeFilm.LesFilms(IndexFilm).TitreFilm,ListeFilm.LesFilms(IndexFilm).NomActeur,IndexFilm);
         ListeFilm.LesFilms(IndexFilm).TypeFilm := LireTypeFilm("Type de film (ACTION,DRAME,COMEDIE,HORREUR):");
         ListeFilm.LesFilms(IndexFilm).PublicCible := LirePublicFilm("Type de categorie de public(HUIT_ET_PLUS, TREIZE_ET_PLUS, SEIZE_ET_PLUS, DIX_HUIT_ET_PLUS, GENERAL):");
         
         ListeFilm.NombreFilms := ListeFilm.NombreFilms + 1;
         
         ListeFilm.LesFilms(IndexFilm).ListeCopie.NombreCopiesUtilise:= ListeFilm.LesFilms(IndexFilm).NombreCopies;
         
         -- Initialise toutes les copies a des valeurs par defauts.
         FOR i in 1..ListeFilm.LesFilms(IndexFilm).ListeCopie.NombreCopiesUtilise loop
            ListeFilm.LesFilms(IndexFilm).ListeCopie.LesCopies(i).Etat:=NON_DEFECTUEUX;
            ListeFilm.LesFilms(IndexFilm).ListeCopie.LesCopies(i).DateLocation:=(1,1,2001);
            ListeFilm.LesFilms(IndexFilm).ListeCopie.LesCopies(i).DateRetoursPrevus:=(1,1,2001);
            ListeFilm.LesFilms(IndexFilm).ListeCopie.LesCopies(i).disponible:=true;            
            for z in ListeFilm.LesFilms(IndexFilm).ListeCopie.LesCopies(i).CodeClient'range loop
               ListeFilm.LesFilms(IndexFilm).ListeCopie.LesCopies(i).CodeClient(z):=' ';     
            end loop;

         end loop;
         
         TrierFilm(ListeFilm);
         
         put_line("Film ajoute.");
      else
         put_line("Aucune place disponible.");
      end if;
      skip_line;
      AttendreTouche;   
   end TransactionAjoutFilm;
   
   
   PROCEDURE TransactionVerifierDisponibilite(ListeFilm: Liste_Film) is
   -- Procedure qui verifie la disponibilite d'un film
   -- PARAMETRE: ListeFilm (IN): Liste de tous les films.
   CodeFilm: String(1..MAX_LONG_CODE);
   IndexFilm: Integer := -1;
   begin
      CodeFilm :=Ada.Strings.Fixed.Translate(LireChaine("Code Film:",CodeFilm'Last), Ada.Strings.Maps.Constants.Upper_Case_Map);
      IndexFilm := TrouveFilm(ListeFilm,CodeFilm);
      IF (IndexFilm > 0) THEN
         IF FilmDisponible(ListeFilm.LesFilms(IndexFilm)) THEN
            put_line("Film disponible.");
         else
            put_line("Film non disponible.");
         END IF;
      ELSE
         put_line("Le film n'existe pas.");
      END IF;
     AttendreTouche;      
   end TransactionVerifierDisponibilite;
   
   procedure TransactionAjoutLocation(ListeFilm: in out Liste_Film;ListeClient: in out Liste_Client) is
   -- Procedure qui fait une location d'un film video a un client.
   -- Parametre: ListeFilm (IN OUT): Liste de film du club video.
   --            ListeClient (IN OUT): Liste de client du club video.
   CodeFilm,CodeClient: String(1..MAX_LONG_CODE);
   MsgErreur: String(1..MAX_LONG_MSGERREUR);
   IndexFilm,IndexClient : Integer:=-1;
   DateLocation,DateRetour: Date;
   Quitter: boolean := false;
   begin
      
      loop
         LireCodeFilm(ListeFilm,CodeFilm,Quitter,IndexFilm);
         -- exit fait sur deux lignes pour eviter d'utiliser Indexfilm si l'utilisateur n'as pas entrer de code film.
         EXIT when  (Quitter); 
         EXIT when FilmDisponible(ListeFilm.LesFilms(IndexFilm));
         put_line("Le film n'est pas disponible");
      end loop;
      
      if(not Quitter) then
         LireCodeClient(ListeClient,CodeClient,Quitter,IndexClient);
      end if;         
      
      if(not Quitter) then             
         DateLocation:=LireDate("Date de location (jj mm aaaa):");
         DateRetour:=LireDate("Date de retour (jj mm aaaa):");
         FaireLocation(ListeFilm,ListeClient,CodeFilm,CodeClient,DateLocation,DateRetour,MsgErreur);
         
         put_line(MsgErreur);
         AttendreTouche;      
      end if;
   end TransactionAjoutLocation;
   
   procedure TransactionListeFilmLoueClient(ListeClient: in Liste_Client;ListeFilm: in Liste_Film) is
   -- Procedure qui affiche a l'ecran la liste des films loue par un client.
   -- Parametre: ListeCLient (IN): Liste de tous les clients.
   --            Listefilm (IN): Liste de tous les films.
   CodeClient: String(1..MAX_LONG_CODE);
   Quitter: boolean := false;
   IndexClient,IndexFilm : integer := -1;
   begin
      LireCodeClient(ListeClient,CodeClient,Quitter,IndexClient);

      if(not Quitter) then
         new_line(2);
         put_line("Liste des locations d'un client");
         put_line("-----------------------------------------------------------------------------");
         put_line("Code     Titre                 Date de location");
         FOR i in 1..ListeClient.LesClients(IndexClient).Locations.NombreLocations loop
            if(not ListeClient.LesClients(IndexClient).Locations.LesLocations(i).Retourne) then
               IndexFilm:=TrouveFilm(ListeFilm,ListeClient.LesClients(IndexClient).Locations.LesLocations(i).CodeFilm);
               if (IndexFilm>0) then
                  put(ListeClient.LesClients(IndexClient).Locations.LesLocations(i).CodeFilm);
                  put(" ");
                  put(ListeFilm.LesFilms(IndexFilm).TitreFilm);
                  put(" ");
                  put(Integer'Image(ListeClient.LesClients(IndexClient).Locations.LesLocations(i).DateLocation.jour) 
                     & " " 
                     & Integer'Image(ListeClient.LesClients(IndexClient).Locations.LesLocations(i).DateLocation.mois)
                     & " "
                     & Integer'Image(ListeClient.LesClients(IndexClient).Locations.LesLocations(i).DateLocation.annee) );
                  
                  new_line;
               end if;   
            end if;
         end loop;
         put_line("-----------------------------------------------------------------------------");
         AttendreTouche;            
      end if;
   end TransactionListeFilmLoueClient;
   
   procedure TransactionListeFilmTransactionClient(ListeClient: in Liste_Client;ListeFilm: in Liste_Film) is
   -- Procedure qui affiche a l'ecran la liste de l'historique des films loue par un client.
   -- Parametre: ListeClient (IN): Liste de tous les clients.
   --            ListeFilm (IN): Liste de tous les films.
   CodeClient: String(1..MAX_LONG_CODE);
   Quitter: boolean := false;
   IndexClient,IndexFilm : integer := -1;
   begin
      LireCodeClient(ListeClient,CodeClient,Quitter,IndexClient);

      if(not Quitter) then
         put_line("Historique des transactions d'un client");
         put_line("-----------------------------------------------------------------------------");
         put_line("Code     Titre                 Date de location Date de retour");
         FOR i in 1..ListeClient.LesClients(IndexClient).Locations.NombreLocations loop
            IndexFilm:=TrouveFilm(ListeFilm,ListeClient.LesClients(IndexClient).Locations.LesLocations(i).CodeFilm);
            if (IndexFilm>0) then
               put(ListeClient.LesClients(IndexClient).Locations.LesLocations(i).CodeFilm);
               put(" ");
               put(ListeFilm.LesFilms(IndexFilm).TitreFilm);
               put(" ");
               put(Integer'Image(ListeClient.LesClients(IndexClient).Locations.LesLocations(i).DateLocation.jour) 
                     & " " 
                     & Integer'Image(ListeClient.LesClients(IndexClient).Locations.LesLocations(i).DateLocation.mois)
                     & " "
                     & Integer'Image(ListeClient.LesClients(IndexClient).Locations.LesLocations(i).DateLocation.annee) );
               put("    ");
               if(ListeClient.LesClients(IndexClient).Locations.LesLocations(i).Retourne) then
               put(Integer'Image(ListeClient.LesClients(IndexClient).Locations.LesLocations(i).DateRetour.jour) 
                     & " " 
                     & Integer'Image(ListeClient.LesClients(IndexClient).Locations.LesLocations(i).DateRetour.mois)
                     & " "
                     & Integer'Image(ListeClient.LesClients(IndexClient).Locations.LesLocations(i).DateRetour.annee) );
               else
                  put(" Encore en location.");
               end if;
               new_line;
            end if;   
         end loop;
         put_line("-----------------------------------------------------------------------------");
         AttendreTouche;            
      end if;
   end TransactionListeFilmTransactionClient;
   
   PROCEDURE TransactionListeFilmNonDisponible(ListeFilm: in Liste_Film) is
   -- Procedure qui affiche la liste des films non disponible.
   -- Parametre: ListeFilm (IN): Liste de tous les films.
   begin
      put_line("Liste des films non disponible.");
      put_line("-----------------------------------------------------------------------------");
      put_line("Code     Titre");
      FOR i in 1..ListeFilm.NombreFilms loop
         if(not FilmDisponible(ListeFilm.LesFilms(i))) then
            put(ListeFilm.LesFilms(i).CodeFilm);
            put(" ");
            put(ListeFilm.LesFilms(i).TitreFilm);
            new_line;
         end if;
      end loop;
      put_line("-----------------------------------------------------------------------------");
      AttendreTouche;            
   end TransactionListeFilmNonDisponible;
   
   PROCEDURE TransactionListeFilmType(ListeFilm: Liste_Film) is
   -- Procedure qui affiche la liste des films d'un certain type
   -- Parametre: ListFilm (IN): Liste de tous les films.
   TypeFilm : Categorie_Film;
   begin
      TypeFilm:=LireTypeFilm("Type de film (ACTION,DRAME,COMEDIE,HORREUR):");
      new_line(2);
      put_line("Liste des films.");
      put_line("-----------------------------------------------------------------------------");
      put_line("Code     Titre");
      FOR i in 1..(ListeFilm.NombreFilms) loop
         if(ListeFilm.LesFilms(i).TypeFilm = TypeFilm) then
            put(ListeFilm.LesFilms(i).CodeFilm);
            put(" ");
            put(ListeFilm.LesFilms(i).TitreFilm);
            new_line;
         end if;
      end loop;
      put_line("-----------------------------------------------------------------------------");
      
      AttendreTouche;
   end TransactionListeFilmType;
   
   PROCEDURE TransactionListeClient5Location(ListeClient: Liste_Client) is
   -- Procedure qui affiche la liste des client qui ont plus que 5 locations.
   -- Parametre: ListeClient (IN): Liste de tous les clients.
   NumLocation: Natural :=0;
   begin
      new_line(2);
      put_line("Liste des clients qui ont plus que 4 locations de film.");
      put_line("-----------------------------------------------------------------------------");
      put_line("Code     Nom             Prenom");
      FOR i in 1 .. ListeClient.NombreClient loop

         NumLocation := 0;
         FOR j in 1 ..ListeClient.LesClients(i).Locations.NombreLocations loop
               if(not ListeClient.LesClients(i).Locations.LesLocations(j).Retourne) then
                  NumLocation := NumLocation + 1;
               end if;
         end loop;
         
         if(NumLocation > 4) then
            put(ListeClient.LesClients(i).CodeClient);
            put(" ");
            put(ListeClient.LesClients(i).Nom);
            put(" ");
            Put(ListeClient.LesClients(i).Prenom);
            new_line;
         end if;
      end loop;
          put_line("-----------------------------------------------------------------------------");
          AttendreTouche;
   end TransactionListeClient5Location;
   
   PROCEDURE TransactionListeFilmEnRetard(ListeFilm: Liste_Film) is
   -- Affiche les films en retard pour une date.
   -- Parametre: ListeFilm (IN): Liste de tous les films.
   DateVerification: Date;
   cout : float := 0.0;
   NbJour : integer :=0;
   begin
      DateVerification:=LireDate("Date de verification (jj mm aaaa):");

      new_line(2);
      put_line("Liste des films en retard.");
      put_line("-----------------------------------------------------------------------------");
      put_line("Code     Titre                 Code Client   Nombre Jour Retard  Frais Retard");
      
      FOR i in 1..ListeFilm.NombreFilms loop          
         FOR j in 1..ListeFilm.LesFilms(i).ListeCopie.NombreCopiesUtilise loop
            if((not ListeFilm.LesFilms(i).ListeCopie.LesCopies(j).disponible)
                  and then 
                  (DateSuperieur(DateVerification,ListeFilm.LesFilms(i).ListeCopie.LesCopies(j).DateRetoursPrevus))) then
               put(ListeFilm.LesFilms(i).CodeFilm);
               put(" ");
               put(ListeFilm.LesFilms(i).TitreFilm);
               put("  ");
               put(ListeFilm.LesFilms(i).ListeCopie.LesCopies(j).CodeClient);
               NbJour := DateInterval(ListeFilm.LesFilms(i).ListeCopie.LesCopies(j).DateRetoursPrevus,DateVerification);
               put("     " & integer'Image(NbJour) & "                  ");
               cout:=float(NbJour)*ListeFilm.LesFilms(i).CoutLocation;
               ES_D_float.put(cout,2,2,0);
               put("$");
               new_line;
            end if;
         end loop;
      end loop;
      put_line("-----------------------------------------------------------------------------");
      AttendreTouche;
   end TransactionListeFilmEnRetard;
   
   PROCEDURE TransactionRetourLocation(ListeFilm: in out Liste_Film;ListeClient: in out Liste_Client) is
   -- Procedure qui enleve une location a un utilisateur.
   -- Parametre: ListeFilm (IN OUT): Liste de tous les films.
   --            ListeClient (IN OUT): Liste de tous les clients.
   CodeFilm,CodeClient: String(1..MAX_LONG_CODE);
   Quitter,trouve: boolean := false;
   IndexFilm,IndexClient: integer := -1;
   DateRetour: Date;
   Retard: Float;
   begin

      LireCodeFilm(ListeFilm,CodeFilm,Quitter,IndexFilm);
      
      if(not Quitter) then
         LireCodeClient(ListeClient,CodeClient,Quitter,IndexClient);
      end if;         
      
      if(not Quitter) then             
      
         DateRetour:=LireDate("Date de retour (jj mm aaaa):");
         EnleveLocationClient(ListeClient.LesClients(IndexClient),CodeFilm,ListeFilm.LesFilms(IndexFilm).CoutLocation,Retard,DateRetour,trouve);
         
         if(trouve) then
            EnleveLocationFilm(ListeFilm.LesFilms(IndexFilm),CodeClient);
            
            IF (Retard >0.0 ) THEN
               put("Vous devez payer en frais de retard: ");
               ES_D_Float.put(Retard,2,2,0);
               put("$");
               new_line;
            END IF;
            
            put_line("La location a ete enlever.");
         else
            put_line("Il n'as aucune location faite de ce film par ce client.");
         end if;
         AttendreTouche;                     
      end if;
   end TransactionRetourLocation;
   
   PROCEDURE EffectuerTransaction(TypeTransaction: in Character; ListeFilm: in out Liste_Film;
                                  ListeClient: in out Liste_Client) is
   -- Cette procedure effectue une transaction selon le type de transaction choisie par l'utilisateur.                                    
   -- parametre:TypeTransaction (in) : Transaction a effectuer.
   --           ListFilm (in out) : Liste de film dans l'inventaire.
   --           ListeClient (in out): Liste des clients.
   begin
      CASE TypeTransaction IS
         WHEN 'A' =>
               TransactionAjoutAbonnement(ListeClient);
         WHEN 'N' =>
               TransactionAjoutFilm(ListeFilm);
         WHEN 'L' =>
               TransactionAjoutLocation(ListeFilm,ListeClient);
         WHEN 'F' => 
               TransactionListeFilm(ListeFilm);
         WHEN 'T' =>
               TransactionListeFilmType(ListeFilm);
         WHEN 'I' =>
               TransactionListeClient(ListeClient);
         WHEN '5' =>
               TransactionListeClient5Location(ListeClient);
         WHEN 'O' =>
               TransactionListeFilmLoueClient(ListeClient,ListeFilm);
         WHEN 'C' =>
               TransactionListeFilmTransactionClient(ListeClient,ListeFilm);
         WHEN 'E' =>
               TransactionListeFilmEnRetard(ListeFilm);
         WHEN 'V' =>
               TransactionVerifierDisponibilite(ListeFilm);
         WHEN 'S' =>
               TransactionListeFilmNonDisponible(ListeFilm);
         WHEN 'R' =>
               TransactionRetourLocation(ListeFilm,ListeClient);
         WHEN others => null;
      END CASE;
   end EffectuerTransaction;

   PROCEDURE LogErreur(Message: String) is
   -- Cette procedure ecrit un message d'erreur dans resultats.txt
   -- Parametre : Message (IN): Contient le message a ecrire.
   FichierResultat: File_Type;
   begin
      open(FichierResultat,Append_File,"resultats.txt");
      put_line(FichierResultat,Message);
      close(FichierResultat);
   end LogErreur;
   
   PROCEDURE EffectuerTransactionEnLot(ListeFilm: in out Liste_Film;ListeClient: in out Liste_Client) is
   -- Cette procedure fait toute les locations qui sont dans resultats.txt
   -- Parametre: ListeFilm (IN OUT): Contient la liste des films.
   --            ListeClient (IN OUT): Contient la liste des clients.
   FichierLocationEnLot,FichierResultat: File_Type;
   Valide : boolean;
   Ligne: Natural := 1;
   CodeFilm,CodeClient: String(1..MAX_LONG_CODE);
   DateLocation, DateRetour: Date;
   MsgErreur: String(1..MAX_LONG_MSGERREUR);
   
   begin
      -- effaceet creer le fichier de resultat.txt
      create(FichierResultat,Out_File,"resultats.txt");
      put_line(FichierResultat,"Resultat du traitement en lot de locations.txt");
      put_line(FichierResultat,"-----------------------------------------------------------------------------");
      close(FichierResultat);
      
      -- Ouvre le fichier de locations.
      open(FichierLocationEnLot,In_file,"locations.txt");
      put("Traitement en lot de locations.txt");
      while(not End_Of_File(FichierLocationEnLot)) loop
         Valide:=true;
         put(".");
         begin
            get(FichierLocationEnLot,CodeFilm);
            CodeFilm:=Ada.Strings.Fixed.Translate(CodeFilm, Ada.Strings.Maps.Constants.Upper_Case_Map);
            Exception
            when Data_error =>
               LogErreur("Ligne " & Integer'Image(Ligne) & " : ERREUR! Code Film invalide.");
               valide := false;
         end;
         
         if(Valide) then
            begin
               get(FichierLocationEnLot,CodeClient);
               CodeClient:=Ada.Strings.Fixed.Translate(CodeClient, Ada.Strings.Maps.Constants.Upper_Case_Map);
               Exception
               when Data_error =>
                  LogErreur("Ligne " & Integer'Image(Ligne) & " : ERREUR! Code Client invalide.");
                  valide := false;
            end ;
         end if;
         
         if(Valide) then
            begin
               ES_D_Entier.get(FichierLocationEnLot,DateLocation.jour);
               ES_D_Entier.get(FichierLocationEnLot,DateLocation.mois);
               ES_D_Entier.get(FichierLocationEnLot,DateLocation.annee);
               Exception
               when Data_error | constraint_error =>
                  LogErreur("Ligne " & Integer'Image(Ligne) & " : ERREUR! date de location invalide.");
                  valide := false;

            end ;
         end if;
         
         if(Valide) then
            begin
               ES_D_Entier.get(FichierLocationEnLot,DateRetour.jour);
               ES_D_Entier.get(FichierLocationEnLot,DateRetour.mois);
               ES_D_Entier.get(FichierLocationEnLot,DateRetour.annee);
               Exception
               when Data_error | constraint_error =>
                  LogErreur("Ligne " & Integer'Image(Ligne) & " : ERREUR! date de retour invalide.");
                  valide := false;
            end ;
         end if;
         if (Valide) then
            FaireLocation(ListeFilm,ListeClient,CodeFilm,CodeClient,DateLocation,DateRetour,MsgErreur);
            LogErreur("Ligne " & Integer'Image(Ligne) & " : " & MsgErreur);
         end if;
         skip_line(FichierLocationEnLot,1);
         Ligne:=Ligne+ 1;
      end loop;   
      new_line;
      LogErreur("-----------------------------------------------------------------------------");
      close(FichierLocationEnLot);
      Exception
      When Name_Error => Put_Line("Fichier 'locations.txt' introuvable."); 
                         New_Line(2);
                         AttendreTouche;
   end EffectuerTransactionEnLot;
   
   -- Declaration des variables.
   ListeFilm : Liste_Film; --Liste de tous les films du club video.
   ListeClient: Liste_Client; --Liste de tous les clients du club video.
   TypeTransaction: Character; --Transaction entrer par l'utilisateur.
   
begin
   put_line("Club Video UQAM");
   put_line("Par Yann Bourdeau");
   new_line(2);
   LireFichierFilmClient(ListeFilm,ListeClient);
   EffectuerTransactionEnLot(ListeFilm,ListeClient);
   
   loop
      AfficherMenu;
      TypeTransaction := ada.characters.handling.To_Upper(LireCaractere("qalrvcostefin5QALRVCOSTEFIN","Choix(5,Q,A,L,R,V,C,O,S,T,E,F,I,N):"));
      exit when (TypeTransaction = 'Q');
      EffectuerTransaction(TypeTransaction,ListeFilm,ListeClient);
   end loop;
   
   SauverFichiersFilmClient(ListeFilm,ListeClient);
exception
   when others => put_Line("Exception inconnus. Fin du programme.");
end ClubUQAM;
