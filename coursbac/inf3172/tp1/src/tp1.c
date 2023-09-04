/*****************************************************************************/
/*$Id: tp1.c,v 1.35 2003/10/14 22:10:06 sebastien Exp $                           */
/*****************************************************************************/
/* Ce programme simule un "shell" sur Unix.                                  */
/*                                                                           */
/* Auteur: Sebastien Bonneau (bonneau.sebastien.2@courrier.uqam.ca)          */
/*         Yann Bourdeau (bourdeau.yann@courrier.uqam.ca)                    */
/*                                                                           */
/*****************************************************************************/
/* Le programme supporte les fonctionnalites suivantes:                      */
/* 1- Affiche un "prompt" a l'usager.                                        */
/* 2- Permet de lancer un programme. Affiche toutes l'information sur la fin */
/*    du programme.                                                          */
/* 3- Le shell se termine avec la commande exit.                             */
/* 4- Le programme se comporte comme un "shell" pour les commande suivantes  */
/*    - cd <repertoire>                                                      */
/*    - pwd                                                                  */
/*    - cmd1; cmd2; cmd3; cmd4                                               */
/*****************************************************************************/

/*****************************************************************************/
/* Fichier de prototype inclus                                               */
/*****************************************************************************/
#include <stdio.h> 
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <limits.h>
#include <pwd.h>

/*****************************************************************************/
/* Macros utilise par ce programme                                           */
/*****************************************************************************/
#define FALSE 0                       /* Constante FALSE                     */
#define TRUE  1                       /* Constante TRUE                      */
#define MAX_LONGUEUR_NOM_COMMANDE 100 /* Longueur max. d'un nom de commande  */
#define MAX_COMMANDE_DEFINIS 4        /* Nombre de commande supporte         */

/* Nombre de commande par ligne (separe par ;)                               */
#define MAX_COMMANDE_PAR_LIGNE 500

/* Nombre de caractere maximum par ligne                                     */
#define MAX_CARACTERE_PAR_LIGNE 4000

/* Liste des erreur possibles                                                */
#define TP1_MANQUE_MEMOIRE 1
#define TP1_FORK_ERREUR 2
#define TP1_CHDIR_ERREUR 3
#define TP1_GETCWD_ERREUR 4
#define TP1_TERMINE 5
#define TP1_HOMEDIR_ERREUR 6

/*****************************************************************************/
/* Enumeration definis pour ce programme                                     */
/*****************************************************************************/        
enum COMMANDE_ID { EXIT, CHDIR, PWD, OTHER, FINLISTE, NONDEFINIS };

/*****************************************************************************/
/* Type definis pour ce programme                                            */
/*****************************************************************************/
/* Structure d'une commande                                                  */
typedef struct TP1_COMMANDE
    {
    char Nom[MAX_LONGUEUR_NOM_COMMANDE]; /* nom de la commande saisie */
    enum COMMANDE_ID Id;                 /* Identifiant de la commande */
    int (*pFunc)(char *);                /* fonction qui execute la commande */
    } TP1_COMMANDE;

/* Structure de la liste de commande                                         */
typedef struct LISTE_COMMANDE
    {
    char Option[MAX_LONGUEUR_NOM_COMMANDE]; /* Option de la commande saisie */
    enum COMMANDE_ID Id;                    /* Identifiant de la commande */
    int (*pFunc)(char *);                   /* fonction qui execute la commande */
    } LISTE_COMMANDE;

/*****************************************************************************/
/* Prototype des fonctions.                                                  */
/*****************************************************************************/
int CommandeLance(char *);
int CommandeChangeRep(char *);
int CommandeAffRep(char *);
int CommandeTermine(char *);
void EtendsRepertoire(char* pRepSource,char *pRepRes);
void EnleveEspaceDebut(char *pChaine);
/*****************************************************************************/
/* Liste des commandes supportes.                                            */
/*****************************************************************************/
const TP1_COMMANDE gStruct[MAX_COMMANDE_DEFINIS]=
    {
        { "exit",  EXIT,  CommandeTermine   },
        { "cd",    CHDIR, CommandeChangeRep },        
        { "chdir", CHDIR, CommandeChangeRep },
        { "pwd",   PWD,   CommandeAffRep    }
    };

