/*****************************************************************************/
/* $Id: test.cpp,v 1.5 2003/12/15 19:09:51 yann Exp $                        */
/*****************************************************************************/
/*****************************************************************************/
/* Pilote de test de la classe pile et du "template" pile.                   */
/*                                                                           */
/* Auteurs: Sebastien Bonneau (bonneau.sebastien.2@courrier.uqam.ca)         */
/*          Yann Bourdeau (bourdeau.yann@courrier.uqam.ca)                   */
/*                                                                           */
/*****************************************************************************/
#include <iostream> 
#include "tp3.hpp"
#include "tp3temp.hpp"
using namespace std;
void main (int argc, char *argv[])
    {
    cout << "TP3: " << endl;
        {

        // TEST PILE INT
        Pile p;
        cout << "TEST1: Sommet d'une pile vide" << endl;
        try
            {
            p.sommet();
            cout << "erreur pile.sommet sur pile vide." << endl;
            }
        catch ( PileVide ep )
            {
            cout << ep.probleme() << endl;
            }

        cout << "TEST2: Depile une pile vide avec depile()" << endl;
        try
            {
            p.depile();
            cout << "ERREUR: pille.depile() sur pile vide." << endl;
            }
        catch ( PileVide ep )
            {
            cout << ep.probleme() << endl;
            }

        cout << "TEST3:Depile une pile vide avec depile(int)" << endl;
        try
            {
            int valeur;
            p.depile(valeur);
            cout << "ERREUR: pille.depile() sur pile vide." << endl;
            }
        catch ( PileVide ep )
            {
            cout << ep.probleme() << endl;
            }

        cout << "TEST4: Empile sur la pile 43,45 et depile" << endl;
        p.empile(43);
        p.empile(45);
        int Valeur; 
        cout << "  sommet: " << p.sommet() << endl;
        p.depile(Valeur);
        cout << "  depile: " << Valeur << endl;
        p.depile(Valeur);
        cout << "  depile: " << Valeur << endl;
        }
        // TEST  PILE TEMPLATE INT
        {
        cout << "TEST TEMPLATE INT" << endl;
        PileT <int> p;
        cout << "TEST1: Sommet d'une pile vide" << endl;
        try
            {
            p.sommet();
            cout << "erreur pile.sommet sur pile vide." << endl;
            }
        catch ( PileVide ep )
            {
            cout << ep.probleme() << endl;
            }

        cout << "TEST2: Depile une pile vide avec depile()" << endl;
        try
            {
            p.depile();
            cout << "ERREUR: pille.depile() sur pile vide." << endl;
            }
        catch ( PileVide ep )
            {
            cout << ep.probleme() << endl;
            }

        cout << "TEST3:Depile une pile vide avec depile(int)" << endl;
        try
            {
            int valeur;
            p.depile(valeur);
            cout << "ERREUR: pille.depile() sur pile vide." << endl;
            }
        catch ( PileVide ep )
            {
            cout << ep.probleme() << endl;
            }

        cout << "TEST4: Empile sur la pile 43,45 et depile" << endl;
        p.empile(43);
        p.empile(45);
        int Valeur; 
        cout << "  sommet: " << p.sommet() << endl;
        p.depile(Valeur);
        cout << "  depile: " << Valeur << endl;
        p.depile(Valeur);
        cout << "  depile: " << Valeur << endl;
        }
        // TEST  PILE TEMPLATE DOUBLE
        {
        cout << "TEST TEMPLATE DOUBLE" << endl;
        PileT <double> p;
        cout << "TEST1: Sommet d'une pile vide" << endl;
        try
            {
            p.sommet();
            cout << "erreur pile.sommet sur pile vide." << endl;
            }
        catch ( PileVide ep )
            {
            cout << ep.probleme() << endl;
            }

        cout << "TEST2: Depile une pile vide avec depile()" << endl;
        try
            {
            p.depile();
            cout << "ERREUR: pille.depile() sur pile vide." << endl;
            }
        catch ( PileVide ep )
            {
            cout << ep.probleme() << endl;
            }

        cout << "TEST3:Depile une pile vide avec depile(int)" << endl;
        try
            {
            double valeur;
            p.depile(valeur);
            cout << "ERREUR: pille.depile() sur pile vide." << endl;
            }
        catch ( PileVide ep )
            {
            cout << ep.probleme() << endl;
            }

        cout << "TEST4: Empile sur la pile 43,45 et depile" << endl;
        p.empile(43);
        p.empile(45);
        double Valeur; 
        cout << "  sommet: " << p.sommet() << endl;
        p.depile(Valeur);
        cout << "  depile: " << Valeur << endl;
        p.depile(Valeur);
        cout << "  depile: " << Valeur << endl;
        }

    }
