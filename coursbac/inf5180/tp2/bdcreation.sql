SET echo ON
SET term ON
/* $Id: bdcreation.sql,v 1.10 2005/05/04 13:51:07 Yann Exp $ */
spool c:\CREATE.OUT

DROP TABLE STATISTIQUEGLOBAL;
DROP TABLE STATISTIQUEANNEE;
DROP TABLE COMMANDECONSULTATION;
DROP TABLE PRODUITCOMMANDE;
DROP TABLE WISHLIST;
DROP TABLE ARTICLELIVRAISON;
DROP TABLE ARTICLESPECIAL;
DROP TABLE PAIEMENT;
DROP TABLE FACTURE;
DROP TABLE LIVRAISON;
DROP TABLE COMMANDE;
DROP TABLE ARTICLE;
DROP TABLE CATEGORIE;
DROP TABLE CLIENT;
DROP TABLE FOURNISSEUR;
DROP TABLE COMPAGNIE;
/

CREATE TABLE COMPAGNIE(
	NUMERO_COMPAGNIE	INTEGER 	NOT NULL 	UNIQUE,
	NOM_COMPAGNIE		VARCHAR(20),
	CONSTRAINT CCOMPAGNIE1 PRIMARY KEY (NUMERO_COMPAGNIE),
	CONSTRAINT CCOMPAGNIE2 CHECK (NUMERO_COMPAGNIE > 0))
/

CREATE TABLE FOURNISSEUR(
	NUMERO_FOURNISSEUR	INTEGER		NOT NULL 	UNIQUE,
	NOM_FOURNISSEUR		VARCHAR(20),
	CONSTRAINT CFOURNISSEUR1 PRIMARY KEY (NUMERO_FOURNISSEUR),
	CONSTRAINT CFOURNISSEUR2 CHECK (NUMERO_FOURNISSEUR > 0))
/

CREATE TABLE CLIENT(
	NUMERO_CLIENT		INTEGER 	NOT NULL 	UNIQUE,
	MOT_PASSE_CLIENT	VARCHAR(6) 	NOT NULL,
	DATE_INSCRIPTION	DATE,
	NOM_CLIENT		VARCHAR(20) 	NOT NULL,
	PRENOM_CLIENT		VARCHAR(20) 	NOT NULL,
	COURRIEL_CLIENT		VARCHAR(50),
	ADRESSE_LIVRAISON	VARCHAR(100) 	NOT NULL,
	TYPECLIENT		CHAR 		NOT NULL,
	RANG_CLIENT		INTEGER 	NOT NULL,
	NUMERO_COMPAGNIE	INTEGER,
	CONSTRAINT CCLIENT1 PRIMARY KEY (NUMERO_CLIENT),
	CONSTRAINT CCLIENT2 FOREIGN KEY (NUMERO_COMPAGNIE) REFERENCES COMPAGNIE,
	CONSTRAINT CCLIENT3 CHECK (NUMERO_CLIENT > 0),
	CONSTRAINT CCLIENT4 CHECK (TYPECLIENT IN ('i', 'c')),
	CONSTRAINT CCLIENT5 CHECK (RANG_CLIENT >= 1 AND RANG_CLIENT <= 10),
	CONSTRAINT CCLIENT6 CHECK (NUMERO_COMPAGNIE > 0 OR numero_compagnie IS NULL))
/

CREATE TABLE CATEGORIE(
	CODE_CATEGORIE		INTEGER 	NOT NULL 	UNIQUE,
	LIBELLE_CATEGORIE	VARCHAR(30),
	CATEGORIE_PARENT	INTEGER,
	CONSTRAINT CCATEGORIE1 PRIMARY KEY (CODE_CATEGORIE),
	CONSTRAINT CCATEGORIE2 FOREIGN KEY (CATEGORIE_PARENT) REFERENCES CATEGORIE,
	CONSTRAINT CCATEGORIE3 CHECK (CODE_CATEGORIE > 0),
	CONSTRAINT CCATEGORIE4 CHECK (CATEGORIE_PARENT > 0))
/