/*****************************************************************************/
/* Cette fonction permet de lancer un programme unix                         */
/* PARAMETRE: pOption : pointeur sur les options de la commande,             */
/* RETOURNE:  0 si ok, sinon une erreur de la liste definis                  */
/*****************************************************************************/
int CommandeLance(char *pOption)
    {
    int rc= 0;          /* Contient le code de retour */
    pid_t Pid= fork();  /* Creation d'un nouveau processus */

    /* Le processus n'a pas pu etre cree, donc le code de retour sera */
    /*  une erreur de la liste definis */
    if (Pid == -1)
        rc= TP1_FORK_ERREUR;
    else
        {
        /* 0 = Processus enfant */
        if (Pid == 0)
            {
            char seps[]= " ";
            char *token;
            char *pExecParm[255]= {NULL};
            int i= 0;

            /* Identifie les options qui sont separe par un espace */
            token= strtok(pOption, seps);

            /* Boucle tant qu'il y a des options separe par un espace */
            while (token != NULL)
                {
                /* Copie l'option dans le tableau des options */
                pExecParm[i]= token;

                i++;           /* Incremente de 1 l'indice pour pExecParm */
                token= strtok(NULL, seps); /* Obtient la prochaine option */
                }

            /* Charge et execute le processus enfant */
            execvp(pExecParm[0], &(pExecParm[0]));

            /* Le fichier ou le chemin d'acces n'est pas valide */
            if (errno == ENOENT)
                printf("Commande inconnus.\n");
            else
                printf("ERREUR: execv: %d\n", errno);

            exit(0);
            }
        else
            {
            int Status;

            /* Attend la terminaison du processus enfant */
            waitpid(Pid,&Status,0);

            /* Affiche les informations de la terminaisaon du processus enfant */
            printf("PID: %d, Exit status: %d, Signal: %d, Core Dump: %d\n",Pid,
                   WEXITSTATUS(Status),WTERMSIG(Status),
                   WCOREDUMP(Status));
            }
        }

    return rc;
    }

/*****************************************************************************/
/* Cette fonction permet de revenir au repertoire maison de l'usager         */
/* PARAMETRE: Aucun                                                          */
/* RETOURNE:  Le nom du repertoire maison                                    */
/*****************************************************************************/
char* RetourneHomeDir(void)
    {
    /* Obtient la valeur de la variable d'environnement HOME */
    char *pHome= getenv("HOME");
    
    /* La variable d'environnement HOME n'est pas defini */
    if (!pHome)
        {
        /* Obtient une structure "password" sur l'usager utilisant le shell */
        struct passwd *pw= getpwuid(getuid());
    
        /* La structure password est defini, */
        /*  donc on obtient le répertoire initial de travail */
        if (pw)
          pHome= pw->pw_dir;
        }

    return pHome;
    }

