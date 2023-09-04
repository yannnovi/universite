package Beans;

import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;

public interface CalcUnHome extends EJBHome {
	
	// m�thode qui permettra de cr�er l'objet Home qui lui cr�era l'objet m�tier 
	// et le bean - le client obtient l'inteface m�tier qui lui permettra d'appeler 
	// la m�thode du bean
	CalcUn create() throws CreateException, RemoteException;
}
