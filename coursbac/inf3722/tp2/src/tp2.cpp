/***************************************************************/
/* $Id: tp2.cpp,v 1.17 2003/11/25 12:33:15 sebastien Exp $     */
/***************************************************************/
/***************************************************************/
/* Fonction principal du programme.                            */
/***************************************************************/
#include <iostream>
#include <math.h> 

#include "tp2.hpp"

using namespace std;

///////////////////////////////////////////////////////////////////////////////
// Cette fonction trouve le pgcd de deux nombres
// Parametres: IN nb1: Premier nombre
//             IN nb2: Second nombre
// Retourne le pgcd
///////////////////////////////////////////////////////////////////////////////
static int pgcd(int nb1, int nb2) 
    {
    // Mets les nombres positif
    nb1= abs(nb1);
    nb2= abs(nb2);

    if (nb2 == 0)
        return nb1;
    else
        return pgcd(nb2, nb1 % nb2);
    }

///////////////////////////////////////////////////////////////////////////////
// Constructeur par defaut.
///////////////////////////////////////////////////////////////////////////////
Rationnel::Rationnel()
    {}

///////////////////////////////////////////////////////////////////////////////
// Constructeur
// Parametres: IN numer: Numerateur du rationnel
//             IN denom: Denominateur du rationnel
///////////////////////////////////////////////////////////////////////////////
Rationnel::Rationnel(int numer, int denom)
    : valeurNumerateur(numer), valeurDenominateur(denom)
    {
    // Si le denominateur est 0, lance exception
    if (denom == 0)
        throw Infinite();
    }

///////////////////////////////////////////////////////////////////////////////
// Cette fonction additionne deux rationnels
// Parametre: IN Rat2: Le rationnel a additionner
// Retourne le rationnel resultant
///////////////////////////////////////////////////////////////////////////////
Rationnel Rationnel::Addition(const Rationnel& rat2) const
    {
    Rationnel resultat; // Le rationnel resultat
    int diviseur;       // Pgcd entre le numerateur et denominateur du resultat

    // Mets le denominateur resultat commun au deux nombres
    resultat.mDenominateur(vDenominateur() * rat2.vDenominateur());

    // Multiplie le numerateur du premier rationnel par le denominateur du second
    //  Additionne cela au numerateur du second rationnel par le denominateur du premier
    resultat.mNumerateur((vNumerateur() * rat2.vDenominateur()) 
                       + (rat2.vNumerateur() * vDenominateur()));

    // Trouve le pgcd du rationnel resultat
    diviseur= pgcd(resultat.vNumerateur(), resultat.vDenominateur());

    // Ajuste le rationnel resultat en divisant par le pcgd
    resultat.mNumerateur(resultat.vNumerateur() / diviseur);
    resultat.mDenominateur(resultat.vDenominateur() / diviseur);

    return resultat;
    }

///////////////////////////////////////////////////////////////////////////////
// Cette fonction soustrait deux nombres rationnels
// Parametre: IN rat2: Le rationnel a soustraire
// Retourne le rationnel resultant
///////////////////////////////////////////////////////////////////////////////
Rationnel Rationnel::Soustraction(const Rationnel& rat2) const
    {
    Rationnel resultat; // Le rationnel resultat
    int diviseur;       // Pgcd entre le numerateur et denominateur du resultat

    // Mets le denominateur resultat commun au deux nombres
    resultat.mDenominateur(vDenominateur() * rat2.vDenominateur());
    
    // Effectue la soustraction des deux relationnels
    resultat.mNumerateur((vNumerateur() * rat2.vDenominateur()) 
                       - (vDenominateur() * rat2.vNumerateur()));

    // Trouve le pgcd du rationnel resultat
    diviseur= pgcd(resultat.vNumerateur(), resultat.vDenominateur());

    // Ajuste le rationnel resultat en divisant par le pcgd
    resultat.mNumerateur(resultat.vNumerateur() / diviseur);
    resultat.mDenominateur(resultat.vDenominateur() / diviseur);

    return resultat;
    }

