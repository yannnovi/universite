/* $Id: vues.sql,v 1.9 2004/11/11 03:22:48 Yann Exp $ */
SET echo ON
SET term ON

spool VUES.OUT
/* Par Yann Bourdeau BOUY06097202  */

/* efface les vues existantes */
DROP VIEW RELEVE_DE_NOTES
/
DROP VIEW BILAN_COURS
/
DROP VIEW PROGRAMMES_UNIVERSITE
/
/* creation de la vue RELEVE_DE_NOTES */
CREATE VIEW RELEVE_DE_NOTES AS
   SELECT SYSDATE AS "DATE",u.nom,u.prenom,e.codepermanent,u.adresse1,c.numero_cours,c.titre,DECODE(MAX(DECODE(r2.note,'A+',4.3,'A-',3.7,'A',4.0,'B+',3.3,'B',3.0,'B-',2.7,'C+',2.3,'C',2.0,'C-',1.7,'D+',1.3,'D',1.0)),4.3,'A+',4.0,'A',3.7,'A-',3.3,'B+',3.0,'B',2.7,'B-',2.3,'C+',2.0,'C',1.7,'C-',1.3,'D+',1.0,'D') AS "meilleure note",r.note AS note 
   FROM utilisateurs u ,etudiants e,cours c, resultats r, groupecours g,resultats r2
   WHERE u.nas=e.nas
         AND
         e.codepermanent = r.codepermanent
         AND
         r.codegroupecours = g.codegroupecours
         AND
         g.numero_cours = c.numero_cours
         AND
         r2.codegroupecours = r.codegroupecours
   GROUP BY SYSDATE,u.nom,u.prenom,e.codepermanent,u.adresse1,c.numero_cours,c.titre,r.note
   ORDER BY u.nom,u.prenom
/
/* execution de la vue RELEVE_DE_NOTES */
SELECT * FROM RELEVE_DE_NOTES
/
/* creation de la vue BILAN_COURS */
CREATE VIEW BILAN_COURS AS
SELECT SUBSTR(g.session_c,2,2) AS "Annee",DECODE(SUBSTR(g.session_c,1,1),'A','Automne','H','Hiver','E','Ete') AS "Session"
       ,e.DEPARTEMENT,p.codeprogramme,p.titre AS "Titre Departement",c.numero_cours,c.titre AS "Titre cours"
       ,u.nom,u.prenom,COUNT(DISTINCT et.codepermanent) AS "NB Etudiants"
FROM groupecours g, enseignants e,utilisateurs u, cours c,programmes p,etudiants et
WHERE u.NAS = e.NAS
      AND
      g.enseignant = e.matricule
      AND
      g.numero_cours = c.numero_cours
      AND
      p.codeprogramme= c.programme
      AND
      et.programme = p.codeprogramme
GROUP BY g.session_c,e.departement,p.codeprogramme,p.titre,c.numero_cours,c.titre,u.nom,u.prenom
/
/* creation de la vue BILAN_COURS */
SELECT * FROM BILAN_COURS
/
/* creation de la vue PROGRAMMES_UNIVERSITE */
CREATE VIEW PROGRAMMES_UNIVERSITE AS 
   SELECT p.codeprogramme,c.numero_cours,count(e.matricule) AS "Nombre enseignants"
   FROM programmes p, cours c,groupecours g, enseignants e
   WHERE c.programme = p.codeprogramme
         AND
         g.numero_cours = c.numero_cours
         AND
         e.matricule = g.enseignant
   GROUP BY p.codeprogramme,c.numero_cours
/
/* execution de la vue PROGRAMMES_UNIVERSITE */
SELECT * FROM PROGRAMMES_UNIVERSITE
/
spool off 
