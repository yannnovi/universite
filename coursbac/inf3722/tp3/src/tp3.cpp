/*****************************************************************************/
/* $Id: tp3.cpp,v 1.7 2003/12/15 19:09:51 yann Exp $                         */
/*****************************************************************************/
/* Implemente un classe de pile.                                             */
/*                                                                           */
/* Auteurs: Sebastien Bonneau (bonneau.sebastien.2@courrier.uqam.ca)         */
/*          Yann Bourdeau (bourdeau.yann@courrier.uqam.ca)                   */
/*                                                                           */
/*****************************************************************************/
#include <iostream> 

#include "tp3.hpp"

using namespace std;

///////////////////////////////////////////////////////////////////////////////
// Constructeur de pile.
///////////////////////////////////////////////////////////////////////////////
Pile::Pile()
    {
    ptr=NULL;   
    }


///////////////////////////////////////////////////////////////////////////////
// Destructeur de pile, libere tous les elements contenus dans la pile
///////////////////////////////////////////////////////////////////////////////
Pile::~Pile()
    {
    Element *pSuivant=NULL; // Pointeur sur l'element suivant (ptr->suivant)
    Element *pCourant=NULL; // Pointeur sur l'element courant (ptr)
    pCourant=pSuivant=ptr;
    while ( pSuivant )
        {
        pSuivant=pCourant->suivant;
        delete(pCourant);
        pCourant=pSuivant;
        }
    }

///////////////////////////////////////////////////////////////////////////////
// Retourne l'element au sommet de la pile mais le laisse dans la pile.
// Si la pile est vide, lance une exception.
///////////////////////////////////////////////////////////////////////////////
int Pile::sommet()
    {
    // Verifie si la pile est vide.
    if ( ptr==NULL )
        {
        throw PileVide();
        }
    // Retourne la valeur
    return ptr->valeur;
    }

///////////////////////////////////////////////////////////////////////////////
// Empile un element sur la pile. Ajoute l'element au debut de la pile.
///////////////////////////////////////////////////////////////////////////////
Pile& Pile::empile(int Valeur)
    {
    // Alloue le nouveau element avec le pointeur suivant qui pointe a l'ancien
    // sommet de pile
    Element *pNouveau= new Element(Valeur,ptr);

    // Mets jour le sommet de pile sur le nouveau element.
    ptr=pNouveau;           

    return *this;
    }

///////////////////////////////////////////////////////////////////////////////
// Enleve l'element au sommet de la pile.
///////////////////////////////////////////////////////////////////////////////
Pile& Pile::depile()
    {
    int Valeur;

    // Enleve l'element.
    depile(Valeur);

    return *this;
    }

///////////////////////////////////////////////////////////////////////////////
// Enleve et retourne l'element au sommet de la pile.
// Si la pile est vide, lance une exception.
///////////////////////////////////////////////////////////////////////////////
Pile& Pile::depile(int &Valeur)
    {

    // Verifie si la pile est vide.
    if ( ptr==NULL )
        {
        throw PileVide();
        }

    // Mets l'element dans la variable temporaire.
    Element *pAncient=ptr;

    // retourne la valeur du sommet.
    Valeur=ptr->valeur;

    // mets le sommet de la pile sur le second element
    ptr=ptr->suivant;

    // Libere l'ancient sommet de la pile.
    delete pAncient;

    return *this;
    }



