/*$Id: Vendeur.java,v 1.3 2004/04/27 16:15:28 yann Exp $*/


package tp3;
import java.util.*;
/**
 * La classe Vendeur gere un employe de type vendeur dans une entreprise.
 * Cela permet de retrouver les clients du vendeur
 */
public class Vendeur extends Personne
{
    private String numeroEmploye; // numero de l'employe
    private Set clients= new HashSet(); // Liste de tous les clients
    private Map localisateurClient= new HashMap(); // map qui permet de localiser un client.
    
    /**
     * Constructeur du vendeur
     * 
     * @param numeroEmploye   Le numero de l'employe
     * @param nom             le nom de l'employe
     * @param prenom          le prenom de l'employe
     * 
     * @throws ExceptionVendeur
      @throws ExceptionPersonne
     */
    public Vendeur(String numeroEmploye,String nom,String prenom) throws ExceptionVendeur,ExceptionPersonne
    {
        super (nom,prenom);
        if(numeroEmploye==null)
        {
            throw new ExceptionVendeur("Le numero d'employe ne peut etre null.");
        }


        this.numeroEmploye=numeroEmploye;
    }

    /**
     * Retourne le numero de l'employe
     * 
     * @return retourne le numero de l'employe.
     */
    public String getNumeroEmploye()
    {
        return numeroEmploye;
    }

    /**
     * Ajoute un client au vendeur
     * 
     * @param client   Le client a ajouter.
     * 
     * @throws ExceptionVendeur
     */
    public void ajoutClient(Client client) throws ExceptionVendeur
    {
        if(client == null)
        {
            throw new ExceptionVendeur("Le prenom ne peut etre null.");
        }

        if(localisateurClient.get(client.getIdentifiantClient())==null)
        {
            clients.add(client);
            localisateurClient.put(client.getIdentifiantClient(),client);
        }
        else
        {
            throw new ExceptionVendeur("Le client existe deja.");
        }
    }

    /** Trouve un client du vendeur
     * 
     * @param identifiantClient  Identifiant du client utilise pour retrouver le client
     * 
     * @return Le client trouve
     * 
     * @throws ExceptionVendeur
     */
    public Client getClient(String identifiantClient) throws ExceptionVendeur
    {
        if(identifiantClient == null)
        {
            throw new ExceptionVendeur("L'identifiant ne peut etre null.");
        }

        return (Client) localisateurClient.get(identifiantClient);
    }

    /** Retourne l'ensemble des client
     * 
     * @return le set de client
     */
    public Set getListeClient()
    {
        return clients;
    }

    public String toString()
    {
        return numeroEmploye + ": " + this.getNom() + " "+ this.getPrenom();
    }

}
