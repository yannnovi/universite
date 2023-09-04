/* $Id: create.sql,v 1.9 2004/11/03 22:49:27 Yann Exp $ */
SET echo ON
SET term ON

spool CREATE.OUT
/* Par Yann Bourdeau BOUY06097202 */

/* EFFACE LES TABLES EXISTANTES */
DROP TABLE RESULTATS;
DROP TABLE GROUPECOURS;
DROP TABLE ENSEIGNANTS;
DROP TABLE COURS;
DROP TABLE ETUDIANTS;
DROP TABLE PROGRAMMES;
DROP TABLE UTILISATEURS;
DROP TABLE DEPARTEMENTS;

/* creation de la table departement */
CREATE TABLE DEPARTEMENTS
   (
    NOM           VARCHAR(32),
    CONSTRAINT CDEPARTEMENT1 PRIMARY KEY (NOM))
/

/* creation de la table utilisateurs */
CREATE TABLE UTILISATEURS
   (
      NAS         VARCHAR(12),
      NOM         VARCHAR(24),
      PRENOM      VARCHAR(24),
      ADRESSE1    VARCHAR(24),
      ADRESSE2    VARCHAR(24),
      ADRESSE3    VARCHAR(24),
      TELEPHONE   VARCHAR(16),
      COURRIEL    VARCHAR(32),
      CONSTRAINT CUTILISATEUR1 PRIMARY KEY (NAS),
      CONSTRAINT CUTILISATEUR2 CHECK(nom IS NOT NULL
                                     AND
                                     prenom IS NOT NULL
                                     AND
                                     adresse1 IS NOT NULL
                                     AND
                                     adresse2 IS NOT NULL),
      CONSTRAINT CUTILISATEUR3 CHECK (LENGTH(TRANSLATE(courriel,'@1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM.,!#$%^&*()-_=+<>?~ ','@'))=1
                                      AND
                                      courriel LIKE '%@%.%'),
      CONSTRAINT CUTILISATEUR4 CHECK (( TRANSLATE(telephone,'0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM.,!#$%^&*()-_=+<>?~ ',
                                                            '0000000000AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA ')
                                        = '00 000 000 0000'
                                      )
                                      OR
                                      (
                                        TRANSLATE(telephone,'0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM.,!#$%^&*()-_=+<>?~ ',
                                                            '0000000000AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA ')
                                        = '000 0000'
                                      )
                                      OR
                                      (
                                        TRANSLATE(telephone,'0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM.,!#$%^&*()-_=+<>?~ ',
                                                            '0000000000AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA ')
                                        = '000 000 0000'
                                      )),
      CONSTRAINT CUTILISATEUR5 CHECK (adresse1 <> adresse2
                                      AND
                                      adresse1 <> adresse3
                                      AND
                                      adresse2 <> adresse3)
  )
/

/* creation de la table programmes */
CREATE TABLE PROGRAMMES
   (
   CODEPROGRAMME  SMALLINT,
   TITRE          VARCHAR(64),
   CONSTRAINT CPROGRAMMES1 PRIMARY KEY (CODEPROGRAMME),
   CONSTRAINT CPROGRAMMES2 CHECK (TITRE IS NOT NULL))
/

/* creation de la table etudiants */
CREATE TABLE ETUDIANTS
   (
   CODEPERMANENT VARCHAR(12),
   PROGRAMME     SMALLINT,
   NAS           VARCHAR(12),
   CONSTRAINT CETUDIANTS1 PRIMARY KEY (CODEPERMANENT),
   CONSTRAINT CETUDIANTS2 CHECK (PROGRAMME IS NOT NULL),
   CONSTRAINT CETUDIANTS3 FOREIGN KEY (PROGRAMME) REFERENCES PROGRAMMES(CODEPROGRAMME),
   CONSTRAINT CETUDIANTS4 FOREIGN KEY (NAS) REFERENCES UTILISATEURS)
/

/* creation de la table cours */
CREATE TABLE COURS
   (
   NUMERO_COURS   VARCHAR(12),
   TITRE          VARCHAR(24),
   PROGRAMME      SMALLINT,
   CONSTRAINT CCOURS1 CHECK(SUBSTR(NUMERO_COURS,1,3) = 'UQ_'
                            AND
                            SUBSTR(NUMERO_COURS,4,3) = SUBSTR(TITRE,1,3)
                            AND
                            TRANSLATE(SUBSTR(NUMERO_COURS,7,1),'0123456789','0000000000') = '0'),
   CONSTRAINT CCOURS2 CHECK (TITRE IS NOT NULL),
   CONSTRAINT CCOURS3 PRIMARY KEY (NUMERO_COURS),
   CONSTRAINT CCOURS4 FOREIGN KEY (PROGRAMME) REFERENCES PROGRAMMES(CODEPROGRAMME))
/

/* creation de la table enseignants */
CREATE TABLE ENSEIGNANTS
   (
   MATRICULE      VARCHAR(5),
   DEPARTEMENT    VARCHAR(32),
   NAS            VARCHAR(12),
   CONSTRAINT CENSEIGNANTS1 PRIMARY KEY (MATRICULE),
   CONSTRAINT CENSEIGNANTS2 CHECK(departement IS NOT NULL),
   CONSTRAINT CENSEIGNANTS3 FOREIGN KEY (DEPARTEMENT) REFERENCES DEPARTEMENTS(NOM),
   CONSTRAINT CENSEIGNANTS4 FOREIGN KEY (NAS) REFERENCES UTILISATEURS
   )
/

/* creation de la table groupecours */
CREATE TABLE GROUPECOURS
   (
   CODEGROUPECOURS   SMALLINT,
   NUMERO_COURS      VARCHAR(12),
   NUMERO_GROUPE     VARCHAR(2),
   ENSEIGNANT        VARCHAR(5),
   SESSION_C         VARCHAR(3),
   PLACES            SMALLINT,
   CONSTRAINT CGROUPECOURS1 PRIMARY KEY (CODEGROUPECOURS),
   CONSTRAINT CGROUPECOURS2 UNIQUE(NUMERO_COURS,NUMERO_GROUPE,SESSION_C),
   CONSTRAINT CGROUPECOURS3 CHECK(ENSEIGNANT IS NOT NULL),
   CONSTRAINT CGROUPECOURS4 CHECK(PLACES >= 0),
   CONSTRAINT CGROUPECOURS5 FOREIGN KEY (NUMERO_COURS) REFERENCES COURS,
   CONSTRAINT CGROUPECOURS6 FOREIGN KEY (ENSEIGNANT) REFERENCES ENSEIGNANTS(MATRICULE)
   )
/

/* creation de la table resultats */
CREATE TABLE RESULTATS
   (
    CODEGROUPECOURS  SMALLINT,
    CODEPERMANENT    VARCHAR(12),
    NOTE             VARCHAR(2) DEFAULT NULL,
    CONSTRAINT CRESULTATS1 PRIMARY KEY (CODEGROUPECOURS,CODEPERMANENT),
    CONSTRAINT CRESULTATS3 CHECK( note IN ('A','A+','A-','B','B+','B-','C','C+','C-','D','D+','D-','E')),
    CONSTRAINT CRESULTATS4 FOREIGN KEY (CODEPERMANENT) REFERENCES ETUDIANTS,
    CONSTRAINT CRESULTATS5 FOREIGN KEY (CODEGROUPECOURS) REFERENCES GROUPECOURS
    )
/
spool off 
