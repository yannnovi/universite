///////////////////////////////////////////////////////////////////////////////
//$Id: etudiant.h,v 1.2 2004/03/21 19:44:50 yann Exp $                     
//Auteur : Yann Bourdeau (BOUY06097202)
///////////////////////////////////////////////////////////////////////////////
#ifndef ETUDIANT_H
#define ETUDIANT_H
#include <string>
#include <iostream>
#include "Personne.h"
using namespace std;
//classe d�riv�e

enum TypProgramme {bacSysInfo, bacGeniLog, bacSysRepa, certificat, certifDevL};
ostream& operator<<(ostream&, const TypProgramme&);

class Etudiant : public Personne
{
public:
  Etudiant(): Personne(), code(""){} //constructeur
  Etudiant(string Nom, string Prenom, TypGenre Sexe, int Taille, string Pays,
    int Date, TypCouleur Couleur, int Civique, string Rue, string Ville,
    string Province, string Telephone, string leCode, TypProgramme Sorte,
    int date1, int date2, int Credits, int Solde,  bool Diplomee, string lesCours)
  : Personne(Nom, Prenom, Sexe, Taille, Pays, Date, Couleur, Civique, Rue,
    Ville, Province,Telephone), code(leCode), programme(Sorte), date_Admission(date1),
    derniere_Date(date2), solde(Solde), credits(Credits), diplome(Diplomee), cours(lesCours){}
  string Code() const{return code;}  // Retourne le code de l'�tudiant.
  int Date_Admission() const{return date_Admission;}  // Retourne la date de l'�tudiant.
  int Derniere_Date() const{return derniere_Date;}  // Retourne la derni�re date de l'�tudiant.
  TypProgramme Programme() const{return programme;}  // Retourne le programme de l'�tudiant.
  int Solde() const{return solde;}  // Retourne le solde de l'�tudiant.
  int Credits() const{return credits;}  // Retourne lenombre de cr�dits de l'�tudiant.
  bool Diplome() const{return diplome;}  // Retourne le fait que l'�tudiant est dipl�m�.
  string Cours() const{return cours;}  // Retourne les cours de l'�tudiant.
  void DonnerCode(string Code){code = Code;}  // Cons�quent: l'�tudiant poss�de un code.
  void Afficher() const; // red�finit Personne::Afficher
                         // Cons�quent: l'�tudiant est affich�.
protected:
  string code;
  int date_Admission;
  int derniere_Date;
  TypProgramme programme;
  int solde;
  int credits;
  bool diplome;
  string cours;
};

void Etudiant::Afficher() const
{
    Personne::Afficher();
} //Afficher;


#endif