package Beans;

import javax.ejb.EJBObject;
import java.rmi.RemoteException;

public interface CalcUnFinal extends EJBObject {
	
	// signature de la méthode que le client pourra appelé à partie de l'objet métier qu'il aura
	// obtenu après l'appel de la méthode create() 
	public double calcul(double parm1,double parm2,double parm3,double parm4) throws RemoteException; 
}
