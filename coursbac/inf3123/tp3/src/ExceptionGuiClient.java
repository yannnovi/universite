/*$Id: ExceptionGuiClient.java,v 1.3 2004/04/27 16:15:26 yann Exp $*/

package tp3;
/**
 * Exception d'une personne invalide
 */
public class ExceptionGuiClient extends Exception
{
    public ExceptionGuiClient(String erreur)
    {
        super(erreur);
    }
}
