echo off
rem $id$
date /t
time /t
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 1: Ajout d'un client et liste des client
echo .
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testn1.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 2: Ajout d'un film et liste des films
echo .
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testn2.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 3: Lecteure et sauvegarde de client.bin 
echo .
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testn1.txt
echo ===============================================
echo === Test3: Fichier sauvegarder et recharger ===
echo ===============================================
tp3.exe < testn3.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 4: Lecture et sauvegarde film.bin
echo .
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testn2.txt
echo ===============================================
echo === Test4: Fichier sauvegarder et recharger ===
echo ===============================================
tp3.exe < testn4.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 5: Liste du film selon un type
echo.
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testn5.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 6: Fait une location et liste location pour un client
echo.
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testn6.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 7: Verifie la disponibilite d'un film
echo.
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testn7.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 8: Affiche la liste des films non disponible.
echo.
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testn8.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 9: Affiche la liste des clients qui ont plus que 5 locations.
echo.
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testn9.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 10: Verifie un retour de location.
echo.
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testn10.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 11: Verifie la liste des transaction d'un client.
echo.
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testn11.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 12: Verification de la liste des films en retard.
echo.
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testn12.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 13: Verification du traitement en lot de locations.txt
echo.
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testn1.txt
tp3.exe < testn2.txt
echo kilr1001bouy1001 10 10 2003 12 10 2003 > locations.txt
tp3.exe < testn13.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 14: Verification des listes en ordre croissant
echo.
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testn14.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas limites
echo test 1: Verification de la creation du maximum de clients.
echo.
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testl1.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas limites
echo test 2: Verification de la creation du maximum de films.
echo.
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testl2.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas limites
echo test 3: Verification de la creation du maximum de copie pour un film.
echo.
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testl3.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas limites
echo test 4: Verification de la creation du maximum de location pour un film.
echo.
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testl4.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors borne.
echo test 1: Verification de la validation de la saisie d'un nouveau client.
echo.
copy filmsvide.bin films.bin
copy clientsvide.bin clients.bin
tp3.exe < testh1.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors borne.
echo test 2: Verification de la validation de la saisie d'ajout de nouveau film.
echo.
tp3.exe < testh2.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors borne.
echo test 3: Verification de la validation de la saisie d'une location.
echo.
tp3.exe < testh3.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors borne.
echo test 4: Verification de la validation d'un retour d'une location.
echo.
tp3.exe < testh4.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors borne.
echo test 5: Verification de la validation de verification de disponibilite.
echo.
tp3.exe < testh5.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors borne.
echo test 6: Verification de la validation de la generation de la liste de transactions
echo.
tp3.exe < testh6.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors borne.
echo test 7: Verification de la validation de la generation de la liste de locations
echo.
tp3.exe < testh7.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors borne.
echo test 8: Verification de la validation de la generation de la liste de locations
echo.
tp3.exe < testh8.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors borne.
echo test 9: Verification de la validation de la generation de la liste des films en retard. 
echo.
tp3.exe < testh9.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
date  /t
time /t


