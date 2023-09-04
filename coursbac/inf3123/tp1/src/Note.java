/*$Id: Note.java,v 1.7 2004/02/14 21:39:56 yann Exp $*/
/* Classe de Note. Cette classe contient une note et peut retourner
/* sa cote alphabetique*/
package net.homeip.codeyann.inf3123.tp1;

public class Note
{
    private double note;

    // Constructeur qui prends une note en format double.
    public Note(double note) throws ExceptionNote
    {
        setNote(note);
    }

    // Constructuur qui prends une note en format chaine de caracteres.
    public Note(String note) throws ExceptionNote
    {
        if(note==null)
        {
            throw new ExceptionNote("La chaine note ne peut etre null.");
        }
        Double tempNote =new Double(note);
        setNote(tempNote.doubleValue());
    }

    /* setNote: Specifie la note*/
    public void setNote(double note) throws ExceptionNote
    {
        /* la note doit etre entre 0 et 100 inclusivement */
        if( note <0 || note > 100)
        {
            throw new ExceptionNote("La valeur de la note doit etre entre 0 et 100 inclusivement (" + note +")");
        }
        this.note=note;
    }

    /* getNote: Prends la note*/
    public double getNote()
    {
        return note;
    }

    /* getCote: Retourne la cote alphabetique de la note */
    public char getCote()
    {
        char cote='E';
        /* Fait la cote selon:
           A: 90 <= note <= 100
           B: 80 <= note < 90
           C: 70 <= note < 80
           D: 60 <= note < 70
           E: 0 <= note < 60
        */
        if(note >= 90)
        {
            cote='A';
        }
        else
        {
            if(note >= 80)
            {
                cote='B';
            }
            else
            {
                if(note >= 70)
                {
                    cote='C';
                }
                else
                {
                    if(note >= 60)
                    {
                        cote='D';
                    }
                }
            }

        }
        return cote;
    }

    // toString: Retourne la note en format chaine de caracteres.
    public String toString()
    {
        long toto=java.lang.Math.round(this.note);
        String noteChaine = " " + toto + "%";
        return noteChaine;
    }
}
