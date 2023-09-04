/*$Id: Dossier.java,v 1.5 2004/02/14 21:39:55 yann Exp $*/
// Classe Dossier: Fait le lien entre un etudiant et une fiche resultat.

package net.homeip.codeyann.inf3123.tp1;

public class Dossier
{
    private Etudiant etudiant;
    private FicheResultats ficheResultats;

    // Constructeur qui construit le dossier. Fait le lien entre un etudiant et une fiche resultat.
    public Dossier(String nom,String prenom,Note noteTP1,Note noteTP2,Note noteTP3,Note noteIntra,Note noteFinal) throws ExceptionEtudiant
    {
        ficheResultats=new FicheResultats(noteTP1,noteTP2,noteTP3,noteIntra,noteFinal);
        etudiant=new Etudiant(nom,prenom);
    }

    /* fait le dossier de l'etudiant */
    public void setDossier(String nom,String prenom,Note noteTP1,Note noteTP2,Note noteTP3,Note noteIntra,Note noteFinal) throws ExceptionEtudiant
    {
        etudiant.setNom(nom);
        etudiant.setPrenom(prenom);
        ficheResultats.setNoteFinal(noteFinal);
        ficheResultats.setNoteIntra(noteIntra);
        ficheResultats.setNoteTP1(noteTP1);
        ficheResultats.setNoteTP2(noteTP2);
        ficheResultats.setNoteTP3(noteTP3);
    }

    /*  retourne l'etudiant */
    public Etudiant getEtudiant()
    {
        return etudiant;
    }

    /* retourne la fiche de resultat*/
    public FicheResultats getFicheResultats()
    {
        return ficheResultats;
    }
}
