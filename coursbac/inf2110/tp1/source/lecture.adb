------------------------------------------------------------------------------
--$Id: lecture.adb,v 1.1 2003/07/15 14:55:28 yann Exp $
------------------------------------------------------------------------------
-- Module qui fait une gestion evolue des entrees au clavier.
--
-- Auteur: Yann Bourdeau
-- Courriel: bourdeau.yann@courrier.uqam.ca
-- cours: INF2110-10
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Liste des modules utilisees.
------------------------------------------------------------------------------
WITH ada.text_io; use ada.text_io;


PACKAGE body lecture is

   package ES_D_Positive is new Integer_IO(positive);   
   ------------------------------------------------------------------------------
   -- Lis un caractere et fait la validation du caractere a partir d'une chaine de caractere.
   -- PARAMETRE: ListeCaractere: (IN) Liste des caractere valide.
   --            Question: (IN) Question qui est pose a l'usager.
   -- RETOURNE: character: Le caractere lus.
   ------------------------------------------------------------------------------
   function LireCaractere(ListeCaracteres: in String; 
                          Question: in string) 
                          return character is
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
   
   ------------------------------------------------------------------------------
   -- Lis une chaine avec un filtre de caracteres.
   -- PARAMETRE: Filtre : (IN) Filtre des caracteres de la chaines. Doit etre la 
   --                          meme longueur que la chaine retourne.
   --                          ' ' => N'importe quelle caractere.
   --                          'N' => Nombre
   --                          'L' => Lettre Majuscule
   --                          'l' => Lettre miniscule
   --                          'A' => Lettre sans tenir compte majuscule/minuscule
   --                       exemple: "LLLN N", le filtre vas obliger de saisir
   --                                          3 lettres majuscules
   --                                          1 nombre
   --                                          1 caractere quelconque
   --                                          1 nombre
   --            Question: (IN) Question qui est pose a l'usager.
   -- RETOURNE: La chaine lus.
   ------------------------------------------------------------------------------                                                                              
   FUNCTION LireChaine(Filtre: in String;
                       Question: in String) 
                       return String is
   -- Declaration des variables
      TempChaine: string(1..Filtre'Last + 1); -- Chaine qui contient la chaine lus au clavier
      Chaine: String(1..Filtre'Last);-- Chaine qui vas contenir la chaine retourner
      LongueurChaine : Natural; -- Longueur de la chaine lus au clavier
      ChaineValide : boolean; -- Determine si la chaine est valide ou pas
      begin
         loop      
            ChaineValide:=true;
            put(Question);
            Get_Line(TempChaine, LongueurChaine);
            
            -- remplis le reste de la chaine avec des espace blanc
            For i in LongueurChaine+1..TempChaine'Last loop 
                TempChaine(i) := ' ';
            End loop; 
            
            -- Si la chaine lus est au maximum, trop de caracteres
            if (LongueurChaine>Chaine'Last) then                 
               put_line("Trop de caractere(s)");
               ChaineValide := false;
               -- Enleve les caracteres de trop dans le tampon
               -- de lecture
               skip_line;
            else
               -- Valide chaque caractere de la chaine
               FOR i in Filtre'Range loop
                  CASE Filtre(i) IS
                     WHEN ' ' =>
                        null;
                        
                     WHEN 'N' =>
                        IF not (TempChaine(i) in '0'..'9') THEN
                           put_line("Caractere invalide a la position" & Integer'Image(i) & ".");
                           ChaineValide := False;
                        END IF;
                        
                     WHEN 'L' =>
                        IF not (TempChaine(i) in 'A'..'Z') THEN
                           put_line("Caractere invalide a la position" & Integer'Image(i) & ".");
                           ChaineValide := false;
                        END IF;
                        
                     WHEN 'l' =>
                        IF not (TempChaine(i) in 'a'..'z') THEN
                           put_line("Caractere invalide a la position" & Integer'Image(i) & ".");
                           ChaineValide := false;
                        END IF;                  
                        
                     WHEN 'A' =>
                        IF not (TempChaine(i) in 'a'..'z' or TempChaine(i) in 'A'..'Z') THEN
                           put_line("Caractere invalide a la position" & Integer'Image(i) & ".");
                           ChaineValide := false;
                        END IF;
                        
                     WHEN others =>
                        null;
                  END CASE;
               end loop;
            end if;
   
            EXIT when ChaineValide;
            
         end loop;
         -- copie la chaine lus dans la destination.
         Chaine := TempChaine(Chaine'First..Chaine'Last);
         RETURN Chaine;
         
      end LireChaine;
   

   ------------------------------------------------------------------------------                                                                              
   -- Lis un nombre positif sur la ligne de commande.
   -- Parametre: Question (IN): Question qui est pose a l'usager.
   -- retourne: positive: nombre lus sur la ligne de commande.
   ------------------------------------------------------------------------------                                                                              
   function LirePositive(Question: in String) return Positive is
   Nombre: positive ; -- Nombre qui est lus sur le clavier.
   begin
      loop
         begin

            put(Question);
            ES_D_Positive.get(Nombre);
            skip_line;
            EXIT ;
         exception
            when Data_error =>
               Put_line("Erreur de saisie de donnees. Le nombre doit etre un entier positif.");
               new_line;
               skip_line;
               
         end;
      end loop;
      return Nombre;
   end LirePositive;
   
   ------------------------------------------------------------------------------                                                                              
   -- Cette procedure attends apres une touche
   ------------------------------------------------------------------------------                                                                              
   PROCEDURE AttendreTouche is
   begin
      put_line("Appuyez sur 'ENTER' pour continuer!");
      skip_line;
   end AttendreTouche;
   
end lecture;
