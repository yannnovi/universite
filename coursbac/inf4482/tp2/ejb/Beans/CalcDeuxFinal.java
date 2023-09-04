package Beans;

import javax.ejb.EJBObject;
import java.rmi.RemoteException;
	
public interface CalcDeuxFinal extends EJBObject {
	
	// signature de la m�thode que le client pourra appel� � partie de l'objet m�tier qu'il aura
	// obtenu apr�s l'appel de la m�thode create() 
	public double calcPartie2(double valeur) throws RemoteException; 
}
