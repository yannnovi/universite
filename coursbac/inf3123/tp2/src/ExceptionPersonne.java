/*$Id: ExceptionPersonne.java,v 1.4 2004/04/19 02:16:20 yann Exp $*/

package tp2;
/**
 * Exception d'une personne invalide
 */
public class ExceptionPersonne extends Exception
{
    public ExceptionPersonne(String erreur)
    {
        super(erreur);
    }
}
