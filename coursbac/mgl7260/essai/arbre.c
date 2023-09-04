#include <stdio.h>

typedef
struct Arbre //structure Arbre
{
  int valeur;
  struct Arbre* gauche;
  struct Arbre* droit;

}Arbre;

Arbre* init (int v, Arbre* g, Arbre* d)
{
  Arbre* a;
  a=(Arbre*) malloc (sizeof(Arbre));

  a->valeur=v;
  a->gauche=g;
  a->droit=d;
 
  return (a);

}

void affiche (Arbre* a)
{
  if (a==NULL)
    return;

  printf("(%d, ", a->valeur);
  affiche(a->gauche);
  printf (", ");
  affiche(a->droit);
  printf (")");
}
//Liberation de la memoire
void detruit (Arbre* a)
{ 
  if (a==NULL)
    return;

  detruit(a->gauche);
  detruit(a->droit);

  free((char*)a);
}

Arbre* copie (Arbre* a)
{
  Arbre* b;

  if(a==NULL)
    return NULL;
 
  b=(Arbre*) malloc (sizeof(Arbre));
  b->valeur=a->valeur;
 
  b->gauche=copie(a->gauche);
  b->droit=copie(a->droit);
  return(b);

}

int cherche(Arbre* a, int v)
{
  int n;

  if(a==NULL)
    return (0);

  n = cherche(a->gauche,v) + cherche(a->droit,v);

  if(a->valeur == v)
    return 1+n;

  return (n);
}

void remplace (Arbre* a, int old, int new)
{
 
  if(a==NULL)
    return;

  if(a->valeur == old)
   a->valeur=new;

remplace(a->gauche, old, new);
remplace(a->droit, old, new);

}

main(int c, char ** v)
{
  int n;
  Arbre* a;

  a=init(5,init(7,NULL,init(9,NULL,NULL)),init(5,NULL,NULL));
  affiche(a);
  printf("\n\n");
 
  affiche(copie(a));
  printf("\n");

  n=cherche(a,9);
  printf("\n%d\n",n);
 
  remplace(a, 5, 3);
  affiche(a);
  printf("\n");
}