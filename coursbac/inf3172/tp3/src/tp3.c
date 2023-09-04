/*****************************************************************************/
/*$Id: tp3.c,v 1.25 2003/12/17 01:30:57 sebastien Exp $                      */
/*****************************************************************************/
/* Ce programme simule des algorithmes de remplacement de pages              */
/*                                                                           */
/* Auteurs: Sebastien Bonneau (bonneau.sebastien.2@courrier.uqam.ca)         */
/*          Yann Bourdeau (bourdeau.yann@courrier.uqam.ca)                   */
/*                                                                           */
/*****************************************************************************/

/*****************************************************************************/
/* Fichier de prototype inclus                                               */
/*****************************************************************************/
#include <stdio.h> 
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <limits.h>

/* Pour les plateforme win32 */
#ifndef PATH_MAX
    #define PATH_MAX 255
#endif

/*****************************************************************************/
/* Macros utilise par ce programme                                           */
/*****************************************************************************/
#define FALSE 0                  /* Constante FALSE                          */
#define TRUE  1                  /* Constante TRUE                           */
#define CASE_VIDE (-1)           /* Constante de case vide pour les tableaus */

/* Liste des erreurs possibles                                               */
#define TP3_ERREUR_PARAMETRE_INCORRECT   1
#define TP3_ERREUR_MANQUE_MEMOIRE        2
#define TP3_ERREUR_LISTE_VIDE            3
#define TP3_ERREUR_FIN_LISTE             4
#define TP3_ERREUR_NB_CASE_MEMOIRE       5
#define TP3_ERREUR_LECTURE_FICHIER       6

/*****************************************************************************/
/* Definition de type                                                        */
/*****************************************************************************/
typedef unsigned int NUMCASE;
typedef unsigned char BOOL;
typedef unsigned int LISTENBELEMENT;

/*****************************************************************************/
/* Element d'une liste chainee                                               */
/*****************************************************************************/
/* Element d'une liste chaine                                                */
typedef struct LISTE_ELEMENT
    {
    struct LISTE_ELEMENT *pProchain;
    void *pValeur;
    } LISTE_ELEMENT;

/* Structure d'une liste chaine                                              */
typedef struct LISTE
    {
    LISTE_ELEMENT *pPremier;
    LISTENBELEMENT nbElement;
    } LISTE;

/* Element d'une liste chaine pour l'algorithme de l'horloge                 */
typedef struct PAGE_HORLOGE
    {
    int valeur;
    BOOL reference;               /* Represente si l'element a ete reference */
    } PAGE_HORLOGE;

/*****************************************************************************/
/* Enumeration pour paremetre de CopieElementListe                           */
/*****************************************************************************/
enum CopieElementListeOption
    {
    AUCUN, BOUCLE_DEBUT
    };

typedef enum CopieElementListeOption COPIEELEMENTCOURANTOPTION;

/*****************************************************************************/
/* Prototypes                                                                */
/*****************************************************************************/
/* Fonction qui gere une liste chaine */
int CreerListe(LISTE **ppListe);
int DetruireListe(LISTE **ppListe);
int DupliquerListe(LISTE **ppListeSrc, LISTE **ppListeDest);  
int nbElementListe(LISTE *pListe, LISTENBELEMENT *pnbElement);
int AjouteElementListe(LISTE *pListe, void *pValeur);
int EnleveElementListe(LISTE *pListe, LISTE_ELEMENT *pElementAEnlever);
int CopiePremierElementListe(LISTE *pListe, LISTE_ELEMENT **ppIndex,void **ppValeur);
int CopieElementSuivantListe(LISTE *pListe, LISTE_ELEMENT **ppIndex,void **ppValeur,
                             COPIEELEMENTCOURANTOPTION Option);

int AfficherResultat(char* nomListe, LISTE *pListe, NUMCASE nbCaseMem, int nbDefautPage);
int PagePresenteEnMemoire(LISTE *pListeMem, int valeur);

/*****************************************************************************/
/* Fonction qui creer une liste chaine                                       */
/* Parametre : OUT ppListe: Liste qui vas etre creer                         */
/* Retourne code d'erreur : 0 - OK                                           */
/*                          Sinon - Erreur                                   */
/*****************************************************************************/
int CreerListe(LISTE **ppListe)
    {
    int rc= 0;      /* Code de retour */

    /* Alloue la liste en memoire */
    *ppListe= (LISTE*)calloc(1, sizeof(LISTE));

    if (*ppListe == NULL)
        rc= TP3_ERREUR_MANQUE_MEMOIRE;

    return rc;
    }

/*****************************************************************************/
/* Fonction qui detruis une liste chaine                                     */
/* Parametre : IN ppListe : Liste qui vas etre detruite                      */
/* Retourne code d'erreur : 0 - OK                                           */
/*                          Sinon - Erreur                                   */
/*****************************************************************************/
int DetruireListe(LISTE **ppListe)
    {
    int rc= 0;               /* Code de retour */
    LISTE_ELEMENT *pCourant; /* Element courant lors de l'enumeration   */
    LISTE_ELEMENT *pEfface;  /* Element a effacer lors de l'enumeration */

    /* Parcous la liste pour liberer tous les elements */
    if ((*ppListe)->nbElement > 0)
        {
        /* Prends le premier element de la liste */
        pCourant=(*ppListe)->pPremier;

        while (pCourant != NULL)
            {
            pEfface= pCourant;            
            pCourant= pCourant->pProchain; /* Passe a l'element suivant */
            free(pEfface);                 /* Libere la memoire         */
            }
        }

    free(*ppListe);

    return rc;
    }

