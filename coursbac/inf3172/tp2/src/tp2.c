/*****************************************************************************/
/*$Id: tp2.c,v 1.41 2003/11/19 21:07:46 sebastien Exp $                      */
/*****************************************************************************/
/* Ce programme simule un ordonnanceur de processus de type feedback.        */
/*                                                                           */
/* Auteur: Sebastien Bonneau (bonneau.sebastien.2@courrier.uqam.ca)          */
/*         Yann Bourdeau (bourdeau.yann@courrier.uqam.ca)                    */
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
#define FALSE 0                       /* Constante FALSE                     */
#define TRUE  1                       /* Constante TRUE                      */
#define NB_CAR_PAR_LIGNE 255          /* Nombre de caracteres lus par ligne  */

#define NB_PROCESSUS_PAR_DEFAUT 1000  /* Dimension du tableau par defaut     */

/* Liste des erreurs possibles                                               */
#define TP2_ERREUR_PARAMETRE_INCORRECT   1
#define TP2_ERREUR_MANQUE_MEMOIRE        2
#define TP2_ERREUR_QUEUE_VIDE            3
#define TP2_ERREUR_QUEUE_NULL            4
#define TP2_ERREUR_LECTURE_FICHIER       5
#define TP2_ERREUR_QUANTUM_INVALIDE      6
/*****************************************************************************/
/* Enumeration definie pour ce programme                                     */
/*****************************************************************************/        

/*****************************************************************************/
/* Types definis pour ce programme                                           */
/*****************************************************************************/
typedef unsigned int QUANTUM;
typedef unsigned int TEMPS;
typedef unsigned int ID;

typedef struct QUEUE_ELEMENT
    {
    struct QUEUE_ELEMENT *pSuivant; /* Pointeur sur le prochain element   */
    void *pElement;                 /* Pointeur sur l'element en question */
    } QUEUE_ELEMENT;

typedef struct QUEUE
    {
    int nbElement;                 /* Nombre d'elements de la queue       */
    QUEUE_ELEMENT *pElement;       /* Pointeur sur un element de la queue */
    } QUEUE;

typedef struct PROCESSUS
    {
    ID id;                 /* L'id du processus (permet de l'identifier)     */
    TEMPS tempsArrive;     /* Le temps d'arrivee de ce processus             */
    TEMPS duree;           /* La duree du processus                          */ 
    TEMPS debutExecution;  /* Le temps du debut de l'execution du processus  */
    TEMPS finExecution;    /* Le temps de la fin de l'execution du processus */
    } PROCESSUS;

/*****************************************************************************/
/* Prototypes des fonctions                                                  */
/*****************************************************************************/
/* Entetes de fonctions qui gerent les queues */
int CreerQueue(QUEUE **ppQueue);
int LibererQueue(QUEUE **ppQueue);
int AjouteElementQueue(QUEUE *pQueue, void *pElement);
int PrendElementQueue(QUEUE *pQueue, void **ppElement);
int VoirProchainElementQueue(QUEUE *pQueue, void **ppElement);
int NbElementQueue(QUEUE *pQueue);

/* Entetes de fonctions qui gerent les processus */
int AlloueProcessus(PROCESSUS **pProc, ID id, TEMPS tempsArrive, TEMPS duree);
int LibereProcessus(PROCESSUS **pProc);
int PlacerDebutExecutionProcessus(PROCESSUS *pProc, TEMPS debutExecution);
int PlacerFinExecutionProcessus(PROCESSUS *pProc, TEMPS finExecution);

/* Entetes de fonctions generales au programme */
int TrouveParametre(int argc, char *argv[], QUANTUM *pQuantum, char *nomFichier);
int LireProcessus(char *nomFichier, PROCESSUS *tabProcessus[], int *pnbProcessus);
int TrierProcessusParTempsArrive(PROCESSUS *tableau[], const int taille);

/*****************************************************************************/
/* Fonction qui initialise par defaut la queue de type FIFO                  */
/*                                                                           */
/* Parametre: OUT pQueue  : Pointeur sur la queue allouee                    */
/* Retourne code d'erreur : 0 - OK                                           */
/*                          Sinon - Erreur                                   */
/*****************************************************************************/
int CreerQueue(QUEUE **ppQueue)
    {
    int rc= 0; /* Code de retour */

    /* Cree la queue en memoire et initialise tous les champs a zero */
    *ppQueue= (QUEUE*) calloc(1, sizeof(QUEUE));

    if (*ppQueue == NULL)
        rc= TP2_ERREUR_MANQUE_MEMOIRE;

    return rc;
    }

