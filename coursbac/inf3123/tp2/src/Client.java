/*$Id: Client.java,v 1.6 2004/04/19 02:16:20 yann Exp $*/

package tp2;

/**
 * La classe Client implemente les clients des vendeurs.
 */
public class Client extends Personne
{
    private String identifiant; // Identifiant du client (unique: nomdetel+nom)
    private String adresse; //adresse du client.
    private String commentaire; // Commentaire au sujet du client.
    private String numeroTelephone; // Numero de Telephone du client.

    /** Constructeur
     * @param adresse adresse du client
     * @param commentaire commentaire au sujet du client, habituellement du vendeur
     * @param numeroTelephone numero du telephone du client
     * 
     * @throws ExceptionClient
     */
    public Client(String nom,String prenom, String adresse, String commentaire, String numeroTelephone ) throws ExceptionClient,ExceptionPersonne
    {
        super(nom,prenom);
        if(adresse==null)
        {
            throw new ExceptionClient("L'adresse ne peut etre null.");
        }

        if(commentaire==null)
        {
            throw new ExceptionClient("Le commentaire ne peut etre null.");
        }

        if(numeroTelephone==null)
        {
            throw new ExceptionClient("Le numero de telephone ne peut etre null.");
        }

        identifiant=nom+numeroTelephone;

        this.adresse=adresse;
        this.commentaire=commentaire;
        this.numeroTelephone=numeroTelephone;
    }

    /** Retourne l'identifiant unique du client
     * @return L'identifiant
     */
    public String getIdentifiantClient()
    {
        return identifiant;
    }


    /** Retourne l'adresse du client
     * @return l'adresse du client
     */
    public String getAdresse()
    {
        return adresse;
    }

    /** Change l'adresse du client
     * @param l'adresse du client.
     * @throws ExceptionClient
     */
    public void setAdresse(String adresse) throws ExceptionClient
    {
        if(adresse==null)
        {
            throw new ExceptionClient("L'adresse ne peut etre null.");
        }

        this.adresse=adresse;
    }

    /** Retourne le commentaire du client
     * @return Le commentaire
     */
    public String getCommentaire()
    {
        return commentaire;
    }

    /** Change le commentaire du client
     * @param commentaire Le commentaire du client
     * @throws ExceptionClient
     */
    public void setCommentaire(String commentaire) throws ExceptionClient
    {
        if(commentaire==null)
        {
            throw new ExceptionClient("Le commentaire ne peut etre null.");
        }

        this.commentaire=commentaire;
    }

    /** Change le numero de telephone
     * @param numeroTelephone le nouveau numero de telephone
     * @throws ExceptionClient
     */
    public void setNumeroTelephone(String numeroTelephone) throws ExceptionClient
    {
        if(numeroTelephone==null)
        {
            throw new ExceptionClient("le numero de telephone ne peut etre null.");
        }
        this.numeroTelephone=numeroTelephone;
    }

    /** Retourne le numero de telephone du client.
     * @return le numero de telephone.
     */
    public String getNumeroTelephone()
    {
        return numeroTelephone;
    }

    public String toString()
    {
        return identifiant + ":" +this.getNom() + " "+ this.getPrenom() + "," + adresse + "," + numeroTelephone + ":" + commentaire ;
    }

}
