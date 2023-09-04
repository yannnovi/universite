// definition d'un incident de calcul
class PileVide
    {
public:
    PileVide()
    : message( "la pile est vide !" )
        {
        };
    const char *probleme() const
        {
        return message;
        };
private:
    const char *message;
    };

// definition d'une classe utilitaire Element
class Element; // declaration avant

class Element
    {
public:
    Element(int v, Element * ptr = NULL) : valeur(v), suivant(ptr)
        {
        }
    int valeur;
    Element * suivant;
    };

// prototype d'une classe Pile de int
class Pile
    {
public:
    Pile();
    ~Pile();
    int sommet();
    Pile& empile(int);
    Pile& depile();
    Pile& depile(int&);
private:
    Element* ptr;
    };


