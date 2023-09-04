/*****************************************************************************/
/* $Id: test.cpp,v 1.8 2003/11/25 12:33:15 sebastien Exp $                   */
/*****************************************************************************/
/* Ce programme sert de pilote d'essai pour la classe Rationnel              */
/*                                                                           */
/* Auteur: Sebastien Bonneau (bonneau.sebastien.2@courrier.uqam.ca)          */
/*         Yann Bourdeau (bourdeau.yann@courrier.uqam.ca)                    */
/*                                                                           */
/*****************************************************************************/
#include <iostream> 
#include "tp2.hpp"
using namespace std;

/*****************************************************************************/
/* Fonction principal (main)                                                 */
/* Cette fonction contient l'ensemble des tests sur les fonctions et         */
/*  operateurs surcharges de la classe Rationnel. Les {} seront utilises     */
/*  pour delimiter les blocs de tests. Ce qui permettra de reutiliser les    */
/*  memes noms de variable tout au long du programme principal.              */
/*****************************************************************************/
void main (int argc, char *argv[])
    {
    cout << "TP2: " << endl;
    
    {
    // Test de la fonction Addition
    Rationnel rat1(2,5);
    Rationnel rat2(-2,5);
    Rationnel rat3 = rat1.Addition(rat2);
    cout << " 2/5 + -2/5 = " << rat3 << endl;
    }

    {
    // Test de l'operateur d'addition
    Rationnel rat1(2,5);
    Rationnel rat2(2,5);
    Rationnel rat3 = rat1 + rat2;
    cout << " 2/5 + 2/5 = " << rat3 << endl;
    }

    {
    // Test de la fonction division
    Rationnel rat1(2,9);
    Rationnel rat2(4,9);
    Rationnel rat3= rat2.Division(rat1);
    cout << " 4/9 / 2/9 = " << rat3 << endl;
    }

    {
    // Test de l'operateur de la division
    Rationnel rat1(2,9);
    Rationnel rat2(4,9);
    Rationnel rat3= rat2 / rat1;
    cout << " 4/9 / 2/9 = " << rat3 << endl;
    }

    {
    // Test de la fonction de l'egalite
    Rationnel rat2(4,9);
    Rationnel rat1(4,9);
    
    if (rat2.Egalite(rat1))
        cout << " " << rat2 << " == " << rat1 << endl;
    else
        cout << " " << rat2 << " != " << rat1 << endl;
    }

    {
    // Test de l'operateur de l'egalite
    Rationnel rat1(2,5);
    Rationnel rat2(4,9);
    
    if (rat1 == rat2)
       cout << " " << rat1 << " == " << rat2 << endl;
    else
       cout << " " << rat1 << " != " << rat2 << endl;
    }

    {
    // Test de la fonction de soustraction
    Rationnel rat1(2,3);
    Rationnel rat2(2,9);
    Rationnel rat3 = rat1.Soustraction(rat2);
    cout << " 2/3 - 2/9 = " << rat3 << endl;
    }

    {
    // Test de l'operateur de la soustraction
    Rationnel rat1(2,3);
    Rationnel rat2(2,9);
    Rationnel rat3 = rat1 - rat2;
    cout << " 2/3 - 2/9 = " << rat3 << endl;
    }

    {
    // Test de la fonction de multiplication
    Rationnel rat1(2,3);
    Rationnel rat2(2,9);
    Rationnel rat3 = rat1.Multiplication(rat2);
    cout << " 2/3 * 2/9 = " << rat3 << endl;
    }

    {
    // Test de l'operateur de multiplication
    Rationnel rat1(2,3);
    Rationnel rat2(2,9);
    Rationnel rat3 = rat1 * rat2;
    cout << " 2/3 * 2/9 = " << rat3 << endl;
    }

    {
    // Test des operateurs Mettre (<<) et Prendre (>>)
    Rationnel rat1;
    cout << "\nEntrez un rationnel format: numerateur/denominateur (1/5): ";
    cin >> rat1;
    cout << endl << "Le rationnel lus: " << rat1 << endl;
    }
    }

