/*****************************************************************************/
/*$Id: tp1.cpp,v 1.9 2003/10/08 04:45:00 sebastien Exp $                     */
/*****************************************************************************/
/*                                                                           */
/* Ce programme permet de calculer et d’afficher certaines statistiques      */
/* elementaires sur un fichier specifie par l'usager.                        */
/*                                                                           */
/* Auteur: Yann Bourdeau (bourdeau.yann@courrier.uqam.ca)                    */
/*         Sebastien Bonneau (bonneau.sebastien.2@courrier.uqam.ca)          */
/*                                                                           */
/*****************************************************************************/

/*****************************************************************************/
/* Fichier de prototype inclus                                               */
/*****************************************************************************/
#include <iostream>
#include <map>
#include <string>
#include <fstream>
#include <iomanip>
#include <vector>

using namespace std;

/*****************************************************************************/
/* Prototypes des fontions et procedures                                     */
/*****************************************************************************/
void ExtraireStatsLigne(string p_ligne, map<string, int>& p_es_tabMots, 
						int& p_es_nbMots);
void AfficherStatistiques(map<string, int> p_tabMots, 
						  int p_nbLignes, 
						  int p_nbMots);
void AfficherTrierMots(map<string, int> p_tabMots);
void AfficherTrierFrequence(map<string, int> p_tabMots);

/*****************************************************************************/
/* Type definis pour ce programme                                            */
/*****************************************************************************/
/* Structure contenant un mot et la frequence de ce mot dans le fichier      */
struct TypeMot
	{
	string	mot;		/* Le mot en soit */
	int		frequence;	/* La frequence que ce mot revient dans le fichier */
	};

/*****************************************************************************/
/* Macros utilise par ce programme                                           */
/*****************************************************************************/
const int LARGEUR_COLONNE=16;

/*****************************************************************************/
/* Fonction principal                                                        */
/* Cette fonction ouvre un fichier en lecture,                               */
/* execute la boucle principal du programme et                               */
/* appelle une procedure qui affichera les statistiques du fichier           */
/*                                                                           */
/* La boucle fait: 1- Lis chaque ligne du fichier                            */
/*                 2- Affiche le numero de la ligne ainsi que son contenu    */
/*                 3- Extrait les statistiques de la ligne lue               */
/*                                                                           */
/*****************************************************************************/
int main()
	{
	/* Contiendra les mots du fichier et leur frequence */
	map<string, int> tabMots;	

	/* Contiendra le nom du fichier */
    string nomFichier;			

    cout << "Donnez le nom du fichier de donnees : ";
    cin >> nomFichier;

	/* Le constructeur de ifstream ouvre le fichier */
	ifstream fichier( nomFichier.c_str(), ios::in );

	/* Le fichier n'a pas pu s'ouvrir, donc le programme s'arrete */
	if ( !fichier ) 
		{
		cerr << "Ouverture du fichier impossible.\n";
		exit( 1 );
		}
	else
		{
		string ligneFichier;	/* Contiendra le texte d'une ligne */
		int nbLignes= 0;		/* Nombre de lignes total du fichier */
		int nbMots= 0;			/* Nombre de mots total du fichier */
		
		cout << endl << "Texte lu\n\n";
		
		/* Boucle sur l'ensemble des lignes du fichier */
		while ( getline(fichier, ligneFichier, '\n') )
			{
			/* Affiche le numero de la ligne */
			/* ainsi que le texte de chaque ligne */
			cout << nbLignes << "\t" << ligneFichier << endl; 
			nbLignes+= 1;

			ExtraireStatsLigne(ligneFichier, tabMots, nbMots);
			}

		AfficherStatistiques(tabMots, nbLignes, nbMots);
		}

	return 0;
	}

/*****************************************************************************/
/* ExtraireStatsLigne                                                        */
/* Cette procedure extrait les statistiques d'une ligne du fichier passe en  */
/* parametre.                                                                */
/*                                                                           */
/* PARAMETRES :                                                              */
/* p_ligne (ENTRE) : Contient le texte d'une ligne du fichier                */
/* p_es_tabMots (ENTRE / SORTIE) : Contient le tableau des mots ainsi que    */
/*                                 leur frequence                            */
/* p_es_nbMots (ENTRE / SORTIE) : Contient le nombre de mots du fichier      */
/*                                                                           */
/*****************************************************************************/
void ExtraireStatsLigne(string p_ligne, map<string, int>& p_es_tabMots, 
						int& p_es_nbMots)
	{
	int posCar= 0;
	int posDebut= 0;
	int posFin= 0;

	/* Boucle sur l'ensemble des characteres de la ligne passe en parametre */
	while (posCar < p_ligne.length())
		{
		/* Permet de savoir si le tiret ('-') est utilise dans un mot ou non */
		bool flagTiret= false;	
		posDebut= posCar;	/* La position de depart est garde en memoire */

		/* Boucle sur l'ensemble des lettres (a-z ou A-Z) */
		/* ou */
		/* si un tiret est place entre deux lettres et qu'aucun tiret n'a */
		/* ete rencontre dans le mot courant */
		while (isalpha(p_ligne[posCar]) 
			|| 
			(p_ligne[posCar] == '-' 
				&& posCar < p_ligne.length()
				&& isalpha(p_ligne[posCar - 1])
				&& isalpha(p_ligne[posCar + 1])
				&& !flagTiret))
			{
			/* Met la lettre courante en minuscule */
			p_ligne[posCar]= tolower(p_ligne[posCar]);

			/* Le caractere courant n'est pas une lettre, donc un tiret */
			if (!isalpha(p_ligne[posCar]))
				flagTiret= true;

			posCar++;	/* Se positionne sur le prochain caractere */
			}

		/* La position de depart est differente de la position courante, */
		/* donc nous avons rencontre un mot */
		if (posDebut != posCar)
			{
			/* Incrementons la frequence du mot courant */
			p_es_tabMots[p_ligne.substr(posDebut, posCar - posDebut)]++;
			p_es_nbMots++;
			}

		posCar++;	/* Se positionne sur le prochain caractere */
		}
	}

