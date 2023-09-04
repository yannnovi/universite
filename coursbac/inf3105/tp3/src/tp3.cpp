///////////////////////////////////////////////////////////////////////////////
//$Id: tp3.cpp,v 1.9 2004/04/16 14:29:11 yann Exp $                     
//Auteur : Yann Bourdeau (BOUY06097202)
///////////////////////////////////////////////////////////////////////////////
//#include <stdafx.h>
#include "etudiant.h"
#include "dossieretudiant.h"
#include "exceptions.h"
#include <vector>
#include <fstream>
#include <map>
using namespace std;

// Prototypes.
char *enleveEspaceALaFin(char *pChaine,int longueur);
char * enleveEspaceDebut(char *pChaine);
int convertisDate(char *date);
void lireFichierEtudiantDansVecteurPersonne(vector<Etudiant*> &vecteurEtudiant,
                                            map<string,DossierEtudiant> &dossierEtudiants);
TypSigle convertisChaineEnCours(char *pChaine);
void lireFichierCoursDansDossiersEtudiants(const vector<Etudiant*> &vecteurEtudiant,
                                           map<string,DossierEtudiant> &dossierEtudiants);
string convertisDateEnChaine(int Date);
string convertisProgrammeEnChaine(TypProgramme programme );
string transformeSigleEnChaine(TypSigle cours);
void AfficheResultat(ostream & sortie,const DossierEtudiant  &dossier);
void genereEtAfficheListeParProgramme(const map<string,DossierEtudiant> &dossiersEtudiants);
void genereEtAfficheListeParCours(map<string,DossierEtudiant> dossiersEtudiants);
void LibereMemoire(vector<Etudiant*> vecteurEtudiant);
void main();

///////////////////////////////////////////////////////////////////////////////
// Cette fonction enleve les espaces a la fin d'une chaine de caracteres.
// Parametres: pChaine : La chaine de caracteres
//             longueur: longueur de la chaine de caractere
// Retourne: La chaine
///////////////////////////////////////////////////////////////////////////////
char *enleveEspaceALaFin(char *pChaine,int longueur)
{
    bool carTrouve=false; // Determine si il y a autre chose qu'un espace blanc
                          // de trouve.

    // Boucle a partir de la fin de la chaine.
    for (int i=longueur-1;i>=0 && !carTrouve;--i)
    {
        // si espace blanc, remplace le caractere par un 0.
        if(pChaine[i]==' ' && !carTrouve)
        {
            pChaine[i]=0;
        }
        else
        {
            carTrouve=true;
        }
    }
    return pChaine;
}

/*****************************************************************************/
/* Cette fonction enleve les espaces blancs au debut d'une chaine            */
/* PARAMETRE: pChaine: Chaine qui contient les espaces a enlever             */
/* RETOURNE: la chaine                                                       */
/*****************************************************************************/
char * enleveEspaceDebut(char *pChaine)
{
     /* Boucle sur les espaces blancs au debut de la chaine */
     while(strlen(pChaine) > 0 && pChaine[0] == ' ')
     {
         unsigned int i= 0; // variable temporaire qui sert a garder l'index.
         /* Deplace les caracteres vers la gauche de 1 caractere */
         for(i= 0; i < strlen(pChaine); ++i)
             pChaine[i]= pChaine[i + 1];     
     }
     return pChaine;
}

 

