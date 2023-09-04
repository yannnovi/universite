package Beans;

import java.rmi.RemoteException;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

public class CalcDeuxBean implements SessionBean {
	
	// implémentation de la méthode que le client pourra appelé à partir de l'objet métier 
	public double calcPartie2(double valeur) {
		double calc = (valeur/100);
		return calc;
	}

	public void ejbCreate() { }
	public void setSessionContext(SessionContext ctx) { }
	public void ejbRemove() { }
	public void ejbActivate() { }
	public void ejbPassivate() { }
	public void ejbLoad() { }
	public void ejbStore() { }
}