------------------------------------------------------------------------------
--$Id: lecture.ads,v 1.1 2003/07/16 01:40:46 yann Exp $
------------------------------------------------------------------------------
-- Module qui fait une gestion evolue des entrees sortie au clavier.
--
-- Auteur: Yann Bourdeau
-- Courriel: bourdeau.yann@courrier.uqam.ca
-- cours: INF2110-10
------------------------------------------------------------------------------

PACKAGE lecture is

   ------------------------------------------------------------------------------
   -- Lis un caractere et fait la validation du caractere a partir d'une chaine
   -- de caractere.
   -- Parametre: in: ListeCaractere: Liste des caractere valide.
   -- Parametre: in: Question: Question qui est pose a l'usager.
   -- retourne: character: Le caractere lus.
   ------------------------------------------------------------------------------
   function LireCaractere(ListeCaracteres: in String; Question: in string) return character;
   
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
   FUNCTION LireChaine(Filtre: in String;Question: in String) return String;

   ------------------------------------------------------------------------------                                                                              
   -- Lis un nombre positif sur la ligne de commande.
   -- Parametre: Question (IN): Question qui est pose a l'usager.
   -- retourne: positive: nombre lus sur la ligne de commande.
   ------------------------------------------------------------------------------                                                                              
   function LirePositive(Question: in String) return Positive;

   ------------------------------------------------------------------------------                                                                              
   -- Cette procedure attends apres une touche
   ------------------------------------------------------------------------------                                                                              
   PROCEDURE AttendreTouche;

   
end lecture;   
