/* $Id: insert.sql,v 1.9 2004/11/14 16:39:22 Yann Exp $ */
SET echo ON
SET term ON

spool INSERT.OUT
/* Par Yann Bourdeau BOUY06097202 */
/* remplissage table departement */
/* Valide positivement contraintes: CDEPARTEMENT1 */
INSERT INTO DEPARTEMENTS(nom) VALUES ('INFORMATIQUE')
/
INSERT INTO DEPARTEMENTS(nom) VALUES ('MATHEMATIQUE')
/
/* remplissage table utilisateur */
/* Valide positivement contraintes: CUTILISATEUR1, CUTILISATEUR2, CUTILISATEUR3, CUTILISATEUR4, CUTILISATEUR5*/
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336752','bourdeau','yann','4790 cazelais','montreal','514 219 4607','bourdeau.yann@courrier.uqam.ca')
/
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336753','bourdeau','katia','4790 cazelais','montreal','514 937 8095','bourdeau.katia@uqam.ca')
/
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336754','bourdeau','alphonse','4790 cazelais','montreal','514 111 1111','bourdeau.alphonse@uqam.ca')
/
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336755','bourdeau','raton','4790 cazelais','montreal','514 222 2222','bourdeau.raton@uqam.ca')
/
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336756','bourdeau','tiguidou','4790 cazelais','montreal','514 333 3333','bourdeau.tiguidou@uqam.ca')
/
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336757','bourdeau','seraphin','4790 cazelais','montreal','514 444 5555','bourdeau.seraphin@uqam.ca')
/
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336758','bourdeau','louis','4790 cazelais','montreal','514 666 6666','bourdeau.louis@uqam.ca')
/
INSERT INTO UTILISATEURS(nas,nom,prenom,adresse1,adresse2,telephone,courriel) VALUES( '271336759','bourdeau','rudolphe','4790 cazelais','montreal','514 777 7777','rudolphe@uqam.ca')
/

/* remplissage table enseignant */
/* Valide positiviement contraintes: CENSEIGNATS1, CENSEIGNANTS2 */
INSERT INTO ENSEIGNANTS(matricule,departement,nas) VALUES ('45676','INFORMATIQUE','271336752')
/
INSERT INTO ENSEIGNANTS(matricule,departement,nas) VALUES ('45677','INFORMATIQUE','271336759')
/

/* remplissage table programmes */
/* Valide positivement contraintes: CPROGRAMME1, CPROGRAMME2 */
INSERT INTO PROGRAMMES(codeprogramme,titre) VALUES (7316,'Bac informatique')
/
INSERT INTO PROGRAMMES(codeprogramme,titre) VALUES (4216,'Bac gestion')
/
/* remplissage table cours */                       
/* Valide positivement contraintes: COURS1, COURS2 */
INSERT INTO COURS(numero_cours,titre,programme) VALUES ('UQ_DON0','DONNEE',7316)
/
INSERT INTO COURS(numero_cours,titre,programme) VALUES ('UQ_RES0','RESEAU',7316)
/
INSERT INTO COURS(numero_cours,titre,programme) VALUES ('UQ_COU0','COURS',7316)
/
INSERT INTO COURS(numero_cours,titre,programme) VALUES ('UQ_COU1','COURS',7316)
/
INSERT INTO COURS(numero_cours,titre,programme) VALUES ('UQ_COU2','COURS',7316)
/
INSERT INTO COURS(numero_cours,titre,programme) VALUES ('UQ_COU3','COURS',7316)
/
INSERT INTO COURS(numero_cours,titre,programme) VALUES ('UQ_COU4','COURS',7316)
/
INSERT INTO COURS(numero_cours,titre,programme) VALUES ('UQ_COU5','COURS',7316)
/
INSERT INTO COURS(numero_cours,titre,programme) VALUES ('UQ_COU6','COURS',7316)
/
INSERT INTO COURS(numero_cours,titre,programme) VALUES ('UQ_COU7','COURS',7316)
/
INSERT INTO COURS(numero_cours,titre,programme) VALUES ('UQ_COU8','COURS',7316)
/

