///////////////////////////////////////////////////////////////////////////////
//$Id: personne.h,v 1.3 2004/03/21 19:44:50 yann Exp $                     
//Auteur : Yann Bourdeau (BOUY06097202)
///////////////////////////////////////////////////////////////////////////////
#ifndef PERSONNES_H
#define PERSONNES_H
#include <string>
#include <iostream>
#include <iomanip>
using namespace std;
//classe de base

enum TypGenre  {Masculin, Feminin};
enum TypCouleur {Bleu, Brun, Noir, Jaune, Vert, Pers};
class Personne
{
public:
  typedef struct TypAdresse;
  friend ostream& operator<<(ostream&, const TypAdresse&);
  friend ostream& operator<<(ostream&, const TypCouleur&);
  Personne(): nom(""), prenom("") {} // constructeur  
  Personne(string leNom, string lePrenom, TypGenre leSexe, 
           int laTaille, string lieu_Naissance, int laDate_Naissance, 
           TypCouleur lesYeux, int leNumero, string laRue,
           string laVille, string laProvince, string leTelephone)
  :nom(leNom),prenom(lePrenom),sexe(leSexe),taille(laTaille),
  pays_naissance(lieu_Naissance),date_naissance(laDate_Naissance),
  yeux(lesYeux),telephone(leTelephone){ adresse.numero = leNumero;
    adresse.rue = laRue;
    adresse.ville = laVille;
    adresse.province = laProvince;}
  
  string Nom() const{return nom;} 
  string Prenom() const{return prenom;}  // Conséquent: retourne le champ désiré.
  TypGenre Sexe()const{return sexe;} 
  int Taille()const{return taille;} 
  string Lieu_Naissance()const{return pays_naissance;} 
  int Date_Naissance()const{return date_naissance;} 
  TypCouleur Yeux()const{return yeux;} 
  TypAdresse Adresse()const{return adresse;} 
  string Telephone()const{return telephone;} 
  // Antécédent: la personne est définie.
  // Conséquent: retourne le champ désiré.
  void DonnerNom(string Nom){nom = Nom;}// Conséquent: Nom devient le nom de la personne.
  void DonnerPrenom(string Prenom){prenom = Prenom;}// Conséquent: Prenom devient le prénom la personne.
  virtual void Afficher() const;// Conséquent: les champs sont affichés.
  
#ifdef MSVC
// Permet de compiler avec Visual Studio.NET
  typedef struct TypAdresse {
                           int numero;
                           string rue;
                           string ville;
                           string province;};
#endif
protected:
#ifndef MSVC
// remet le fichier en mode original pour Code Warrior.
  typedef struct TypAdresse {
                           int numero;
                           string rue;
                           string ville;
                           string province;};
#endif

  string nom;
  string prenom;
  TypGenre sexe;
  int taille;
  string pays_naissance;
  int date_naissance;
  TypCouleur yeux;
  TypAdresse adresse;
  string telephone;
};
  
void Personne::Afficher() const
{
  cout << endl << "Nom: " << nom << " Prénom: " << prenom << " Sexe: " << sexe;
  cout << "Taille: " << taille << " Pays naissance: " << pays_naissance;
  cout << "Date naissance: " << date_naissance << " Yeux: " << yeux << endl;
  cout << "Adresse: " << adresse << endl;
  cout << "Téléphone: " << telephone << endl;
} //Afficher;

ostream& operator<<(ostream& sortie, const Personne::TypAdresse& Adresse)
{
  sortie << setw(4) << Adresse.numero << ' ' << Adresse.rue << ' ' 
         << Adresse.ville << ' ' << Adresse.province ;
  return sortie;
}

ostream& operator<<(ostream& sortie, const TypCouleur& Yeux)
{
  if(Yeux == Bleu )
    sortie << "Bleu ";
  else if(Yeux == Brun)
    sortie << "Brun ";
  else if(Yeux == Noir)
    sortie << "Noir ";
  else if(Yeux == Jaune)
    sortie << "Jaune";
  else if(Yeux == Vert)
    sortie << "Vert ";
  else if(Yeux == Pers)
    sortie << "Pers ";
  return sortie;
}
#endif

