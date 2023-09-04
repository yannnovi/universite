/* $Id: test.sql,v 1.6 2004/11/03 22:49:27 Yann Exp $ */
SET echo ON
SET term ON

spool TEST.OUT
/* Par Yann Bourdeau BOUY06097202 */
/******************************************/
/* Assume que insert.sql a ete fait avant */
/******************************************/
/* test table enseignant */
/* contrainte 1 CENSEIGNANTS1 */
INSERT INTO ENSEIGNANTS(matricule,departement,nas) VALUES ('45676','INFORMATIQUE','271336752')
/
/* contraite 2 CENSEIGNANTS2 */
INSERT INTO ENSEIGNANTS(matricule,departement,nas) VALUES ('45676',NULL,'271336752')
/
/* test table utilisateur */
/* contrainte 1 CUTILISATEUR1 */
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336752','bourdeau','yann','4790 cazelais','montreal','514 219 4607','bourdeau.yann@courrier.uqam.ca')
/
/* contrainte 2 CUTILISATEUR2 */
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336754',NULL,'yann','4790 cazelais','montreal','514 219 4607','bourdeau.yann@courrier.uqam.ca')
/
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336754','bourdeau',NULL,'4790 cazelais','montreal','514 219 4607','bourdeau.yann@courrier.uqam.ca')
/
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336754','bourdeau','yann',NULL,'montreal','514 219 4607','bourdeau.yann@courrier.uqam.ca')
/
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336754','bourdeau','yann','4790 cazelais',NULL,'514 219 4607','bourdeau.yann@courrier.uqam.ca')
/
/* contrainte 3 CUTILISATEUR3 */
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336754','bourdeau','yann','4790 cazelais','montreal','514 219 4607','bourdeau.yann@@courrier.uqam.ca')
/
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336754','bourdeau','yann','4790 cazelais','montreal','514 219 4607','yann@courrier')
/
/* contrainte 4 CUTILISATEUR4 */
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336754','bourdeau','yann','4790 cazelais','montreal','51 219 4607','bourdeau.yann@courrier.uqam.ca')
/
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336754','bourdeau','yann','4790 cazelais','montreal','4607','bourdeau.yann@courrier.uqam.ca')
/
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336754','bourdeau','yann','4790 cazelais','montreal','450 4A07','bourdeau.yann@courrier.uqam.ca')
/
/* contrainte 5 CUTILISATEUR5 */
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,adresse3,telephone,courriel) VALUES( '271336754','bourdeau','katia','adresse1','adresse1','adresse1','514 937 8095','bourdeau.katia@courrier.uqam.ca')
/
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,adresse3,telephone,courriel) VALUES( '271336754','bourdeau','katia','adresse1','adresse2','adresse1','514 937 8095','bourdeau.katia@courrier.uqam.ca')
/
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,adresse3,telephone,courriel) VALUES( '271336754','bourdeau','katia','adresse1','adresse1','adresse2','514 937 8095','bourdeau.katia@courrier.uqam.ca')
/
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,adresse3,telephone,courriel) VALUES( '271336754','bourdeau','katia','adresse2','adresse1','adresse1','514 937 8095','bourdeau.katia@courrier.uqam.ca')
/
/* test table departements*/
/* contrainte 1 CDEPARTEMENT1 */
INSERT INTO DEPARTEMENTS(nom) VALUES ('INFORMATIQUE')
/
/* test table cours */
/* contrainte 1 CCOURS1*/
INSERT INTO COURS(numero_cours,titre,programme) VALUES ('AA_RES0','RESEAU',7316)
/
INSERT INTO COURS(numero_cours,titre,programme) VALUES ('UQ_REA0','RESEAU',7316)
/                                                                               
INSERT INTO COURS(numero_cours,titre,programme) VALUES ('UQ_RESA','RESEAU',7316)
/
/* contrainte 2 CCOURS2*/
INSERT INTO COURS(numero_cours,titre,programme) VALUES ('UQ_RES0',NULL,7316)
/
/* test table groupecours */
/* contrainte 1 CGROUPECOURS1 */
INSERT INTO GROUPECOURS(codegroupecours,numero_cours,numero_groupe,enseignant,session_c,places) VALUES (4270,'UQ_RES0','50','45676','ETE',10)
/
/* contrainte 2 CGROUPECOURS2 */
INSERT INTO GROUPECOURS(codegroupecours,numero_cours,numero_groupe,enseignant,session_c,places) VALUES (4271,'UQ_RES0','50','45676','ETE',10)
/
/* contrainte 3 CGROUPECOURS3 */
INSERT INTO GROUPECOURS(codegroupecours,numero_cours,numero_groupe,enseignant,session_c,places) VALUES (4272,'UQ_RES1','50',NULL,'ETE',10)
/
/* contrainte 4 CGROUPECOURS4 */
INSERT INTO GROUPECOURS(codegroupecours,numero_cours,numero_groupe,enseignant,session_c,places) VALUES (4272,'UQ_RES1','50','45676','ETE',-1)
/
/* test table programmes */
/* contrainte 1 CPROGRAMMES1 */
INSERT INTO PROGRAMMES(codeprogramme,titre) VALUES (4216,'Bac gestion')
/
/* contrainte 2 CPROGRAMMES2 */
INSERT INTO PROGRAMMES(codeprogramme,titre) VALUES (4516,NULL)
/
/* test table etudiants */
/* contrainte 1 CETUDIANTS1 */
INSERT INTO ETUDIANTS(codepermanent,programme,nas) VALUES ('BOUY06097202',7316,'271336752')
/
/* contrainte 2 CETUDIANTS2 */
INSERT INTO ETUDIANTS(codepermanent,programme,nas) VALUES ('BOUY06097202',NULL,'271336752')
/
/* test table resultat */
/* contrainte 1 CRESULTATS1 */
INSERT INTO RESULTATS(codegroupecours,codepermanent) VALUES (4270,'BOUY06097202')
/
/* contrainte 2 CRESULTATS2 */
INSERT INTO RESULTATS(codegroupecours,codepermanent) VALUES (3180,'BOUY06097202')
/
/* contrainte 3 CRESULTATS3 */
INSERT INTO RESULTATS(codegroupecours,codepermanent,note) VALUES (3180,'BOUY06097202','V')
/

spool off 
