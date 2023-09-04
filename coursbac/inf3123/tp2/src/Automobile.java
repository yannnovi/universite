/*$Id: Automobile.java,v 1.7 2004/04/19 02:16:19 yann Exp $*/
package tp2;

/**
 * <p>Title: Classe Automobile</p>
 * <p>Description: Classe (SuperClasse) Abstraite</p>
 * <p>Copyright: Copyright (c) 2004</p>
 * @author Framcis Goyer (GOYF14037303)
 * @version 1.0
 */

public abstract class Automobile
{
  private String numeroSerie; //Le numéro de série de l'automobile.
  private int prixAnnonce;    //Le prix annonce de l'automobile.
  private int prixCoutant;    //Le prix coutant de l'automobile.
  private boolean vendue;
  
  /** Constructeur
   */
  public Automobile()
  {
      numeroSerie=null;
      prixAnnonce=0;
      prixCoutant=0;
      vendue=false;
  }
  /**Constructeur
   *
   * @param numeroSerie String
   * @param prixAnnonce int
   * @param prixCoutant int
   * @throws ExceptionAuto
   */
  public Automobile(String numeroSerie, int prixAnnonce, int prixCoutant,boolean vendue) throws ExceptionAuto
  {
    if(numeroSerie == null)
    {
      throw new ExceptionAuto("Le numero de serie ne peut pas etre null.");
    }
    if(prixAnnonce == 0)
    {
      throw new ExceptionAuto("Le prix annonce ne peut pas etre 0$");
    }
    if(prixCoutant == 0)
    {
      throw new ExceptionAuto("Le prix coutant ne peut pas etre 0$");
    }
    this.numeroSerie=numeroSerie;
    this.prixAnnonce=prixAnnonce;
    this.prixCoutant=prixCoutant;
    this.vendue=vendue;
  }

  /**Optenir le numero de serie du vehicule
   *
   * @return String
   */
  public String getNumero()
  {
    return numeroSerie;
  }

  /** Mets le numero de serie du vehicule
   * 
   * @param numero Le numero de serie
   */
  public void setNumero(String numero) throws ExceptionAuto
  {
      if(numero==null)
      {
          throw new ExceptionAuto("Le numero de serie ne peut etre null.");
      }
      this.numeroSerie=numero;
  }

  /**Optenir le prix annonce pour un vehicule
   *
   * @return int
   */
  public int getPrixAnnonce()
  {
    return prixAnnonce;
  }

  /**Optenir le prix coutant pour un vehicule
   *
   * @return int
   */
  public int getPrixCoutant()
  {
    return prixCoutant;
  }

  /**Changer le prix annonce
   *
   * @param prixAnnonce int
   * @throws ExceptionAuto
   */
  public void setPrixAnnonce(int prixAnnonce) throws ExceptionAuto
  {
    if(prixAnnonce == 0)
    {
      throw new ExceptionAuto("Le prix annonce ne peut pas etre 0$");
    }
    this.prixAnnonce = prixAnnonce;
  }

  /**Changer le prix coutant
   *
   * @param prixCoutant int
   * @throws ExceptionAuto
   */
  public void setPrixCoutant(int prixCoutant) throws ExceptionAuto
  {
    if(prixCoutant == 0)
    {
      throw new ExceptionAuto("Le prix annonce ne peut pas etre 0$");
    }
    this.prixCoutant = prixCoutant;
  }

  /**Méthode abstraite a implente dans chaque classe
   * derive d'automobile dont les objets seront instancies.
   *
   * @return String
   */
  //public abstract String getCouleur();

  /**Méthode abstraite a implente dans chaque classe
   * derive d'automobile dont les objets seront instancies.
   *
   * @return String
   */
  public boolean getVendue()
  {
      return vendue;
  }
  public void setVendue(boolean vendue)
  {
      this.vendue=vendue;
  }

}
