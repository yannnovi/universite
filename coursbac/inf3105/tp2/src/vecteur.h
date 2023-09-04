///////////////////////////////////////////////////////////////////////////////
//$Id: vecteur.h,v 1.9 2004/03/05 22:06:06 yann Exp $                     
//Auteur : Yann Bourdeau (BOUY06097202)
///////////////////////////////////////////////////////////////////////////////
#ifndef VECTEUR_H__
#define VECTEUR_H__
#include "exceptions.h"

#include <vector>
using namespace std;

///////////////////////////////////////////////////////////////////////////////
//  Classe vecteur.
// Gabarit qui permet de gerer un vecteur avec un indice de debut et de fin.
///////////////////////////////////////////////////////////////////////////////
template  <class T> class Vecteur : public vector<T>
{
public:
    Vecteur(int,int);
    void resize(int,int);
    const T &operator[](int) const;
    T &operator[](int);
    const T &at(int Indice) const;
    T &at(int Indice);
private:
    int IndexDebut;
    int IndexFin;
    int ajusteIndice(int Indice);
};

///////////////////////////////////////////////////////////////////////////////
// Fonction ajusteIndice
// Fait correspondre un indice Vecteur a un indice vector
// Parametre: int indice: Indice vecteur a ajuste
//            int: Indice ajuste.
///////////////////////////////////////////////////////////////////////////////
template <class T> int Vecteur<T> ::ajusteIndice(int indice)
{
    // Ajuste l'indice pour qu'il commence a zero.
    indice -= IndexDebut; 
    return indice;
}

///////////////////////////////////////////////////////////////////////////////
// Constructeur de classe vecteur
// Parametre: int IndiceDebut: Indice du debut du vecteur
//            int IndiceFin: Indice de la fin du vecteur
///////////////////////////////////////////////////////////////////////////////
template <class T> Vecteur<T> ::Vecteur(int IndiceDebut ,int IndiceFin):vector<T>()
{
    if(IndiceFin-IndiceDebut  < 0)
    {
        throw ErreurBorneInvalide("Bornes invalides, la difference entre l'indiceFin et l'indiceDebut doit etre positif.");
    }

    IndexDebut=IndiceDebut;
    IndexFin=IndiceFin;
    
        // Alloue le vecteur de la bonne grandeur
  	vector<T>::resize(   IndiceFin-IndiceDebut + 1);
  	
    // Alloue un objet pour avoir sa valeur par defaut.
    T *pValeurDefaut= new T();
    if(pValeurDefaut)
    {
        // Initialise chaque element a la valeur par defaut du type.
        for(int i=IndexDebut;i<=IndexFin;++i)
        {
            (*this)[i]=*pValeurDefaut;
        }
        delete pValeurDefaut;
    }
    else
    {
        // Lance une exception si impossible d'allour l'objet
        throw ErreurManqueMemoire("Manque de memoire");
    }

}

///////////////////////////////////////////////////////////////////////////////
// Operateur []
// Retourne une reference constante sur l'element specifie.
// Parametre: Indice: Indice de l'element a retourner.
// Retourne: reference constante sur l'element.
///////////////////////////////////////////////////////////////////////////////
template <class T> const T&  Vecteur<T> :: operator[](int Indice) const
{
    return at(Indice);
}

///////////////////////////////////////////////////////////////////////////////
// Operateur []
// Retourne une reference sur l'element specifie.
// Parametre: Indice: Indice de l'element a retourner.
// Retourne: reference sur l'element.
///////////////////////////////////////////////////////////////////////////////
template <class T> T& Vecteur<T> ::  operator[](int Indice)
{
    return at(Indice);
}

///////////////////////////////////////////////////////////////////////////////
// Methode Resize
// Change l'indice de fin et de debut du vecteur. Le contenu des indices qui
// existe encore vas etre sauvegarder.
///////////////////////////////////////////////////////////////////////////////
template <class T> void Vecteur<T>::resize(int IndiceDebut ,int IndiceFin)
{
    // Alloue un vecteur temporaire pour sauvegarder le contenu du vecteur.
    Vecteur<T> TempVect(IndexDebut,IndexFin);
    TempVect=(*this);

    // Fait un resize sur le vecteur existant.
    vector<T>::resize(IndiceFin-IndiceDebut + 1);

    // Mets les nouveaux indices de fin et de debut.
    IndexDebut=IndiceDebut;
    IndexFin=IndiceFin;

    // Alloue un objet pour avoir sa valeur par defaut.
    T *pValeurDefaut= new T();
    if(pValeurDefaut)
    {
        // Copie les elements qui existaient deja dans le vecteur sinon copie
        // la valeur par defaut.
        for(int i=IndexDebut;i<=IndexFin;++i)
        {
            if(i >= TempVect.IndexDebut && i <= TempVect.IndexFin)
            {
                (*this)[i]=TempVect[i];
            }
            else
            {
                
                (*this)[i]=*pValeurDefaut;
            }
        }
        delete pValeurDefaut;
    }
    else
    {
        // Lance une exception si impossible d'allour l'objet
        throw ErreurManqueMemoire("Manque de memoire");
    }
    
}

///////////////////////////////////////////////////////////////////////////////
// Methode at
// Retourne une reference constante sur l'element specifie.
// Parametre: Indice: Indice de l'element a retourner.
// Retourne: reference constante sur l'element.
///////////////////////////////////////////////////////////////////////////////
template <class T> const T& Vecteur<T>::at(int Indice) const
{
    // Verifie que l'indice est dans le vecteur
    if(Indice < IndexDebut || Indice > IndexFin)
    {
        // Lance une exception si l'indice n'est pas dans le vecteur
        throw ErreurLimiteIndice("Index Invalide",Indice,IndexDebut,IndexFin);
    }

    // Ajuste l'indice
    Indice =ajusteIndice(Indice); 

    // retourne l'element specifie.
    return vector<T>::at(Indice);
}

///////////////////////////////////////////////////////////////////////////////
// Methode at
// Retourne une reference sur l'element specifie.
// Parametre: Indice: Indice de l'element a retourner.
// Retourne: reference sur l'element.
///////////////////////////////////////////////////////////////////////////////
template <class T> T& Vecteur<T>::at(int Indice)
{
    // Verifie que l'indice est dans le vecteur
    if(Indice < IndexDebut || Indice > IndexFin)
    {
        // Lance une exception si l'indice n'est pas dans le vecteur
        throw ErreurLimiteIndice("Index Invalide",Indice,IndexDebut,IndexFin);
    }

    // Ajuste l'indice
    Indice =ajusteIndice(Indice); 

    // retourne l'element specifie.
    return vector<T>::at(Indice);
}

#endif
