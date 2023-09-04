/*$Id: ExceptionClient.java,v 1.4 2004/04/19 02:16:20 yann Exp $*/
package tp2;
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
