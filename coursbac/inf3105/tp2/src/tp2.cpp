///////////////////////////////////////////////////////////////////////////////
//$Id: tp2.cpp,v 1.9 2004/03/17 13:49:44 yann Exp $               
//Auteur : Yann Bourdeau (BOUY06097202)      
///////////////////////////////////////////////////////////////////////////////

#include <iostream>
#include <fstream>

#include "vecteur.h"
#include "string"
#include "exceptions.h"
using namespace std;

///////////////////////////////////////////////////////////////////////////////
// Programme qui test le gabarit Vecteur.
///////////////////////////////////////////////////////////////////////////////
void main()
{
    Vecteur<char> majuscules(65,90);
    char charus='A';
    cout << "TP2" << endl;
    cout << "Test tableau majuscules" << endl;
    for(int i=65;i<=90;i++)
    {
        majuscules[i]=charus;
        charus++;
    }

    cout << "majuscules(65,90) resultat:";
    for(int i=65;i<=90;++i)
    {
        cout << majuscules[i] << ",";
    }

    cout << endl;
    cout << "===============================================================================" << endl;
    cout << "Test majuscules resize" << endl;
    majuscules.resize(30,70);
    cout << "majuscules.resize(30,70) resultat:";
    for(int i=30;i<=70;++i)
    {
        cout << majuscules[i] << ",";
    }

    cout << endl;
    cout << "===============================================================================" << endl;
    cout << "Test majuscules.at(65):" << majuscules.at(65) << endl ;
    cout << "===============================================================================" << endl;
    cout << "Test temperature non initialise" << endl;
    Vecteur<double> temperatures(-10,25);
    cout <<"temperatures(-10,25) resultat non initialise:" ;
    for(int i=-10;i<=25;++i)
    {
        cout << temperatures[i] << ',';
    }
    cout << endl;
    cout << "===============================================================================" << endl;
    cout << "Test temperature initialise" << endl;
    for(int i=-10;i<=25; ++i)
    {
        temperatures[i]=((1.8)*i)+32;
    }

    cout <<"temperatures(-10,25) resultat initialise:" ;
    for(int i=-10;i<=25;++i)
    {
        cout << temperatures[i] << ',';
    }
    cout << endl;
    cout << "===============================================================================" << endl;
    cout << "Test ErreurLimiteException:";
    try
    {
        majuscules[500]='i';
        cout << "Erreur, gestion sur indice" << endl;
            
    }
    catch(ErreurLimiteIndice &e)
    {
        cout << e.what() << ". Indice:" << e.getIndiceEnErreur() << " Indice Minimum:" << e.getIndiceMinimum() << " Indice Maximum:" << e.getIndiceMaximum()<< endl;
    }
    cout << "===============================================================================" << endl;
    cout << "Test ouverture de fichier non existant" << endl;
    string NomFichierLecture="raisin.sec";
    try
    {
        
        fstream FichierEntrer; // Fichier d'entrer, le fichier a encoder.

        FichierEntrer.open( NomFichierLecture.c_str(),ios::in);

        // Le fichier n'a pas pu s'ouvrir 
        if ( !FichierEntrer.is_open() )
        {
            throw ErreurOuvertureFichier(NomFichierLecture.c_str());
        }
        cout << "Erreur, gestion d' ouverture de fichier" << endl;
    }
    catch(ErreurOuvertureFichier &e)
    {
        cout << e.what() << "  Fichier:" << e.getNomFichier() << endl;
    }
    cout << "===============================================================================" << endl;
    cout << "Test borne -10 a -5" << endl;


    try
    {
        Vecteur<int> p(-10,-5);
        cout << "OK" << endl;
    }
    catch (ErreurBorneInvalide &e)
    {
        cout << "erreur test:"<< e.what() << endl;
    }
    cout << "===============================================================================" << endl;
    cout << "Test convertis fichier de celsius a fahrenheit (valeur de -10 a 25 seulement)" << endl;
    
    try
    {
        cout << "Entrez le nom du fichier a convertir:";
        string source;
        cin >> source;

        fstream FichierEntrer; 

        // Le constructeur de ifstream ouvre le fichier 
        FichierEntrer.open( source.c_str(),ios::in);

        // Le fichier n'a pas pu s'ouvrir 
        if ( !FichierEntrer.is_open() )
        {
            throw ErreurOuvertureFichier(source.c_str());
        }

        cout << "entrez le nom du fichier de sortie:";
        string sortie;
        cin >> sortie;

        ofstream FichierSortie(sortie.c_str());
        string ligneFichier;
        /* Boucle sur l'ensemble des lignes du fichier */
        
        while ( getline(FichierEntrer, ligneFichier, '\n'))
        {
            size_t Pos=0,PosResultat=0; // Initialise la position dans la chaine a zero.
            while(PosResultat != -1)
            {
                string LeMot = "";
                while(LeMot.length()==0 && Pos <= ligneFichier.length())
                {
                    // Trouve le premier espace qui separe deux mots.
                    PosResultat = ligneFichier.find(" ",Pos);                   
        
                    // Copie le mot
                    LeMot=ligneFichier.substr(Pos, PosResultat - Pos);
                    if(LeMot.length()==0)
                    {
                        //Passe au caractere suivant.
                        Pos++;
                    }
                }
                if(Pos <= ligneFichier.length() )
                {
                    try
                    {
                        FichierSortie << temperatures.at(atoi(LeMot.c_str())) << " ";
                    }
                    catch(ErreurLimiteIndice &e)
                    {
                        cout << "Temperature hors borne (-10 a 25)." << e.what() << endl;
                    }
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
    catch(ErreurOuvertureFichier &e)
    {
        cout << e.what() << "  Fichier:" << e.getNomFichier() << endl;
    }
}