/*****************************************************************************/
/* Fonction qui duplique une liste existante. La liste destination doit      */
/* etre prealablement cree.                                                  */
/* Parametres: IN  ppListeSrc  : Liste source qui contient les elements      */
/*             OUT ppListeDest : Liste de destination a remplir              */
/* Retourne code d'erreur      : 0 - OK                                      */
/*                               Sinon - Erreur                              */
/*****************************************************************************/
int DupliquerListe(LISTE **ppListeSrc, LISTE **ppListeDest)
    {
    int rc= 0;              /* Code de retour */
    unsigned int i;         /* Variable servant a l'incrementation de la boucle */
    LISTE_ELEMENT *pIndex;  /* Pointeur sur un element de la liste              */
    int *pInt;              /* Pointeur sur la valeur d'un element de la liste  */

    /* Il doit avoir des elements dans la liste source */
    if ((*ppListeSrc)->nbElement > 0)
        {
        rc= CopiePremierElementListe(*ppListeSrc, &pIndex, (void**)&pInt);

        /* Boucle sur les elements de la liste source tant qu'il n'y a pas */
        /*  d'erreur ou que la liste n'est pas termine */
        for (i= 1; i <= (*ppListeSrc)->nbElement && !rc; ++i)
            {
            int *pNoPage= (int*)malloc(sizeof(int));
            *pNoPage= *pInt;

            AjouteElementListe(*ppListeDest, (void*)pNoPage);

            rc= CopieElementSuivantListe(*ppListeSrc, &pIndex, (void**)&pInt, BOUCLE_DEBUT);
            }
        
        /* Traitement de l'erreur de fin de liste */
        if (rc == TP3_ERREUR_LISTE_VIDE || rc == TP3_ERREUR_FIN_LISTE)
            rc= 0;
        }

    return rc;
    } 

/*****************************************************************************/
/* Fonction qui retourne le nombre d'element dans la liste                   */
/* Parametres: IN pListe     : Liste qui vas contenir l'element              */
/*             OUT nbElement : Nombre d'element dans la liste                */
/* Retourne code d'erreur    : 0 - OK                                        */
/*                             Sinon - Erreur                                */
/*****************************************************************************/
int nbElementListe(LISTE *pListe, LISTENBELEMENT *pnbElement)
    {
    int rc= 0;      /* Code de retour */
    *pnbElement=pListe->nbElement;

    return rc;
    }

/*****************************************************************************/
/* Fonction qui ajoute une element dans la liste                             */
/* Parametres: IN pListe  : Liste qui vas contenir l'element                 */
/*             IN pValeur : Element a ajouter                                */
/* Retourne code d'erreur : 0 - OK                                           */
/*                          Sinon - Erreur                                   */
/*****************************************************************************/
int AjouteElementListe(LISTE *pListe, void *pValeur)
    {
    int rc= 0;               /* Code de retour   */
    LISTE_ELEMENT *pElement; /* Element a ajoute */
    LISTE_ELEMENT *pCourant; /* Element courant lors de l'enumeration */

    /* Alloue la memoire pour le nouveau element */
    pElement= (LISTE_ELEMENT*)calloc(1, sizeof(LISTE_ELEMENT));

    if (pElement == NULL)
        rc= TP3_ERREUR_MANQUE_MEMOIRE;

    if (!rc)
        {
        /* Copie la valeur dans le nouveau element */
        pElement->pValeur= pValeur;

        /* Verifie si il y a des elements dans la liste*/
        if (pListe->nbElement == 0)
            {
            /* Aucun element, ajoute l'element a la premiere position*/
            pListe->nbElement= 1;
            pListe->pPremier= pElement;
            }
        else
            {
            /* Ajoute l'element apres les autres */
            pListe->nbElement++;
            pCourant= pListe->pPremier;

            while (pCourant->pProchain != NULL)
                pCourant= pCourant->pProchain;

            pCourant->pProchain= pElement;
            }
        }

    return rc;
    }

/*****************************************************************************/
/* Fonction qui enleve un element de la liste                                */
/* Parametres: IN pListe           : Liste qui contient l'element a enlver   */
/*             IN pElementAEnlever : Pointeur sur l'element a enlever        */
/* Retourne code d'erreur          : 0 - OK                                  */
/*                                   Sinon - Erreur                          */
/*****************************************************************************/
int EnleveElementListe(LISTE *pListe, LISTE_ELEMENT *pElementAEnlever)
    {
    int rc= 0;               /* Code de retour    */
    LISTE_ELEMENT *pCourant; /* element courant lors de l'enumeration */
    LISTE_ELEMENT *pEfface;  /* Element a effacer */

    /* Verifie que la liste contient des elements */
    if (pListe->nbElement <= 0)
        rc= TP3_ERREUR_LISTE_VIDE;
    else
        {
        /* Si la liste contient un seul element */
        if (pListe->nbElement == 1)
            {
            pListe->nbElement= 0;
            free(pListe->pPremier);
            }
        else 
            {
            /* verifie si le premier element */
            if (pListe->pPremier == pElementAEnlever)
                {
                pEfface= pListe->pPremier;
                pListe->pPremier= pListe->pPremier->pProchain;
                free(pEfface);
                }
            else
                {
                /* Parcours tous les element pour trouver le bon */
                pCourant= pListe->pPremier;

                while (pCourant->pProchain != pElementAEnlever)
                    pCourant = pCourant->pProchain;

                pEfface= pCourant->pProchain; /* Copie le pointeur a efface */

                /* Ecrase le pointeur de l'element a efface pas son suivant */
                pCourant->pProchain= pCourant->pProchain->pProchain;
                
                free(pEfface); /* Libere le pointeur */
                }

            pListe->nbElement--;
            }
        }

    return rc;
    }

