import java.rmi.*;

public interface Calcul extends Remote {
	
	// signature de la m�thode distante
	public double getCalcul(double parm1,double parm2, double parm3, double parm4) throws RemoteException;

}
