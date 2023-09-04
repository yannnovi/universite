--$Id: tp2.ada,v 1.1 2003/07/15 15:05:27 yann Exp $
-- Ce programme simule un terminal de Loto-UQAM.
--
-- Auteur: Yann Bourdeau
--
--$Log: tp2.ada,v $
--Revision 1.1  2003/07/15 15:05:27  yann
--Sauvegarde du backup
--
--Revision 1.8  2003/04/10 16:29:38  yannb
--Last check in.
--
--Revision 1.7  2003/03/13 04:20:56  yannb
---Correction de faute d'ortographe.
-- 	tp2.ada
--
--Revision 1.6  2003/03/12 20:55:55  yannb
--- Ajout des annexes au document.
--- Modification d'alignement dans tp2.ada.
--
--Revision 1.5  2003/03/12 20:45:40  yannb
---Corriger erreur dans le document.
---Corriger bouclie infinis lorsque les exceptions etaients appeler, il manquais un skip_line.
---ajout des fichiers de test.
-- Modified Files:
--    doc/tp2.doc source/tp2.ada
-- Added Files:
--    source/test.cmd source/test11.txt source/test12.txt
-- source/test21.txt source/test31.txt source/test32.txt
--    source/test33.txt source/test34.txt
--
--Revision 1.4  2003/03/12 20:04:44  yannb
--Appele la bonne function pour le pari decroissant.
-- Modified Files:
-- tp2.ada
--
--Revision 1.3  2003/03/12 19:44:15  yannb
--- Calcule la somme d'argent proprement lorsque un pari est gagne.
--- Sort de la boucle principale si l'utilisateur n'as plus d'argent.
-- Modified Files:
--    tp2.ada
--
--Revision 1.2  2003/03/12 19:26:39  yannb
--Le TP2 est completer. Le programme semble fonctionner.
-- Modified Files:
--    tp2.ada
--
--Revision 1.1  2003/03/12 18:26:20  yannb
--- Ajoute de la premiere revision du TP2.
-- Added Files:
--    tp2.ada tp2.adb tp2.ads
--

with Ada.Text_IO;           use Ada.Text_IO;
With Tp2;
with ada.characters.Handling;