/*****************************************************************************/
/* Fonction qui retourne le premier element de la liste                      */
/* Parametres: IN pListe  : liste qui contient le premier element            */
/*            OUT ppIndex : Index sur l'element, l'utilisateur ne dois pas   */
/*                           le modifier                                     */
/*            OUT ppValeur: Valeur de l'element                              */
/* Retourne code d'erreur : 0 - OK                                           */
/*                          Sinon - Erreur                                   */
/*****************************************************************************/
int CopiePremierElementListe(LISTE *pListe, LISTE_ELEMENT **ppIndex, void **ppValeur)
    {
    int rc= 0;       /* Code de retour    */

    if (pListe->nbElement <= 0)
        rc= TP3_ERREUR_LISTE_VIDE;
    else
        {
        *ppIndex= pListe->pPremier;

        if (ppValeur != NULL)
            *ppValeur= pListe->pPremier->pValeur;
        }
    
    return rc;
    }

/*****************************************************************************/
/* Fonction qui retourne l'element suivant dans la liste                     */
/* Parametres: IN pListe  : liste qui contient l'element                     */
/*            OUT ppIndex : Index sur l'element, l'utilisateur ne doit pas le*/
/*                           modifier                                        */
/*            out ppValeur: Valeur de l'element                              */
/*            IN Option   : Determine si la liste boucle atteind la fin      */
/* Retourne code d'erreur : 0 - OK                                           */
/*                          Sinon - Erreur                                   */
/*****************************************************************************/
int CopieElementSuivantListe(LISTE *pListe, LISTE_ELEMENT **ppIndex, 
                             void **ppValeur, COPIEELEMENTCOURANTOPTION option)
    {
    int rc= 0;      /* Code de retour       */

    /* Verifie si il y a un element suivant */
    if ((*ppIndex)->pProchain)
        {
        /* Retourne l'element suivant */
        *ppIndex= (*ppIndex)->pProchain;
        *ppValeur= (*ppIndex)->pValeur;
        }
    else
        {
        /* Si l'utilisateur a specifie BOUCLE_DEBUT, retourne le premier
           element de la liste quand a la fin */
        if (option == BOUCLE_DEBUT)
            {
            /* retourne le premier element */
            *ppIndex= pListe->pPremier;
            *ppValeur= pListe->pPremier->pValeur;
            }
        else
            rc= TP3_ERREUR_FIN_LISTE;
        }
    return rc;
    }

/*****************************************************************************/
/* Cette fonction lit les numeros de page du fichier et les charge dans une  */
/*  listes chainees                                                          */
/* Parametres: IN  nomFichier   : Nom du fichier a lire                      */
/*             IN  pListeNoPage : Liste des numeros de page                  */
/* Retourne code d'erreur       : 0 - OK                                     */
/*                                Sinon - Erreur                             */
/*****************************************************************************/ 
int LirePages(char *nomFichier, LISTE *pListe)
    {
    int rc= 0;                              /* Code de retour                */
    FILE *pFichier= fopen(nomFichier, "r"); /* Ouvre le fichier en lecture   */

    /* Une erreur est survenue a l'ouverture du fichier,       */
    /*  sinon les donnees sont transfere dans la liste chainee */
    if (pFichier == NULL)
        rc= TP3_ERREUR_LECTURE_FICHIER;
    else
        {
        int noPage; /* Numero de la page lu du fichier */

        /* Boucle sur chaque no de page de la premiere ligne */
        /*  tant qu'il n'y a pas d'erreur                    */
        while (!rc && (1 == fscanf(pFichier, "%d", &noPage)))
            {
            int *pNoPage= (int*)malloc(sizeof(int));

            if (pNoPage == NULL)
                rc= TP3_ERREUR_MANQUE_MEMOIRE;
            else
                {
                *pNoPage= noPage;

                rc= AjouteElementListe(pListe, (void*)pNoPage);
                }
            }

        fclose(pFichier);   /* Ferme le fichier */
        }

    return rc;
    }

/*****************************************************************************/
/* Cette fonction extrait les parametres de la ligne de commande             */
/*                                                                           */
/* Parametres: IN argc : Nombre d'elements dans le vecteur argv              */
/*             IN argv : Vecteur contenant les parametres                    */
/*                       de la ligne de commande                             */
/*             OUT pNbCaseMem   : Pointeur sur le nombre de case memoire     */
/*             OUT nomFichier   : Nom du fichier                             */
/* Retourne code d'erreur       : 0 - OK                                     */
/*                                Sinon - Erreur                             */
/*****************************************************************************/ 
int TrouveParametre(int argc, char *argv[], NUMCASE *pNbCaseMem, char *nomFichier)
    {
    int rc= 0;      /* Code de retour */

    /* Determine s'il y a le bon nombre de parametres */
    if (argc != 3)
        rc= TP3_ERREUR_PARAMETRE_INCORRECT;
    else
        {
        *pNbCaseMem= atoi(argv[1]); /* copie le nombre de case memoire */

        /* Le nombre de case memoire doit etre plus grand que 0 pour etre valide */
        if (*pNbCaseMem <= 0)
            rc= TP3_ERREUR_NB_CASE_MEMOIRE;

        strncpy(nomFichier, argv[2], PATH_MAX);   /* copie le nom du fichier */
        }

    return rc;
    }

/*****************************************************************************/
/* Cette fonction initialise un tableau de case memoire                      */
/* PARAMETRES:  pTableauCase : Tableau de case a initialise                  */
/*              IN nbCaseMem : Nombre de case memoire disponible             */
/* Retourne code d'erreur       : 0 - OK                                     */
/*                                Sinon - Erreur                             */
/*****************************************************************************/
int InitCase(int *pTableauCase,NUMCASE nbCaseMem)
    {
    int rc= 0;      /* Code de retour */
    NUMCASE i;

    /* Initalise le tableau des case memoire a vide */
    for(i= 0; i < nbCaseMem; ++i)
        pTableauCase[i]=CASE_VIDE;

    return rc;
    }