/*****************************************************************************/
/* Cette fonction permet de changer le repertoire courant                    */
/* PARAMETRE: pParm :                                                        */
/* RETOURNE:  0 si ok, sinon une erreur de la liste definis                  */
/*****************************************************************************/
int CommandeChangeRep(char *pParm)
    {
    int rc= 0;  /* Contient le code de retour */
    int i= 0;
    char *pDir= NULL;

    /* Enleve les espaces blanc de la chaine pour chdir. chdir ne supporte */
    /*  pas un repertoire qui contient des espaces a la fin */
    for (i= strlen(pParm) - 1; (i >= 0) && pParm[i] == ' '; --i)
        pParm[i]=0;

    /* La commande est seule (sans nom de repertoire) */
    if (strlen(pParm)==0)
        {
        /* Obtient le nom du repertoire maison */
        pDir= RetourneHomeDir();
        
        /* Le repertoire maison n'est pas defini */
        if (pDir == NULL)
            rc= TP1_HOMEDIR_ERREUR;
        }
    else
        {
        pDir= pParm;
        }

    /* Si aucune erreur, changer le repertoire courant */
    if (!rc)
        {
        rc= chdir(pDir);    /* change le repertoire courant */
        
        /* Une erreur est survenue, lors du changement de repertoire */
        if (rc == -1)
            {
            /* Identifie le type de l'erreur */
            switch (errno)
                {
                /* Affiche un message d'erreur lorsque le repertoire */
                /* n'est pas valide ou que l'usager n'a pas les droits */
                case EACCES:
                case ENOENT:
                    printf("Le repertoire n'existe pas.\n");
                    rc= 0;
                    break;

                /* Pour toutes autres erreurs, ce sera une erreur */
                /*  de la liste des erreurs definis */
                default:
                    rc= TP1_CHDIR_ERREUR;
                }
            }
        }

    return rc;
    }

/*****************************************************************************/
/* Cette fonction affiche le nom du repertoire courant                       */
/* PARAMETRE: pOption : pointeur sur les options de la commande,             */
/* RETOURNE:  0 si ok, sinon une erreur de la liste definis                  */
/*****************************************************************************/
int CommandeAffRep(char *pOption)
    {
    /* Variable contenant le nom du repertoire courant */
    char Path[PATH_MAX]= ""; 
    int rc= 0;           /* Contient le code de retour */
    
    /* Impossible d'obtenir le nom du repertoire courant */
    if (getcwd(Path, PATH_MAX) == NULL)
        rc= TP1_GETCWD_ERREUR;

    /* Si aucune erreur, affiche le repertoire courant */
    if (!rc)
        printf("%s\n", Path);

    return rc;
    }

/*****************************************************************************/
/* Cette fonction retourne une constante signifiant la fin du shell          */
/* PARAMETRE: pOption : pointeur sur les options de la commande,             */
/*                      les options ne sont pas utilise dans ce cas ci       */
/* RETOURNE:  TP1_TERMINE, constante signifiant la fin du shell              */
/*****************************************************************************/
int CommandeTermine(char *pOption)
    {
    return TP1_TERMINE;
    }

/*****************************************************************************/
/* Affiche le prompt a l'utilisateur                                         */
/* PARAMETRE: Aucun.                                                         */
/* RETOURNE: 0 si ok, sinon une erreur de la liste definis                   */
/*****************************************************************************/
int AffichePrompt(void)
    {
    char Path[PATH_MAX]= "";
    getcwd(Path, PATH_MAX);     /* Obtient le nom du repertoire courant */
    printf("<%s> ? ",Path);      /* Affiche le repertoire courant */
    }

