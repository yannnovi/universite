echo off
rem $Id: test.cmd,v 1.1 2003/07/15 14:55:07 yann Exp $
date /t
time /t
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 1: Création d'un cours et liste le cours.
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testn1.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 2: Création d'un nouveau dossier étudiant et sa consultation.
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testn2.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 3: Annulation d'un cours sans inscription.
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testn3.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 4: Ajout d'une inscription à un dossier étudiant 
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testn4.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 5: Annulation d'une inscription à un dossier étudiant
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testn5.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 6: Annulation d'un cours avec inscription.
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testn6.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 7: Lister les inscriptions d'un cours
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testn7.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas normaux
echo test 8: Sauvegarde et lecture des fichiers cours.bin et etudiant.bin
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testn81.txt
echo ===============================================
echo === Test8: Fichier sauvegarder et recharger ===
echo ===============================================
tp1 < testn82.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas limites
echo test 1: Création du maximum (100) de cours
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testl1.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas limites
echo test 2: Création du maximum (100) de dossiers etudiant.
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testl2.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas limites
echo test 3: Création du maximum de dossier étudiant avec le même nom et prenom.
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testl3.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas limites
echo test 4: Création du maximum de dossier étudiant avec le même nom et prenom.
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testl4.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors bornes.
echo test 1: Création de doublon de cours
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testh1.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors bornes.
echo test 2: Création de doublon d'inscription de cours pour un même étudiant
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testh2.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors bornes.
echo test 3: Annulation d'un cours qui n'existe pas.
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testh3.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors bornes.
echo test 4: Annulation d'une inscription qui n'existe pas.
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testh4.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors bornes.
echo test 5: Consultation d'un dossier qui n'existe pas
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testh5.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors bornes.
echo test 6: Ajouter une inscription a un cours qui n'existe pas.
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testh6.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors bornes.
echo test 7: Liste des inscriptions d'un cours qui n'existe pas.
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testh7.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors bornes.
echo test 8: Valider la saisie des champs de créer cours
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testh8.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors bornes.
echo test 9: Valider la saisie des champs d'annuler un cours.
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testh9.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors bornes.
echo test 10: Valider la saisie des champs de liste des inscriptions. 
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testh10.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors bornes.
echo test 11: Valider la saisie des champs de créer un nouveau dossier
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testh11.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors bornes.
echo test 12: Valider la saisie des champs de consulter un dossier.
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testh12.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors bornes.
echo test 13: Valider la saisie des champs d'ajouter une inscription.
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testh13.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors bornes.
echo test 14: Valider la saisie des champs d'annuler une inscription.
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testh14.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors bornes.
echo test 15: Valider la saisie des options du menu principal.
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testh15.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors bornes.
echo test 16: Valider la saisie des options du menu cours
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testh16.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
echo Verification des cas hors bornes.
echo test 17: Valider la saisie des options du menu étudiant.
copy cours.vide.bin cours.bin
copy etudiant.vide.bin etudiant.bin
tp1 < testh17.txt
echo ==========================================================================
echo ==========================================================================
echo ==========================================================================
date  /t
time /t