/*****************************************************************************/
/* Cette fonction initialise un tableau de case memoire                      */
/* PARAMETRES:  IN pTableauCase : Tableau de case a initialise               */
/*              IN nbCaseMem : Nombre de case memoire disponible             */
/*              IN ViellePage: Page qui doit etre remplacer                  */
/*              IN NouvellePage: La nouvelle page                            */
/* Retourne code d'erreur       : 0 - OK                                     */
/*                                Sinon - Erreur                             */
/*****************************************************************************/
int RemplaceCasePage(int *pTableauCase, NUMCASE nbCaseMem, int viellePage, 
                     int nouvellePage)
    {
    int rc= 0;
    NUMCASE i;

    for (i= 0; i < nbCaseMem; ++i)
        {
        if (pTableauCase[i] == viellePage)
            {
            pTableauCase[i]= nouvellePage;
            break;
            }
        }

    return rc;
    }

/*****************************************************************************/
/* cette fonction trouve une page dans une liste                             */
/* PARAMETRES:  IN pListeUtilisation: Liste de page                          */
/*              OUT ppIndex: Index dans la liste de l'element                */
/*              IN Valeur: Valeur a trouve                                   */
/*              OUT pIndexResultat : Index sur l'element trouve              */
/*              OUT pTrouve: Si l'element est trouve                         */
/* Retourne code d'erreur       : 0 - OK                                     */
/*                                Sinon - Erreur                             */
/*****************************************************************************/
int TrouvePageDansListe(LISTE *pListeUtilisation, LISTE_ELEMENT **ppIndex,
                        int Valeur, int **pIndexResultat, BOOL *pTrouve)
    {
    int rc= 0;  /* Code de retour */
    
    *pTrouve= FALSE;
    rc= CopiePremierElementListe(pListeUtilisation, ppIndex, (void**)pIndexResultat);
    
    /* Boucle tant qu'il n'y a pas d'erreur et que l'element n'est pas trouve */
    while (!rc && !(*pTrouve))
        {
        if (Valeur == *(*pIndexResultat))
            *pTrouve= TRUE;
        else
            rc= CopieElementSuivantListe(pListeUtilisation, ppIndex, (void**)pIndexResultat, AUCUN);
        }

    /* Traitement de l'erreur de fin de liste */
    if (rc == TP3_ERREUR_LISTE_VIDE || rc == TP3_ERREUR_FIN_LISTE)
        rc= 0;
                
    return rc;
    }

/*****************************************************************************/
/* Cette fonction affiche le resultat LRU                                    */
/* PARAMETRES:  IN pTableauCase : Tableau de case                            */
/*              IN nbCaseMem    : Nombre de case memoire disponible          */
/*              IN PageFaute    : Nombre de page en faute                    */
/* Retourne code d'erreur       : 0 - OK                                     */
/*                                Sinon - Erreur                             */
/*****************************************************************************/
int AfficheResultatLRU(int *pTableauCase, NUMCASE nbCaseMem, unsigned int PageFaute)
    {
    int rc= 0;      /* Code de retour */
    unsigned int i; /* Variable d'incrementation pour la boucle */

    /* Affiche l'entete */
    printf("===============================================================================\n");
    printf("Resultat algorithme de replacement de page (LRU)\n");
    printf("-------------------------------------------------------------------------------\n");            
    
    /* Affiche l'ensemble des case memoires */
    for (i= 0; i < nbCaseMem; ++i)
        {
        printf("case %d : ", i + 1);

        if(pTableauCase[i] != CASE_VIDE)
            printf("%d\n", pTableauCase[i]);
        else
            printf("-\n");
        }

    /* Affiche le pied du rapport */
    printf("\nNombre de page en faute : %d\n",PageFaute);
    printf("===============================================================================\n");

    return rc;
    }

