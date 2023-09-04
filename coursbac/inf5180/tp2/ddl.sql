SET echo ON
SET term ON


SPOOL c:\DELAIDELIVRAION.OUT

DROP PROCEDURE ddl;

CREATE PROCEDURE ddl (unNumeroCommande IN COMMANDE.NUMERO_COMMANDE%TYPE) IS 

	date_commande	COMMANDE.DATE_CREATION_COMMANDE%TYPE;
	date_livraison	LIVRAISON.DATE_LIVRAISON%TYPE;
	no_data_found	EXCEPTION;
	
BEGIN 
	--Trouve la date de la commande
	SELECT COMMANDE.DATE_CREATION_COMMANDE
	INTO date_commande
	FROM COMMANDE 
	WHERE unNumeroCommande = COMMANDE.NUMERO_COMMANDE;
	--Vérification sur le numero de commande
	IF (date_commande IS NULL) 
		THEN DBMS_OUTPUT.PUT_LINE('Le numéro de commande entré est invalide.');
	
	ELSE
		SELECT LIVRAISON.DATE_LIVRAISON
		INTO date_livraison
		FROM LIVRAISON, ARTICLELIVRAISON
		WHERE unNumeroCommande = ARTICLELIVRAISON.NUMERO_COMMANDE 
		AND ARTICLELIVRAISON.NUMERO_LIVRAISON = LIVRAISON.NUMERO_LIVRAISON;
	
		IF (TO_CHAR(date_livraison,'DDD') - TO_CHAR(date_commande,'DDD')) > 14 
			THEN 	DBMS_OUTPUT.PUT_LINE('Pour le numéro de commande :');
				DBMS_OUTPUT.PUT_LINE(unNumeroCommande);
				DBMS_OUTPUT.PUT_LINE('La livraison est en retard.');
		ELSE 
			IF TO_CHAR(date_livraison,'DDD') - TO_CHAR(date_commande,'DDD') < 14
				THEN 	DBMS_OUTPUT.PUT_LINE('Pour le numéro de commande :');
					DBMS_OUTPUT.PUT_LINE(unNumeroCommande);
					DBMS_OUTPUT.PUT_LINE('La livraison n est pas en retard.');
			END IF;
		END IF;
	END IF;
	EXCEPTION
        	when no_data_found 
	 		then DBMS_OUTPUT.PUT_LINE('Le numéro de commande entré n est pas valide.');
	END;
END ddl;
/*EXCEPTION
         when no_data_found 
	 	then DBMS_OUTPUT.PUT_LINE('Le numéro de commande entré n est pas valide.');
END;*/
/

show errors
SPOOL OFF
