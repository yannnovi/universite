/*$Id: ExceptionTransaction.java,v 1.3 2004/04/27 16:15:26 yann Exp $*/
package tp3;
/**
 * Exception d'une transaction invalide
 */
public class ExceptionTransaction extends Exception
{
    public ExceptionTransaction(String erreur)
    {
        super(erreur);
    }
}