/*****************************************************************************/
/* Cette fonction fait l'algorithme LRU                                      */
/* PARAMETRES:  IN nbCaseMem : Nombre de case memoire disponible pour l'algo */
/*              IN pListPage : Liste des pages demandees                     */
/* Retourne code d'erreur    : 0 - OK                                        */
/*                             Sinon - Erreur                                */
/*****************************************************************************/
int ExecuterAlgoLRU(NUMCASE nbCaseMem, LISTE *pListePage)
    {
    int rc= 0;                 /* Code de retour             */
    int *pTableauCase= NULL;   /* Tableau des cases memoires */
    unsigned int pageFaute= 0; /* Nombre de page non trouve  */
    LISTE *pListeUtilisation= NULL;
    LISTE_ELEMENT *pIndex;
    int *pInt;
    
    pTableauCase= (int*)calloc(nbCaseMem,sizeof(int));

    if (pTableauCase == NULL)
        rc=TP3_ERREUR_MANQUE_MEMOIRE;
            
    if (!rc)
        rc= InitCase(pTableauCase,nbCaseMem);

    if (!rc)
        rc= CreerListe(&pListeUtilisation);

    if (!rc)
        {
        /* Prendre le premier acces de page */
        rc= CopiePremierElementListe(pListePage, &pIndex,(void**)&pInt);

        while (!rc)
            {
            /* Verifie si la page est deja utilise*/
            LISTE_ELEMENT *pIndexUtilisation;
            int *pIntUtilisation;
            BOOL trouve= FALSE;
            rc= TrouvePageDansListe(pListeUtilisation, &pIndexUtilisation, 
                                    *pInt, &pIntUtilisation, &trouve);
            
            if (!rc)
                {
                if (trouve)
                    {
                    /* La page est deja charger */

                    /* Si l'element est deja dans la liste, remet l'element en premiere position */
                    rc= EnleveElementListe(pListeUtilisation,pIndexUtilisation);

                    if (!rc)
                        rc=AjouteElementListe(pListeUtilisation,pIntUtilisation);
                    }
                else
                    {
                    LISTENBELEMENT nbElementUtilisation;
                    /* Il faut charger la page*/
                    pageFaute++; /* Augmente le compteur de faute de page. */

                    rc= nbElementListe(pListeUtilisation,&nbElementUtilisation);

                    if (!rc)
                        {
                        /* Alloue nouvelle valeur */
                        pIntUtilisation=(int*)malloc(sizeof(int));

                        if (pIntUtilisation == NULL)
                            rc= TP3_ERREUR_MANQUE_MEMOIRE;

                        if (!rc)
                            {
                            *pIntUtilisation= *pInt;

                            /* Encore de la place pour inserer la page */
                            if (nbElementUtilisation < nbCaseMem)
                                {
                                /* Ajoute la page dans la liste chaine*/
                                rc= AjouteElementListe(pListeUtilisation,pIntUtilisation);

                                /* Remplace une case vide par la page */
                                if(!rc)
                                    rc= RemplaceCasePage(pTableauCase,nbCaseMem,CASE_VIDE, *pIntUtilisation);
                                }
                            else
                                {
                                int *pValeurVieux;
                                
                                /* Il faut enlever une page */
                                rc=CopiePremierElementListe(pListeUtilisation,&pIndexUtilisation,(void**)&pValeurVieux);

                                if (!rc)
                                    rc= EnleveElementListe(pListeUtilisation,pIndexUtilisation);

                                if (!rc)
                                    {
                                    /* Ajoute la page dans la liste chaine*/
                                    rc= AjouteElementListe(pListeUtilisation,pIntUtilisation);
                                    }

                                if (!rc)
                                    {
                                    /* Change la case memoire */
                                    rc= RemplaceCasePage(pTableauCase,nbCaseMem,*pValeurVieux, *pIntUtilisation);
                                    }
                                }
                            }
                        }
                    }
                }

            /* libere */
            free(pInt);

            /* Passe a la demande de page suivante */
            rc= CopieElementSuivantListe(pListePage,&pIndex,(void**)&pInt,AUCUN);
            }
 
        if (rc == TP3_ERREUR_FIN_LISTE)
            rc=0;
        }

    if (!rc)
        rc= AfficheResultatLRU(pTableauCase, nbCaseMem, pageFaute);

    if (pListeUtilisation)
        DetruireListe(&pListeUtilisation);

    if (pTableauCase != NULL)
        free(pTableauCase);

    return rc;
    }

