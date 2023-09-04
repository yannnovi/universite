/*$Id: Transaction.java,v 1.3 2004/04/27 16:15:28 yann Exp $*/

package tp3;
import java.util.Calendar;
/**
 * La classe Transaction implemente l'achat d'une automobile par un client a un vendeur.
 */
public class Transaction
{
    private Calendar date; // Calendar de la transaction
    private int prix; // prix de la transaction.
    private String numeroEmploye; // Numero de l'employe ayant fait le transaction
    private String identifiantClient; // Identifiant du client.
    private String numeroSerieAutomobile; // Numero de serie de l'automobile.

    /** Constructeur
     * @param date Date de la transaction.
     * @param prix prix de la transaction
     * @param numeroEmploye numero de l'employe
     * @param identifiantClient Identifiant du client
     * @param Numero serie automobile.
     * @throws ExceptionTransaction
     */
    public Transaction(Calendar date,int prix,String numeroEmploye,String identifiantClient,String numeroSerieAutomobile) throws ExceptionTransaction
    {
        if(date==null)
        {
            throw new ExceptionTransaction ("La date ne peut etre null.");
        }

        if(numeroEmploye==null)
        {
            throw new ExceptionTransaction ("La numero d'employe ne peut etre null.");
        }

        if(identifiantClient==null)
        {
            throw new ExceptionTransaction ("L'identifiant client ne peut etre null.");
        }

        if(numeroSerieAutomobile==null)
        {
            throw new ExceptionTransaction ("Le numero de serie de l'automobile ne peut etre null.");
        }
        this.date = date;
        this.prix = prix;
        this.numeroEmploye = numeroEmploye;
        this.identifiantClient=identifiantClient;
        this.numeroSerieAutomobile= numeroSerieAutomobile;
    }

    /** Retourne la date de la transaction
     * @return La date de la transaction
     */
    public Calendar getDate()
    {
        return date;
    }

    /** Retourne le prix de la transaction
     * @return le prix
     */
    public int getPrix()
    {
        return prix;
    }

    /** Retourne le numero d'employe du vendeur qui a fait la transaction
     * @return le numero d'employe.
     */
    public String getNumeroEmployeVendeur()
    {
        return numeroEmploye;
    }

    /** retourne l'identifiant client du client de la transaction
     * @return l'identifiant du client
     */
    public String getIdentifiantClient()
    {
        return identifiantClient;
    }

    /** retourne le numero de serie de l'automobile de la transaction
     * @return Le numero de serie
     */
    public String getNumeroSerieAutomobile()
    {
        return numeroSerieAutomobile;
    }

    public String toString()
    {
        return ""+ date.getTime() + ":" + prix + "$, "+ numeroSerieAutomobile + "," + numeroEmploye + "," + identifiantClient ;
    }

}