///////////////////////////////////////////////////////////////////////////////
// Cette fonctions convertis une date en format jj/mm/aaaa en un entier.
// Parametre: date: La date a convertir
// Retourne: Entier : La date convertis.
///////////////////////////////////////////////////////////////////////////////
int convertisDate(char *date)
{
    union
    {
        char chaineDate[10];
        struct {
                char jour[2];
                char filler1[1];
                char mois[2];
                char filler2[1];
                char annee[4];
               } date;
    } unionDate; // Contient le format de la date en chaine, pratique pour le
                 // convertir

    char chaineDateCompacte[9]=""; // contient la date sans les /.

    // Copie la date dans l'union pour la decortiquer.
    memcpy(unionDate.chaineDate,date,sizeof(unionDate.chaineDate));
    
    // Copie chaque element de la date.
    strncat(chaineDateCompacte,unionDate.date.jour,sizeof(unionDate.date.jour ));
    strncat(chaineDateCompacte,unionDate.date.mois,sizeof(unionDate.date.mois));
    strncat(chaineDateCompacte,unionDate.date.annee,sizeof(unionDate.date.annee));
    return atoi(chaineDateCompacte);
}
///////////////////////////////////////////////////////////////////////////////
// Cette fonction lis les enregistrement de etudiants.dat et les ajoutes aux
// vecteurs etudiants.
// Parametre: vecteurEtudiant: Vecteur qui vas contenir tous les etudiants.
///////////////////////////////////////////////////////////////////////////////
void lireFichierEtudiantDansVecteurPersonne(vector<Etudiant*> &vecteurEtudiant,
                                            map<string,DossierEtudiant> &dossierEtudiants)
{
    // variable qui represente une entree du fichier etudiant.dat
    union
    {
        char chaineRecord[598];
        struct
        {
            char nom[15];
            char prenom[15];
            char sexe;
            char taille[3];
            char pays[15];
            char dateNaissance[10];
            char couleurYeux[5];
            char numeroCivique[4];
            char rue[15];
            char ville[15];
            char province[10];
            char telephone[13];
            char dateAdmission[10];
            char dateDerniereInscription[10];
            char programme[10];
            char historiqueCours[30][14];
            char diplome[5];
            char codeEtudiant[12];
            char solde[7];
            char credits[3];
        } structureRecord;
    } fichierEtudiantRecord;

    fstream fichierEntrer; // Stream de lecture du fichier.

    // Demande a l'utilisateur le nom du fichier etudiants.dat
    cout << "Nom du fichier etudiants:" ;
    string nomFichier;
    cin >> nomFichier;
    
    
    cout << "lecture " << nomFichier << endl ;

    // Le constructeur de ifstream ouvre le fichier 
    fichierEntrer.open( nomFichier.c_str(),ios::in);

    // Le fichier n'a pas pu s'ouvrir 
    if ( !fichierEntrer.is_open() )
    {
        throw ExceptionFichier("Impossible d'ouvrir le fichier." ,nomFichier.c_str());
    }

    string ligneFichier; // Contient une ligne (enregistrement) lus dans le fichier
    unsigned int numLigne=0; // Contient le numero de la ligne courante.

    /* Boucle sur l'ensemble des lignes du fichier */
    while ( getline(fichierEntrer, ligneFichier, '\n') )
    {
        numLigne++;

        // verifie que l'enregistrement soit de bonne taille
        if(ligneFichier.length() != sizeof(fichierEtudiantRecord.chaineRecord))
        {
            throw ExceptionEnregistrementInvalide("L'enregistrement n'est pas de taille de 598 caracteres." ,nomFichier.c_str(),numLigne);
        }

        // Copie la ligne lue, dans le record pour le decortiquer
        strncpy(fichierEtudiantRecord.chaineRecord,ligneFichier.c_str(),sizeof(fichierEtudiantRecord.chaineRecord));

        // definis les variables temporaire de l'enregistrement
        // et
        // transforme les variable de l'enregistrement en bon format.

        // Traite le nom
        char nom[sizeof(fichierEtudiantRecord.structureRecord.nom)+1]="";
        enleveEspaceALaFin(strncat(nom,fichierEtudiantRecord.structureRecord.nom,sizeof(fichierEtudiantRecord.structureRecord.nom)),sizeof(fichierEtudiantRecord.structureRecord.nom));

        // Traite le prenom.
        char prenom[sizeof(fichierEtudiantRecord.structureRecord.prenom)+1]="";
        enleveEspaceALaFin(strncat(prenom,fichierEtudiantRecord.structureRecord.prenom,sizeof(fichierEtudiantRecord.structureRecord.prenom)),sizeof(fichierEtudiantRecord.structureRecord.prenom));

        // Traite le genre de la personne
        TypGenre genre;
        if(fichierEtudiantRecord.structureRecord.sexe == 'M' || fichierEtudiantRecord.structureRecord.sexe == 'm')
        {
            genre=Masculin;
        }
        else
        {
            if(fichierEtudiantRecord.structureRecord.sexe == 'F' || fichierEtudiantRecord.structureRecord.sexe == 'f')
            {
                genre=Feminin;
            }
            else
            {
                throw ExceptionEnregistrementInvalide("Sexe inconnue" ,nomFichier.c_str(),numLigne);
            }
        }

        // traite la taille de l'etudiant
        char chaineTaille[sizeof(fichierEtudiantRecord.structureRecord.taille)+1]="";
        int taille=atoi(strncat(chaineTaille,fichierEtudiantRecord.structureRecord.taille,sizeof(fichierEtudiantRecord.structureRecord.taille)));

        // Traite le pays
        char pays[sizeof(fichierEtudiantRecord.structureRecord.pays)+1]="";
        enleveEspaceALaFin(strncat(pays,fichierEtudiantRecord.structureRecord.pays,sizeof(fichierEtudiantRecord.structureRecord.pays)),sizeof(fichierEtudiantRecord.structureRecord.pays));

        // Traite la date de naissance.
        int dateDeNaissance=convertisDate(fichierEtudiantRecord.structureRecord.dateNaissance);
        
        // Traite la couleur des yeux.
        TypCouleur yeux;
        if(memcmp(fichierEtudiantRecord.structureRecord.couleurYeux,"Bleu ",sizeof(fichierEtudiantRecord.structureRecord.couleurYeux ))==0)
        {
            yeux=Bleu;
        }
        else
        {
            if(memcmp(fichierEtudiantRecord.structureRecord.couleurYeux,"Brun ",sizeof(fichierEtudiantRecord.structureRecord.couleurYeux ))==0)
            {
                yeux=Brun;
            }
            else
            {
                if(memcmp(fichierEtudiantRecord.structureRecord.couleurYeux,"Noir ",sizeof(fichierEtudiantRecord.structureRecord.couleurYeux ))==0)
                {
                    yeux=Noir;
                }
                else
                {
                    if(memcmp(fichierEtudiantRecord.structureRecord.couleurYeux,"Jaune",sizeof(fichierEtudiantRecord.structureRecord.couleurYeux ))==0)
                    {
                        yeux=Jaune;
                    }
                    else
                    {
                        if(memcmp(fichierEtudiantRecord.structureRecord.couleurYeux,"Vert ",sizeof(fichierEtudiantRecord.structureRecord.couleurYeux ))==0)
                        {
                            yeux=Vert;
                        }
                        else
                        {
                            if(memcmp(fichierEtudiantRecord.structureRecord.couleurYeux,"Pers ",sizeof(fichierEtudiantRecord.structureRecord.couleurYeux ))==0)
                            {
                                yeux=Pers;
                            }
                            else
                            {
                                throw ExceptionEnregistrementInvalide("Couleur de yeux inconnue" ,nomFichier.c_str(),numLigne);
                            }
                        }
                    }
                }
            }
        }

        // Traite l'adresse civique.
        char numeroCivique[sizeof(fichierEtudiantRecord.structureRecord.numeroCivique)+1]="";
        int adresseNumeroCivique=atoi(strncat(numeroCivique,fichierEtudiantRecord.structureRecord.numeroCivique ,
                                              sizeof(fichierEtudiantRecord.structureRecord.numeroCivique)));

        // Traite le nom de la rue.
        char rue[sizeof(fichierEtudiantRecord.structureRecord.rue)+1]="";
        enleveEspaceALaFin(strncat(rue,fichierEtudiantRecord.structureRecord.rue,sizeof(fichierEtudiantRecord.structureRecord.rue)),sizeof(fichierEtudiantRecord.structureRecord.rue));

        // Traite le nom de la ville.
        char ville[sizeof(fichierEtudiantRecord.structureRecord.ville)+1]="";
        enleveEspaceALaFin(strncat(ville,fichierEtudiantRecord.structureRecord.ville,sizeof(fichierEtudiantRecord.structureRecord.ville)),sizeof(fichierEtudiantRecord.structureRecord.ville));

        // Traite le nom de la province.
        char province[sizeof(fichierEtudiantRecord.structureRecord.province)+1]="";
        enleveEspaceALaFin(strncat(province,fichierEtudiantRecord.structureRecord.province,sizeof(fichierEtudiantRecord.structureRecord.province)),sizeof(fichierEtudiantRecord.structureRecord.province));

        // traite le numero de telephone
        char telephone[sizeof(fichierEtudiantRecord.structureRecord.telephone)+1]="";
        strncat(telephone,fichierEtudiantRecord.structureRecord.telephone,sizeof(fichierEtudiantRecord.structureRecord.telephone ));

        // traite le code etudiant
        char codeEtudiant[sizeof(fichierEtudiantRecord.structureRecord.codeEtudiant)+1]="";
        strncat(codeEtudiant,fichierEtudiantRecord.structureRecord.codeEtudiant,sizeof(fichierEtudiantRecord.structureRecord.codeEtudiant ));

        // traite le programme de l'etudiant.
        TypProgramme programme;
        if(memcmp(fichierEtudiantRecord.structureRecord.programme,"bacSysInfo",sizeof (fichierEtudiantRecord.structureRecord.programme ))==0)
        {
            programme=bacSysInfo;
        }
        else
        {
            if(memcmp(fichierEtudiantRecord.structureRecord.programme,"bacGéniLog",sizeof (fichierEtudiantRecord.structureRecord.programme ))==0)
            {
                programme=bacGeniLog;
            }
            else
            {
                if(memcmp(fichierEtudiantRecord.structureRecord.programme,"bacSysRépa",sizeof (fichierEtudiantRecord.structureRecord.programme ))==0)
                {
                    programme=bacSysRepa;
                }
                else
                {
                    if(memcmp(fichierEtudiantRecord.structureRecord.programme,"certificat",sizeof (fichierEtudiantRecord.structureRecord.programme ))==0)
                    {
                        programme=certificat;
                    }
                    else
                    {
                        if(memcmp(fichierEtudiantRecord.structureRecord.programme,"certifDévL",sizeof (fichierEtudiantRecord.structureRecord.programme ))==0)
                        {
                            programme=certifDevL;
                        }
                        else
                        {
                            throw ExceptionEnregistrementInvalide("Programme inconnu" ,nomFichier.c_str(),numLigne);
                        }
                    }
                }
            }
        }
        
        // Traite la date d'admission
        int dateAdmission=convertisDate(fichierEtudiantRecord.structureRecord.dateAdmission);

        // Traite la date de la derniere inscription
        int dateInscription=convertisDate(fichierEtudiantRecord.structureRecord.dateDerniereInscription);

        // Traite les credits.
        char chaineCredits[sizeof(fichierEtudiantRecord.structureRecord.credits)+1]="";
        int credits=atoi(enleveEspaceDebut(strncat(chaineCredits,fichierEtudiantRecord.structureRecord.credits,sizeof(fichierEtudiantRecord.structureRecord.credits ) ) ));

        // Traite le solde
        char chaineSolde[sizeof(fichierEtudiantRecord.structureRecord.solde)+1]="";
        int solde=atoi(enleveEspaceDebut(strncat(chaineSolde,fichierEtudiantRecord.structureRecord.solde,sizeof(fichierEtudiantRecord.structureRecord.solde ))));

        // Traite si l'etudiant est diplome!
        bool diplome;
        if(memcmp(fichierEtudiantRecord.structureRecord.diplome,"false",sizeof(fichierEtudiantRecord.structureRecord.diplome ))==0)
        {
            diplome=false;
        }
        else
        {
            if(memcmp(fichierEtudiantRecord.structureRecord.diplome,"true ",sizeof(fichierEtudiantRecord.structureRecord.diplome ))==0)
            {
                diplome=true;
            }
            else
            {
                throw ExceptionEnregistrementInvalide("Etat du diplome inconnu inconnu" ,nomFichier.c_str(),numLigne);
            }
        }

        //Traite les cours
        char listeCours[sizeof(fichierEtudiantRecord.structureRecord.historiqueCours)+1]="";
        strncat(listeCours,&(fichierEtudiantRecord.structureRecord.historiqueCours[0][0]),sizeof(fichierEtudiantRecord.structureRecord.historiqueCours ));

        // Alloue l'etudiant
        Etudiant *pEtudiant= new Etudiant(nom,prenom,genre,taille,pays,dateDeNaissance,yeux,adresseNumeroCivique,
                                         rue,ville,province,telephone,codeEtudiant,programme,dateAdmission,
                                         dateInscription,credits,solde,diplome,listeCours);
        if(pEtudiant==NULL)
        {
            throw ExceptionManqueMemoire("Manque de memoire pour allouer etudiant.");
        }

             
        vecteurEtudiant.push_back(pEtudiant);

        // Creer le dossier etudiant de l'etudiant

        DossierEtudiant e=DossierEtudiant( pEtudiant);

        // Verifie si un etudiant du meme code n'as pas deja mits dans le map.
        if(dossierEtudiants.find(pEtudiant->Code()) == dossierEtudiants.end())
        {
            dossierEtudiants[pEtudiant->Code()]=e;
        }
        else
        {
            throw ExceptionEnregistrementInvalide("Code etudiant deja existant",nomFichier.c_str(),numLigne);
        }


      }
}

