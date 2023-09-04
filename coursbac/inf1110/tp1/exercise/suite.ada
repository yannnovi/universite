-- $Id: suite.ada,v 1.1 2003/07/15 15:05:27 yann Exp $       
with Ada.Text_IO;           use Ada.Text_IO;
-- allo a toute la famille. test2
procedure Suite is
-- Instanciation des paquetages génériques
package      ES_D_Entiers is new Integer_IO(integer);

-- Déclaration des variables.
NombreBase : integer := 0;
NombreCourant: integer := 0;
NumNombre,NumSup,NumInf,NumEg,NumPair,NumImpair,NumPos,NumNeg : integer := 0;
begin
    put("bonjour!");
    new_line;
    put("Entrez un nombre:");
    ES_D_Entiers.get(NombreBase);
    new_line;
    skip_line;
   loop
      put("Entrez un nombre de la serie:");
        ES_D_Entiers.get(NombreCourant);
        new_line;
        skip_line;
        
        exit when NombreCourant = 0;
        
        NumNombre := NumNombre + 1;
        
        if(NombreCourant > NombreBase)then
            NumSup:= NumSup +1;
        elsif (NombreCourant < NombreBase)then
         NumInf := NumInf + 1;
        else
            NumPair := NumPair + 1;
        end if;
            
        if (NombreCourant mod 2 = 0) then
            NumPair := NumPair + 1;
        else
            NumImpair:= NumImpair + 1;
        end if;
        if (NombreCourant > 0 )then
            NumPos := NumPos +1;
        else
            NumNeg := NumNeg + 1;
        end if;            
    end loop;        

put("Nombre de nombre:");
ES_D_Entiers.put(NumNombre);
new_line;
put("Nombre de nombre superieur:");
ES_D_Entiers.put(NumSup);
new_line;
put("Nombre de nombre inferieur:");
ES_D_Entiers.put(NumInf);
new_line;
put("Nombre de nombre egaux:");
ES_D_Entiers.put(NumEg);
new_line;
put("Nombre de nombre pair:");
ES_D_Entiers.put(NumPair);
new_line;
put("Nombre de nombre impair:");
ES_D_Entiers.put(NumImpair);
new_line;
put("Nombre de nombre positif:");
ES_D_Entiers.put(NumPos);
new_line;
put("Nombre de nombre negatif:");
ES_D_Entiers.put(NumNeg);
new_line;
    
exception
    when Data_error   =>
        Put("erreur de saisie de données");
end Suite;
    

