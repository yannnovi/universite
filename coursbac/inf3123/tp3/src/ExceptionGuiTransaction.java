/*
 * ExceptionGuiTransaction.java
 *
 * Created on 25 avril 2004, 22:32
 */

package tp3;
/**
 * <p>Title: Classe ExceptionGuiTransaction</p>
 * <p>Description: Classe Exception pour GuiTransaction</p>
 * <p>Copyright: Copyright (c) 2004</p>
 * @author Framcis Goyer (GOYF14037303)
 * @version 1.0
 */

public class ExceptionGuiTransaction extends Exception{

    /** Creates a new instance of ExceptionGuiTransaction */
   public ExceptionGuiTransaction(String erreur)
    {
        super(erreur);
    }
}

