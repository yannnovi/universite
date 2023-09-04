package Beans;

import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;

public interface CalcUnHomeFinal extends EJBHome {
	
	// méthode qui permettra de créer l'objet Home qui lui créera l'objet métier 
	// et le bean - le client obtient l'inteface métier qui lui permettra d'appeler 
	// la méthode du bean
	CalcUnFinal create() throws CreateException, RemoteException;
}