CREATE TABLE ARTICLE(
	NUMERO_ARTICLE		INTEGER		NOT NULL	UNIQUE,
	DESCRIPTION_ARTICLE	VARCHAR(100),
	PRIX_UNITAIRE		REAL,
	URL_ARTICLE		VARCHAR(100),
	IMAGE_ARTICLE		VARCHAR(100),
	QUANTITE_ARTICLE	INTEGER,
	NUMERO_FOURNISSEUR	INTEGER,
	CODE_CATEGORIE		INTEGER,
	CONSTRAINT CARTICLE1 PRIMARY KEY (NUMERO_ARTICLE),
	CONSTRAINT CARTICLE2 FOREIGN KEY (NUMERO_FOURNISSEUR) REFERENCES FOURNISSEUR,
	CONSTRAINT CARTICLE3 FOREIGN KEY (CODE_CATEGORIE) REFERENCES CATEGORIE,
	CONSTRAINT CARTICLE4 CHECK (NUMERO_ARTICLE > 0),
	CONSTRAINT CARTICLE5 CHECK (PRIX_UNITAIRE > 00.00),
	CONSTRAINT CARTICLE6 CHECK (QUANTITE_ARTICLE > 0),
	CONSTRAINT CARTICLE7 CHECK (NUMERO_FOURNISSEUR > 0),
	CONSTRAINT CARTICLE8 CHECK (CODE_CATEGORIE > 0))
/

CREATE TABLE COMMANDE(
	NUMERO_COMMANDE		INTEGER 	NOT NULL 	UNIQUE,
	DATE_CREATION_COMMANDE	DATE,
	NUMERO_CLIENT		INTEGER,
	CONSTRAINT CCOMMANDE1 PRIMARY KEY (NUMERO_COMMANDE),
	CONSTRAINT CCOMMANDE2 FOREIGN KEY (NUMERO_CLIENT) REFERENCES CLIENT,
	CONSTRAINT CCOMMANDE3 CHECK (NUMERO_COMMANDE > 0),
	CONSTRAINT CCOMMANDE4 CHECK (NUMERO_CLIENT > 0))
/

CREATE TABLE LIVRAISON(
	NUMERO_LIVRAISON	INTEGER 	NOT NULL 	UNIQUE,
	DATE_LIVRAISON		DATE,
	NUMERO_CLIENT		INTEGER,
	CONSTRAINT CLIVRAISON1 PRIMARY KEY (NUMERO_LIVRAISON),
	CONSTRAINT CLIVRAISON2 FOREIGN KEY (NUMERO_CLIENT) REFERENCES CLIENT,
	CONSTRAINT CLIVRAISON3 CHECK (NUMERO_LIVRAISON > 0),
	CONSTRAINT CLIVRAISON4 CHECK (NUMERO_CLIENT > 0))
/

CREATE TABLE FACTURE(
	NUMERO_FACTURE		INTEGER 	NOT NULL 	UNIQUE,
	MONTANT_TOTAL_FACTURE	REAL,
	NUMERO_LIVRAISON	INTEGER,
	CONSTRAINT CFACTURE1 PRIMARY KEY (NUMERO_FACTURE),
	CONSTRAINT CFACTURE2 FOREIGN KEY (NUMERO_LIVRAISON) REFERENCES LIVRAISON,
	CONSTRAINT CFACTURE3 CHECK (NUMERO_FACTURE > 0),
	CONSTRAINT CFACTURE4 CHECK (MONTANT_TOTAL_FACTURE > 00.00),
	CONSTRAINT CFACTURE5 CHECK (NUMERO_LIVRAISON > 0))
/