/*****************************************************************************/
/* Cette fonction execute l'algorithme de l'horloge                          */
/* PARAMETRES:  IN nbCaseMem: Nombre de case memoire disponible pour l'algo. */
/*              IN pListPage: Liste des pages demandees                      */
/* Retourne code d'erreur       : 0 - OK                                     */
/*                                Sinon - Erreur                             */
/*****************************************************************************/
int ExecuterAlgoHorloge(NUMCASE nbCaseMem, LISTE *pListePage)
    {
    int rc= 0;                 /* Code de retour                             */
    LISTE *pListeMem= NULL;    /* Liste qui represente les cases memoires    */
    LISTE *pListeRef= NULL;    /* Liste qui represente les cases memoires    */
    int nbDefautPage= 0;       /* Nombre de defauts de page effectue         */
    LISTE_ELEMENT *pIndexPage; /* Pointeur sur un element d'une liste        */
    int *pValeur;              /* Valeur d'un element d'une liste            */
    unsigned int i;            /* Variable utilise pour les boucles 'for'    */   
    
    /* Pointeur sur un element de la liste en memoire */
    LISTE_ELEMENT *pIndexPageMem;
    PAGE_HORLOGE  *pValeurMem; /* Valeur d'un element de la liste en memoire */

    /* Creation de la liste representant les cases memoires */
    rc= CreerListe(&pListeMem);

    if (!rc)
        {
        rc= CopiePremierElementListe(pListePage, &pIndexPage, (void**)&pValeur);

        /* Remplir la liste en memoire avant de commencer */
        /* Boucle sur les cases memoires ou jusqu'une erreur survienne      */
        while (pListeMem->nbElement < nbCaseMem && !rc)
            {
            /* La page ne doit pas etre en memoire pour qu'elle soit traite */
            if (!PagePresenteEnMemoire(pListeMem, *((int*)pValeur)))
                {
                PAGE_HORLOGE *pElement;
                
                /* Alloue la memoire pour le nouvel element */
                pElement= (PAGE_HORLOGE*)calloc(1, sizeof(PAGE_HORLOGE));
                pElement->reference= TRUE;
                pElement->valeur= *pValeur;

                AjouteElementListe(pListeMem, (void*)pElement);
                ++nbDefautPage; /* Un defaut de page est survenu */
                }

            /* Copie la valeur de l'element suivant de 'pIndexPage' dans 'pValeur' */
            rc= CopieElementSuivantListe(pListePage, &pIndexPage, (void**)&pValeur, AUCUN);
            }

        /* Traitement de l'erreur de fin de liste */
        if (rc == TP3_ERREUR_LISTE_VIDE || rc == TP3_ERREUR_FIN_LISTE)
            rc= 0;

        rc= CopiePremierElementListe(pListeMem, &pIndexPageMem, (void**)&pValeurMem);

        /* Boucle sur les cases memoires ou jusqu'une erreur survienne      */
        for (i= 0; i < pListePage->nbElement && !rc; ++i)
            {
            /* La page ne doit pas etre en memoire pour qu'elle soit traite */
            if (!PagePresenteEnMemoire(pListeMem, *((int*)pValeur)))
                {
                if (pValeurMem->reference == FALSE)
                    {
                    pValeurMem->valeur= *pValeur;
                    pValeurMem->reference= TRUE;

                    /* Copie la valeur de l'element suivant de 'pIndexPageMem' dans 'pValeurMem' */
                    rc= CopieElementSuivantListe(pListeMem, &pIndexPageMem, (void**)&pValeurMem, BOUCLE_DEBUT);
                    }
                else
                    {
                    LISTE_ELEMENT *pIndexPageTemp= pIndexPageMem; /* Valeur d'un element de la liste en memoire */
                    BOOL trouve= FALSE;
                    
                    pValeurMem->reference= FALSE;
                    
                    /* Copie la valeur de l'element suivant de 'pIndexPageMem' dans 'pValeurMem' */
                    rc= CopieElementSuivantListe(pListeMem, &pIndexPageMem, (void**)&pValeurMem, BOUCLE_DEBUT);

                    while (pIndexPageTemp != pIndexPageMem && !rc && !trouve)
                        {
                        if (pValeurMem->reference == TRUE)
                            pValeurMem->reference= FALSE;
                        else
                            {
                            pValeurMem->valeur= *pValeur;
                            trouve= TRUE;
                            }

                        /* Copie la valeur de l'element suivant de 'pIndexPageMem' dans 'pValeurMem' */
                        rc= CopieElementSuivantListe(pListeMem, &pIndexPageMem, (void**)&pValeurMem, BOUCLE_DEBUT);
                        }

                    if (pIndexPageTemp == pIndexPageMem)
                        {
                        pValeurMem->reference= TRUE;
                        pValeurMem->valeur= *pValeur;
                        
                        /* Copie la valeur de l'element suivant de 'pIndexPageMem' dans 'pValeurMem' */
                        rc= CopieElementSuivantListe(pListeMem, &pIndexPageMem, (void**)&pValeurMem, BOUCLE_DEBUT);
                        }
                    }

                ++nbDefautPage; /* Un defaut de page est survenu */
                }

            /* Copie la valeur de l'element suivant de 'pIndexPage' dans 'pValeur' */
            rc= CopieElementSuivantListe(pListePage, &pIndexPage, (void**)&pValeur, AUCUN);
            }

        /* Traitement de l'erreur de fin de liste */
        if (rc == TP3_ERREUR_LISTE_VIDE || rc == TP3_ERREUR_FIN_LISTE)
            rc= 0;
        }

    if (!rc)
        AfficherResultat("Horloge", pListeMem, nbCaseMem, nbDefautPage);

    if (pListeMem != NULL)
        DetruireListe(&pListeMem);

    return rc;
    }

/*****************************************************************************/
/* Cette fonction trouve la position ou le defaut de page doit avoir lieu    */
/* PARAMETRES: IN  pListeMem   : Liste des cases memoires                    */
/*             OUT ppIndexMem  : Index du defaut de page de la liste des     */
/*                                cases memoires                             */
/*             IN  pListePages : Liste des pages demandees                   */
/*             IN  pIndex      : Pointeur sur l'element qui doit etre ajoute */
/*                                a la liste des pages en memoire            */
/* Retourne code d'erreur      : 0 - OK                                      */
/*                               Sinon - Erreur                              */
/*****************************************************************************/
int TrouverPageARemplacerOptimal(LISTE *pListeMem, LISTE_ELEMENT **ppIndexMem,
                                 LISTE *pListePages, LISTE_ELEMENT *pIndex)
    {
    int rc= 0;                  /* Code de retour                                        */
    unsigned int i;             /* Variable utilise pour la boucle 'for'                 */   
    int *pValeurMem;            /* Valeur d'un element de la liste des pages en memoire  */
    int posValeurDefautPage= 0; /* Position de la page dans la liste des pages demandees */
    int *pValeurPage;           /* Valeur d'un element de la liste des pages demandees   */
    LISTE_ELEMENT *pDefautPage; /* Pointeur sur l'element du defaut de page             */
    LISTE_ELEMENT *pIndexTemp;   /* Pointeur temporaire sur un element                   */
    BOOL trouve= FALSE;

    rc= CopiePremierElementListe(pListeMem, ppIndexMem, (void**)&pValeurMem);
    pIndexTemp= pIndex;

    /* Boucle sur les cases memoires pour trouve la case a remplace */
    for (i= 0; i < pListeMem->nbElement && !rc; ++i)
        {
        int posPage= 0; /* Position de la page dans la liste des pages demandees */
        
        /* Identifiera si la page est presente dans la liste des pages demandees */
        trouve= FALSE;
        pIndex= pIndexTemp;
        rc= CopieElementSuivantListe(pListePages, &pIndex, (void**)&pValeurPage, AUCUN);

        /* Boucle tant qu'il n'y a pas d'erreur ou que la page n'est pas trouve */
        /*  de la liste des page demandees */
        while (!rc && !trouve)
            {
            /* La valeur est trouve */
            if (*pValeurMem == *pValeurPage)
                trouve= TRUE;

            ++posPage;  /* Incremente la position de l'element */
            rc= CopieElementSuivantListe(pListePages, &pIndex, (void**)&pValeurPage, AUCUN);
            }

        /* L'element courant de la liste memoire n'est pas present     */
        /*  dans le reste de la liste de pages demandes. Donc, c'est a */
        /*  cette endroit qu'aura lieu le defaut de page               */
        if (!trouve)
            {
           // *ppIndexMem= pDefautPage;
            break;  /* Sort de la boucle, car l'element n'est pas trouve */
            }
        else
            {
            /* Si l'element trouve est plus loin que l'ancien element le plus loin, */
            /*  copie de l'element ainsi que de la position */
            if (posValeurDefautPage < posPage)
                {
                pDefautPage= *ppIndexMem;
                posValeurDefautPage= posPage;
                }
            }

        rc= CopieElementSuivantListe(pListeMem, ppIndexMem, (void**)&pValeurMem, AUCUN);

        /* Traitement de l'erreur de fin de liste */
        if (rc == TP3_ERREUR_LISTE_VIDE || rc == TP3_ERREUR_FIN_LISTE)
            rc= 0;
        }

    if (trouve)
        {
        /* Copie l'adresse de l'element qui fera un defaut de page */
        /*  dans le parametre de sortie */
        *ppIndexMem= pDefautPage;
        }
    
    /* Traitement de l'erreur de fin de liste */
    if (rc == TP3_ERREUR_LISTE_VIDE || rc == TP3_ERREUR_FIN_LISTE)
        rc= 0;

    return rc;
    }

