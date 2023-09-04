/*$Id: ExceptionType.java,v 1.5 2004/04/19 02:16:20 yann Exp $*/
package tp2;

/**
 * <p>Title: Classe ExceptionType</p>
 * <p>Description: exception sur la validite des informations d'une automobile</p>
 * <p>Copyright: Copyright (c) 2004</p>
 * @author Framcis Goyer (GOYF14037303)
 * @version 1.0
 */


public class ExceptionType extends Exception
{
  public ExceptionType(String erreur)
  {
    super(erreur);
  }

}