/*****************************************************************************/
/* Saisie l'ensemble des commandes a l'ecran                                 */
/* PARAMETRE: pListeCommande (SORTIE): Pointeur sur le tableau des commandes */
/*                Le tableau sera rempli par les commandes saisies a l'ecran */
/*                                                                           */
/* RETOURNE: 0 si ok, sinon une erreur de la liste definis                   */
/*****************************************************************************/
int SaisieCommande(LISTE_COMMANDE *pListeCommande)
    {
    int rc=0;          /* Contient le code de retour */
    char *pBuf=NULL;   /* Pointeur sur la memoire qui vas contenir la */
                       /*  commande lus */
    char Trouve=FALSE; /* Booleen qui indique si la commande a ete trouve */
    int i= 0;          /* Iterateur de la boucle for */
    char *token;
    int z= 0;   /* Iterateur de la boucle des commandes */
    
    /* Alloue la memoire qui vas contenir la ligne de commande lus.*/
    pBuf= malloc(MAX_CARACTERE_PAR_LIGNE);

    /* Verifie si la memoire a ete alloue */
    if (pBuf == NULL)
        rc= TP1_MANQUE_MEMOIRE;

    /* Si aucune erreur, continue le traitement.*/
    if (!rc)
        {
        gets(pBuf); /* Lis une ligne à l'écran */

        /* Identifie les commandes qui sont separe par un ';' */
        token= strtok( pBuf, ";" ); 

        /* Boucle tant qu'il y a des commandes separe par un ';' */
        while ( token != NULL )
            {
            /* Copie la commande dans le tableau des commandes */
            strcpy(pListeCommande[i].Option, token);
            
            /* La commande est temporairement non-defini */
            pListeCommande[i].Id= NONDEFINIS;   
            
            i++;       /* Incremente de 1 l'indice pour pListeCommande */
            token= strtok(NULL, ";"); /* Obtient la prochaine commande */
            }

        /* Il ne reste plus de commande a l'ecran */      
        pListeCommande[i].Id= FINLISTE;  

        /* Boucle sur l'ensemble des commandes deja lus */
        while (pListeCommande[z].Id != FINLISTE)
            {
            /* Flag indiquant si la commande est une commande pre-defini */
            /*  ou un programme unix a lance */
            Trouve= FALSE;  

            /* Boucle sur les commandes pre-definis afin de savoir si la commande */
            /*  courante est une commande pre-defini */
            for (i= 0; i < MAX_COMMANDE_DEFINIS && !Trouve; ++i)
                {
                /* La commande courante est une commande pre-defini */
                if (strncmp(gStruct[i].Nom, pListeCommande[z].Option, strlen(gStruct[i].Nom)) == 0)
                    {
                    /* Copie les attributs de la commandes pre-definis */
                    pListeCommande[z].Id= gStruct[i].Id;
                    pListeCommande[z].pFunc= gStruct[i].pFunc;

                    /* Enleve le nom de la commande de la commande */
                    if (strlen(pBuf) == strlen(gStruct[i].Nom))
                        {
                        /* Si aucune option, fait une ligne vide */
                        pListeCommande[z].Option[0]= 0;
                        }
                    else
                        {
                        /* Enleve le nom de la commande */
                        memmove(pListeCommande[z].Option, 
                                pListeCommande[z].Option + strlen(gStruct[i].Nom) + 1,
                                strlen(pListeCommande[z].Option) - (strlen(gStruct[i].Nom) + 1) + 1);
                        }


                    Trouve= TRUE;    /* La commande est une commande pre-defini */
                    }
                }

            /* Si la commande n'est pas trouve, c'est un programme a lance */
            if (!Trouve)
                {
                pListeCommande[z].Id= OTHER;
                pListeCommande[z].pFunc= CommandeLance;
                }

            z++;    /* Incremente l'iterateur des commandes lues a l'ecran */
            }

        }

    /* Le tempon memoire est encore alloue */
    /* Donc, desallocation de la memoire */
    if (pBuf)
        free(pBuf); 

    return rc;
    }

