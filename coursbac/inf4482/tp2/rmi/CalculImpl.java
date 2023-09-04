import java.rmi.*;
import java.rmi.server.UnicastRemoteObject;

public class CalculImpl implements Calcul {
	
	public CalculImpl(  ) throws RemoteException {
		UnicastRemoteObject.exportObject(this);
	}

	// implémentation de la méthode distante
	public double getCalcul(double parm1,double parm2,double parm3,double parm4) throws RemoteException {
		double resultat = ((parm1*35)+(parm2*35)+(parm3*17)+(parm4*13))/100;
		return resultat;
	}
}