///////////////////////////////////////////////////////////////////////////////
// Cette fonction convertis un sigle de cours en format chaine de caractere
// en format enumeration TypSigle.
// Parametre: pChaine: Chaine qui contient le sigle du cours a convertir.
// Retour: Le sigle en format enumeration TypSigle
///////////////////////////////////////////////////////////////////////////////
TypSigle convertisChaineEnCours(char *pChaine)
{
    TypSigle cours=VIDE;

    // Contient le tableau de conversion
    struct
    {
        char *pChaine;
        TypSigle sigle;
    } const tableauSigle[]={{"INF1110",INF1110 },
                      {"ADM1105",ADM1105 },
                      {"ECO1080",ECO1080 },
                      {"SCO1080",SCO1080 },
                      {"INF1130",INF1130 },
                      {"INF2110",INF2110 },
                      {"MAT4680",MAT4680 },
                      {"ADM1163",ADM1163 },
                      {"INF2160",INF2160 },
                      {"INF2170",INF2170 },
                      {"INF3102",INF3102 },
                      {"INF3123",INF3123 },
                      {"INF3172",INF3172 },
                      {"INF3180",INF3180 },
                      {"INF3722",INF3722 },
                      {"INF4100",INF4100 },
                      {"INF4170",INF4170 },
                      {"INF4270",INF4270 },
                      {"INF4481",INF4481 },
                      {"INF5151",INF5151 },
                      {"INF5153",INF5153 },
                      {"INF5180",INF5180 },
					  {"INF5270",INF5270},
                      {"INF5280",INF5280 },
                      {"INM5151",INM5151 },
                      {"INF6150",INF6150 },
                      {"INM5000",INM5000 },
                      {"INM5800",INM5800 },
                      {"INM5801",INM5801 },
                      {"INM6000",INM6000 },
                      {"VIDE   ",VIDE }};
    
    bool trouve=false; // Determine si le sigle a ete trouve dans le tableau.

    // Cherche dans le tableau si le sigle existe.
    for(unsigned int i=0;tableauSigle[i].sigle != VIDE && !trouve;++i)
    {
        if(strcmp(tableauSigle[i].pChaine,pChaine)==0)
        {
            trouve=true;
            cours=tableauSigle[i].sigle;
        }
    }

    // Si le sigle n'existe pas, lance une exception.
    if(!trouve)
    {
        throw ExceptionCoursInexistant("Ce cours n'existe pas",pChaine);
    }

    return cours;
}

