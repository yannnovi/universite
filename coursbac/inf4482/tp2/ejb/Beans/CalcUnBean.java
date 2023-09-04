package Beans;

import java.rmi.RemoteException;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;

public class CalcUnBean implements SessionBean {
	
	// nom pas approprié ...
	// implémentation de la méthode que le client pourra appelé à partir de l'objet métier 
	public double calcPartie1(double parm1,double parm2, double parm3, double parm4)
    {
		// déclaration de la variable représentant le résultat
		double resultat=0.0;
		// première partie du calcul
		double resultatPartiel = (parm1 * 35) + (parm2 * 35) + (parm3 * 17) + (parm4 * 13);
		
		// obtention du résultat final 
		try {
			// déclaration d'un nouveau contexte
			InitialContext ctx = new InitialContext();
			// obtention de l'interface Home du bean qui fera la deuxième partie du calcul
			Object objref = ctx.lookup("CalcDeuxBean");
			CalcDeuxHome homecalc2;
			homecalc2 = (CalcDeuxHome)PortableRemoteObject.narrow(objref, CalcDeuxHome.class);
			// obtention de l'interface métier du bean qui fera la deuxième partie du calcul
			CalcDeux leCalculateur;
 			leCalculateur= homecalc2.create();
			// obtention du résultat final en appelant la méthode qui fera la deuxième partie du calcul
			resultat = leCalculateur.calcPartie2(resultatPartiel);
		} catch (Exception NamingException) {
			NamingException.printStackTrace();
		}
		
		// le résultat final est retourné au client
		return resultat;
	}

	public void ejbCreate() { }
	public void setSessionContext(SessionContext ctx) { }
	public void ejbRemove() { }
	public void ejbActivate() { }
	public void ejbPassivate() { }
	public void ejbLoad() { }
	public void ejbStore() { }
}