/*****************************************************************************/
/* Fonction qui libere la memoire de la queue                                */
/*                                                                           */
/* Parametre: OUT IN ppQueue : Queue a liberer                               */
/* Retourne code d'erreur    : 0 - OK                                        */
/*                             Sinon - Erreur                                */
/*****************************************************************************/
int LibererQueue(QUEUE **ppQueue)
    {
    int rc= 0;             /* Code de retour */
    QUEUE_ELEMENT *pQElem; /* Pointeur sur un element temporaire */

    /* Une queue est definie */
    if (*ppQueue != NULL)
        {
        /* Il existe des elements dans la queue */
        if ((*ppQueue)->pElement != NULL)
            {
            /* Libere l'ensemble des processus de la queue */
            while ((*ppQueue)->pElement->pSuivant != NULL)
                {
                pQElem= (*ppQueue)->pElement->pSuivant;
                free((*ppQueue)->pElement);
                (*ppQueue)->pElement= pQElem;
                } 
            }

        /* Libere le pointeur sur la queue */
        free(*ppQueue);
        *ppQueue= NULL;
        }

    return rc;
    }

/*****************************************************************************/
/* Ajoute un element dans la queue                                           */
/*                                                                           */
/* Parametres: IN pQueue   : Queue qui vas contenir le nouvel element        */
/*             IN pElement : Element a ajouter                               */
/* Retourne code d'erreur  : 0 - OK                                          */
/*                           Sinon - Erreur                                  */
/*****************************************************************************/
int AjouteElementQueue(QUEUE *pQueue, void *pElement)
    {
    int rc= 0;                            /* Code de retour               */
    QUEUE_ELEMENT *pQueueElement= NULL;   /* Element a ajouter            */   
    QUEUE_ELEMENT *pElementCourant= NULL; /* Element de la liste courante */

    /* Verifie que la queue existe */
    if (pQueue == NULL)
        rc= TP2_ERREUR_QUEUE_NULL;
    else
        {
        /* Alloue le nouvel element */
        pQueueElement= (QUEUE_ELEMENT*) calloc(1, sizeof(QUEUE_ELEMENT));

        if (pQueueElement == NULL)
            rc= TP2_ERREUR_MANQUE_MEMOIRE;

        if (!rc)
            {
            /* Initialise l'element */
            pQueueElement->pElement= pElement;
            pQueue->nbElement++;

            /* La queue ne contient aucun element */
            if (pQueue->pElement == NULL)
                pQueue->pElement= pQueueElement;
            else
                {
                /* Ajoute l'element a la fin */
                pElementCourant= pQueue->pElement;

                while (pElementCourant->pSuivant != NULL)
                    pElementCourant= pElementCourant->pSuivant;

                pElementCourant->pSuivant= pQueueElement;
                }
            }
        }
    
    return rc;
    }

/*****************************************************************************/
/* Enleve un element de la queue                                             */
/*                                                                           */
/* Parametres: IN  pQueue    : Queue qui vas contenir le nouvel element      */
/*             OUT pElement  : Element retourner                             */
/* Retourne code d'erreur    : 0 - OK                                        */
/*                             Sinon - Erreur                                */
/*****************************************************************************/
int PrendElementQueue(QUEUE *pQueue, void **pElement)
    {
    int rc= 0;                          /* Code de retour    */
    QUEUE_ELEMENT *pQueueElement= NULL; /* Element a enlever */   

    /* La queue n'est pas definie */
    if (pQueue == NULL)
        rc= TP2_ERREUR_QUEUE_NULL;
    else
        {
        /* Il n'y a pas d'element dans la queue */
        if (pQueue->nbElement == 0)
            rc= TP2_ERREUR_QUEUE_VIDE;
        else
            {
            /* Enleve le premier element */
            *pElement= pQueue->pElement->pElement;
            pQueueElement= pQueue->pElement;
            pQueue->pElement= pQueue->pElement->pSuivant;
            pQueue->nbElement--;
            free(pQueueElement);
            }
        }

    return rc;
    }

