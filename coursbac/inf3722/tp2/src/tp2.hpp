/*****************************************************************************/
/* $Id: tp2.hpp,v 1.3 2003/11/07 20:08:19 yann Exp $ */
/*****************************************************************************/
#ifndef TP2_HPP__
#define TP2_HPP__
#include <iostream>

using namespace std;

// definition d'un incident de calcul
class Infinite
    {
public:
    Infinite()
    : message( "vous essayer de definir une nombre infini !" )
        {
        };
    const char *quoi() const
        {
        return message;
        };
private:
    const char *message;
    };
// definition du prototype de la classe Rationnel
class Rationnel
    {
public:
// constructeur par defaut
    Rationnel();
// un autre constructeur
    Rationnel(int numer, int denom = 1);
// prototypes des fonctions membres utilitaires
    Rationnel Addition(const Rationnel&) const;
    Rationnel Soustraction(const Rationnel&) const;
    Rationnel Multiplication(const Rationnel&) const;
    Rationnel Division(const Rationnel&) const;
    bool Egalite(const Rationnel&) const;
    void Mettre(ostream&) const;
    void Prendre(istream&);
protected:
// fonctions de consultation
    int vNumerateur() const;
    int vDenominateur() const;
// fonctions de modification
    void mNumerateur(int);
    void mDenominateur(int);
private:
// variables membres
    int valeurNumerateur;
    int valeurDenominateur;
    };
// prototypes des surcharges des operateurs de C++
Rationnel operator+(const Rationnel&, const Rationnel&);
Rationnel operator-(const Rationnel&, const Rationnel&);
Rationnel operator*(const Rationnel&, const Rationnel&);
Rationnel operator/(const Rationnel&, const Rationnel&);
bool operator==(const Rationnel&, const Rationnel&);
ostream& operator<<(ostream&, const Rationnel&);
istream& operator>>(istream&, Rationnel&);

#endif
