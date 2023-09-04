/*$Id: ExceptionAuto.java,v 1.5 2004/04/19 02:16:20 yann Exp $*/
package tp2;

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