/*****************************************************************************/
/* Fonction principal (main)                                                 */
/* Cette fonction contient la boucle principal du programme. De plus, cette  */
/* fonction gere les erreurs et affiche l'erreur à l'ecran s'il y a lieu     */
/* LA boucle fait: 1- Affiche le prompt                                      */
/*                 2- Saisie une commande                                    */
/*                 3- Effectue la commande                                   */
/*****************************************************************************/                    
int main(int argc, char *argv[])
    {
    int rc=0;           /* Code de retour */
    char Termine=FALSE; /* booleen qui indique si le programme doit terminer */

    /* Tableau qui contiendra l'ensembles des commandes entrées par l'usager */
    LISTE_COMMANDE ListeCommande[MAX_COMMANDE_PAR_LIGNE];
    int i=0;    
    
    printf("Shell\n");

    /* Boucle tant que l'usgaer ne sort pas du "shell" */
    /* et qu'il n'y a pas d'erreur */
    while (!Termine && !rc)
        {
        rc= AffichePrompt();    /* Affiche le prompt du shell */

        /* Si aucune erreur, continuer le traitement.*/
        if (!rc)
            {
            /* Saisie la/les commande (s) à l'écran */
            rc= SaisieCommande(&ListeCommande[0]);
            }

        /* Si aucune erreur, continuer le traitement.*/
        if (!rc)
            {
            i= 0;   /* Indice de la commande */

            /* Boucle sur l'ensemble des commandes du tableau ListeCommande */
            /* et exécute la commande */
            while (ListeCommande[i].Id != FINLISTE)
                {
		char PathComplet[PATH_MAX]= ""; 
                
		EtendsRepertoire(ListeCommande[i].Option, PathComplet);
                rc= ListeCommande[i].pFunc(PathComplet);

                /* La commande courante est de quitter le shell */
                if (rc == TP1_TERMINE)
                    {
                    /* Flag indiquant de quitter la boucle principale */
                    Termine= TRUE;
                    rc= 0;   /* Code de retour 0 */
                    }

                ++i;  /* Incrémentation de 1 de l'indice de la commande */
                }
            }

        }

    /* En cas d'erreur, le shell affiche un message d'erreur */
    if (rc)
        {
        printf("\nERREUR: ");

        /* Affiche une description de l'erreur dépendament de l'erreur */
        switch (rc)
            {
            case TP1_MANQUE_MEMOIRE:
                printf("Impossible d'allouer de la memoire."); 
                break;
            case TP1_FORK_ERREUR:
                printf("Impossible de creer un nouveau processus (fork)."); 
                break;
            case TP1_CHDIR_ERREUR:
                printf("Impossible de changer de repertoire (chdir)."); 
                break;
            case TP1_GETCWD_ERREUR:
                printf("Impossible d'afficher le repertoire courant (getcwd).");
                break;
            case TP1_HOMEDIR_ERREUR:
                printf("Impossible d'aller chercher le repertoire maison (HOME).");
                break;
            default:
                printf("Inconnue.");
            }
        }

    printf("\nFin du programme.\n");
    return rc;
    }

/*****************************************************************************/
/* Cette fonction enleve les espaces blancs au debut d'une chaine            */
/* PARAMETRE: pChaine: Chaine qui contient les espaces a enlever             */
/* RETOURNE: Aucun                                                           */
/*****************************************************************************/
void EnleveEspaceDebut(char *pChaine)
    {
    /* Boucle sur les espaces blancs au debut de la chaine */
    while(strlen(pChaine) > 0 && pChaine[0] == ' ')
        {
        int i= 0;

        /* Deplace les caracteres vers la gauche de 1 caractere */
        for(i= 0; i < strlen(pChaine); ++i)
            pChaine[i]= pChaine[i + 1];     
        }
    }

/*****************************************************************************/
/* Cette fonction permet de remplacer le '~' par le repertoire maison        */
/* PARAMETRE: pRepSource (ENTRE) : repertoire source                         */
/*            pRepRes    (SORTIE): repertoire resultant                      */
/* RETOURNE: Aucun                                                           */
/*****************************************************************************/
void EtendsRepertoire(char* pRepSource, char* pRepRes)
    {
    char* p= strchr(pRepSource, '~'); /* Pointe sur le caractere suivant le '~' */
    strcpy(pRepRes, pRepSource);      /* Copie la chaine source dans la */
                                      /*  chaine resultante */
    EnleveEspaceDebut(pRepRes);

    /* Le '~' est present dans la chaine source */    
    if (p)
        {
	*p= 0;    /* Remplace le '~' par un caractere de fin de chaine */
        p++;      /* Se positionne sur le caractere suivant le '~'     */

        /* Copie la chaine source avant le '~' dans la chaine resultante */
        strcpy(pRepRes, pRepSource);         

        /* Concatene le repertoire maison de l'utilisateur */
        strcat(pRepRes, RetourneHomeDir()); 

        /* Concatene la chaine apres le '~' */
        strcat(pRepRes, p);
        }
    }

