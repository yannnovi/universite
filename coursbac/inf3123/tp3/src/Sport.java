/*$Id: Sport.java,v 1.5 2010/12/01 01:32:28 yannb Exp $*/
package tp3;

/**
 * <p>Title: Classe Sport</p>
 * <p>Description: Classe Abstraite, sous-classe de Automobile</p>
 * <p>Copyright: Copyright (c) 2004</p>
 * @author Framcis Goyer (GOYF14037303)
 * @version 1.0
 */

/* 2*/
public abstract class Sport extends Automobile
{
  private boolean option1;
  private boolean option2;
  private boolean option3;
  private boolean option4;
  private boolean option5;

  /** Constructeur
   *
   * @param numeroSerie String
   * @param prixAnnonce int
   * @param prixCoutant int
   * @param couleur String
   * @throws ExceptionAuto
   * @throws ExceptionType
   */
  public Sport(String numeroSerie, int prixAnnonce, int prixCoutant,
               boolean option1, boolean option2, boolean option3,
               boolean option4, boolean option5,boolean vendue)
       throws ExceptionAuto, ExceptionType
   {
     super(numeroSerie, prixAnnonce, prixCoutant,vendue);
     this.option1 = option1;
     this.option2 = option2;
     this.option3 = option3;
     this.option4 = option4;
     this.option5 = option5;
   }

  /** Constructeur
   */
  public Sport()
  {
      option1=false;
      option2=false;
      option3=false;
      option4=false;
      option5=false;
  }
   /** Retourn l'option 1.
    *
    * @return String
    */
   public boolean getOption1() {
     return option1;
   }

   /** Retourne l'option 2.
    *
    * @return String
    */
   public boolean getOption2() {
     return option2;
   }

   /** Retourne l'option 3.
    *
    * @return String
    */
   public boolean getOption3() {
     return option3;
   }

   /** Retourne l'option 4.
    *
    * @return String
    */
   public boolean getOption4() {
     return option4;
   }

   /** Retourne l'option 5.
    *
    * @return String
    */
   public boolean getOption5() {
     return option5;
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

   /** Mets l'option 3
    *
    * @param option3 String
    * @throws ExceptionModele
    */
   public void setOption3(boolean option3)throws ExceptionModele
   {
     this.option3 = option3;
   }

   /** Mets l'option 4
    *
    * @param option4 String
    * @throws ExceptionModele
    */
   public void setOption4(boolean option4)throws ExceptionModele
   {
     this.option4 = option4;
   }

   /** Mets l'option 5
    *
    * @param option5 String
    * @throws ExceptionModele
    */
   public void setOption5(boolean option5)throws ExceptionModele
   {
     this.option5 = option5;
   }

  /**Méthode abstraite a implente dans chaque classe
   * derive d'automobile dont les objets seront instancies.
   *
   * @return String
   */
  public abstract String getCouleur();


}
