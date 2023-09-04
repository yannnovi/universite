/*$Id: ExceptionTransaction.java,v 1.4 2004/04/19 02:16:20 yann Exp $*/
package tp2;
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
