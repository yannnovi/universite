/*$Id: ExceptionClient.java,v 1.3 2004/04/27 16:15:26 yann Exp $*/
package tp3;
/**
 * Exception d'un client invalide
 */
public class ExceptionClient extends Exception
{
    public ExceptionClient(String erreur)
    {
        super(erreur);
    }
}
