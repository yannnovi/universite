///////////////////////////////////////////////////////////////////////////////
//$Id: encode.cpp,v 1.10 2004/02/04 20:34:36 yann Exp $                     
//
// encode.cpp
//
// Auteur: Yann Bourdeau BOUY06097202 bourdeau.yann@courrier.uqam.ca
//
// Ce programme permet de coder un fichier qui contient les mots en 
// occurences double par le caratere $pos. Le programme vas remplacer
// les mots qui ont plus qu'un occurence par $pos.
// 
// Les mots commencencant par $ vont etre changer pour $$mot
///////////////////////////////////////////////////////////////////////////////
#include <iostream>
#include <map>
#include <string>
#include <fstream>

using namespace std;

///////////////////////////////////////////////////////////////////////////////
// Definition des type
typedef unsigned int POSITION_MOT; // Position du mot dans le map
// Liste des code de retour.
enum CODE_RETOUR {CODE_OK=0, // Aucune erreur.
                  CODE_RETOUR_ERREUR_FICHIER=1 // Erreur de fichier.
                  };

///////////////////////////////////////////////////////////////////////////////
// Definition des constantes
const string gNomFichierSortieExtension=".ref";
const char gCharReference = '$';
const char gSeparateurMot = ' ';

///////////////////////////////////////////////////////////////////////////////
// Prototypes
CODE_RETOUR OuvrirFichier(fstream &FichierEntrer,fstream &FichierSortie);
CODE_RETOUR AjouteMot(string &LeMot,map<string,POSITION_MOT> &tabMots,POSITION_MOT &PositionMot,
                      fstream &FichierSortie);

///////////////////////////////////////////////////////////////////////////////
// Fonction OuvrirFichier
// Cette fonction ouvre les fichiers de sortie et d'entree
// Parametre: FichierEntrer: Stream du fichier d'entree.
//            FichierSortie: Stream du fichier de sortie.
///////////////////////////////////////////////////////////////////////////////
CODE_RETOUR OuvrirFichier(fstream &FichierEntrer,fstream &FichierSortie)
{
    CODE_RETOUR rc=CODE_OK; // Code de retour
    string NomFichierLecture; // Contient le nom du fichier a encoder.
    string NomFichierEcriture; // Nom du fichier encoder

    cout << "Donnez le nom du fichier a encoder : ";
    cin >> NomFichierLecture;


    FichierEntrer.open( NomFichierLecture.c_str(),ios::in);
    // Le fichier n'a pas pu s'ouvrir 
    if ( !FichierEntrer.is_open() )
    {
        cerr << "Ouverture du fichier \"" << NomFichierLecture  << "\" impossible." << endl;
        rc = CODE_RETOUR_ERREUR_FICHIER;
    }

    if(!rc)
    {
        // Creer le nom du fichier en sortie.
        NomFichierEcriture = NomFichierLecture + gNomFichierSortieExtension;
    
        FichierSortie.open(NomFichierEcriture.c_str(),ios::out);
        // Le fichier n'a pas pu s'ouvrir
        if ( !FichierSortie )
        {
            cerr << "Ouverture du fichier \"" << NomFichierEcriture  << "\" impossible." << endl;
            rc = CODE_RETOUR_ERREUR_FICHIER;
        }
    }

    return rc;
}

///////////////////////////////////////////////////////////////////////////////
// Fonction AjouteMot
// Cette fonction ajoute un mot du fichier dans le map (si necessaire) et le
// mets dans le fichier de sortie.
// Parametre: LeMot: Le mot a ajouter.
//            tabMots: Map qui contient la liste des mots
//            PositionMot: Position du mot dans le fichier.
//            FichierSortie: Le stream du fichier de sortie.
///////////////////////////////////////////////////////////////////////////////
CODE_RETOUR AjouteMot(string &LeMot,map<string,POSITION_MOT> &tabMots,POSITION_MOT &PositionMot,
                      fstream &FichierSortie)
{
    CODE_RETOUR rc=CODE_OK; // Code de retour

    if(LeMot[0]==gCharReference)
    {
        LeMot=gCharReference+LeMot;
    }
    // Cherche le mot si il existe deja.
    map<string,POSITION_MOT>::iterator Iterateur  = tabMots.find(LeMot );


    if(Iterateur != tabMots.end())
    {
        FichierSortie  << gCharReference << tabMots[LeMot];
    }
    else
    {
        // Ajoute le mots dans le tableau
        tabMots[LeMot]=PositionMot;
        FichierSortie << LeMot ;
        PositionMot++;
    }

    return rc;
}
///////////////////////////////////////////////////////////////////////////////
// Fonction principal
// Cette fonction ouvre un fichier en lecture et creer un fichier en sortie
// La boucle principale lis le fichier et remplace tous les occurence du meme 
// mot par $Pos
///////////////////////////////////////////////////////////////////////////////
int main()
{
    CODE_RETOUR rc=CODE_OK; // Code de retour
    map<string,POSITION_MOT> tabMots;  // Contient les mots et leur position.

    POSITION_MOT PositionMot=0; // Contient la position du mot courant(le nouveau). 
    
    fstream FichierEntrer; // Fichier d'entrer, le fichier a encoder.
    fstream FichierSortie; // Fichier de sortir, le fichier encoder.
    
    // Ouvre les fichiers
    rc=OuvrirFichier(FichierEntrer,FichierSortie);

    // Continue le traitement si il y a pas d'erreur.
    if(!rc)
    {

        string ligneFichier;    /* Contiendra le texte d'une ligne */

        /* Boucle sur l'ensemble des lignes du fichier */

        while ( getline(FichierEntrer, ligneFichier, '\n') )
        {

            size_t Pos=0,PosResultat=0; // Initialise la position dans la chaine a zero.
            
            // Tant que la ligne n'est pas vide
            while(PosResultat != -1 )
            {
                string LeMot=""; // Variable qui contient un mot du fichier

                // Boucle tant que le mot est vide (un espace) et que la 
                // position dans la ligne est plus petite que la grandeur
                // de la ligne.
                while(LeMot.length()==0 && Pos <= ligneFichier.length())
                {
                    // Trouve le premier espace qui separe deux mots.
                    PosResultat = ligneFichier.find(gSeparateurMot,Pos);                   
                        
                    // Copie le mot
    				LeMot=ligneFichier.substr(Pos, PosResultat - Pos);

                    // Si le mot est de longueur zero indique un espace.
                    if(LeMot.length()==0)
                    {
                        // Passe au caractere suivant.
                        Pos++;
			FichierSortie << ' ';
                    }
                }
                if(Pos <= ligneFichier.length() )
                {
                    // Ajoute le mot dans le map si necessaire et dans le fichier de sortie.
                    rc=AjouteMot(LeMot,tabMots,PositionMot,FichierSortie);
                    // Ajoute un espace apres le mot.
                    FichierSortie << ' ';
                    /* Passe au mots suivant en sautant l'espace blanc qui les separe */
                    Pos=PosResultat+1;
                }
                else
                {
                    // Si le position est superieur a la fin de la ligne, indique fin de ligne.
                    PosResultat=-1;
                }
            }
            FichierSortie << endl;
        }
    }
    cout << "Fin du programme.";
    return rc;
}