/* remplissage table groupecours */
/* Valide positivement contraintes: CGROUPECOURS1,CGROUPECOURS2,CGROUPECOURS3,CGROUPECOURS4 */
INSERT INTO GROUPECOURS(codegroupecours,numero_cours,numero_groupe,enseignant,session_c,places) VALUES (4270,'UQ_RES0','50','45676','E04',10)
/
INSERT INTO GROUPECOURS(codegroupecours,numero_cours,numero_groupe,enseignant,session_c,places) VALUES (3180,'UQ_DON0','50','45676','H04',10)
/
INSERT INTO GROUPECOURS(codegroupecours,numero_cours,numero_groupe,enseignant,session_c,places) VALUES (3300,'UQ_COU0','50','45676','A04',10)
/
INSERT INTO GROUPECOURS(codegroupecours,numero_cours,numero_groupe,enseignant,session_c,places) VALUES (3310,'UQ_COU1','10','45676','H04',10)
/
INSERT INTO GROUPECOURS(codegroupecours,numero_cours,numero_groupe,enseignant,session_c,places) VALUES (3320,'UQ_COU2','20','45676','H04',10)
/
INSERT INTO GROUPECOURS(codegroupecours,numero_cours,numero_groupe,enseignant,session_c,places) VALUES (3330,'UQ_COU3','30','45676','H04',10)
/
INSERT INTO GROUPECOURS(codegroupecours,numero_cours,numero_groupe,enseignant,session_c,places) VALUES (3340,'UQ_COU4','40','45676','H04',10)
/
INSERT INTO GROUPECOURS(codegroupecours,numero_cours,numero_groupe,enseignant,session_c,places) VALUES (3350,'UQ_COU5','60','45676','H04',10)
/
INSERT INTO GROUPECOURS(codegroupecours,numero_cours,numero_groupe,enseignant,session_c,places) VALUES (3360,'UQ_COU6','70','45676','H04',10)
/
INSERT INTO GROUPECOURS(codegroupecours,numero_cours,numero_groupe,enseignant,session_c,places) VALUES (3370,'UQ_COU7','80','45676','H04',10)
/
INSERT INTO GROUPECOURS(codegroupecours,numero_cours,numero_groupe,enseignant,session_c,places) VALUES (3380,'UQ_COU8','90','45676','H04',10)
/
INSERT INTO GROUPECOURS(codegroupecours,numero_cours,numero_groupe,enseignant,session_c,places) VALUES (3381,'UQ_COU8','95','45677','H04',10)
/

/* remplissage table etudiants */
/* Valide positivement contraintes: CETUDIANTS1, CETUDIANTS2 */
INSERT INTO ETUDIANTS(codepermanent,programme,nas) VALUES ('BOUY06097202',7316,'271336752')
/
INSERT INTO ETUDIANTS(codepermanent,programme,nas) VALUES ('BOUY06097203',7316,'271336754')
/
INSERT INTO ETUDIANTS(codepermanent,programme,nas) VALUES ('BOUY06097204',7316,'271336755')
/
INSERT INTO ETUDIANTS(codepermanent,programme,nas) VALUES ('BOUY06097205',7316,'271336756')
/
INSERT INTO ETUDIANTS(codepermanent,programme,nas) VALUES ('BOUY06097206',7316,'271336757')
/
INSERT INTO ETUDIANTS(codepermanent,programme,nas) VALUES ('BOUY06097207',7316,'271336758')
/

/* remplissage table resultats */
/* Valide positivement contraintes: CRESULTATS1,CRESULTATS2, CRESULTATS3 */   
INSERT INTO RESULTATS(codegroupecours,codepermanent,note) VALUES (4270,'BOUY06097202','A+')
/
INSERT INTO RESULTATS(codegroupecours,codepermanent,note) VALUES (4270,'BOUY06097204','B+')
/
INSERT INTO RESULTATS(codegroupecours,codepermanent,note) VALUES (4270,'BOUY06097205','C+')
/
INSERT INTO RESULTATS(codegroupecours,codepermanent,note) VALUES (4270,'BOUY06097206','D+')
/
INSERT INTO RESULTATS(codegroupecours,codepermanent,note) VALUES (4270,'BOUY06097207','B+')
/
INSERT INTO RESULTATS(codegroupecours,codepermanent,note) VALUES (3180,'BOUY06097202','D')
/
INSERT INTO RESULTATS(codegroupecours,codepermanent,note) VALUES (3180,'BOUY06097204','B+')
/
INSERT INTO RESULTATS(codegroupecours,codepermanent,note) VALUES (3180,'BOUY06097205','C+')
/
INSERT INTO RESULTATS(codegroupecours,codepermanent,note) VALUES (3180,'BOUY06097206','D+')
/
INSERT INTO RESULTATS(codegroupecours,codepermanent,note) VALUES (3180,'BOUY06097207','B+')
/
INSERT INTO RESULTATS(codegroupecours,codepermanent,note) VALUES (3300,'BOUY06097202','C')
/
INSERT INTO RESULTATS(codegroupecours,codepermanent,note) VALUES (3300,'BOUY06097204','B+')
/
INSERT INTO RESULTATS(codegroupecours,codepermanent,note) VALUES (3300,'BOUY06097205','C+')
/
INSERT INTO RESULTATS(codegroupecours,codepermanent,note) VALUES (3300,'BOUY06097206','D+')
/
INSERT INTO RESULTATS(codegroupecours,codepermanent,note) VALUES (3300,'BOUY06097207','B+')
/


COMMIT
/
spool off 