///////////////////////////////////////////////////////////////////////////////
// Cette fichier lis le fichier cours.dat et le transforme en dossier etudiant.
// Pour ce faire il lis chaque ligne dans cours.dat, recupere l'index de l'etudiant
// et retrouve cet etudiant dans le vecteurEtudiant. Ensuite il lis le cours etudiant
// et inscrit ce cous dans le dossier etudiant.
// Parametre: vecteurEtudiant : Contient tous les etudiants.
//            dossierEtudiant: Contient les dossier etudiants (inscription)
///////////////////////////////////////////////////////////////////////////////
void lireFichierCoursDansDossiersEtudiants(const vector<Etudiant*> &vecteurEtudiant,
                                           map<string,DossierEtudiant> &dossierEtudiants)
{
    // variable qui represente une entree du fichier cours.dat
    union
    {
        char chaineRecords[14];
        struct
        {
            char indexEtudiant[7];
            char sigleCours[7];
        } coursStruct;
    } fichierCoursRecord;


    fstream fichierEntrer; 

    // Fait la lecture du nom de fichier.
    cout << "Nom du fichier cours:";
    
    string nomFichier;
    cin >> nomFichier;

    cout << "lecture " << nomFichier << endl ;

    // Le constructeur de ifstream ouvre le fichier 
    fichierEntrer.open( nomFichier.c_str(),ios::in);

    // Le fichier n'a pas pu s'ouvrir 
    if ( !fichierEntrer.is_open() )
    {
        throw ExceptionFichier("Impossible d'ouvrir le fichier." ,nomFichier.c_str());
    }

    string ligneFichier;
    unsigned int numLigne=0;
    /* Boucle sur l'ensemble des lignes du fichier */
    while ( getline(fichierEntrer, ligneFichier, '\n') )
    {
        numLigne++;
        if(ligneFichier.length() != sizeof(fichierCoursRecord.chaineRecords))
        {
            throw ExceptionEnregistrementInvalide("L'enregistrement n'est pas de la bonne taille" ,nomFichier.c_str(),numLigne);
        }
        // copie la ligne lu dans le fichier dans la structure.
        strncpy(fichierCoursRecord.chaineRecords,ligneFichier.c_str(),sizeof(fichierCoursRecord.chaineRecords));

        // Fait le traitement sur la partie du cours.
        char chaineCours[sizeof(fichierCoursRecord.coursStruct.sigleCours) +1]="";
        TypSigle cours=convertisChaineEnCours(strncat(chaineCours,fichierCoursRecord.coursStruct.sigleCours,sizeof(fichierCoursRecord.coursStruct.sigleCours )));

        // Fait le traitement sur l'index de l'etudiant.
        char chaineIndex[sizeof(fichierCoursRecord.coursStruct.indexEtudiant )+1] ="";
        int indexEtudiant=atoi(enleveEspaceDebut(strncat(chaineIndex,fichierCoursRecord.coursStruct.indexEtudiant ,sizeof(fichierCoursRecord.coursStruct.indexEtudiant ) ) ))-1;

        // Inscrit l'etudiant au cours.
		if(indexEtudiant < 0 || indexEtudiant >> vecteurEtudiant.size())
		{
			throw ExceptionEnregistrementInvalide("L'index etudiant n'existe pas." ,nomFichier.c_str(),numLigne);
		}
        dossierEtudiants[(vecteurEtudiant.at(indexEtudiant))->Code()].inscriptionCours(cours);
    }


}