CREATE TABLE PAIEMENT(
	NUMERO_FACTURE			INTEGER 	NOT NULL 	UNIQUE,
	DATE_RECEPTION_PAIEMENT		DATE 		NOT NULL,
	MONTANT_PAIEMENT		REAL,
	TYPE_PAIEMENT			VARCHAR(2), 
	TYPE_CARTE_PAIEMENT		VARCHAR(2),
	NUMERO_CARTE_PAIEMENT		CHAR(16), 
	CARTE_EXPIRATION_PAIEMENT	DATE,
	CARTE_AUTORISATION_PAIEMENT	INTEGER,
	NUMERO_CHEQUE			INTEGER,
	DATE_CHEQUE			DATE,
	NUMERO_COMPTE_CHEQUE_PAIEMENT	INTEGER,
	BANQUE_CHEQUE_PAIEMENT		INTEGER,
	CONSTRAINT CPAIEMENT1 PRIMARY KEY (NUMERO_FACTURE, DATE_RECEPTION_PAIEMENT),
	CONSTRAINT CPAIEMENT2 FOREIGN KEY (NUMERO_FACTURE) REFERENCES FACTURE,
	CONSTRAINT CPAIEMENT3 CHECK (NUMERO_FACTURE > 0),
	CONSTRAINT CPAIEMENT4 CHECK (MONTANT_PAIEMENT > 00.00),
	CONSTRAINT CPAIEMENT5 CHECK (TYPE_PAIEMENT IN ('ch','cc')),
	CONSTRAINT CPAIEMENT6 CHECK (TYPE_CARTE_PAIEMENT IN ('vi','mc','ae')),
	CONSTRAINT CPAIEMENT7 CHECK (TRANSLATE(NUMERO_CARTE_PAIEMENT,'0123456789','0000000000') = '0000000000000000'),
	CONSTRAINT CPAIEMENT8 CHECK (CARTE_AUTORISATION_PAIEMENT > 0),
	CONSTRAINT CPAIEMENT9 CHECK (NUMERO_CHEQUE > 0),
	CONSTRAINT CPAIEMENT10 CHECK (NUMERO_COMPTE_CHEQUE_PAIEMENT > 0),
	CONSTRAINT CPAIEMENT11 CHECK (BANQUE_CHEQUE_PAIEMENT > 0))
/

CREATE TABLE ARTICLESPECIAL(
	NUMERO_ARTICLE		INTEGER 	NOT NULL 	UNIQUE,
	RABAIS_ARTICLE		REAL,
	CONSTRAINT CCONSULTERRABAIS1 PRIMARY KEY (NUMERO_ARTICLE, RABAIS_ARTICLE),
	CONSTRAINT CCONSULTERRABAIS2 FOREIGN KEY (NUMERO_ARTICLE) REFERENCES ARTICLE,
	CONSTRAINT CCONSULTERRABAIS3 CHECK (NUMERO_ARTICLE > 0),
	CONSTRAINT CCONSULTERRABAIS4 CHECK (RABAIS_ARTICLE >= 0.0 AND RABAIS_ARTICLE <= 1.0))
/
CREATE TABLE WISHLIST(
	NUMERO_ARTICLE		INTEGER 	NOT NULL,
	NUMERO_CLIENT		INTEGER 	NOT NULL,
	CONSTRAINT CWISHLIST1 PRIMARY KEY (NUMERO_ARTICLE, NUMERO_CLIENT),
	CONSTRAINT CWISHLIST2 FOREIGN KEY (NUMERO_ARTICLE) REFERENCES ARTICLE,
	CONSTRAINT CWISHLIST3 CHECK (NUMERO_ARTICLE > 0),
	CONSTRAINT CWISHLIST4 CHECK (NUMERO_CLIENT > 0))
/

CREATE TABLE PRODUITCOMMANDE(
	NUMERO_ARTICLE		INTEGER 	NOT NULL,
	NUMERO_COMMANDE		INTEGER 	NOT NULL,
	QUANTITE_COMMANDE	INTEGER,
	CONSTRAINT CPRODUITCOMMANDE1 PRIMARY KEY (NUMERO_ARTICLE, NUMERO_COMMANDE),
	CONSTRAINT CPRODUITCOMMANDE2 FOREIGN KEY (NUMERO_ARTICLE) REFERENCES ARTICLE,
	CONSTRAINT CPRODUITCOMMANDE3 FOREIGN KEY (NUMERO_COMMANDE) REFERENCES COMMANDE,
	CONSTRAINT CPRODUITCOMMANDE4 CHECK (NUMERO_ARTICLE > 0),
	CONSTRAINT CPRODUITCOMMANDE5 CHECK (NUMERO_COMMANDE > 0),
	CONSTRAINT CPRODUITCOMMANDE6 CHECK (QUANTITE_COMMANDE > 0))
/

