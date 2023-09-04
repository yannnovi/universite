/*$Id: ExceptionAuto.java,v 1.3 2004/04/27 16:15:26 yann Exp $*/
package tp3;

/**
 * <p>Title: Classe ExceptionAuto</p>
 * <p>Description: exception sur la validite des informations d'une automobile</p>
 * <p>Copyright: Copyright (c) 2004</p>
 * @author Framcis Goyer (GOYF14037303)
 * @version 1.0
 */


public class ExceptionAuto extends Exception
{
  public ExceptionAuto(String erreur) 
  {
    super(erreur);
  }
}