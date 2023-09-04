///////////////////////////////////////////////////////////////////////////////
//$Id: decode.cpp,v 1.11 2004/02/04 20:34:36 yann Exp $                     
//
// Decode.cpp
//
// Auteur: Yann Bourdeau BOUY06097202 bourdeau.yann@courrier.uqam.ca
//
// Ce programme permet de decoder un fichier qui contient les mots en 
// occurences double par le caratere $pos. Le programme vas remplacer
// les caracteres $pos par le bon mot.
// 
// Les mots commencencant par $$mot vont etre changer pour $mot
///////////////////////////////////////////////////////////////////////////////
#include <iostream>
#include <map>
#include <string>
#include <fstream>

using namespace std;
///////////////////////////////////////////////////////////////////////////////
// Definition des type
typedef unsigned int POSITION_MOT;
// Liste des code de retour.
enum CODE_RETOUR {CODE_OK=0, // Aucune erreur.
                  CODE_RETOUR_ERREUR_FICHIER=1, // Erreur de fichier.
                  CODE_RETOUR_ERREUR_REFERENCE_INCONNUE =2,
                  CODE_RETOUR_ERREUR_REFERENCE_INVALIDE =2
                  };


///////////////////////////////////////////////////////////////////////////////
// Definition des constantes
const string gNomFichierLectureExtension=".ref";
const string gNomFichierSortieExtension= ".drf";
const char gCharReference = '$';
const char gSeparateurMot = ' ';

///////////////////////////////////////////////////////////////////////////////
// Prototypes
CODE_RETOUR OuvrirFichier(fstream &FichierEntrer,fstream &FichierSortie,string NomFichierLecture);
CODE_RETOUR TraitementMot(string &LeMot,map<POSITION_MOT,string> &tabMots,POSITION_MOT &PositionMot,
                          string &NomFichierLecture,unsigned int NumLigne,fstream &FichierSortie);

///////////////////////////////////////////////////////////////////////////////
// Fonction OuvrirFichier
// Cette fonction ouvre les fichiers de sortie et d'entree
// Parametre: FichierEntrer: Stream du fichier d'entree.
//            FichierSortie: Stream du fichier de sortie.
///////////////////////////////////////////////////////////////////////////////
CODE_RETOUR OuvrirFichier(fstream &FichierEntrer,fstream &FichierSortie,string NomFichierLecture)
{
    CODE_RETOUR rc= CODE_OK; // Code de retour
    string NomFichierEcriture; // Nom du fichier encoder

    // Lis le nom du fichier a decoder.
    cout << "Donnez le nom du fichier a decoder : ";
    cin >> NomFichierLecture;

    // Le constructeur de ifstream ouvre le fichier 
    FichierEntrer.open( NomFichierLecture.c_str(),ios::in);

    // Le fichier n'a pas pu s'ouvrir 
    if ( !FichierEntrer.is_open() )
    {
        cerr << "Ouverture du fichier \"" << NomFichierLecture  << "\" impossible." << endl;
        rc = CODE_RETOUR_ERREUR_FICHIER;
    }

    // Creer le nom du fichier de sortie.
    NomFichierEcriture=NomFichierLecture;

    // Verifie si il contient .ref
    if(NomFichierEcriture.find(gNomFichierLectureExtension,0)!=-1)
    {
        // Si oui, enleve le .ref
        NomFichierEcriture=NomFichierEcriture.substr(0,NomFichierEcriture.find(gNomFichierLectureExtension,0));
    }
    else
    {
        // si non, ajoute .drf
        NomFichierEcriture=NomFichierEcriture + gNomFichierSortieExtension;
    }

    FichierSortie.open(NomFichierEcriture.c_str(),ios::out);

    // Le fichier n'a pas pu s'ouvrir
    if ( !FichierSortie.is_open() )
    {
        cerr << "Ouverture du fichier \"" << NomFichierEcriture  << "\" impossible." << endl;
        rc = CODE_RETOUR_ERREUR_FICHIER;
    }


    return rc;
}

