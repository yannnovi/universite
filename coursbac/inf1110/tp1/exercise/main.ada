-- Ce programme détermine le plus petit et plus grand nombre d'une série de trois nombre
--
-- Auteur: Yann Bourdeau
-- $Id: main.ada,v 1.1 2003/07/15 15:05:27 yann Exp $       
with Ada.Text_IO;           use Ada.Text_IO;
procedure toto is
   	-- Instanciation des paquetages génériques
    package      ES_D_Entiers is new Integer_IO(integer);
    
    -- déclaration des variables
    Nb1, Nb2, Nb3, LePlusGrand,LePlusPetit: integer := 0;
    
begin
    -- Introduction
    put("Programme qui détermine le plus grand,plus petit, la moyenne et la somme d'une série de trois nombres.");
    New_line(3);                                     
	
    -- Entrée des données
    put("Entrez le premier nombre:");
    ES_D_Entiers.Get(Nb1);
    Skip_Line;
    New_Line;
    LePlusGrand:=Nb1;
    LePlusPetit:=Nb1;
    
    put("Entrez le deuxieme nombre:");
    ES_D_Entiers.Get(Nb2);   
    Skip_Line;
    New_Line;
    if ( LePlusGrand<Nb2) then
        LePlusGrand:=Nb2;
    end if;
    if (LePlusPetit> Nb2) then
        LePlusPetit:=Nb2;
    end if;
    
    put("Entrez le troisieme nombre:");
    ES_D_Entiers.Get(Nb3);   
    Skip_Line;
    New_Line;
    
    if ( LePlusGrand<Nb3) then
        LePlusGrand:=Nb3;
    end if;
    if (LePlusPetit> Nb3) then
        LePlusPetit:=Nb3;
    end if;
    
    put("le plus grand nombre:");
    ES_D_Entiers.Put(LePlusGrand);
    New_Line;
    
    put("le plus petit nombre:");
    ES_D_Entiers.Put(LePlusPetit);
    New_Line;
    
    put("La somme:");
    ES_D_Entiers.Put(Nb1+Nb2+Nb3);
    New_Line;
        
    put("Le multiple:");
    ES_D_Entiers.Put(Nb1*Nb2*Nb3);
    New_Line;
    
exception
    when Data_error =>
    Put("erreur de saisie de données.");
        
end  toto;
    