///////////////////////////////////////////////////////////////////////////////
// Cette fonction convertis une date en format entier en chaine de caractere
// Parametre: Date: Date en format entier.
// Retour: La date en format chaine de caractere (format: jj/mm/aaaa )
// NB: Le nombre entier contient la date comme cela jjmmaaaa
///////////////////////////////////////////////////////////////////////////////
string convertisDateEnChaine(int Date)
{
    string retour=""; // Chaine qui vas contenir la date a retourner
    char tempChaine[25]=""; // Champs temporaire utilise pour convertir la date.
    
    // Convertis le nombre en chaine de caractere.
    itoa(Date,tempChaine,10);

    unsigned int carLus=0;

    // Verifie que le nombre commence pas par un zero.
    if(strlen(tempChaine)==7)
    {
        // Si commence par un 0, ajoute un 0 au debut
        retour="0";
        retour.append(tempChaine,1);
        carLus=1;
    }
    else
    {
        // Ajoute le jour
        retour.append(tempChaine,2);
        carLus=2;
    }
    
    // Ajoute le mois.
    retour.append("/");
    retour.append(tempChaine+carLus,2);
    carLus+=2;

    //Ajoute l'annee.
    retour.append("/");
    retour.append(tempChaine+carLus,4);
    return retour;
}