CREATE TABLE COMMANDECONSULTATION(
	NUMERO_COMMANDE		INTEGER 	NOT NULL,
	NUMERO_CLIENT		INTEGER 	NOT NULL,
	DATE_CONSULTATION	DATE,
	CONSTRAINT CCOMMANDECONSULTATION1 PRIMARY KEY (NUMERO_COMMANDE, NUMERO_CLIENT, DATE_CONSULTATION),
	CONSTRAINT CCOMMANDECONSULTATION2 FOREIGN KEY (NUMERO_COMMANDE) REFERENCES COMMANDE,
	CONSTRAINT CCOMMANDECONSULTATION3 FOREIGN KEY (NUMERO_CLIENT) REFERENCES CLIENT,
	CONSTRAINT CCOMMANDECONSULTATION4 CHECK (NUMERO_COMMANDE > 0),
	CONSTRAINT CCOMMANDECONSULTATION5 CHECK (NUMERO_CLIENT > 0))
/

CREATE TABLE ARTICLELIVRAISON(
	NUMERO_ARTICLE		INTEGER 	NOT NULL,
	NUMERO_COMMANDE		INTEGER 	NOT NULL,
	NUMERO_LIVRAISON	INTEGER 	NOT NULL,
	QUANTITE_LIVRAISON	INTEGER,
	CONSTRAINT CARTICLELIVRAISON1 PRIMARY KEY (NUMERO_ARTICLE, NUMERO_COMMANDE, NUMERO_LIVRAISON),
	CONSTRAINT CARTICLELIVRAISON2 FOREIGN KEY (NUMERO_ARTICLE) REFERENCES ARTICLE,
	CONSTRAINT CARTICLELIVRAISON3 FOREIGN KEY (NUMERO_COMMANDE) REFERENCES COMMANDE,
	CONSTRAINT CARTICLELIVRAISON4 FOREIGN KEY (NUMERO_LIVRAISON) REFERENCES LIVRAISON,
	CONSTRAINT CARTICLElIVRAISON5 CHECK (NUMERO_ARTICLE > 0),
	CONSTRAINT CARTICLElIVRAISON6 CHECK (NUMERO_COMMANDE > 0), 
	CONSTRAINT CARTICLElIVRAISON7 CHECK (NUMERO_LIVRAISON > 0),
	CONSTRAINT CARTICLElIVRAISON8 CHECK (QUANTITE_LIVRAISON > 0))
/

CREATE TABLE STATISTIQUEANNEE(
	NUMERO_CLIENT		INTEGER 	NOT NULL,
	NOMBRE_COMMANDE   	INTEGER 	NOT NULL,
	SOMME		        REAL,
	ANNEE			DATE 		NOT NULL,
	CONSTRAINT CSTATISTIQUEANNEE1 PRIMARY KEY (NUMERO_CLIENT, NOMBRE_COMMANDE, ANNEE),
	CONSTRAINT CSTATISTIQUEANNEE2 FOREIGN KEY (NUMERO_CLIENT) REFERENCES CLIENT ON DELETE SET NULL,
	CONSTRAINT CSTATISTIQUEANNEE3 CHECK (NUMERO_CLIENT > 0),
	CONSTRAINT CSTATISTIQUEANNEE4 CHECK (NOMBRE_COMMANDE >= 0),
	CONSTRAINT CSTATISTIQUEANNEE5 CHECK (SOMME >= 00.00))
/

CREATE TABLE STATISTIQUEGLOBAL(
	NUMERO_CLIENT		INTEGER 	NOT NULL,
	NOMBRE_COMMANDE_GLOBAL	INTEGER,
	SOMME_COMMANDE_GLOBAL	REAL,
	CONSTRAINT CSTATISTIQUEGLOBAL1 PRIMARY KEY (NUMERO_CLIENT),
	CONSTRAINT CSTATISTIQUEGLOBAL2 FOREIGN KEY (NUMERO_CLIENT) REFERENCES CLIENT ON DELETE SET NULL,
	CONSTRAINT CSTATISTIQUEGLOBAL3 CHECK (NUMERO_CLIENT > 0),
	CONSTRAINT CSTATISTIQUEGLOBAL4 CHECK (NOMBRE_COMMANDE_GLOBAL >= 0),
	CONSTRAINT CSTATISTIQUEGLOBAL5 CHECK (SOMME_COMMANDE_GLOBAL >= 00.00))
/
SPOOL OFF
