/*$Id: ExceptionModele.java,v 1.3 2004/04/27 16:15:26 yann Exp $*/
package tp3;
/**
 * <p>Title: Classe ExceptionModele</p>
 * <p>Description: exception sur la validite des informations d'une automobile</p>
 * <p>Copyright: Copyright (c) 2004</p>
 * @author Framcis Goyer (GOYF14037303)
 * @version 1.0
 */

public class ExceptionModele extends Exception
{
  /**Exception
   * exception est leve lorsqu'une couleur est instanciee a null
   * @param erreur String
   */
  public ExceptionModele(String erreur)
  {
    super (erreur);
  }

}
