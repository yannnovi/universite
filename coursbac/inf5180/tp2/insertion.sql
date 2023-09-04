/*INSERTION*/
SET echo ON
SET term ON
SET SERVEROUTPUT ON
/* $Id: insertion.sql,v 1.11 2005/05/04 13:51:07 Yann Exp $ */
spool c:\insertion.OUT

/* insertion dans la table compagnie*/
INSERT INTO compagnie(numero_compagnie, nom_compagnie) VALUES (34,'videotron') 
/
INSERT INTO compagnie(numero_compagnie, nom_compagnie) VALUES (37,'bell') 
/
INSERT INTO compagnie(numero_compagnie, nom_compagnie) VALUES (69,'algorithm') 
/
INSERT INTO compagnie(numero_compagnie, nom_compagnie) VALUES (55,'sony') 
/
INSERT INTO compagnie(numero_compagnie, nom_compagnie) VALUES (10,'lafleur') 
/

/* insertion dans la table fournisseur*/
INSERT INTO fournisseur(numero_fournisseur, nom_fournisseur) VALUES (1,'bic') 
/
INSERT INTO fournisseur(numero_fournisseur, nom_fournisseur) VALUES (2,'pilot') 
/
INSERT INTO fournisseur(numero_fournisseur, nom_fournisseur) VALUES (3,'sanford') 
/
INSERT INTO fournisseur(numero_fournisseur, nom_fournisseur) VALUES (4,'pentel') 
/

/* insertion dans la table client*/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (1,'aef1ww',TO_DATE('2005/05/05','yyyy/mm/dd'),'goyer','francis','goyer.francis@videotron.ca','1234rueaaaa','i',1,34) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (2,'aaaaaa',TO_DATE('2005/05/05','yyyy/mm/dd'),'goyer','pierre','goyer.pierre@videotron.ca','4321rueaaaa','c',3,37) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (3,'bbbbbb',TO_DATE('2005/05/05','yyyy/mm/dd'),'massicotte','julie','massicottej@videotron.ca','1234ruezzzz','i',4,69) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (4,'cccccc',TO_DATE('2005/05/05','yyyy/mm/dd'),'bourdeau','yann','bourdeau.yann@courrier.uqam.ca','1234sssa','i',5,55) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (5,'ddddcc',TO_DATE('2005/05/05','yyyy/mm/dd'),'lamothe','roger','roger.lamothe@gmail.com','1234sssa','i',6,NULL) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (6,'ddddcc',TO_DATE('2005/05/05','yyyy/mm/dd'),'1','1','roger.lamothe@gmail.com','1234sssa','i',6,NULL) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (7,'ddddcc',TO_DATE('2005/05/05','yyyy/mm/dd'),'2','2','roger.lamothe@gmail.com','1234sssa','i',6,NULL) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (8,'ddddcc',TO_DATE('2005/05/05','yyyy/mm/dd'),'3','3','roger.lamothe@gmail.com','1234sssa','i',6,NULL) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (9,'ddddcc',TO_DATE('2005/05/05','yyyy/mm/dd'),'4','4','roger.lamothe@gmail.com','1234sssa','i',6,NULL) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (10,'ddddcc',TO_DATE('2005/05/05','yyyy/mm/dd'),'5','5','roger.lamothe@gmail.com','1234sssa','i',6,NULL) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (11,'ddddcc',TO_DATE('2005/05/05','yyyy/mm/dd'),'6','6','roger.lamothe@gmail.com','1234sssa','i',6,NULL) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (12,'ddddcc',TO_DATE('2005/05/05','yyyy/mm/dd'),'7','7','roger.lamothe@gmail.com','1234sssa','i',6,NULL) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (13,'ddddcc',TO_DATE('2005/05/05','yyyy/mm/dd'),'8','8','roger.lamothe@gmail.com','1234sssa','i',6,NULL) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (14,'ddddcc',TO_DATE('2005/05/05','yyyy/mm/dd'),'9','9','roger.lamothe@gmail.com','1234sssa','i',6,NULL) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (15,'ddddcc',TO_DATE('2005/05/05','yyyy/mm/dd'),'11','11','roger.lamothe@gmail.com','1234sssa','i',6,NULL) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (16,'ddddcc',TO_DATE('2005/05/05','yyyy/mm/dd'),'12','12','roger.lamothe@gmail.com','1234sssa','i',6,NULL) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (17,'ddddcc',TO_DATE('2005/05/05','yyyy/mm/dd'),'13','13','roger.lamothe@gmail.com','1234sssa','i',6,NULL) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (18,'ddddcc',TO_DATE('2005/05/05','yyyy/mm/dd'),'14','14','roger.lamothe@gmail.com','1234sssa','i',6,NULL) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (19,'ddddcc',TO_DATE('2005/05/05','yyyy/mm/dd'),'15','15','roger.lamothe@gmail.com','1234sssa','i',6,NULL) 
/
INSERT INTO client(numero_client, mot_passe_client, date_inscription, nom_client, prenom_client, courriel_client, adresse_livraison, typeclient, rang_client, numero_compagnie) VALUES (20,'ddddcc',TO_DATE('2005/05/05','yyyy/mm/dd'),'16','16','roger.lamothe@gmail.com','1234sssa','i',6,NULL) 
/

