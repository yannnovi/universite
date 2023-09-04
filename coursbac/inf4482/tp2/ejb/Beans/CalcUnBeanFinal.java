package Beans;

import java.rmi.RemoteException;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;

public class CalcUnBeanFinal implements SessionBean {
	
	// impl�mentation de la m�thode que le client pourra appel� � partir de l'objet m�tier 
	public double calcul(double parm1,double parm2, double parm3, double parm4)
    {
		// d�claration de la variable repr�sentant le r�sultat
		double resultat=0.0;
		// premi�re partie du calcul
		double resultatPartiel = (parm1 * 35) + (parm2 * 35) + (parm3 * 17) + (parm4 * 13);
		
		// obtention du r�sultat final 
		try {
			// d�claration d'un nouveau contexte
			InitialContext ctx = new InitialContext();
			// obtention de l'interface Home du bean qui fera la deuxi�me partie du calcul
			Object objref = ctx.lookup("CalcDeuxBeanFinal");
			CalcDeuxHomeFinal homecalc2;
			homecalc2 = (CalcDeuxHomeFinal)PortableRemoteObject.narrow(objref, CalcDeuxHomeFinal.class);
			// obtention de l'interface m�tier du bean qui fera la deuxi�me partie du calcul
			CalcDeuxFinal leCalculateur;
 			leCalculateur= homecalc2.create();
			// obtention du r�sultat final en appelant la m�thode qui fera la deuxi�me partie du calcul
			resultat = leCalculateur.calcPartie2(resultatPartiel);
		} catch (Exception NamingException) {
			NamingException.printStackTrace();
		}
		
		// le r�sultat final est retourn� au client
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