///////////////////////////////////////////////////////////////////////////////
// Fonction TraitementMot
// Cette fonction effectue le traitement pour chaque mot trouve dans le fichier
// Il ecrit le mot dans le fichier de sortie.
// Parametre: LeMot: Le mot du fichier
//            tabMots: map des mots qui ont ete deja lus.
//            PositionMot: Position du mot dans le fichier.
//            NomFichierLecteure: Nom du fichier a decoder.
//            NumLigne: Numero de ligne courant dans le fichier a decoder
//            FichierSortie: Stream du fichier de sortie   
///////////////////////////////////////////////////////////////////////////////
CODE_RETOUR TraitementMot(string &LeMot,map<POSITION_MOT,string> &tabMots,POSITION_MOT &PositionMot,
                          string &NomFichierLecture,unsigned int NumLigne,fstream &FichierSortie)
{
    CODE_RETOUR rc= CODE_OK; // Code de retour
    if(LeMot[0]==gCharReference && LeMot[1]==gCharReference)
    {
        //Enleve un $ au mot
        LeMot=LeMot.erase(0,1);
        tabMots[PositionMot]=LeMot;
        PositionMot++;

    }
    else
    {
        // Si le mot est une reference
        if(LeMot[0]==gCharReference  )
        {
            bool ErreurValidation=false;
            // Valide que tous les caractere suivant le $ soit numerique
            for(size_t i=1;i<LeMot.length();++i)
            {
                if(!isdigit(LeMot[i]))
                {
                    ErreurValidation=true;
                }
            }

            if(!ErreurValidation)
            {
                // Enleve le $ du mot.
                LeMot=LeMot.erase(0,1);
                // Retrouve le mot dans le map.
                map<POSITION_MOT,string>::iterator Iterateur  = tabMots.find(atoi(LeMot.c_str()) );
    
                if(Iterateur != tabMots.end())
                {
                    LeMot=tabMots[atoi(LeMot.c_str())];
                }
                else
                {
                    // La reference n'existe pas.
                    cerr << NomFichierLecture << ": ligne " << NumLigne << ": " << LeMot << ": Cette Reference n'existe pas.";
                    rc=CODE_RETOUR_ERREUR_REFERENCE_INCONNUE;
                }
            }
            else
            {
                // La reference est invalide.
                cerr << NomFichierLecture << ": ligne " << NumLigne << ": " << LeMot << ": Reference invalide.";
                rc=CODE_RETOUR_ERREUR_REFERENCE_INVALIDE;
            }
        }
        else
        {
            // Le mot est pas une reference, ajoute le mot dans le map.
                tabMots[PositionMot]=LeMot;
                PositionMot++;
        }
    }

    if(!rc)
    {
        // Mets le mots dans le fichier de sortie.
        FichierSortie << LeMot << ' ';
    }
    return rc;
}
///////////////////////////////////////////////////////////////////////////////
// Fonction principal
// Cette fonction ouvre un fichier en lecture et creer un fichier en sortie
// La boucle principale lis le fichier et remplace tous les occurence de $pos
// par le bon mot
///////////////////////////////////////////////////////////////////////////////
int main()
{
    CODE_RETOUR rc=CODE_OK; // Code de retour
    map<POSITION_MOT,string> tabMots;  // Contient les mots et leur position.
    string NomFichierLecture; // Contient le nom du fichier en lecture.

    POSITION_MOT PositionMot=0; // Contient la position du mot. 
    fstream FichierEntrer; // Stream du fichier a decoder
    fstream FichierSortie; // Stream du fichier decoder

    rc= OuvrirFichier(FichierEntrer,FichierSortie,NomFichierLecture);
    // Continue le traitement si il y a pas d'erreur.
    if(!rc)
    {
        string ligneFichier;    /* Contiendra le texte d'une ligne */
        unsigned int NumLigne=0;//Contiendra le numero de ligne

        /* Boucle sur l'ensemble des lignes du fichier */

        while ( getline(FichierEntrer, ligneFichier, '\n') && !rc)
        {
            size_t Pos=0,PosResultat=0; // Initialise la position dans la chaine a zero.
            NumLigne ++;
            while(PosResultat != -1 && !rc)
            {
                string LeMot = "";
                while(LeMot.length()==0 && Pos <= ligneFichier.length())
                {
                    // Trouve le premier espace qui separe deux mots.
                    PosResultat = ligneFichier.find(gSeparateurMot,Pos);                   
    
                    // Copie le mot
    		    LeMot=ligneFichier.substr(Pos, PosResultat - Pos);
                    if(LeMot.length()==0)
                    {
                        //Passe au caractere suivant.
                        Pos++;
			FichierSortie << ' ' ;
                    }
                }
                if(Pos <= ligneFichier.length() )
                {
                    rc=TraitementMot(LeMot,tabMots,PositionMot,NomFichierLecture,NumLigne,FichierSortie);
                    Pos=PosResultat+1;
                }
                else
                {
                    // Rendus a la fin de la ligne, indique fin de ligne.
                    PosResultat=-1;
                }

            }
            FichierSortie << endl;
        }
    }
    cout << "Fin du programme.";
    return rc;
}