/* insertion dans la table categorie*/
INSERT INTO categorie(code_categorie, libelle_categorie, categorie_parent) VALUES (1,'crayon',1) 
/
INSERT INTO categorie(code_categorie, libelle_categorie, categorie_parent) VALUES (2,'plume',1) 
/
INSERT INTO categorie(code_categorie, libelle_categorie, categorie_parent) VALUES (3,'efface',3) 
/
INSERT INTO categorie(code_categorie, libelle_categorie, categorie_parent) VALUES (4,'marker',4) 
/

/* insertion dans la table article*/
INSERT INTO article(numero_article, description_article, prix_unitaire, url_article, image_article, quantite_article, numero_fournisseur, code_categorie) VALUES (1,'crayon bleu',1.80,'URLCrayonBleu.com','ImageCrayonBleu',500,1,1) 
/
INSERT INTO article(numero_article, description_article, prix_unitaire, url_article, image_article, quantite_article, numero_fournisseur, code_categorie) VALUES (2,'crayon rouge',0.75,'URLCrayonRouge.com','ImageCrayonrouge',500,1,1) 
/
INSERT INTO article(numero_article, description_article, prix_unitaire, url_article, image_article, quantite_article, numero_fournisseur, code_categorie) VALUES (11,'gomme à effacée',0.50,'URLCrayonBleu.com','ImageCrayonBleu',200,2,3) 
/
INSERT INTO article(numero_article, description_article, prix_unitaire, url_article, image_article, quantite_article, numero_fournisseur, code_categorie) VALUES (3,'plume encre de chine',2.00,'URLCrayonPlumeChine.com','ImageCrayonPlumeChine',25,4,2) 
/
INSERT INTO article(numero_article, description_article, prix_unitaire, url_article, image_article, quantite_article, numero_fournisseur, code_categorie) VALUES (4,'plume encre de chine',2.00,'URLCrayonPlumeChine.com','ImageCrayonPlumeChine',25,4,2) 
/
INSERT INTO article(numero_article, description_article, prix_unitaire, url_article, image_article, quantite_article, numero_fournisseur, code_categorie) VALUES (5,'plume encre de chine',2.00,'URLCrayonPlumeChine.com','ImageCrayonPlumeChine',25,4,2) 
/
INSERT INTO article(numero_article, description_article, prix_unitaire, url_article, image_article, quantite_article, numero_fournisseur, code_categorie) VALUES (6,'plume encre de chine',2.00,'URLCrayonPlumeChine.com','ImageCrayonPlumeChine',25,4,2) 
/
INSERT INTO article(numero_article, description_article, prix_unitaire, url_article, image_article, quantite_article, numero_fournisseur, code_categorie) VALUES (7,'plume encre de chine',2.00,'URLCrayonPlumeChine.com','ImageCrayonPlumeChine',25,4,2) 
/

