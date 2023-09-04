with Ada.Numerics.Discrete_Random;  

package body Tp2 is

package Aleatoire is new Ada.Numerics.Discrete_Random(Natural);
Germe : Aleatoire.Generator;

procedure InitialiserAleatoire (n : in Natural ) is
  -- initialise la sequence aleatoire.
begin
 Aleatoire.Reset(Germe, n);
end InitialiserAleatoire;

procedure lancerTroisDes ( Val_De1, Val_De2, Val_De3 : out Natural ) is
  -- Val_De1 contiendra la valeur du premier dé.
  -- Val_De2 contiendra la valeur du deuxième dé.
  -- Val_De3 contiendra la valeur du troisième dé.
begin  --lancerTroisDes
  Val_De1 := Aleatoire.Random(Germe) rem 6 + 1;
  Val_De2 := Aleatoire.Random(Germe) rem 6 + 1;
  Val_De3 := Aleatoire.Random(Germe) rem 6 + 1;
end lancerTroisDes;

end Tp2;

