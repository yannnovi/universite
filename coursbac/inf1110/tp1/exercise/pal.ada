-- $Id: pal.ada,v 1.1 2003/07/15 15:05:27 yann Exp $       
with Ada.Text_IO;           use Ada.Text_IO;
procedure Palin is
-- Instanciation des paquetages génériques
package      ES_D_Entiers is new Integer_IO(integer);

-- Déclaration des variables.
Nombre : integer := 0;
Chif1, Chif2, Chif3, Chif4: integer :=0;
begin
	Put("Trouveur de palindrome!");    
    New_Line;
    loop
    	Put("Entrez un nombre:");
		ES_D_Entiers.Get(Nombre);
        Skip_Line;
        New_Line;
        exit when ((Nombre >= 10000) and (Nombre <= 99999));
        Put ("Nombre invalide!");
        New_Line;
    end loop;
    --- Extraire_Chiffre(N)---- 
    Chif1 := Nombre /10000;
    Chif2 := (Nombre/1000) mod 10;
    Chif3 := (Nombre/10) mod 10;
    Chif4 := Nombre mod 10;
    
    if((Chif1 = Chif4) and (chif2 =chif3)) then
        Put("Le nombre est un palindrome!");
    else
        Put("Le nombre n'est pas un palindrome!");
	end if;

        
        
exception
    when Data_error   =>
        Put("erreur de saisie de données");
end Palin;
    
