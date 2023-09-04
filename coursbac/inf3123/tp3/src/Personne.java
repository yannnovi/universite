/*$Id: Personne.java,v 1.3 2004/04/27 16:15:27 yann Exp $*/
 package tp3;


/**
 * La classe Personne implemente une personne.
 */
public class Personne
{
    private String nom; // Nom de la personne.
    private String prenom; // Prenom de la personne.

    /** Constructeur
     * @param nom Nom de la personne
     * @param prenom de la personne
     * 
     * @throws ExceptionPersonne
     */
    public Personne(String nom, String prenom) throws ExceptionPersonne
    {
        if(nom==null)
        {
            throw new ExceptionPersonne("Le nom ne peut etre null.");
        }

        if(prenom==null)
        {
            throw new ExceptionPersonne("Le prenom ne peut etre null.");
        }

        this.nom=nom;
        this.prenom=prenom;

    }

        /** Retourne le nom de la personne
     * @return Le nom de la personne
     */
    public String getNom()
    {
        return nom;
    }

    /** Change le nom de la personne
     * @param nom Le nom de la personne
     * @throws ExceptionPersonne
     */
    public void setNom(String nom) throws ExceptionPersonne
    {
        if(nom==null)
        {
            throw new ExceptionPersonne("Le nom ne peut etre null.");
        }
        this.nom=nom;
    }

    /** Retrouve le prenom de la personne
     * @return Le prenom de la personne
     */
    public String getPrenom()
    {
        return prenom;
    }

    /** Change le prenom de la personne
     * @param prenom Le prenom de la personne
     * @throws ExceptionPersonne
     */
    public void setPrenom(String prenom) throws ExceptionPersonne
    {
        if(prenom==null)
        {
            throw new ExceptionPersonne("Le prenom ne peut etre null.");
        }

        this.prenom=prenom;
    }

    public String toString()
    {
        return this.getNom() + " "+ this.getPrenom();
    }

    public boolean equals(Personne v)
    {
        return (nom.equals(v.nom) && prenom.equals(v.prenom));
    }

}