/*****************************************************************************/
/* Retourne le prochain element a etre enleve de la queue                    */
/*                                                                           */
/* Parametres: IN  pQueue   : Queue qui vas contenir le nouvel element       */
/*             OUT pElement : Element retourne                               */
/* Retourne code d'erreur   : 0 - OK                                         */
/*                            Sinon - Erreur                                 */
/*****************************************************************************/
int VoirProchainElementQueue(QUEUE *pQueue, void **pElement)
    {
    int rc= 0; /* Code de retour */

    /* La queue n'est pas definie */
    if (pQueue == NULL)
        rc= TP2_ERREUR_QUEUE_NULL;
    else
        {
        /* Retourne le prochain element s'il n'y a pas d'erreur */
        if (pQueue->nbElement == 0)
            rc= TP2_ERREUR_QUEUE_VIDE;
        else
            *pElement= pQueue->pElement->pElement;
        }
    
    return rc;
    }

/*****************************************************************************/
/* Retourne le nombre d'elements dans la queue                               */
/*                                                                           */
/* Parametre: IN pQueue : Queue                                              */
/* Retourne le nombre d'elements de la queue                                 */
/*****************************************************************************/
int NbElementQueue(QUEUE *pQueue)
    {
    return pQueue->nbElement;
    }

/*****************************************************************************/
/* Cette fonction alloue une structure PROCESSUS                             */
/*                                                                           */
/* Parametres: OUT ppProc      : Processus alloue                            */
/*             IN  Id          : Id du processus                             */
/*             IN  TempsArrive : Temps d'arrive du processus                 */
/*             IN  Duree       : Duree du processus                          */
/* Retourne code d'erreur      : 0 - OK                                      */
/*                               Sinon - Erreur                              */
/*****************************************************************************/
int AlloueProcessus(PROCESSUS **ppProc, ID id, TEMPS tempsArrive, TEMPS duree)
    {
    int rc= 0; /* Code de retour */

    /* Alloue la memoire pour la structure PROCESSUS */
    *ppProc= (PROCESSUS *) calloc(1, sizeof(PROCESSUS));

    if (*ppProc == NULL)
        rc= TP2_ERREUR_MANQUE_MEMOIRE;
    else
        {
        /* Assigne les champs */
        (*ppProc)->id= id;
        (*ppProc)->tempsArrive= tempsArrive;
        (*ppProc)->duree= duree;
        }

    return rc;
    }

/*****************************************************************************/
/* Cette fonction libere une structure processus                             */
/*                                                                           */
/* Parametre: IN OUT ppProc : Processus a liberer                            */
/* Retourne code d'erreur   : 0 - OK                                         */
/*                            Sinon - Erreur                                 */
/*****************************************************************************/
int LibereProcessus(PROCESSUS **ppProc)
    {
    int rc= 0; /* Code de retour */

    free(*ppProc);
    *ppProc= NULL;

    return rc;
    }

/*****************************************************************************/
/* Cette fonction place le temps de debut d'execution                        */
/*                                                                           */
/* Parametres: IN OUT ppProc     : Processus                                 */
/*             IN debutExecution : Le temps du debut d'execution             */
/* Retourne code d'erreur        : 0 - OK                                    */
/*                                 Sinon - Erreur                            */
/*****************************************************************************/
int PlacerDebutExecutionProcessus(PROCESSUS *pProc, TEMPS debutExecution)
    {
    int rc= 0; /* Code de retour */      
    pProc->debutExecution= debutExecution;

    return rc;
    }

/*****************************************************************************/
/* Cette fonction place le temps de fin d'execution                          */
/*                                                                           */
/* Parametres: IN OUT ppProc     : Processus                                 */
/*             IN debutExecution : Le temps de fin d'execution               */
/* Retourne code d'erreur        : 0 - OK                                    */
/*                                 Sinon - Erreur                            */
/*****************************************************************************/
int PlacerFinExecutionProcessus(PROCESSUS *pProc, TEMPS finExecution)
    {
    int rc= 0; /* Code de retour */      
    pProc->finExecution= finExecution;

    return rc;
    }

