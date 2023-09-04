/*$Id: ExceptionVendeur.java,v 1.4 2004/04/19 02:16:20 yann Exp $*/

package tp2;

/** Exception d'un vendeur invalide
 * 
 */
public class ExceptionVendeur extends Exception
{
    public ExceptionVendeur(String erreur)
    {
        super(erreur);
    }
}
