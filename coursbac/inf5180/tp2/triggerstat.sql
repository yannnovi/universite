/* $Id: triggerstat.sql,v 1.4 2005/04/29 17:56:35 Yann Exp $ */
SET echo ON
SET term ON

spool c:\TRIGGER.OUT

DROP TRIGGER AjoutGlobalClient;
/

DROP TRIGGER AjoutStatGlobalCompteur;
/

DROP TRIGGER AjoutStatGlobalSomme;
/

DROP TRIGGER AjoutStatAnneeClient;
/

DROP TRIGGER AjoutStatAnneeSomme;
/


CREATE TRIGGER AjoutGlobalClient
AFTER INSERT ON client
REFERENCING NEW AS crap
FOR EACH ROW
BEGIN
   INSERT INTO STATISTIQUEGLOBAL VALUES(:crap.numero_client,0,0.0);
END;
/
show errors

CREATE TRIGGER AjoutStatGlobalCompteur
AFTER INSERT ON COMMANDE
REFERENCING NEW AS ligneapres
FOR EACH ROW
BEGIN
   UPDATE STATISTIQUEGLOBAL
   SET NOMBRE_COMMANDE_GLOBAL = NOMBRE_COMMANDE_GLOBAL + 1
   WHERE NUMERO_CLIENT = :ligneapres.NUMERO_CLIENT;
END;
/
show errors

CREATE TRIGGER AjoutStatGlobalSomme
AFTER INSERT ON PRODUITCOMMANDE
REFERENCING NEW AS ligneapres
FOR EACH ROW
DECLARE
facture REAL;
BEGIN
   SELECT (:ligneapres.QUANTITE_COMMANDE * prix_unitaire )
   INTO facture
   FROM article
   WHERE numero_article = :ligneapres.numero_article;

   UPDATE STATISTIQUEGLOBAL
   SET SOMME_COMMANDE_GLOBAL = somme_commande_global + facture
   WHERE NUMERO_CLIENT = (SELECT commande.numero_client
                          FROM commande
                          WHERE commande.numero_commande = :ligneapres.numero_commande);
END;
/
show errors

CREATE TRIGGER AjoutStatAnneeClient
AFTER INSERT ON COMMANDE
REFERENCING NEW AS ligneapres
FOR EACH ROW
DECLARE
nombreclient INTEGER;
BEGIN
   SELECT count(numero_client)
   INTO nombreclient
   FROM STATISTIQUEANNEE
   WHERE STATISTIQUEANNEE.numero_client = :ligneapres.numero_client
         AND 
         TO_CHAR(ANNEE,'YYYY') =  TO_CHAR(:ligneapres.DATE_CREATION_COMMANDE,'YYYY');

   IF (0 = nombreclient) THEN
      INSERT INTO STATISTIQUEANNEE VALUES(:ligneapres.numero_client,0,0.0,TO_DATE(TO_CHAR(:ligneapres.DATE_CREATION_COMMANDE,'YYYY'),'YYYY'));
   END IF;

   UPDATE STATISTIQUEANNEE
   SET NOMBRE_COMMANDE = NOMBRE_COMMANDE + 1
   WHERE NUMERO_CLIENT = :ligneapres.NUMERO_CLIENT
         AND
         TO_CHAR(annee,'YYYY') = TO_CHAR(:ligneapres.DATE_CREATION_COMMANDE,'YYYY');

END;
/
show errors

CREATE TRIGGER AjoutStatAnneeSomme
AFTER INSERT ON PRODUITCOMMANDE
REFERENCING NEW AS ligneapres
FOR EACH ROW
DECLARE
facture REAL;
BEGIN
   SELECT (:ligneapres.QUANTITE_COMMANDE * prix_unitaire )
   INTO facture
   FROM article
   WHERE numero_article = :ligneapres.numero_article;

   UPDATE STATISTIQUEANNEE
   SET SOMME = somme + facture
   WHERE NUMERO_CLIENT = (SELECT commande.numero_client
                          FROM commande
                          WHERE commande.numero_commande = :ligneapres.numero_commande)
         AND
         TO_CHAR(ANNEE,'YYYY') =(SELECT TO_CHAR(commande.DATE_CREATION_COMMANDE,'YYYY')
                                FROM commande
                                WHERE commande.numero_commande = :ligneapres.numero_commande);
END;
/
show errors
SPOOL OFF