///////////////////////////////////////////////////////////////////////////////
// Cette fonction multiplie deux nombres rationnels
// Parametre: IN rat2: Le rationnel a multiplier
// Retourne le rationnel resultant
///////////////////////////////////////////////////////////////////////////////
Rationnel Rationnel::Multiplication(const Rationnel& rat2) const
    {
    Rationnel resultat; // Le rationnel resultat
    int diviseur;       // Pgcd entre le numerateur et denominateur du resultat

    // Effectue la multiplication des numerateur des deux rationnels
    resultat.mNumerateur(vNumerateur() * rat2.vNumerateur());
    
    // Effectue la multiplication des denominateur des deux rationnels
    resultat.mDenominateur(vDenominateur() * rat2.vDenominateur());

    // Trouve le pgcd du rationnel resultat
    diviseur= pgcd(resultat.vNumerateur(), resultat.vDenominateur());

    // Ajuste le rationnel resultat en divisant par le pcgd
    resultat.mNumerateur(resultat.vNumerateur() / diviseur);
    resultat.mDenominateur(resultat.vDenominateur() / diviseur);

    return resultat;
    }

///////////////////////////////////////////////////////////////////////////////
// Cette fonction divise un rationnel par un rationnel
// Parametre: IN rat2: Le rationnel diviseur
// Retourne le rationnel resultant
///////////////////////////////////////////////////////////////////////////////
Rationnel Rationnel::Division(const Rationnel& rat2) const
    {
    Rationnel resultat; // Le rationnel resultat
    int diviseur;       // Pgcd entre le numerateur et denominateur du resultat
    int temp;           // Variable temporaire

    // Inverser le rationnel diviseur
    Rationnel tempRat= rat2;
    temp= tempRat.vNumerateur();
    tempRat.mNumerateur(tempRat.vDenominateur());
    tempRat.mDenominateur(temp);
    
    // Mets le denominateur resultat commun aux deux nombres
    resultat.mDenominateur(vDenominateur() * tempRat.vDenominateur());

    // Multiplie le numerateur du premier rationnel par le numerateur du second
    resultat.mNumerateur(vNumerateur() * tempRat.vNumerateur());
    
    // Trouve le pgcd du rationnel resultat
    diviseur= pgcd(resultat.vNumerateur(), resultat.vDenominateur());

    // Ajuste le rationnel resultat en divisant par le pcgd
    resultat.mNumerateur(resultat.vNumerateur() / diviseur);
    resultat.mDenominateur(resultat.vDenominateur() / diviseur);

    return resultat;
    }

///////////////////////////////////////////////////////////////////////////////
// Fonction qui determine si deux rationnel sont equivalent
// Parametre: IN rat2: deuxieme rationnel a compare
// Retourne TRUE si equivalent
//          sinon FALSE
///////////////////////////////////////////////////////////////////////////////
bool Rationnel::Egalite(const Rationnel& rat2) const
    {
    return ((vNumerateur() * rat2.vDenominateur()) == (rat2.vNumerateur() * vDenominateur()));
    }

///////////////////////////////////////////////////////////////////////////////
// Fonction qui envoi dans un stream un rationnel
// Parametre: IN OUT stream: Stream qui vas contenir le rationnel
///////////////////////////////////////////////////////////////////////////////
void Rationnel::Mettre(ostream& stream) const
    {
    stream << vNumerateur();
    
    // Affiche le denominateur seulement s'il est different de 1
    if (vDenominateur() != 1)
        stream << "/" << vDenominateur();
    }

///////////////////////////////////////////////////////////////////////////////
// Fonction qui lis dans un stream un rationnel.
// Parametre: IN OUT: Stream qui recoit le rationnel
///////////////////////////////////////////////////////////////////////////////
void Rationnel::Prendre(istream& stream)
    {
    char temp[1];
    stream >>  valeurNumerateur >> temp[0] >> valeurDenominateur;
    }

///////////////////////////////////////////////////////////////////////////////
// Fonction qui retourne le numerateur du rationnel
// Retourne le numerateur
///////////////////////////////////////////////////////////////////////////////
int Rationnel::vNumerateur() const
    {
    return valeurNumerateur;
    }

