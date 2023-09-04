/*$Id: Renault5.java,v 1.4 2004/04/27 16:15:27 yann Exp $*/
package tp3;

/**
 * <p>Title: Classe Renault5</p>
 * <p>Description: Classe concrete pour instancier une renault 5</p>
 * <p>Copyright: Copyright (c) 2004</p>
 * @author Framcis Goyer (GOYF14037303)
 * @version 1.0
 */

public class Renault5 extends Compacte
{
    private String couleur;


    /** Constructeur
     * @param numeroSerie Le numero de serie
     * @param prixAnnonce le prix annonce
     * @param prixCoutant le prix coutant
     * @param couleur la couleur de la voiture
     * @param option1 L'option 1
     * @param option1 L'option 2
     * @param vendue Si la voiture est vendue
     * 
     * @throws ExceptionAuto
     * @throws ExceptionType
     * @throws ExceptionModele
     */
    public Renault5(String numeroSerie, int prixAnnonce, int prixCoutant,
                    String couleur, boolean option1, boolean option2, boolean vendue)
    throws ExceptionAuto, ExceptionType, ExceptionModele
    {
        super (numeroSerie, prixAnnonce, prixCoutant, option1, option2,vendue);
        if (couleur == null)
        {
            throw new ExceptionModele("La couleur ne peut pas etres null.");
        }
        this.couleur = couleur;
    } 

    /** Constructeur
     * @param Chaine contenant la description de la voiture.
     * 
     * @throws ExceptionAuto
     * @throws ExceptionType
     * @throws ExceptionModele
     */
    public Renault5(String desc) throws ExceptionAuto, ExceptionType, ExceptionModele
    {
        boolean enregistrementValide=false;

        if (desc==null)
        {
            throw new ExceptionModele("La chaine ne peut pas etres null.");
        }

        int begin = 0;
        int end;
        char delim = ':';

        if ( (end = desc.indexOf(delim, begin)) >= 0)
        {
            String numSerie = desc.substring(begin, end);
            begin = end + 1;
            if ( (end = desc.indexOf(delim, begin)) >= 0)
            {
                int prixAnn = java.lang.Integer.parseInt(desc.substring(begin, end));
                begin = end + 1;
                if ( (end = desc.indexOf(delim, begin)) >= 0)
                {
                    int prixCou = java.lang.Integer.parseInt(desc.substring(begin, end));
                    begin = end + 1;
                    if ( (end = desc.indexOf(delim, begin)) >= 0)
                    {
                        String couleur = desc.substring(begin, end);
                        begin = end + 1;
                        if ( (end = desc.indexOf(delim, begin)) >= 0)
                        {
                            String op1 = desc.substring(begin, end);
                            boolean o1 = false;
                            if (op1.equals("true") ||op1.equals("false"))
                            {
                                o1 = java.lang.Boolean.getBoolean(op1);
                            } 
                            else
                            {
                                throw new ExceptionModele("Enregistrement invalide op1(boolean invalide " + op1 +" ).");
                            }

                            begin = end + 1;

                            if ( (end = desc.indexOf(delim, begin)) >= 0)
                            {
                                String op2 = desc.substring(begin, end);
                                boolean o2= false;
                                if (op2.equals("true") ||op2.equals("false"))
                                {
                                    o2 = java.lang.Boolean.getBoolean(op2);
                                }
                                else
                                {
                                    throw new ExceptionModele("Enregistrement invalide op2(boolean invalide " + op2 +" ).");
                                }

                                
                                String vendu = desc.substring(end+1);
                                
                                if (!(vendu.equals("true") || vendu.equals("false")))
                                {
                                    throw new ExceptionModele("Enregistrement invalide vendu(boolean invalide " + vendu +" ).");
                                }


                                boolean sold = java.lang.Boolean.getBoolean(vendu);

                                setNumero(numSerie);
                                setPrixAnnonce(prixAnn);
                                setPrixCoutant(prixCou);
                                setOption1(o1);
                                setOption2(o2);
                                setVendue(sold);
                                this.couleur = couleur;
                                enregistrementValide=true;
                            }
                        }
                    }
                }
            }
        }
        if(!enregistrementValide)
       {
           throw new ExceptionModele("Enregistrement invalide.");
       }

    }

    /** retourne la couleur
     *
     * @return String
     */
    public String getCouleur()
    {
        return couleur;
    }

    /** Mets la couleur.
     *
     * @param couleur String
     * @throws ExceptionModele
     */
    public void setCouleur(String couleur)throws ExceptionType
    {
        if (couleur == null)
        {
            throw new ExceptionType("La valeur couleur ne peut pas etre null.");
        }
        this.couleur = couleur;
    }
public String toString()
  {
      return "Renault5 : "+ this.getNumero() +" : "+ this.getPrixAnnonce() +" : "+ this.getPrixCoutant() +" : " + couleur +" : "+ this.getOption1() +" : "+ this.getOption2() +" : "+ this.getVendue();
  }
}
