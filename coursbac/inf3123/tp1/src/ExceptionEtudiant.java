/*$Id: ExceptionEtudiant.java,v 1.2 2004/02/14 21:39:55 yann Exp $*/
/* Exception d'une note invalide*/

package net.homeip.codeyann.inf3123.tp1;

public class ExceptionEtudiant extends Exception
{
    public ExceptionEtudiant(String erreur)
    {
        super(erreur);
    }
}
