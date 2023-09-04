/*$Id: ExceptionVendeur.java,v 1.3 2004/04/27 16:15:26 yann Exp $*/

package tp3;
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
