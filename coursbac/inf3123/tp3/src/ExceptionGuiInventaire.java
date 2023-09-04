/*
 * ExceptionGuiInventaire.java
 *
 * Created on 26 avril 2004, 03:56
 */
package tp3;
/**
 * <p>Title: Classe ExceptionGuiInventaire</p>
 * <p>Description: Classe Exception pour GuiInventaire</p>
 * <p>Copyright: Copyright (c) 2004</p>
 * @author Framcis Goyer (GOYF14037303)
 * @version 1.0
 */

public class ExceptionGuiInventaire extends Exception
{
    /** Creates a new instance of ExceptionGuiInventaire */
    public ExceptionGuiInventaire(String erreur) {
        super(erreur);
    }

}