-- Procedure principal du programme.
procedure LotoUQAM is
   
   -- Instanciation des paquetages generiques.
   package      ES_D_Float is new Float_IO(float);
   package      ES_D_Natural is new Integer_IO(Natural);
   

   -- Definition des types.
   type Type_Pari is (Pair, Impair, Croissant, Decroissant, TroisEgaux, DeuxEgaux, Suite);

   -- Definition des constantes.
   PARI_MULTIPLICATEUR_PAIR : constant := 1;
   PARI_MULTIPLICATEUR_IMPAIR : constant := 1;
   PARI_MULTIPLICATEUR_CROISSANT : constant :=15;
   PARI_MULTIPLICATEUR_DECROISSANT:constant := 15;
   PARI_MULTIPLICATEUR_DEUXEGAUX : constant := 3;
   PARI_MULTIPLICATEUR_TROISEGAUX: constant := 50;
   PARI_MULTIPLICATEUR_SUITE: constant := 30;

   -- Function LireFloat
   -- Lis un reel sur la ligne de commande.
   -- Parametre: in : Question : Question qui est pose a l'usager.
   -- Retourne: float: nombre lus sur la ligne commande.
   function LireFloat(Question: in string) return float is
   -- declaration des variables
      Nombre: float :=0.0;
   begin
      loop
     	begin
            put(Question);
            eS_D_Float.get(Nombre);
            skip_line;
            new_line;
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

   -- Function LireCaractere.
   -- Lis un caractere et fait la validation du caractere a partir d'une chaine de caracter.
   -- Parametre: in: ListeCaractere: Liste des caractere valide.
   -- Parametre: in: Question: Question qui est pose a l'usager.
   -- retourne: character: Le caractere lus.
   function LireCaractere(ListeCaracteres: in String; Question: in string) return character is
      
      -- declaration des variables
      Caractere: Character;   
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
   end;
   
   -- Function LireNatural
   -- Lis un nombre naturel sur la ligne de commande.
   -- Parametre: in: Question: Question qui est pose a l'usager.
   -- retourne: natural: nombre lus sur la ligne de commande.
   function LireNatural(Question: in String) return natural is
      -- declaration des variables
      Nombre: Natural := 0;
   begin
      loop
         begin
            put(Question);
            ES_D_Natural.get(Nombre);
            skip_line;
            new_line;
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

   -- Procedure initialisation.
   -- Lis le montant initial de l'utilisateur.
   -- Initialise le generateur aleatoire.
   -- Parametre: out: MontantInitial: Montant initial d'argent entrer par l'utilisateur.
   procedure Initialisation(MontantInitial: out float) is
   begin
      put_line("Loto-UQAM: Bonjour!");
      new_line;
      Tp2.InitialiserAleatoire (LireNatural("Entrer un nombre naturel pour initialiser le generateur aleatoire:"));
      new_line;
      MontantInitial:=LireFloat("Enter votre montant initial d'argent:");
      new_line;
   end Initialisation;

   -- Procedure LirePari.
   -- Le montant et le type du pari.
   -- Parametre: out: Type : Type du pari.
   --            out: Montant: Montant du pari.
   procedure LirePari(TypePari: out Type_Pari;MontantPari: out float; MontantMaximum: in float) is
      -- declarations des variables.
      TempType : character;
   begin
      loop
         begin
            put("Quelles type de pari(P,I,C,D,S,3,2):");
            Get(TempType);
            new_line;
            skip_line;

            TempType:= ada.characters.handling.To_Upper(TempType);

            case TempType is
               when 'P' => TypePari := Pair; 
                        exit;
               when 'I' => TypePari := Impair;
                        exit;
               When 'C' => TypePari := Croissant;
                        exit;
               When 'D' => TypePari := Decroissant;
                        exit;
               when 'S' => TypePari := suite;
                        exit;
               when '3' => TypePari := TroisEgaux;
                        exit;
               when '2' => TypePari := DeuxEgaux;
                        exit;
               when others => put_line("Type invalide.");
                          new_line;
            end case;
         exception
            when Data_error =>
               Put_line("erreur de saisie de donnees.");
               new_line;
         end;
      end loop;
      
      loop
         MontantPari := LireFloat("Montant du pari:");

         exit when (MontantPari <= MontantMaximum);
         Put_line("Vous n'avez pas assez d'argent.");
         new_line;
      end loop;
   end;

   -- Function EffectuerPariPair
   -- Determine si les trois des du paris sont pair
   -- Parametre: in: De1 : Valeur du de 1.
   -- Parametre: in: De2 : Valeur du de 2.
   -- Parametre: in: De3 : Valeur du de 3.
   -- retourne boolean : Vrai si les trois des sont pair sinon faux
   function EffectuerPariPair(De1,De2,De3: Natural) return boolean is
      
      -- declaration des variables
      Valide : boolean := false;

   begin
      if ( (De1 mod 2 =0) and (de2 mod 2 = 0) and (de3 mod 2 =0)) then
         valide := true;
      end if;
      return valide;
   end;

   -- Function EffectuerPariImpair
   -- Determine si les trois des du paris sont impair
   -- Parametre: in: De1 : Valeur du de 1.
   -- Parametre: in: De2 : Valeur du de 2.
   -- Parametre: in: De3 : Valeur du de 3.
   -- retourne boolean : Vrai si les trois des sont impair sinon faux
   function EffectuerPariImpair(De1,De2,De3: Natural) return boolean is
      
      -- declaration des variables
      Valide : boolean := false;

   begin
      if ( (De1 mod 2 /= 0) and (de2 mod 2 /= 0) and (de3 mod 2 /= 0)) then
         valide := true;
      end if;
      return valide;
   end;

   -- Function EffectuerPariCroissant
   -- Determine si les trois des sont croissant
   -- Parametre: in: De1 : Valeur du de 1.
   -- Parametre: in: De2 : Valeur du de 2.
   -- Parametre: in: De3 : Valeur du de 3.
   -- retourne boolean : Vrai si les trois des sont croissant sinon faux
   function EffectuerPariCroissant(De1,De2,De3: Natural) return boolean is
      
      -- declaration des variables
      Valide : boolean := false;

   begin
      if ( (De1 < de2) and (de2 < de3)) then
         valide := true;
      end if;
      return valide;
   end;

   -- Function EffectuerPariDecroissant
   -- Determine si les trois des sont decroissant
   -- Parametre: in: De1 : Valeur du de 1.
   -- Parametre: in: De2 : Valeur du de 2.
   -- Parametre: in: De3 : Valeur du de 3.
   -- retourne boolean : Vrai si les trois des sont decroissant sinon faux
   function EffectuerPariDecroissant(De1,De2,De3: Natural) return boolean is
      
      -- declaration des variables
      Valide : boolean := false;

   begin
      if ( (De1 > de2) and (de2 > de3)) then
         valide := true;
      end if;
      return valide;
   end;

   -- Function EffectuerPariTroisEgaux
   -- Determine si les trois des sont egaux
   -- Parametre: in: De1 : Valeur du de 1.
   -- Parametre: in: De2 : Valeur du de 2.
   -- Parametre: in: De3 : Valeur du de 3.
   -- retourne boolean : Vrai si les trois des sont egaux sinon faux
   function EffectuerPariTroisEgaux(De1,De2,De3: Natural) return boolean is
      
      -- declaration des variables
      Valide : boolean := false;

   begin
      if ( (De1 = de2) and (de2 = de3)) then
         valide := true;
      end if;
      return valide;
   end;

   -- Function EffectuerPariDeuxEgaux
   -- Determine si deux des trois des sont egaux
   -- Parametre: in: De1 : Valeur du de 1.
   -- Parametre: in: De2 : Valeur du de 2.
   -- Parametre: in: De3 : Valeur du de 3.
   -- retourne boolean : Vrai si deux des trois des sont egaux sinon faux
   function EffectuerPariDeuxEgaux(De1,De2,De3: Natural) return boolean is
      
      -- declaration des variables
      Valide : boolean := false;

   begin
      if ( (De1 = de2) or (de1 = de3) or (De2 = De3)) then
         valide := true;
      end if;
      return valide;
   end;

   -- Function EffectuerPariSuite
   -- Determine si les trois des sont une suite
   -- Parametre: in: De1 : Valeur du de 1.
   -- Parametre: in: De2 : Valeur du de 2.
   -- Parametre: in: De3 : Valeur du de 3.
   -- retourne boolean : Vrai si les trois des sont une suite sinon faux
   function EffectuerPariSuite(De1,De2,De3: Natural) return boolean is
      
      -- declaration des variables
      Valide : boolean := false;

   begin
      if ( ((De1 + 1 =  de2) and (de2 + 1  = de3))
            or
         ((De3 + 1 = de2) and ( de2+1 = de1))) then
         valide := true;
      end if;
      return valide;
   end;

   -- Procedure EffectuerPari
   -- Calcule le pari
   -- Parametre: in : TypePari : Le type de pari.
   --            in : MontantPari: Le montant du pari.
   --            out: MontantResultat: l'argent creer par le pari.
    --                                  Le nombre peut etre positif
   --                                  ou negatif.
   procedure EffectuerPari(TypePari : in Type_Pari;
                           MontantPari : in float;
                     MontantResultat: out Float) is
      -- Declaration des variables.
      De1,De2,De3 : Natural; -- Les variable contiennent les trois des.
      PariGagner : boolean; -- Contient si le pari a ete gagne par l'utilisateur
      Multiplicateur : Natural; -- Contient le multiplicateur du montant de la victoire
   begin
      Tp2.lancerTroisDes (De1,De2,De3); -- Determine au hasard la valeur des trois des.
      
      Put("Les des sont: ");
      ES_D_Natural.put(De1,1);
      put(",");
      ES_D_Natural.put(De2,1);
      Put(",");
      ES_D_Natural.put(De3,1);
      Put(".");
      new_line;

      case TypePari is
         
         when Pair => PariGagner := EffectuerPariPair(De1,De2,De3);
            Multiplicateur := PARI_MULTIPLICATEUR_PAIR;

         when impair => PariGagner := EffectuerPariImpair(De1,De2,De3);
            Multiplicateur := PARI_MULTIPLICATEUR_IMPAIR;

         when Croissant => PariGagner := EffectuerPariCroissant(De1,De2,De3);
            Multiplicateur := PARI_MULTIPLICATEUR_CROISSANT;

         when Decroissant=> PariGagner := EffectuerPariDecroissant(De1,De2,De3); 
            Multiplicateur := PARI_MULTIPLICATEUR_DECROISSANT;

         when TroisEgaux => PariGagner := EffectuerPariTroisEgaux(De1,De2,De3);
            Multiplicateur := PARI_MULTIPLICATEUR_TROISEGAUX;

         when DeuxEgaux => PariGagner := EffectuerPariDeuxEgaux(De1,De2,De3);
            Multiplicateur := PARI_MULTIPLICATEUR_DEUXEGAUX;

         when Suite => PariGagner := EffectuerPariSuite(De1,De2,De3);
            Multiplicateur := PARI_MULTIPLICATEUR_SUITE;

         when others => null;
      end case;

      if (PariGagner) then
         MontantResultat := MontantPari * float(Multiplicateur);
      else
         MontantResultat := MontantPari   * (-1.0);
      end if;
   end;

   -- Procedure Termination.
   -- Affiche le montant d'argent final de l'utilisateur.
   -- Parametre: in: MontantFinal: Montant d'argent de l'utilisateur.
   procedure Termination(MontantFinal: in Float) is
   begin
      if(MontantFinal > 0.0) then   
         put("Il vous reste:");
         ES_D_Float.put(MontantFinal,2,2,0);
      else
         put_line("Vous n'avez plus d'argent.");
      end if;
      new_line;
      Put_Line("Loto-UQAM: Au revoir!");
   end Termination;


   -- declaration des variables
   Montant : Float := 0.0; -- Montant d'argent que l'utilisateur possede.
   TypePari: Type_Pari; -- Le type de pari.
   MontantPari: float; -- Le montant du pari.
   Continuer: character; -- Contient la variable de la question si continuer.
   MontantResultat: float; -- Contient le montant du resultat du pari (peut etre positif ou negatif).

begin
   Initialisation(Montant); -- Initialise le programme.
   loop
      Continuer:= ada.characters.handling.To_Upper(LireCaractere("OoNn","Est-ce que vous voulez entrer un pari(O/N)?"));
      exit when (continuer ='N');
      LirePari(TypePari,MontantPari,Montant);
      EffectuerPari(TypePari,MontantPari,MontantResultat);
      Montant := Montant + MontantResultat;
      if(MontantResultat >= 0.0) then
         Put("Vous avez gagnez ");
      else
         put("vous avez perdus ");
         MontantResultat := MontantResultat * (-1.0); -- transforme le montant negatif en positif pour l'afficher.
      end if;
      ES_D_Float.put(MontantResultat,2,2,0);
      Put(". Il vous reste ");
      ES_D_Float.put(Montant,2,2,0);
      Put_line(".");
     new_line;
      exit when (Montant <= 0.0);
   end loop;
   Termination(Montant); -- termine le programme.
exception
   when others => put_Line("Exception inconnus. Fin du programme.");
end LotoUQAM;
