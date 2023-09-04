package Beans;

import javax.ejb.EJBObject;
import java.rmi.RemoteException;
	
public interface CalcDeuxFinal extends EJBObject {
	
	// signature de la méthode que le client pourra appelé à partie de l'objet métier qu'il aura
	// obtenu après l'appel de la méthode create() 
	public double calcPartie2(double valeur) throws RemoteException; 
}