/*****************************************************************************/
/* Cette fonction verifie si une certaine page est en memoire                */
/* PARAMETRES:  IN pListeMem : Liste des cases en memoire                    */
/*              IN valeur    : Valeur a recherche en memoire                 */
/* Retourne code d'erreur    : 0 - OK                                        */
/*                             Sinon - Erreur                                */
/*****************************************************************************/
int PagePresenteEnMemoire(LISTE *pListeMem, int valeur)
    {
    int rc= 0;          /* Code de retour                                        */
    BOOL trouve= FALSE; /* Identifiera si la page est presente en memoire ou non */
    LISTE_ELEMENT *pIndexMem; /* Pointeur sur un element d'une liste             */
    int *pValeur;             /* Valeur d'un element d'une liste                 */
    
    rc= CopiePremierElementListe(pListeMem, &pIndexMem, (void**)&pValeur);

    /* Boucle tant qu'il n'y a pas d'erreur et que l'element n'est pas trouve */
    while (!rc && !trouve)
        {
        /* L'element est trouve, sinon nous allons a l'element suivant */
        if (*pValeur == valeur)
            trouve= TRUE;
        else
            rc= CopieElementSuivantListe(pListeMem, &pIndexMem, (void**)&pValeur, AUCUN);
        }

    /* Traitement de l'erreur de fin de liste */
    if (rc == TP3_ERREUR_LISTE_VIDE || rc == TP3_ERREUR_FIN_LISTE)
        rc= 0;

    return trouve;
    }

/*****************************************************************************/
/* Cette fonction execute l'algorithme optimal                               */
/* PARAMETRES:  IN nbCaseMem : Nombre de case memoire disponible pour l'algo.*/
/*              IN pListePage: Liste des pages demandees                     */
/* Retourne code d'erreur    : 0 - OK                                        */
/*                             Sinon - Erreur                                */
/*****************************************************************************/
int ExecuterAlgoOptimal(NUMCASE nbCaseMem, LISTE *pListePage)
    {
    int rc= 0;                 /* Code de retour                             */
    LISTE *pListeMem= NULL;    /* Liste qui represente les cases memoires    */
    int nbDefautPage= 0;       /* Nombre de defauts de page effectue         */
    LISTE_ELEMENT *pIndexPage; /* Pointeur sur un element d'une liste        */
    int *pValeur;              /* Valeur d'un element d'une liste            */
    unsigned int i;            /* Variable utilise pour les boucles 'for'    */   

    /* Creation de la liste representant les cases memoires */
    rc= CreerListe(&pListeMem);

    if (!rc)
        {
        rc= CopiePremierElementListe(pListePage, &pIndexPage, (void**)&pValeur);

        /* Boucle sur les cases memoires ou jusqu'une erreur survienne      */
        for (i= 0; i < pListePage->nbElement && !rc; ++i)
            {
            /* La page ne doit pas etre en memoire pour qu'elle soit traite */
            if (!PagePresenteEnMemoire(pListeMem, *((int*)pValeur)))
                {
                /* S'il reste des cases memoires disponibles,               */
                /*  la valeur est ajoute a la liste des cases memoires      */
                if (pListeMem->nbElement < nbCaseMem)
                    AjouteElementListe(pListeMem, (int*)pValeur);
                else
                    {
                    /* Pointeur sur la page a modifie ou aura lieu le defaut de page */
                    LISTE_ELEMENT* pIndexMem;

                    TrouverPageARemplacerOptimal(pListeMem, &pIndexMem,
                                                 pListePage, pIndexPage);
                    
                    /* Copie la valeur au bonne endroit de la liste des cases memoires */
                    pIndexMem->pValeur= pValeur;
                    }

                ++nbDefautPage; /* Un defaut de page est survenu */
                }

            /* Copie la valeur de l'element suivant de 'pIndexPage' dans 'pValeur' */
            rc= CopieElementSuivantListe(pListePage, &pIndexPage, (void**)&pValeur, AUCUN);
            }

        /* Traitement de l'erreur de fin de liste */
        if (rc == TP3_ERREUR_LISTE_VIDE || rc == TP3_ERREUR_FIN_LISTE)
            rc= 0;
        }

    /* Le resultat final est affiche si aucune erreur n'est survenue */
    if (!rc)
        AfficherResultat("Optimal", pListeMem, nbCaseMem, nbDefautPage);

    /* Destruction de la liste representant la memoire */
    if (pListeMem != NULL)
        DetruireListe(&pListeMem);

    return rc;
    }

