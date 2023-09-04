import java.net.*;
import java.rmi.*;
public class CalculServeur {
	
	public static void main(String[] args) {

		try {
			// Création de l'objet distant
			CalculImpl calculImpl = new CalculImpl(  );
			// enregistrement de l'objet distant auprès du registre RMI
			Naming.rebind("rmi://arabica.labunix.uqam.ca:9999/calcul", calculImpl);
			// affichage du statut du serveur 
			System.out.println("Serveur calcul prêt.");
		}
		catch (RemoteException re) {
			System.out.println("Exception dans CalculImpl.main: " + re);
		}
		catch (MalformedURLException e) {
			System.out.println("MalformedURLException " + e);
		}
	}
}