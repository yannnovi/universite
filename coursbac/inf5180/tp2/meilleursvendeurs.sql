/* $Id: meilleursvendeurs.sql,v 1.5 2005/04/30 23:55:51 Yann Exp $ */
SET echo ON
SET term ON

spool c:\meilleursvendeurs.OUT

DROP PROCEDURE meilleursvendeurs
/

CREATE PROCEDURE meilleursvendeurs IS
  DateCourante       DATE;
  DateIndex          DATE;
  DateFin            DATE;
  CompteurLigne      INTEGER;
  Jour               INTEGER;
  NbJour             INTEGER;
  CURSOR  CurseurArticle(DateLundi DATE,DateFin DATE) is
      select article.numero_article,SUM(produitcommande.quantite_commande) AS quant
      from article,produitcommande,commande
      where article.numero_article = produitcommande.numero_article
            AND
            commande.numero_commande = produitcommande.numero_commande
            AND
            commande.DATE_CREATION_COMMANDE >= DateLundi
            AND
            commande.DATE_CREATION_COMMANDE <= DateFin
      group by article.numero_article;

BEGIN

   dbms_output.enable(1000000);  

   SELECT SYSDATE
   INTO DateCourante
   FROM DUAL;
                                            
   DateIndex := TO_DATE('01-01' || TO_CHAR(DateCourante,'YYYY'),'MM-DD-YYYY');
   while (TO_CHAR(DateIndex,'DDD') < 365 ) LOOP 
       DateIndex := TO_DATE(TO_CHAR(DateIndex,'DDD')+1,'DDD');
       IF (TO_CHAR(DateIndex,'D') = '2') THEN
          DBMS_OUTPUT.put_line('==============');
          DBMS_OUTPUT.put_line('Semaine du ' || TO_CHAR(DateIndex,'DD-MM-YY')); 
          DBMS_OUTPUT.put_line('no article, quantite');            
          CompteurLigne := 0;
          Jour := TO_CHAR(DateIndex,'DDD');

          IF ((Jour + 6) > 365) THEN
            NbJour := 365-Jour;
          ELSE
             NbJour := 6;
          END IF;
          DateFin := DateIndex;
          DateFin := TO_DATE((TO_CHAR(DateIndex,'DDD')+NbJour),'DDD');
          FOR uneLigne IN CurseurArticle(DateIndex,DateFin) LOOP
            DBMS_OUTPUT.put_line(uneLigne.numero_article || ' ' || uneLigne.quant);
            CompteurLigne:=CompteurLigne + 1 ;
            IF (CompteurLigne >4) THEN
               EXIT;
            END IF;
          END LOOP;

       END IF;
   END LOOP;
   
END meilleursvendeurs;
/

show errors
SPOOL OFF