/* insertion dans la table commande*/
INSERT INTO commande(numero_commande, date_creation_commande, numero_client) VALUES (10,TO_DATE('2005/05/15','yyyy/mm/dd'),4) 
/
INSERT INTO commande(numero_commande, date_creation_commande, numero_client) VALUES (20,TO_DATE('2005/05/18','yyyy/mm/dd'),4) 
/
INSERT INTO commande(numero_commande, date_creation_commande, numero_client) VALUES (30,TO_DATE('2005/05/22','yyyy/mm/dd'),2) 
/
INSERT INTO commande(numero_commande, date_creation_commande, numero_client) VALUES (40,TO_DATE('2005/05/25','yyyy/mm/dd'),3) 
/
INSERT INTO commande(numero_commande, date_creation_commande, numero_client) VALUES (50,TO_DATE('2005/05/26','yyyy/mm/dd'),1) 
/
INSERT INTO commande(numero_commande, date_creation_commande, numero_client) VALUES (60,TO_DATE('2004/04/26','yyyy/mm/dd'),1) 
/

/* insertion dans la table livraison*/
INSERT INTO livraison(numero_livraison, date_livraison, numero_client) VALUES (1,TO_DATE('2005/05/17','yyyy/mm/dd'),4) 
/
INSERT INTO livraison(numero_livraison, date_livraison, numero_client) VALUES (2,TO_DATE('2005/05/29','yyyy/mm/dd'),3) 
/
INSERT INTO livraison(numero_livraison, date_livraison, numero_client) VALUES (3,TO_DATE('2005/05/29','yyyy/mm/dd'),4) 
/
INSERT INTO livraison(numero_livraison, date_livraison, numero_client) VALUES (4,TO_DATE('2005/05/30','yyyy/mm/dd'),2) 
/
INSERT INTO livraison(numero_livraison, date_livraison, numero_client) VALUES (5,TO_DATE('2005/05/30','yyyy/mm/dd'),1) 
/
INSERT INTO livraison(numero_livraison, date_livraison, numero_client) VALUES (6,TO_DATE('2005/06/30','yyyy/mm/dd'),1) 
/

/* insertion dans la table facture*/
INSERT INTO facture(numero_facture, montant_total_facture, numero_livraison) VALUES (1,50.00,1) 
/
INSERT INTO facture(numero_facture, montant_total_facture, numero_livraison) VALUES (2,50.00,3) 
/
INSERT INTO facture(numero_facture, montant_total_facture, numero_livraison) VALUES (3,25.00,2) 
/
INSERT INTO facture(numero_facture, montant_total_facture, numero_livraison) VALUES (4,100.00,5) 
/
INSERT INTO facture(numero_facture, montant_total_facture, numero_livraison) VALUES (5,100.00,4) 
/

/* insertion dans la table paiement*/
INSERT INTO paiement(numero_facture, date_reception_paiement, montant_paiement, type_paiement, type_carte_paiement, numero_carte_paiement, carte_expiration_paiement, carte_autorisation_paiement, numero_cheque, date_cheque, numero_compte_cheque_paiement, banque_cheque_paiement) VALUES (1,TO_DATE('2005/05/18','yyyy/mm/dd'),50.00,'ch',null,null,null,null,575,TO_DATE('2005/05/18','yyyy/mm/dd'),5034,5) 
/
INSERT INTO paiement(numero_facture, date_reception_paiement, montant_paiement, type_paiement, type_carte_paiement, numero_carte_paiement, carte_expiration_paiement, carte_autorisation_paiement, numero_cheque, date_cheque, numero_compte_cheque_paiement, banque_cheque_paiement) VALUES (2,TO_DATE('2005/05/18','yyyy/mm/dd'),50.00,'cc','vi','4540123412341234',TO_DATE('2008/05/18','yyyy/mm/dd'),5,null,null,null,null) 
/
INSERT INTO paiement(numero_facture, date_reception_paiement, montant_paiement, type_paiement, type_carte_paiement, numero_carte_paiement, carte_expiration_paiement, carte_autorisation_paiement, numero_cheque, date_cheque, numero_compte_cheque_paiement, banque_cheque_paiement) VALUES (3,TO_DATE('2005/05/18','yyyy/mm/dd'),25.00,'ch',null,null,null,null,25,TO_DATE('2005/05/30','yyyy/mm/dd'),4444,2) 
/
INSERT INTO paiement(numero_facture, date_reception_paiement, montant_paiement, type_paiement, type_carte_paiement, numero_carte_paiement, carte_expiration_paiement, carte_autorisation_paiement, numero_cheque, date_cheque, numero_compte_cheque_paiement, banque_cheque_paiement) VALUES (4,TO_DATE('2005/05/18','yyyy/mm/dd'),50.00,'cc','mc','4540432143211323',TO_DATE('2008/06/05','yyyy/mm/dd'),4,null,null,null,null) 
/
INSERT INTO paiement(numero_facture, date_reception_paiement, montant_paiement, type_paiement, type_carte_paiement, numero_carte_paiement, carte_expiration_paiement, carte_autorisation_paiement, numero_cheque, date_cheque, numero_compte_cheque_paiement, banque_cheque_paiement) VALUES (5,TO_DATE('2005/05/18','yyyy/mm/dd'),100.00,'ch',null,null,null,null,647,TO_DATE('2005/05/30','yyyy/mm/dd'),3574,1) 
/

