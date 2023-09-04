/*$Id: Etudiant.java,v 1.4 2004/02/14 21:39:55 yann Exp $*/
/* Classe de Etudiant. Cette classe contient les attributs nom et prenom d'un etudiant*/

package net.homeip.codeyann.inf3123.tp1;

public class Etudiant
{
    private String nom; /* le nom de l'etudiant */
    private String prenom; /* le prenom de l'etudiant */

    // Constructeur qui prends un nom et prenom d'une etudiant.
    public Etudiant(String nom, String prenom) throws ExceptionEtudiant
    {
        setNom(nom);
        setPrenom(prenom);
    }


    // Mets le nom de l'etudiant.
    public void setNom(String nom) throws ExceptionEtudiant
    {
        if(nom == null)
        {
            throw new ExceptionEtudiant("Le nom ne peut etre null.");
        }

        this.nom=nom;
    }

    // Mets le prenom de l'etudiant.
    public void setPrenom(String prenom) throws ExceptionEtudiant
    {
        if(prenom == null)
        {
            throw new ExceptionEtudiant("Le prenom ne peut etre null.");
        }
        this.prenom=prenom;
    }

    // Prends le nom.
    public String getNom()
    {
        return nom;
    }

    // Prends le prenom.
    public String getPrenom()
    {
        return prenom;
    }
}