///////////////////////////////////////////////////////////////////////////////
// Cette fonction convertis en chaine le programme de TypProgramme
// Parametre: programme: Le programme a convertir
// Retour: La chaine qui contient le programme converti.
///////////////////////////////////////////////////////////////////////////////
string convertisProgrammeEnChaine(TypProgramme programme )
{
    string retour = "";
    switch(programme)
    {
        case bacSysInfo:
            retour="bacSysInfo";
            break;
        case bacGeniLog:
            retour="bacGeniLog";
            break;
        case bacSysRepa:
            retour="bacSysRepa";
            break;
        case certificat: 
            retour="certificat";
            break;
        case certifDevL:
            retour="certifDevL";
            break;
    }
    return retour;
}

///////////////////////////////////////////////////////////////////////////////
// Cette transforme un sigle de cours en chaine de caracteres.
// Parametre: cours: Sigle du cours a convertir.
// Retour: La chaine contenant le cours converti.
///////////////////////////////////////////////////////////////////////////////
string transformeSigleEnChaine(TypSigle cours)
{
    string retour;
    switch(cours)
    {
        case INF1110:
            retour="INF1110";
            break;
        case ADM1105:
            retour="ADM1105";
            break; 
        case ECO1080:
            retour="ECO1080";
            break;
        case SCO1080:
            retour="SCO1080";
            break;
        case INF1130:
            retour="INF1130";
            break;
        case INF2110:
            retour="INF2110";
            break;
        case MAT4680:
            retour="MAT4680";
            break;
        case ADM1163:
            retour="ADM1163";
            break;
        case INF2160:
            retour="INF2160";
            break;
        case INF2170:
            retour="INF2170";
            break;
        case INF3102:
            retour="INF3102";
            break;
        case INF3123:
            retour="INF3123";
            break;
        case INF3172:
            retour="INF3172";
            break;
        case INF3180:
            retour="INF3180";
            break;
        case INF3722:
            retour="INF3722";
            break;
        case INF4100:
            retour="INF4100";
            break;
        case INF4170:
            retour="INF4170";
            break;
        case INF4270:
            retour="INF4270";
            break;
        case INF4481:
            retour="INF4481";
            break;
        case INF5151:
            retour="INF5151";
            break;
        case INF5153:
            retour="INF5153";
            break;
        case INF5180:
            retour="INF5180";
            break;
        case INF5270:
            retour="INF5270";
            break;
        case INF5280:
            retour="INF5280";
            break;
        case INM5151:
            retour="INM5151";
            break;
        case INF6150:
            retour="INM6150";
            break;
        case INM5000:
            retour="INM5000";
            break;
        case INM5800:
            retour="INM5800";
            break;
        case INM5801:
            retour="INM6801";
            break;
        case INM6000:
            retour="INM6000";
            break;
        case VIDE:
            retour="VIDE";
            break;
    }
    return retour;
}


///////////////////////////////////////////////////////////////////////////////
// Cette fonction mets dans un stream le dossier etduaitns.
// Parametre: sortie: Stream de sortie.
//            dossier: Dossier etudiant.
///////////////////////////////////////////////////////////////////////////////
void AfficheResultat(ostream & sortie,const DossierEtudiant  &dossier)
{
    

    sortie << (dossier.getEtudiant())->Nom() << " " << (dossier.getEtudiant())->Prenom() << " : " 
         << (dossier.getEtudiant())->Adresse().numero <<  " " << (dossier.getEtudiant())->Adresse().rue
         << "," << (dossier.getEtudiant())->Adresse().ville << "," << (dossier.getEtudiant())->Adresse().province << endl;

    sortie << "Code: " << (dossier.getEtudiant())->Code() << " Credits: " << (dossier.getEtudiant())->Credits() 
         << " Admission: " << convertisDateEnChaine((dossier.getEtudiant())->Date_Admission())
         << " Inscription: " << convertisDateEnChaine((dossier.getEtudiant())->Derniere_Date())
         << " " << convertisProgrammeEnChaine((dossier.getEtudiant())->Programme())<<endl;

    sortie << "Cours suivis: " ;

    // Verifie si l'utilisateur est inscrit a des cours.
    if(dossier.getNumCours() == 0)
    {
        // Si aucun, affiche AUCUN
        sortie << "AUCUN" ;
    }
    else
    {
        const vector<TypSigle> cours=dossier.getCours();
        for(vector<TypSigle>::const_iterator i=cours.begin();
             i != cours.end();
             i++)
        {
            if(*i != VIDE)
            {
                sortie << transformeSigleEnChaine(*i) << " ";
            }
        }
    }
    sortie << endl;
         
}

