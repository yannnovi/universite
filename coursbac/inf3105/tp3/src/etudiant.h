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
//classe dérivée

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
  string Code() const{return code;}  // Retourne le code de l'étudiant.
  int Date_Admission() const{return date_Admission;}  // Retourne la date de l'étudiant.
  int Derniere_Date() const{return derniere_Date;}  // Retourne la dernière date de l'étudiant.
  TypProgramme Programme() const{return programme;}  // Retourne le programme de l'étudiant.
  int Solde() const{return solde;}  // Retourne le solde de l'étudiant.
  int Credits() const{return credits;}  // Retourne lenombre de crédits de l'étudiant.
  bool Diplome() const{return diplome;}  // Retourne le fait que l'étudiant est diplômé.
  string Cours() const{return cours;}  // Retourne les cours de l'étudiant.
  void DonnerCode(string Code){code = Code;}  // Conséquent: l'étudiant possède un code.
  void Afficher() const; // redéfinit Personne::Afficher
                         // Conséquent: l'étudiant est affiché.
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