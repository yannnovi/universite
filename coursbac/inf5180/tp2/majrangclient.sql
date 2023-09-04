/* $Id: majrangclient.sql,v 1.1 2005/04/30 18:53:08 Yann Exp $ */
SET echo ON
SET term ON

spool c:\majrangclient.OUT

DROP PROCEDURE majrangclient
/

CREATE PROCEDURE majrangclient(Annee DATE) IS

   NombreClient INTEGER;
   NoClient     Client.NUMERO_CLIENT%TYPE;
   somme        REAL;
   Rang         INTEGER;
   IntervalDecrement INTEGER;
   NombreLu     INTEGER;
   AncienTotalLu INTEGER;

   CURSOR  CurseurClient(Annee DATE) is
      (SELECT client.numero_client AS noclient,SUM(article.PRIX_UNITAIRE * produitcommande.quantite_commande) AS tomate
      FROM client,commande,produitcommande,article
      WHERE client.numero_client = commande.numero_client
            AND
            commande.numero_commande = produitcommande.numero_commande
            AND
            produitcommande.numero_article = article.numero_article
            AND
            TO_CHAR(commande.DATE_CREATION_COMMANDE,'YYYY') = TO_CHAR(annee,'yyyy')
      GROUP BY client.numero_client)
      UNION
      (SELECT client.numero_client AS noclient, 0.0 AS tomate
      FROM client
      WHERE client.numero_client NOT IN (SELECT client.numero_client
                                        FROM client,commande,produitcommande,article
                                        WHERE client.numero_client = commande.numero_client
                                             AND
                                             commande.numero_commande = produitcommande.numero_commande
                                             AND
                                             produitcommande.numero_article = article.numero_article
                                             AND
                                             TO_CHAR(commande.DATE_CREATION_COMMANDE,'YYYY') = TO_CHAR(annee,'yyyy')
                                         ))
      ORDER BY tomate DESC;



BEGIN
   Rang:=10;
   NombreLu:=0;
   AncienTotalLu :=0;
   OPEN CurseurClient(Annee);
   SELECT count(numero_client)
   INTO NombreClient
   FROM client;
   IF (NombreClient < 10) THEN
      IntervalDecrement:=1;
   ELSE
      IntervalDecrement:=NombreClient/10;
   END IF;
   
   DBMS_OUTPUT.put_line('==============');
   LOOP
      FETCH CurseurClient INTO NoClient,somme;

      EXIT WHEN CurseurClient%NOTFOUND;

      UPDATE client
      SET client.RANG_CLIENT = rang
      WHERE client.numero_client = NoClient;

      
      DBMS_OUTPUT.put_line('Fait client -> ' || NoClient);
      NombreLu := NombreLu + 1;
      IF((NombreLu - AncienTotalLu ) >= IntervalDecrement) THEN
         Rang:=Rang - 1;
         IF rang < 1 THEN
            rang :=1;
         END IF;
         AncienTotalLu := NombreLu;
      END IF;

   END LOOP;

   CLOSE CurseurClient;
   DBMS_OUTPUT.put_line('==============');
   DBMS_OUTPUT.put_line('Mise a jour effectue');
   
END majrangclient;
/

show errors
SPOOL OFF