///////////////////////////////////////////////////////////////////////////////
// Cette fonction genere le fichier de sortie contenant la liste d'etudiants
// par programme.
// Parametre: dossiersEtudiants: Les dossiers etudiants.
///////////////////////////////////////////////////////////////////////////////
void genereEtAfficheListeParProgramme(const map<string,DossierEtudiant> &dossiersEtudiants)
{

    // Contient la liste des etudiants par programme trie sur le code etudiants puisque
    // dossiersEtudiants est trie sur le code etudiants.
    multimap <TypProgramme,const DossierEtudiant *> listeParProgramme;

    // Demande a l'utilisateur le nom de fichier de sortie.
    cout << "entrez le nom du fichier (sortie) de la liste d'etudiants par programme:";
    string nomFichier;
    cin >> nomFichier;

    ofstream fichierSortie(nomFichier.c_str());

    cout << "creation de la liste." << endl;
    // Insere dans le multimap tous les etudiants par leur programme.
    for(map<string,DossierEtudiant>::const_iterator i=dossiersEtudiants.begin();
         i!=dossiersEtudiants.end();
         i++)
    {

		DossierEtudiant de=(*i).second;
		const Etudiant *pe=de.getEtudiant();
        TypProgramme programme=pe->Programme();
        listeParProgramme.insert(pair<TypProgramme,const DossierEtudiant *>(programme, &((*i).second)));
    }


    const TypProgramme programmes[]={bacSysInfo, bacGeniLog, bacSysRepa, certificat, certifDevL};
    
    // Mets dans le fichier tous les programme trier selon le programme
    for(unsigned int i=0;i<(sizeof(programmes)/ sizeof(TypProgramme) );++i)
    {                       
        TypProgramme programme=programmes[i];
        fichierSortie << endl;
        fichierSortie << "Programme " << convertisProgrammeEnChaine(programme ) <<" : " << listeParProgramme.count(programme) << " etudiants" << endl;

        /* Affiche tous les etudiants faisant parti du programme. */
        for(multimap <TypProgramme,const DossierEtudiant *>::const_iterator position=listeParProgramme.find(programme);
             position != listeParProgramme.end() && (*position).first == programme;
             ++ position)
        {

            AfficheResultat(fichierSortie,*((*position).second));
        }
    }
}

///////////////////////////////////////////////////////////////////////////////
// Cette fonction genere le fichier de sortie qui contient la liste des etudiants
// inscrits par cours.
// Parametre: dossiersEtudiants: Les dossiers etudiants.
///////////////////////////////////////////////////////////////////////////////
void genereEtAfficheListeParCours(map<string,DossierEtudiant> dossiersEtudiants)
{
    // Contient la liste des etudiants par cours trie sur le code etudiants puisque
    // dossiersEtudiants est trie sur le code etudiants.
    multimap <TypSigle,const DossierEtudiant *> listeParCours;

    // Demande a l'utilisateur le nom de fichier de sortie.
    cout << "entrez le nom du fichier (sortie) de la liste d'etudiants par cours:";
    string nomFichier;
    cin >> nomFichier;

    ofstream fichierSortie(nomFichier.c_str());

    cout << "creation de la liste." << endl;

    // Insere dans le multimap tous les etudiants par leur programme.
    for(map<string,DossierEtudiant>::const_iterator i=dossiersEtudiants.begin();
         i!=dossiersEtudiants.end();
         i++)
    {

        // vas chercher le vector des cours inscrit.
        vector<TypSigle> cours=((*i).second).getCours();

        // ajoute tous les cours inscrits dans le multimap.
        for(vector<TypSigle>::const_iterator pos=cours.begin();
             pos!=cours.end();
             pos++)
        {
            if(*pos != VIDE)
            {
                listeParCours.insert(pair<TypSigle,const DossierEtudiant *>(*pos, &((*i).second)));
            }
        }
    }


    const TypSigle sigles[]={ADM1105,ADM1163,ECO1080,INF1110,INF1130,INF2110,
               INF2160,INF2170,INF3102,INF3123,INF3172,INF3180,INF3722,
               INF4100,INF4170,INF4270,INF4481,INF5151,INF5153,INF5180,INF5270,
               INF5280,INF6150,INM5000,INM5151,INM5800,INM5801,INM6000,MAT4680,SCO1080};
   for (unsigned int i=0;i < sizeof(sigles)/sizeof(TypSigle);++i)
   {
       TypSigle sigle=sigles[i];

       // affiche l'entete pour le cours.
       fichierSortie << endl;
       fichierSortie << "Cours " << transformeSigleEnChaine(sigle) << " : " << listeParCours.count(sigle)<< " etudiants" <<endl;

       // Affiche tous les etudiants inscrit
       for(multimap <TypSigle,const DossierEtudiant *>::const_iterator pos=listeParCours.find(sigle);
            pos != listeParCours.end() && (*pos).first == sigle;
            pos++)
       {
           fichierSortie << (((*pos).second)->getEtudiant())->Nom() << " " << (((*pos).second)->getEtudiant())->Prenom()
                         << " : " << (((*pos).second)->getEtudiant())->Adresse().numero << " " 
                         << (((*pos).second)->getEtudiant())->Adresse().rue << "," 
                         << (((*pos).second)->getEtudiant())->Adresse().ville << ","
                         << (((*pos).second)->getEtudiant())->Adresse().province << "   "
                         << (((*pos).second)->getEtudiant())->Code() << endl;

       }
   }
}