/*****************************************************************************/
/* Cette fonction simule le temps CPU donne a un processus                   */
/*                                                                           */
/* Parametres: IN pProc : Processus courant qui est execute                  */
/*             IN pQDest: Queue que le processus doit etre transfere s'il    */
/*                        n'est pas termine                                  */
/*             IN pQRes : Queue que le processus doit etre transfere s'il    */
/*                        terminer                                           */
/*             IN pTempsCourant: Temps Courant                               */
/*             IN quantum : Quantum                                          */
/* Retourne code d'erreur : 0 - OK                                           */
/*                          Sinon - Erreur                                   */
/*****************************************************************************/
int PlacerProcessusFaitDansQueue(PROCESSUS *pProc, QUEUE *pQDest, QUEUE *pQRes,
                                 TEMPS *pTempsCourant, QUANTUM quantum)
    {
    /* Temps avant l'execution du processus */
    TEMPS tempsAvantQuantum= *pTempsCourant; 
    int rc= 0;  /* code de retour */      

    /* Le processus n'a pas termine son execution completement */
    if (pProc->duree > quantum)
        {
        *pTempsCourant+= quantum; /* Incremente le temps courant */
        pProc->duree-= quantum;   /* Soustrait le quantum a la duree du processus */

        /* Ajoute le processus a la queue suivante */
        AjouteElementQueue(pQDest, pProc);
        }
    else
        {
        *pTempsCourant+= pProc->duree; /* Incremente le temps courant */
        pProc->duree= 0;               /* Le processus est termine    */

        /* Inscrit le temps de fin du processus */
        PlacerFinExecutionProcessus(pProc, *pTempsCourant);

        /* Ajoute le processus a la queue suivante */
        AjouteElementQueue(pQRes, pProc);
        }

    printf("P%d: %d-%d\n", pProc->id, tempsAvantQuantum, *pTempsCourant);
    
   return rc;
   }

