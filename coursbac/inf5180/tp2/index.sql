/*Création des index secondaire*/

DROP INDEX indexArticleNoFournisseur
/
DROP INDEX indexLivraisonNoClient
/
DROP INDEX indexFactureNoLivraison
/
DROP INDEX indexProduitcommande 
/
DROP INDEX indexCommandeNoClient
/
DROP INDEX indexClientNomClient
/
CREATE INDEX indexArticleNoFournisseur ON ARTICLE(NUMERO_FOURNISSEUR)
/

CREATE INDEX indexLivraisonNoClient ON LIVRAISON(numero_client)
/
CREATE INDEX indexFactureNoLivraison ON FACTURE(numero_LIVRAISON)
/
CREATE INDEX indexProduitcommande ON PRODUITCOMMANDE(numero_commande)
/
CREATE INDEX indexCommandeNoClient ON COMMANDE(numero_client)
/
CREATE INDEX indexClientNomClient ON CLIENT(nom_client)
/
