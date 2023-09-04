/*********************************************************/
/* $Id: tp3temp.hpp,v 1.3 2003/11/26 00:05:28 yann Exp $     */
/*********************************************************/

template <class E>
class ElementT
{
public:
    ElementT(E v, ElementT <E> * ptr = NULL) : valeur(v), suivant(ptr)
        {
        }
    E valeur;
    ElementT <E> * suivant;
};

template <class T >
class PileT
{
public:
    PileT();
    ~PileT();
    T sommet();
    PileT& empile(T);
    PileT& depile();
    PileT& depile(T&);
private:
    ElementT<T>* ptr;

};

///////////////////////////////////////////////////////////////////////////////
// Constructeur de pile.
///////////////////////////////////////////////////////////////////////////////
template <class T >
PileT<T>::PileT()
    {
    ptr=NULL;   
    }


///////////////////////////////////////////////////////////////////////////////
// Destructeur de pile, libere tous les elements contenus dans la pile
///////////////////////////////////////////////////////////////////////////////
template <class T >
PileT<T>::~PileT()
    {
    ElementT<T> *pSuivant=NULL; // Pointeur sur l'element suivant (ptr->suivant)
    ElementT<T> *pCourant=NULL; // Pointeur sur l'element courant (ptr)
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
template <class T >
T PileT<T>::sommet()
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
template <class T >
PileT<T>& PileT<T>::empile(T Valeur)
    {
    // Alloue le nouveau element avec le pointeur suivant qui pointe a l'ancien
    // sommet de pile
    ElementT <T> *pNouveau= new ElementT <T>(Valeur,ptr);

    // Mets jour le sommet de pile sur le nouveau element.
    ptr=pNouveau;           

    return *this;
    }

///////////////////////////////////////////////////////////////////////////////
// Enleve l'element au sommet de la pile.
///////////////////////////////////////////////////////////////////////////////
template <class T >
PileT<T>& PileT<T>::depile()
    {
    T Valeur;

    // Enleve l'element.
    depile(Valeur);

    return *this;
    }

///////////////////////////////////////////////////////////////////////////////
// Enleve et retourne l'element au sommet de la pile.
// Si la pile est vide, lance une exception.
///////////////////////////////////////////////////////////////////////////////
template <class T >
PileT<T>& PileT<T>::depile(T &Valeur)
    {

    // Verifie si la pile est vide.
    if ( ptr==NULL )
        {
        throw PileVide();
        }

    // Mets l'element dans la variable temporaire.
    ElementT <T> *pAncient=ptr;

    // retourne la valeur du sommet.
    Valeur=ptr->valeur;

    // mets le sommet de la pile sur le second element
    ptr=ptr->suivant;

    // Libere l'ancient sommet de la pile.
    delete pAncient;

    return *this;
    }

