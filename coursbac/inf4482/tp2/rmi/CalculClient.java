import java.rmi.*;
import java.net.*;

public class CalculClient {
	
	public static void main(String args[]) {
			
		// s'assurer que l'appel de la fonction se fait correctement
		if (args.length < 5 || !args[0].startsWith("rmi:") ) {
			System.err.println("Utilisation : java CalculClient rmi://hote:port/calcul nombre1 nombre2 nombre3 nombre4");
			return;
		}

		try {
			// obtention de l'interface
			Object o = Naming.lookup(args[0]);
			Calcul calculateur = (Calcul) o;
				
			// obtention des diff�rents param�tres de la fonction
			double parm1=Double.parseDouble(args[1]);
			double parm2=Double.parseDouble(args[2]);
			double parm3=Double.parseDouble(args[3]);
			double parm4=Double.parseDouble(args[4]);
			
			// appel de la m�thode distante par l'entremise de l'interface 
			double resultat= calculateur.getCalcul(parm1,parm2,parm3,parm4);
			// affichage du r�sultat 
			System.out.println("Le r�sultat est " + resultat);
		}
        catch (NumberFormatException e) {
			System.err.println("Au moins un des nombres n'est pas un r�el.");
		}
		catch (MalformedURLException e) {
			System.err.println(args[0] + " : URL RMI invalide");
		}
		catch (RemoteException e) {
			System.err.println("L'objet distant a lev� l'exception " + e);
		}
		catch (NotBoundException e) {
			System.err.println("L'objet distant demand� n'a pas �t� trouv� sur le serveur");
		}
	}
}