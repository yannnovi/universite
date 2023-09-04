/*$Id: FicheResultats.java,v 1.7 2004/02/14 21:39:56 yann Exp $*/
/* Classe de Fiche de resultats. Cette classe contient toutes les notes*/

package net.homeip.codeyann.inf3123.tp1;

public class FicheResultats
{
    private Note noteTP1; /* note du tp1.*/
    private Note noteTP2; /* note du tp2.*/
    private Note noteTP3; /* note du tp3.*/
    private Note noteIntra; /* note de l'examen intra*/
    private Note noteFinal; /* note de l'examen final*/

    /* ponderation de chaque note */
    private static double ponderationTP1=0.10;
    private static double ponderationTP2=0.10;
    private static double ponderationTP3=0.10;
    private static double ponderationIntra=0.30;
    private static double ponderationFinal=0.40;

    // Constructeur qui prends tous les parametre d'une fiche resultat.
    public FicheResultats(Note noteTP1,Note noteTP2, Note noteTP3, Note noteIntra, Note noteFinal)
    {
        setNoteTP1(noteTP1);
        setNoteTP2(noteTP2);
        setNoteTP3(noteTP3);
        setNoteIntra(noteIntra);
        setNoteFinal(noteFinal);
    }

    // mets la note du TP1
    public void setNoteTP1(Note noteTP1)
    {
        this.noteTP1=noteTP1;
    }

    // mets la note du TP2
    public void setNoteTP2(Note noteTP2)
    {
        this.noteTP2=noteTP2;
    }

    // mets la note du TP3
    public void setNoteTP3(Note noteTP3)
    {
        this.noteTP3=noteTP3;
    }

    // mets la note de l'intra
    public void setNoteIntra(Note  noteIntra)
    {
        this.noteIntra=noteIntra;
    }

    // mets la note du final
    public void setNoteFinal(Note noteFinal)
    {
        this.noteFinal=noteFinal;
    }

    /* Calcul la note ponderee de l'etudiant*/
    public Note getNoteGlobal() throws ExceptionNote
    {
        Note noteGlobal=new Note((noteTP1.getNote()*ponderationTP1)
                                 +
                                 (noteTP2.getNote()*ponderationTP2 )
                                 +
                                 (noteTP3.getNote()*ponderationTP3 )
                                 +
                                 (noteIntra.getNote()*ponderationIntra)
                                 +
                                 (noteFinal.getNote()*ponderationFinal ));
        return noteGlobal;
    }
}