/*****************************************************************************/
/* AfficherStatistiques                                                      */
/* Cette procedure affiche 3 types de statistiques.                          */
/* Elle affiche : 1- les statistiques generales                              */
/*                2- le tableau des mots ainsi que leur frequence en ordre   */
/*                   alphabetique des mots                                   */
/*                3- le tableau des mots trie par ordre de frequence         */
/*                                                                           */
/* PARAMETRES :                                                              */
/* p_es_tabMots (ENTRE) : Contient le tableau des mots ainsi que             */
/*                        leur frequence                                     */
/* p_nbLignes (ENTRE) : Contient le nombre de lignes du fichier              */
/* p_nbMots (ENTRE)   : Contient le nombre de mots total du fichier          */
/*                                                                           */
/*****************************************************************************/
void AfficherStatistiques(map<string, int> p_es_tabMots, int p_nbLignes, 
						  int p_nbMots)
	{
	/* Affiche les statistiques generales (nb de lignes, nb de mots total et */
	/* le nb de mots differents */
	cout << endl << p_nbLignes << " lignes lues.\n"
	     << p_nbMots << " mots lus.\n"
		 << p_es_tabMots.size() << " mots differents observes.\n\n";

	
	AfficherTrierMots(p_es_tabMots);

	cout << endl << endl << endl;	/* Saut de ligne */

	AfficherTrierFrequence(p_es_tabMots);
	}

/*****************************************************************************/
/* AfficherTrierMots                                                         */
/* Cette procedure affiche l'ensemble des mots du tableau passe en parametre */
/* ainsi que leur frequence. La liste des mots à l'ecran sera en ordre       */
/* alphabetique.                                                             */
/*                                                                           */
/* PARAMETRES :                                                              */
/* p_es_tabMots (ENTRE) : Contient le tableau des mots ainsi que             */
/*                        leur frequence                                     */
/*                                                                           */
/*****************************************************************************/
void AfficherTrierMots(map<string, int> p_tabMots)
	{
	/* Declaration d'un iterateur se positionnant sur le premier element */
	map<string, int>::iterator iter(p_tabMots.begin());

	/* Affiche l'entete du tableau des mots */
	cout << "mots    frequence\n"
		 << "------------------\n";


	string espacement= "";
	
	for (int i= 0; i < LARGEUR_COLONNE; ++i)
		espacement+= " ";

	/* Boucle sur l'ensemble des mots du tableau */
	while (iter != p_tabMots.end()) 
		{
		/* Affiche le mot sur 16 espaces ainsi que sa frequence */
		cout << (iter->first+espacement).erase(LARGEUR_COLONNE,(iter->first).length()-LARGEUR_COLONNE);
		cout << iter->second;
		cout << endl;

		++iter;	/* Passe au prochain element du tableau */
		}
	}

/*****************************************************************************/
/* AfficherTrierFrequence                                                    */
/* Cette procedure permet d'afficher les mots en ordre de frequence debutant */
/* par la frequence la plus eleve. Pour ce faire, un tableau temporaire est  */
/* utilise. Le tri s'effectue sur le tableau temporaire. Ensuite, ce tableau */
/* est affiche à l'ecran.                                                    */
/*                                                                           */
/* PARAMETRES :                                                              */
/* p_es_tabMots (ENTRE) : Contient le tableau des mots ainsi que             */
/*                        leur frequence                                     */
/*                                                                           */
/*****************************************************************************/
void AfficherTrierFrequence(map<string, int> p_tabMots)
	{
	vector<TypeMot> tabMotsTemp; /* Tableau temporaire pour les mots */
	TypeMot motFrequence;		 /* Structure qui servira au element */
								 /* du tableau temporaire            */

	/* Declaration d'un iterateur se positionnant sur le premier element */
	map<string, int>::iterator iter(p_tabMots.begin());

	/* Boucle servant a copier l'ensemble des elements */
	/* du MAP dans le tableau temporaire */
	while (iter != p_tabMots.end()) 
		{
		motFrequence.mot= iter->first;
		motFrequence.frequence= iter->second;

		tabMotsTemp.push_back(motFrequence);
		++iter;
		}

	/* Variable temporaire pour la copie d'un element du tableau temporaire */
	TypeMot stockage;	
	
	/* Boucle sur l'ensemble des elements du tableau temporaire */
	for (int passage= 0; passage < tabMotsTemp.size() - 1; passage++)
		{
		for (int i= 0; i < tabMotsTemp.size() - 1; i++)
			{
			if (tabMotsTemp[i].frequence < tabMotsTemp[i + 1].frequence)
				{						    
				// Permutation d'un element
				stockage = tabMotsTemp[ i ];
				tabMotsTemp[ i ] = tabMotsTemp[ i + 1 ];
				tabMotsTemp[ i + 1 ] = stockage;
				}
			}
		}

	/* Affiche l'entete de la liste des mots */
	cout << "frequence       mots\n"
		 << "--------------------\n";

	/* Affiche les mots du tableau temporaire ainsi que leur frequence */
	/* L'affichage se fait en ordre de frequence debutant par la plus eleve */
	for (int i= 0; i < tabMotsTemp.size(); ++i)
		{
		cout << setw(LARGEUR_COLONNE) << setiosflags(ios::left) << tabMotsTemp[i].frequence 
			 << tabMotsTemp[i].mot << endl;
		}
	}