///////////////////////////////////////////////////////////////////////////////
// Cette fonction libere toute la memoire alloue dans le vecteur etudiant
// pour chaque etudiant.
// Parametre: VecteurEtudiant: Vecteur contenant la memoire a liberer
///////////////////////////////////////////////////////////////////////////////
void LibereMemoire(vector<Etudiant*> vecteurEtudiant)
{
    for(vector<Etudiant*>::iterator i=vecteurEtudiant.begin();
         i!= vecteurEtudiant.end();
         i++)
    {
        delete *i;
        *i=NULL;
    }
}

///////////////////////////////////////////////////////////////////////////////
// Programme principal.
// Cette fonction lis les fichiers cours.dat et etudiants.dat et genere
// deux fichiers de sortie qui contient la liste des etudiants par cours et par
// programme. Cette fonction permet aussi demander le dossier etudiant qu'elle
// affiche a l'ecran.
///////////////////////////////////////////////////////////////////////////////
void main()
{
    vector<Etudiant*> vecteurEtudiant; // Contient tous les etudiants.
    map<string,DossierEtudiant> dossiersEtudiants; // Contient tous les dossier etudiant index sur le code etudiant
    
    try
    {
        lireFichierEtudiantDansVecteurPersonne(vecteurEtudiant,dossiersEtudiants);

        lireFichierCoursDansDossiersEtudiants(vecteurEtudiant,dossiersEtudiants);

        genereEtAfficheListeParProgramme(dossiersEtudiants);

        genereEtAfficheListeParCours(dossiersEtudiants);

        bool termine=false;

        // Demande a l'utilisateur le nom de fichier de sortie.
        cout << "entrez le nom du fichier (sortie) des dossiers etudiants:";
        string nomFichier;
        cin >> nomFichier;

        ofstream fichierSortie(nomFichier.c_str());

        while(!termine)
        {
            cout << "Entrez un code etudiant (q pour quitter):";
            string codeEtudiant;
            cin >> codeEtudiant;
            
            // Verifie si l'utilisateur veut terminer
            if(codeEtudiant.compare("q")==0 || codeEtudiant.compare("Q")==0)
            {
                termine = true;    
                continue;
            }

            // Cherche si le dossier etudiant existe.
            map<string,DossierEtudiant>::const_iterator dossier=dossiersEtudiants.find(codeEtudiant);
            if(dossier != dossiersEtudiants.end())
            {
                // Affiche le dossier
                cout << "Dossier: " << (((*dossier).second).getEtudiant())->Code() << endl;
                AfficheResultat(cout,(*dossier).second);
                AfficheResultat(fichierSortie,(*dossier).second);
            }
            else
            {
                cout << "Dossier '" << codeEtudiant <<"' inexistant." << endl ;
            }
        }

        LibereMemoire(vecteurEtudiant);

    }
    catch ( ExceptionFichier &e )
    {
        cout << e.what() << " fichier: " << e.getNomFichier() << endl;
    }
    catch ( ExceptionEnregistrementInvalide &e )
    {
        cout << "enregistrement invalide: " << e.what() << " fichier: " << e.getNomFichier() << " ligne: " << e.getLigne() << endl;
    }
    catch (ExceptionCoursInexistant &e)
    {
        cout << "Cours inexistant: " << e.what() << " cours: " << e.getCours() << endl;
    }
    catch (ExceptionInscriptionCours &e)
    {
        cout << "Impossible d'ajouter le cours: " << e.what() << " cours: " << transformeSigleEnChaine(e.getCours()) << endl;
    }
    catch (ExceptionManqueMemoire &e)
    {
        cout << "Erreur: " << e.what() << endl;
    }
}