/* insertion dans la table ARTICLESPECIAL*/
INSERT INTO ARTICLESPECIAL(numero_article, rabais_article) VALUES (11,0.50) 
/

/* insertion dans la table wishlist*/
INSERT INTO wishlist(numero_article, numero_client) VALUES (5,4) 
/

/* insertion dans la table produitcommande*/
INSERT INTO produitcommande(numero_article, numero_commande, quantite_commande) VALUES (1,10,50) 
/
INSERT INTO produitcommande(numero_article, numero_commande, quantite_commande) VALUES (2,20,50) 
/
INSERT INTO produitcommande(numero_article, numero_commande, quantite_commande) VALUES (1,30,25) 
/
INSERT INTO produitcommande(numero_article, numero_commande, quantite_commande) VALUES (1,40,50) 
/
INSERT INTO produitcommande(numero_article, numero_commande, quantite_commande) VALUES (2,50,100) 
/
INSERT INTO produitcommande(numero_article, numero_commande, quantite_commande) VALUES (1,50,100) 
/
INSERT INTO produitcommande(numero_article, numero_commande, quantite_commande) VALUES (3,50,100) 
/
INSERT INTO produitcommande(numero_article, numero_commande, quantite_commande) VALUES (4,50,100) 
/
INSERT INTO produitcommande(numero_article, numero_commande, quantite_commande) VALUES (5,50,100) 
/
INSERT INTO produitcommande(numero_article, numero_commande, quantite_commande) VALUES (6,50,100) 
/
INSERT INTO produitcommande(numero_article, numero_commande, quantite_commande) VALUES (7,50,100) 
/
INSERT INTO produitcommande(numero_article, numero_commande, quantite_commande) VALUES (1,60,25) 
/

/* insertion dans la table commandeconsultation*/
INSERT INTO commandeconsultation(numero_commande, numero_client, date_consultation) VALUES (10,4,TO_DATE('2005/05/17','yyyy/mm/dd')) 
/
INSERT INTO commandeconsultation(numero_commande, numero_client, date_consultation) VALUES (20,4,TO_DATE('2005/05/19','yyyy/mm/dd')) 
/
INSERT INTO commandeconsultation(numero_commande, numero_client, date_consultation) VALUES (30,2,TO_DATE('2005/05/27','yyyy/mm/dd')) 
/
INSERT INTO commandeconsultation(numero_commande, numero_client, date_consultation) VALUES (40,3,TO_DATE('2005/06/01','yyyy/mm/dd')) 
/
INSERT INTO commandeconsultation(numero_commande, numero_client, date_consultation) VALUES (50,1,TO_DATE('2005/06/17','yyyy/mm/dd')) 
/

/* insertion dans la table articlelivraison*/
INSERT INTO articlelivraison(numero_article,numero_commande, numero_livraison, quantite_livraison) VALUES (1,10,1,50) 
/
INSERT INTO articlelivraison(numero_article,numero_commande, numero_livraison, quantite_livraison) VALUES (2,20,3,50) 
/
INSERT INTO articlelivraison(numero_article,numero_commande, numero_livraison, quantite_livraison) VALUES (1,30,4,25) 
/
INSERT INTO articlelivraison(numero_article,numero_commande, numero_livraison, quantite_livraison) VALUES (1,40,2,50) 
/
INSERT INTO articlelivraison(numero_article,numero_commande, numero_livraison, quantite_livraison) VALUES (2,50,5,100) 
/
INSERT INTO articlelivraison(numero_article,numero_commande, numero_livraison, quantite_livraison) VALUES (3,60,6,100) 
/
INSERT INTO articlelivraison(numero_article,numero_commande, numero_livraison, quantite_livraison) VALUES (11,10,1,50) 
/

SPOOL OFF
