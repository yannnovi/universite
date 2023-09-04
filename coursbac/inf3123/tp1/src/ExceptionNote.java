/*$Id: ExceptionNote.java,v 1.2 2004/02/14 21:39:56 yann Exp $*/
/* Exception d'une note invalide*/

package net.homeip.codeyann.inf3123.tp1;

public class ExceptionNote extends Exception
{
    public ExceptionNote(String erreur)
    {
        super(erreur);
    }
}
