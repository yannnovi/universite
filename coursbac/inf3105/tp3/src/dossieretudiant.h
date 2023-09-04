///////////////////////////////////////////////////////////////////////////////
//$Id: dossieretudiant.h,v 1.3 2004/03/29 18:27:12 yann Exp $                     
//Auteur : Yann Bourdeau (BOUY06097202)
///////////////////////////////////////////////////////////////////////////////
#ifndef DOSSIER_ETUDIANT__
#define DOSSIER_ETUDIANT__
#include <vector>
///////////////////////////////////////////////////////////////////////////////
// Enumeration des sigles de cours existant.
///////////////////////////////////////////////////////////////////////////////

enum TypSigle {INF1110,ADM1105,ECO1080,SCO1080,INF1130,INF2110,MAT4680,
               ADM1163,INF2160,INF2170,INF3102,INF3123,INF3172,INF3180,INF3722,
               INF4100,INF4170,INF4270,INF4481,INF5151,INF5153,INF5180,INF5270,
               INF5280,INM5151,INF6150,INM5000,INM5800,INM5801,INM6000,VIDE};

#include "exceptions.h" // exception.h utilise TypSigle, donc inclure apres
                        // TypSigle

///////////////////////////////////////////////////////////////////////////////
// Cette classe represente le dossier d'un etudiant. Comprends l'inscription
// des cours par etudiant.               
///////////////////////////////////////////////////////////////////////////////
class DossierEtudiant
{
public:
    DossierEtudiant();
    DossierEtudiant(const Etudiant*);
    void inscriptionCours(TypSigle);
    void retraitCours(TypSigle);
    const Etudiant* getEtudiant(void) const;
    const vector<TypSigle> & getCours(void) const;
    unsigned int getNumCours(void) const;
private:
    static const int MAXIMUM_COURS=6;
    vector <TypSigle> cours;
    const Etudiant* pEtudiant;
};

///////////////////////////////////////////////////////////////////////////////
// Constructeur par defaut d'un DossierEtudiant.
///////////////////////////////////////////////////////////////////////////////
DossierEtudiant::DossierEtudiant()
{
    // Appelle le constructeur avec un parametre.
    DossierEtudiant(NULL);
}

///////////////////////////////////////////////////////////////////////////////
// Constructeur de DossierEtudiant.
// Parametre: pEtudiant: pointeur constant sur l'etudiant.
///////////////////////////////////////////////////////////////////////////////
DossierEtudiant::DossierEtudiant(const Etudiant *pEtudiant)
{
    // Copie l'etudiant.
    this->pEtudiant=pEtudiant;

    // Mets le vecteur cours a la grandre MAXIMUM_COURS.
    cours.resize(MAXIMUM_COURS);

    // Initialise tous les cours par VIDE
    for(vector<TypSigle>::iterator i=cours.begin();
         i!=cours.end();
         ++i)
    {
        (*i)=VIDE;
    }
}


///////////////////////////////////////////////////////////////////////////////
// Cette methode inscript un etudiant a un cours.
// Parametre: cours: Sigle du cours a inscrire.
///////////////////////////////////////////////////////////////////////////////
void DossierEtudiant::inscriptionCours(TypSigle cours)
{
    bool ajoutFait=false; // Determine si l'ajout a ete fait.

    // Essaye de trouver un espace libre dans le vecteur cours.
    for(vector<TypSigle>::iterator i=this->cours.begin();
         i!=this->cours.end() && !ajoutFait;
         ++i)
    {
        // Verifie que l'etudiant ne soit pas deja inscrit a ce cours.
        if((*i)==cours)
        {
            throw ExceptionInscriptionCours("L'etudiant est deja inscrit au cours.",cours);
        }
        else
        {
            // Si le cours est vide, ajoute l'etudiant.
            if((*i)==VIDE)
            {
                (*i)=cours;
                ajoutFait=true;
            }
        }
    }

    // Si l'ajout n'as pas ete fait c'est que l'etudiant est deja inscrit a 6 cours.
    if(!ajoutFait)
    {
        throw ExceptionInscriptionCours("L'etudiant ne peut pas s'inscrire a plus de cours.",cours);
    }
        
}

///////////////////////////////////////////////////////////////////////////////
// Cette methode enleve un cours au dossier etudiant.
// Parametre: cours: sigle du cours a enlever.
///////////////////////////////////////////////////////////////////////////////
void DossierEtudiant::retraitCours(TypSigle cours)
{
    bool coursEnlever=false; // Determine si le cours a ete enlever

    // Cherche le cours pour l'enlever.
    for(vector<TypSigle>::iterator i=this->cours.begin();
         i!=this->cours.end() && !coursEnlever;
         ++i)
    {
        if((*i)==cours)
        {
            (*i)=VIDE;
            coursEnlever=true;
        }
    }

    // Si le cours a pas ete enlever, donc l'etudiant n'etait pas inscrit.
    if(!coursEnlever)
    {
        throw ExceptionRetraitCours("L'etudiant n'est pas inscrit a ce cours.",cours);
    }
}

///////////////////////////////////////////////////////////////////////////////
// Cette methode retourne le pointeur constant etudiant associe au dossier
// etudiant.
// Retourne: Pointer sur l'etudiant.
///////////////////////////////////////////////////////////////////////////////
const Etudiant* DossierEtudiant::getEtudiant(void) const
{
    return pEtudiant;
}

///////////////////////////////////////////////////////////////////////////////
// Cette methode retourne le vecteur contenant tous les cours de l'etudiant.
// Retourne: Le vecteur contenant les cours.
///////////////////////////////////////////////////////////////////////////////
const vector<TypSigle> & DossierEtudiant::getCours(void) const
{
    return cours;
}

///////////////////////////////////////////////////////////////////////////////
// Cette methode retourne le nombre de cours inscrit au dossier etudiant.
// retourne: un entier contenant le nombre de cours.
///////////////////////////////////////////////////////////////////////////////
unsigned int DossierEtudiant::getNumCours(void) const
{
    unsigned int numCours=0;
    
    for (vector<TypSigle>::const_iterator i = cours.begin();
          i != cours.end();
          i++)
    {
        if(*i != VIDE)
        {
            numCours++;
        }
    }

    return numCours;
}
#endif
