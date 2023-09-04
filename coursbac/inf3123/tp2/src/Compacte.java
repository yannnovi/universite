/*$Id: Compacte.java,v 1.6 2004/04/19 02:16:20 yann Exp $*/
package tp2;

/**
 * <p>Title: Classe Compacte</p>
 * <p>Description: Classe Abstraite, sous-classe de Automobile</p>
 * <p>Copyright: Copyright (c) 2004</p>
 * @author Framcis Goyer (GOYF14037303)
 * @version 1.0
 */

public abstract class Compacte extends Automobile
{
  private boolean option1;
  private boolean option2;


  /** Constructeur par defaut.
   */
  public Compacte()
  {
      option1=false;
      option2=false;
  }

  /** Constructeur
   * @param numeroSerie Le numero de serie de la voiture
   * @param prixAnnonce le prix annonce
   * @param prixCoutant le prix coutant
   * @param option1 l'option 1
   * @param option2 l'option 2
   * @param vendue Si la voiture a ete vendue
   */
  public Compacte(String numeroSerie, int prixAnnonce, int prixCoutant,
               boolean option1, boolean option2,boolean vendue)
       throws ExceptionAuto, ExceptionType
   {
     super(numeroSerie, prixAnnonce, prixCoutant,vendue);
     this.option1 = option1;
     this.option2 = option2;

   }
   /** retourn l'option 1
    *
    * @return String
    */
   public boolean getOption1() {
     return option1;
   }

   /** retourn l'option 2
    *
    * @return String
    */
   public boolean getOption2() {
     return option2;
   }

   /** Mets l'option 1
   *
   * @param option1 String
   * @throws ExceptionModele
   */
  public void setOption1(boolean option1)throws ExceptionModele
   {
     this.option1=option1;
   }


  /** Mets l'option 2
   *
   * @param option2 String
   * @throws ExceptionModele
   */
  public void setOption2(boolean option2)throws ExceptionModele
{
 this.option2 = option2;
}


  /**Méthode abstraite a implente dans chaque classe
   * derive d'automobile dont les objets seront instancies.
   *
   * @return String
   */
  public abstract String getCouleur();
}