/*****************************************************************************/
/* Cette fonction affiche les resultats d'une liste de pages                 */
/* PARAMETRES: IN nomListe     : Le nom de la liste en texte                 */
/*             IN pListePage   : Liste des pages demandees                   */
/*             IN nbCaseMem    : Nombre de cases memoire                     */
/*             IN nbDefautPage : Nombre de defaut de pages                   */
/* Retourne code d'erreur      : 0 - OK                                      */
/*                               Sinon - Erreur                              */
/*****************************************************************************/
int AfficherResultat(char* nomListe, LISTE *pListePage, NUMCASE nbCaseMem, 
                     int nbDefautPage)
    {
    int rc= 0;             /* Code de retour                      */
    LISTE_ELEMENT *pIndex; /* Pointeur sur un element d'une liste */
    int *pValeur;          /* Valeur d'un element d'une liste     */
    unsigned int i;        /* Variable servant a la boucle FOR    */

    /* Affiche l'entete du rapport */
    printf("===============================================================================\n");
    printf("Resultat algorithme de replacement de page (%s)\n", nomListe);
    printf("-------------------------------------------------------------------------------\n");            

    rc= CopiePremierElementListe(pListePage, &pIndex, (void**)&pValeur);

    /* Boucle sur l'ensemble des cases memoire */
    for (i= 0; i < nbCaseMem; ++i)
        {
        /* Affiche le contenu de la case memoire si elle est utilise, */
        /*  sinon, affiche un tiret ('-')                             */
        if (i < pListePage->nbElement)
            printf("case %d : %d\n", i + 1, *pValeur);
        else
            printf("case %d : -\n", i + 1);

        rc= CopieElementSuivantListe(pListePage, &pIndex, (void**)&pValeur, AUCUN);
        
        /* Traitement de l'erreur de fin de liste */
        if (rc == TP3_ERREUR_LISTE_VIDE || rc == TP3_ERREUR_FIN_LISTE)
            rc= 0;
        }

    /* Affiche le pied de page du rapport */
    printf("\nNombre de page en faute : %d\n", nbDefautPage);
    printf("===============================================================================\n");

    return rc;
    }

/*****************************************************************************/
/* Fonction principale (main)                                                */
/* Cette fonction contient les trois algorithmes a executer                  */
/*****************************************************************************/                    
int main(int argc, char* argv[])
    {
    int rc= 0;                     /* Code de retour */
    NUMCASE nbCaseMem;             /* Nombre de cases memoire lu sur la ligne de commande */
    char nomFichier[PATH_MAX]= ""; /* Nom du fichier contenant les cases memoires         */
    LISTE *pListeOptimal= NULL;    /* Liste des pages demandees pour l'algo optimal       */
    LISTE *pListeLRU= NULL;        /* Liste des pages demandees pour l'algo LRU           */
    LISTE *pListeHorloge= NULL;    /* Liste des pages demandees pour l'algo horloge       */

    /* Trouve les parametres specifies a la ligne de commande */
    rc= TrouveParametre(argc, argv, &nbCaseMem, nomFichier);    

    /* Creation des listes si aucune erreur n'est survenue */
    if (!rc)
        {
        rc= CreerListe(&pListeOptimal) | CreerListe(&pListeLRU) | 
             CreerListe(&pListeHorloge);
        }

    if (!rc)
        {
        printf("Simulation d'algorithmes de remplacement de pages\n");

        /* Rempli la liste optimal avec les donnees du fichier  */
        rc= LirePages(nomFichier, pListeOptimal);

        /* Duplique la liste optimal pour la liste LRU          */
        if (!rc)
            rc= DupliquerListe(&pListeOptimal, &pListeLRU);

        /* Duplique la liste optimal pour la liste de l'horloge */
        if (!rc)
            rc= DupliquerListe(&pListeOptimal, &pListeHorloge);
        }

    /*****************************/
    /* Execution des algorithmes */
    /*****************************/
    if (!rc)
        rc= ExecuterAlgoLRU(nbCaseMem, pListeLRU);

    if (!rc)
        rc= ExecuterAlgoOptimal(nbCaseMem, pListeOptimal);

    if (!rc)
        rc= ExecuterAlgoHorloge(nbCaseMem, pListeHorloge);

    /*****************************/
    /*  DESTRUCTION DES LISTES   */
    /*****************************/
    if (pListeOptimal != NULL)
        DetruireListe(&pListeOptimal);

    if (pListeLRU != NULL)
        DetruireListe(&pListeLRU);

    if (pListeHorloge  != NULL)
        DetruireListe(&pListeHorloge);

    /*****************************/
    /* GESTION DU CODE D'ERREUR  */
    /*****************************/
    switch (rc)
        {
        case 0:
            /* ne fait rien, aucune erreur */
            printf("Fin du programme\n");
            break;

        case TP3_ERREUR_PARAMETRE_INCORRECT:
            printf("ERREUR: Parametre manquant ou incorrect\n");
            break;

        case TP3_ERREUR_MANQUE_MEMOIRE:
            printf("ERREUR: Manque de memoire\n");
            break;

        case TP3_ERREUR_LISTE_VIDE:
            printf("ERREUR: Liste vide\n");
            break;

        case TP3_ERREUR_FIN_LISTE:
            printf("ERREUR: Fin de liste\n");
            break;

        case TP3_ERREUR_NB_CASE_MEMOIRE:
            printf("Erreur nombre de case memoire\n");
            break;

        case TP3_ERREUR_LECTURE_FICHIER:
            printf("Erreur lecture du fichier\n");
            break;
        }

    return rc;
    }


