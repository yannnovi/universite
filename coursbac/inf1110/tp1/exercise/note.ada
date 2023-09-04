--$Id: note.ada,v 1.1 2003/07/15 15:05:27 yann Exp $
with Ada.Text_IO;           use Ada.Text_IO;
procedure Note is
                
-- Instanciation des paquetages génériques
package      ES_D_Float is new Float_IO(float);

-- Declarations des variables
TP1,TP2,TP3,Intra,Final : float := 0.0;
ResultatTP,ResultatExam: float :=0.0;

begin
	put("Boujour!");
    new_line;
    put("entrez la note du TP1:");
    ES_D_Float.get(TP1);
    new_line;
    Skip_line;
    put("entrez la note du TP2:");
    ES_D_Float.get(TP2);
    new_line;
    Skip_line;
    put("entrez la note du TP3:");
    ES_D_Float.get(TP3);
    new_line;
    Skip_line;
    put("entrez la note de l'examen intra:");
    ES_D_Float.get(Intra);
    new_line;
    Skip_line;
    put("entrez la note du l'examen final:");
    ES_D_Float.get(Final);
    new_line;
    Skip_line;
    ResultatTP:= (TP1* 0.15) + ( TP2 * 0.15) + (TP3 * 0.20);
    ResultatExam := (Intra * 0.25)  + (Final * 0.25);
    put("Resultat TP:");
    ES_D_Float.put(ResultatTP,2,2,0);
    New_line;
    put("Resultat exam:");
    ES_D_Float.put(ResultatExam,2,2,0);
    New_line;
    Put("Resultat :");
    ES_D_Float.put(ResultatTP + ResultatExam,2,2,0);
    New_line;
    if((ResultatTP > 50.0) and (ResultatExam > 50.0)) then
        put("Vouz avez reussis inf1110");
    else
        put("Vous avez echouez inf1110");
    end if;
end Note;    
    
                                                     