/*****************************************************************************/
/* Cette fonction lit les processus du fichier et les charge dans un tableau */
/*                                                                           */
/* Parametres: IN  nomFichier   : Nom du fichier a lire                   */
/*             IN  tabProcessus : Vecteur contenant les info. des processus  */
/*             OUT nbProcessus  : Nombre de processus lus du fichier         */
/* Retourne code d'erreur       : 0 - OK                                     */
/*                                Sinon - Erreur                             */
/*****************************************************************************/ 
int LireProcessus(char *nomFichier, PROCESSUS *tabProcessus[], int *pnbProcessus)
    {
    int rc= 0;                              /* Code de retour */
    FILE *pFichier= fopen(nomFichier, "r"); /* Ouvre le fichier en lecture */

    /* Initialise le nombre de processus a 0 */
    (*pnbProcessus)= 0;

    /* Une erreur est survenue a l'ouverture du fichier, */
    /*  sinon les donnees sont transfere dans le tableau */
    if (pFichier == NULL)
        rc= TP2_ERREUR_LECTURE_FICHIER;
    else
        {
        ID id= 0;   /* Id cree par le numero de la ligne du fichier */
        PROCESSUS *pProcessusLu;   /* Pointeur sur le processus cree dynamiquement */
        TEMPS tempsArrive, duree;  /* Donnees du fichier */
        char ligne[NB_CAR_PAR_LIGNE];   /* Le texte d'une ligne du fichier */
        char surplus[NB_CAR_PAR_LIGNE]; /* Le texte en surplus d'une ligne du fichier */

        /* Boucle sur chaque ligne du fichier tant qu'il n'y a pas d'erreur */
        /*  ou qu'il y a des lignes a lire */
        while (!rc && strcmp(fgets(ligne, NB_CAR_PAR_LIGNE, pFichier), "\n") != 0)
            {
            /* Lit les champs necessaires, ainsi que le surplus de texte, s'il y a lieu */
            int nbParm= sscanf(ligne, "%d %d %s", &tempsArrive, &duree, surplus);
            
            /* Il doit y avoir seulement deux parametres par ligne */
            if (nbParm != 2)
                rc= TP2_ERREUR_LECTURE_FICHIER;
            else
                {
                /* Creation dynamique du processus  */
                rc= AlloueProcessus(&pProcessusLu, ++id, tempsArrive, duree);
                    tabProcessus[id - 1]= pProcessusLu;
                (*pnbProcessus)++;  /* Incremente le nombre de processus lus */
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
/*             OUT pQuantum   : Pointeur sur le QUANTUM                      */
/*             OUT nomFichier : Nom du fichier                               */
/* Retourne code d'erreur     : 0 - OK                                       */
/*                              Sinon - Erreur                               */
/*****************************************************************************/ 
int TrouveParametre(int argc, char *argv[], QUANTUM *pQuantum, char *nomFichier)
    {
    int rc= 0;       /* Code de retour */
    int TempQuantum; /* Variable temporaire pour la lecture du quantum */
    
    /* Determine s'il y a le bon nombre de parametres */
    if (argc != 3)
        rc= TP2_ERREUR_PARAMETRE_INCORRECT;
    else
        {
        TempQuantum= atoi(argv[1]);               /* copie le quantum */
   
        /* Le quantum doit etre plus grand que 0 pour etre valide     */
        if (TempQuantum > 0 )
            *pQuantum= TempQuantum;
        else
            rc= TP2_ERREUR_QUANTUM_INVALIDE;  
      
        strncpy(nomFichier, argv[2], PATH_MAX);   /* copie le nom du fichier */
        }

    return rc;
    }

/*****************************************************************************/
/* Cette fonction echange les processus des deux pointeurs en parametres     */
/*                                                                           */
/* Parametres: PROCESSUS processus1 : Le premier processus                   */
/*             PROCESSUS processus2 : Le deuxieme processus                  */
/* Retourne code d'erreur : Aucune gestion d'erreur - retourne 0             */
/*****************************************************************************/ 
int Interchange(PROCESSUS *processus1, PROCESSUS *processus2)
    {
    PROCESSUS processusTemp= *processus1;
    *processus1= *processus2;
    *processus2= processusTemp;

    return 0;
    }

/*****************************************************************************/
/* Cette fonction trie un tableau de pointeurs sur des processus en ordre de */
/*  croissant de temps d'arrivee au niveau des processus pointes             */
/*  (Tri a bulles)                                                           */
/*                                                                           */
/* Parametres: IN OUT   tableau : Tableau des pointeurs sur les processus    */
/*             CONST IN taille  : Nombre de processus du tableau             */
/* Retourne code d'erreur       : Aucune gestion d'erreur - retourne 0       */
/*****************************************************************************/ 
int TrierProcessusParTempsArrive(PROCESSUS *tableau[], const int taille)
    {
    int passage= 0, j= 0;   /* Variables utilisees pour les deux boucles */

    /* Nombre de passages dans le tableau */
    for (passage= 0; passage < taille - 1; passage++)
        {
        /* Boucle sur chaque element du tableau a chaque passage */
        for (j= 0; j < taille - 1; j++)
            {
            /* Echange les processus pour qu'ils soient en */
            /*  ordre croissant de temps d'arrive */
            if (tableau[j]->tempsArrive > tableau[j + 1]->tempsArrive)
                Interchange(tableau[j], tableau[j + 1]);
            }
        }

    return 0;
    }

/*****************************************************************************/
/* Fonction principale (main)                                                */
/* Cette fonction contient la boucle principale du programme                 */
/*****************************************************************************/                    
int main(int argc, char *argv[])
    {
    int rc= 0;               /* Code de retour                         */
    QUANTUM quantum;         /* Quantum de l'ordonnanceur de processus */
    QUEUE *pQ1= NULL;        /* Queue du premier etage                 */
    QUEUE *pQ2= NULL;        /* Queue du deuxieme etage                */
    QUEUE *pQ3= NULL;        /* Queue du troisieme etage               */
    QUEUE *pQResultat= NULL; /* Queue des resultats                    */

    char nomFichier[PATH_MAX]= "";

    /* Tableau qui contiendra les processus apres avoir lu le fichier */
    PROCESSUS *tabProcessus[NB_PROCESSUS_PAR_DEFAUT];
    int nbProcessus= 0; /* Le nombre de processus que le tableau contient */

    printf("Ordonnanceur de processus de type Feedback a 3 etages.\n");

    /* Trouve les parametres specifies a la ligne de commande */
    rc= TrouveParametre(argc, argv, &quantum, nomFichier);     

    if (!rc)
        {
        /* Affiche les parametres recus*/
        printf("Quantum: %d\nFichier: %s\n", quantum, nomFichier);

        /* Cree les trois queues pour les trois etages,  */
        /*  ainsi que la queue pour les resultats,       */
        /*  rc = 0, si toutes les queues ont ete crees avec succes */
        /*  rc > 0, s'il y a eu un erreur   */
        rc= CreerQueue(&pQ1) | CreerQueue(&pQ2) | 
            CreerQueue(&pQ3) | CreerQueue(&pQResultat);

        if (!rc)
            {
            /* Permet de charger les processus du fichier en memoire */
            rc= LireProcessus(nomFichier, tabProcessus, &nbProcessus);

            if (!rc)
                {
                int i= 0;

                /* Temps qui servira d'horloge pour effectuer les quantums */
                TEMPS tempsCourant= 0; 

                /* Tri le tableau des processus en ordre de temps d'arrivee */
                TrierProcessusParTempsArrive(tabProcessus, nbProcessus);

                /* Ajoute l'ensemble des processus dans la file d'attente */
                /*  de premier niveau  */
                for (i= 0; i < nbProcessus; ++i)
                    AjouteElementQueue(pQ1, tabProcessus[i]);

                /* Boucle tant qu'il existe des processus */
                /*  dans les files d'attentes */
                while (NbElementQueue(pQ1) > 0 || NbElementQueue(pQ2) > 0 || 
                  NbElementQueue(pQ3) > 0)
                    {
                    PROCESSUS *pProcessus;
                    rc= VoirProchainElementQueue(pQ1, (void**) &pProcessus);

                    if (!rc && tempsCourant >= pProcessus->tempsArrive)
                        {
                        // Enleve le processus de la queue de niveau 1
                        rc= PrendElementQueue(pQ1,(void **) &pProcessus);

                        PlacerDebutExecutionProcessus(pProcessus, tempsCourant);
                        rc= PlacerProcessusFaitDansQueue(pProcessus, pQ2, 
                        pQResultat, &tempsCourant, quantum);

                        }
                    else
                        {
                        // Enleve le processus de la queue de niveau 2
                        rc= PrendElementQueue(pQ2, (void **) &pProcessus);

                        if (!rc)
                            {
                            rc= PlacerProcessusFaitDansQueue(pProcessus, pQ3, 
                           pQResultat, &tempsCourant, quantum);
                            }
                        else
                            {
                            // Enleve le processus de la queue de niveau 3
                            rc= PrendElementQueue(pQ3, (void **) &pProcessus);

                            if (!rc)
                                {
                                rc= PlacerProcessusFaitDansQueue(pProcessus, pQ3, 
                              pQResultat, &tempsCourant, quantum);
                                }
                            else
                                {
                                tempsCourant++;
                                }
                            }
                        }
                    }
                }
            }

        /* Libere l'ensemble des queues */
        LibererQueue(&pQ1);
        LibererQueue(&pQ2);
        LibererQueue(&pQ3);

        /* Libere les processus de la queue resultat */
        while (NbElementQueue(pQResultat) > 0)
            {
            PROCESSUS *pProcessus;
            rc= PrendElementQueue(pQResultat,(void **) &pProcessus);

            if (!rc)
                LibereProcessus(&pProcessus);
            }

        LibererQueue(&pQResultat);
      }

    /* Affiche l'erreur trouvee */
    switch (rc)
        {
        case 0:
            /* ne fait rien, aucune erreur */
            break;

        case TP2_ERREUR_PARAMETRE_INCORRECT:
            printf("ERREUR: Parametre manquant ou incorrect.\n");
            break;

        case TP2_ERREUR_MANQUE_MEMOIRE:
            printf("ERREUR: Manque de memoire.\n");
            break;

        case TP2_ERREUR_QUEUE_VIDE:
            printf("ERREUR: Queue vide.\n");
            break;

        case TP2_ERREUR_QUEUE_NULL:
            printf("ERREUR: Queue NULL.\n");
            break;

        case TP2_ERREUR_LECTURE_FICHIER:
            printf("ERREUR: Format de fichier incorrecte.\n");
            break;

        case TP2_ERREUR_QUANTUM_INVALIDE:
            printf("ERREUR: Quantum invalide.\n");
            break;

        default:
            printf("ERREUR: Erreur inconnue : %d.\n", rc);
        }

    printf("Fin du programme.\n");

    return rc;
    }
