/*$Id: Berline.java,v 1.3 2004/04/19 02:16:20 yann Exp $*/
package tp2;

/**
 * <p>Title: Classe Berline</p>
 * <p>Description: Classe Abstraite, sous-classe de Automobile</p>
 * <p>Copyright: Copyright (c) 2004</p>
 * @author Framcis Goyer (GOYF14037303)
 * @version 1.0
 */

  public abstract class Berline extends Automobile
  {
    private boolean option1;
    private boolean option2;
    private boolean option3;
    private boolean option4;

    /** Constructeur
     */
    public Berline()
    {
        option1=false;
        option2=false;
        option3=false;
        option4=false;
    }

    /** Constructeur
     *
     * @param numeroSerie String
     * @param prixAnnonce int
     * @param prixCoutant int
     * @param couleur String
     * @throws ExceptionAuto
     * @throws ExceptionType
     */
    public Berline(String numeroSerie, int prixAnnonce, int prixCoutant,
                 boolean option1, boolean option2, boolean option3,
                 boolean option4,boolean vendue)
         throws ExceptionAuto, ExceptionType
     {
       super(numeroSerie, prixAnnonce, prixCoutant,vendue);
       

       this.option1 = option1;
       this.option2 = option2;
       this.option3 = option3;
       this.option4 = option4;
     }
     /** retourne l'option1
      *
      * @return String
      */
     public boolean getOption1() {
       return option1;
     }

     /** retourne l'option2
      *
      * @return String
      */
     public boolean getOption2() {
       return option2;
     }

     /** retourne l'option3
      *
      * @return String
      */
     public boolean getOption3() {
       return option3;
     }

     /** retourne l'option4
      *
      * @return String
      */
     public boolean getOption4() {
       return option4;
     }

     /** Mets l'option1
      *
      * @param option1 String
      * @throws ExceptionModele
      */
     public void setOption1(boolean option1)throws ExceptionModele
      {
        this.option1=option1;
      }


     /** Mets l'options2
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



    /**Méthode abstraite a implente dans chaque classe
     * derive d'automobile dont les objets seront instancies.
     *
     * @return String
     */
    public abstract String getCouleur();
  }