///////////////////////////////////////////////////////////////////////////////
// Fonction qui retourne le denominateur du rationnel
// Retourne le denominateur
///////////////////////////////////////////////////////////////////////////////
int Rationnel::vDenominateur() const
    {
    return valeurDenominateur;
    }

///////////////////////////////////////////////////////////////////////////////
// Fonctione qui assigne le numerateur
// Parametre: IN num: Numerateur a assigner
///////////////////////////////////////////////////////////////////////////////
void Rationnel::mNumerateur(int num)
    {
    valeurNumerateur= num;
    }

///////////////////////////////////////////////////////////////////////////////
// Fonction qui assigne le denominateur
// Parametre: IN denom: Denominateur a assigner
///////////////////////////////////////////////////////////////////////////////
void Rationnel::mDenominateur(int denom)
    {
    valeurDenominateur= denom;
    }

///////////////////////////////////////////////////////////////////////////////
// Fonction surcharge qui permet d'afficher un rationnel dans un stream
// Parametres: IN OUT stream : Stream qui doit recevoir le rationnel
//             IN     rat    : Rationnel a afficher
// Retourne le stream
///////////////////////////////////////////////////////////////////////////////
ostream& operator<<(ostream& stream, const Rationnel& rat)
    {
    rat.Mettre(stream);

    return stream;
    }

///////////////////////////////////////////////////////////////////////////////
// Fonction surcharge qui permet de lire un rationnel dans un stream
// Parametres: IN OUT stream : Stream qui doit envois le rationnel
//             IN     rat    : Rationnel a lire
// Retourne le stream
///////////////////////////////////////////////////////////////////////////////
istream& operator>>(istream& stream, Rationnel& rat)
    {
    rat.Prendre(stream);

    return stream;
    }

///////////////////////////////////////////////////////////////////////////////
// Fonction surcharge qui permet de verifier si deux nombres rationnels sont egaux
// Parametres: IN rat1: Premier rationnel a comparer
//             IN rat2: Second rationnel a comparer
// Retourne le stream
///////////////////////////////////////////////////////////////////////////////
bool operator==(const Rationnel& rat1, const Rationnel& rat2)
    {
    return rat1.Egalite(rat2);
    }

///////////////////////////////////////////////////////////////////////////////
// Fonction surcharge qui additionne deux rationnels
// Parametres: IN rat1: Premier rationnel a additionner
//             IN rat2: Second rationnel a additionner
// Retourne le rationnel resultat
///////////////////////////////////////////////////////////////////////////////
Rationnel operator+(const Rationnel& rat1, const Rationnel& rat2)
    {
    return rat1.Addition(rat2);
    }

///////////////////////////////////////////////////////////////////////////////
// Fonction surcharge qui soustrait deux rationnels
// Parametres: IN rat1: Premier rationnel a soustraire
//             IN rat2: Second rationnel a soustraire
// Retourne le rationnel resultat
///////////////////////////////////////////////////////////////////////////////
Rationnel operator-(const Rationnel& rat1, const Rationnel& rat2)
    {
    return rat1.Soustraction(rat2);
    }

///////////////////////////////////////////////////////////////////////////////
// Fonction surcharge qui multiplie deux rationnels
// Parametres: IN rat1: Premier rationnel a multiplier
//             IN rat2: Second rationnel a multiplier
// Retourne le rationnel resultat
///////////////////////////////////////////////////////////////////////////////
Rationnel operator*(const Rationnel& rat1, const Rationnel& rat2)
    {
    return rat1.Multiplication(rat2);
    }

///////////////////////////////////////////////////////////////////////////////
// Fonction surcharge qui divise deux rationnels
// Parametres: IN rat1: Premier rationnel a diviser
//             IN rat2: Second rationnel a diviser
// Retourne le rationnel resultat
///////////////////////////////////////////////////////////////////////////////
Rationnel operator/(const Rationnel& rat1, const Rationnel& rat2)
    {
    return rat1.Division(rat2);
    }