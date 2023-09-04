/*$Id: Batmobile.java,v 1.4 2004/04/19 09:08:22 yann Exp $*/
package tp2;

/**
 * <p>Title: Classe Batmobile</p>
 * <p>Description: Classe concrete pour instancier une batmobile</p>
 * <p>Copyright: Copyright (c) 2004</p>
 * @author Framcis Goyer (GOYF14037303)
 * @version 1.0
 */


public class Batmobile extends Sport
{
    private String couleur;


    /**
     *
     * @param numeroSerie String
     * @param prixAnnonce int
     * @param prixCoutant int
     * @param couleur String
     * @param option1 String
     * @param option2 String
     * @param option3 String
     * @param option4 String
     * @param option5 String
     * @param vendue String
     * @throws ExceptionAuto
     * @throws ExceptionType
     * @throws ExceptionModele
     */
    public Batmobile(String numeroSerie, int prixAnnonce, int prixCoutant,
                     String couleur, boolean option1, boolean option2,
                     boolean option3, boolean option4, boolean option5,
                     boolean vendue)
    throws ExceptionAuto, ExceptionType, ExceptionModele
    {
        super (numeroSerie, prixAnnonce, prixCoutant, option1, option2, option3, option4, option5,vendue);
        if (couleur == null)
        {
            throw new ExceptionModele("La couleur ne peut pas etres null.");
        }
        this.couleur = couleur;

    }

    /** Constructeur
     */
    public Batmobile(String record) throws ExceptionAuto, ExceptionType, ExceptionModele
    {
        boolean enregistrementValide=false;
        
        if (record==null)
        {
            throw new ExceptionModele("La chaine ne peut pas etre null.");
        }

        int begin = 0;
        int end;
        char delim = ':';


        if ( (end = record.indexOf(delim, begin)) >= 0)
        {
            String numSerie = record.substring(begin, end);
            begin = end + 1;
            if ( (end = record.indexOf(delim, begin)) >= 0)
            {
                int prixAnn = java.lang.Integer.parseInt(record.substring(begin, end));
                begin = end + 1;
                if ( (end = record.indexOf(delim, begin)) >= 0)
                {
                    int prixCou = java.lang.Integer.parseInt(record.substring(begin, end));
                    begin = end + 1;
                    if ( (end = record.indexOf(delim, begin)) >= 0)
                    {
                        String couleur = record.substring(begin, end);
                        begin = end + 1;
                        if ( (end = record.indexOf(delim, begin)) >= 0)
                        {
                            String op1 = record.substring(begin, end);
                            boolean o1= false;
                            if (op1.equals("true") ||op1.equals("false"))
                            {
                                o1 = java.lang.Boolean.getBoolean(op1);
                            }
                            else
                            {
                                throw new ExceptionModele("Enregistrement invalide op1(boolean invalide " + op1 +" ).");
                            }
                            begin = end + 1;
                            if ( (end = record.indexOf(delim, begin)) >= 0)
                            {
                                String op2 = record.substring(begin, end);
                                boolean o2= false;
                                if (op2.equals("true") ||op2.equals("false"))
                                {
                                    o2 = java.lang.Boolean.getBoolean(op2);
                                }
                                else
                                {
                                    throw new ExceptionModele("Enregistrement invalide op2(boolean invalide " + op2 +" ).");
                                }
                                begin = end + 1;
                                if ( (end = record.indexOf(delim, begin)) >= 0)
                                {
                                    String op3 = record.substring(begin, end);
                                    boolean o3= false;
                                    if (op3.equals("true") ||op3.equals("false"))
                                    {
                                        o3 = java.lang.Boolean.getBoolean(op3);
                                    }
                                    else
                                    {
                                        throw new ExceptionModele("Enregistrement invalide op3(boolean invalide " + op3 +" ).");
                                    }
                                    begin = end + 1;
                                    if ( (end = record.indexOf(delim, begin)) >= 0)
                                    {
                                        String op4 = record.substring(begin, end);
                                        boolean o4= false;
                                        if (op4.equals("true") ||op4.equals("false"))
                                        {
                                            o4 = java.lang.Boolean.getBoolean(op4);
                                        }
                                        else
                                        {
                                            throw new ExceptionModele("Enregistrement invalide op4(boolean invalide " + op4 +" ).");
                                        }
                                        begin = end + 1;
                                        if ( (end = record.indexOf(delim, begin)) >= 0)
                                        {
                                            String op5 = record.substring(begin, end);
                                            boolean o5= false;
                                            if (op5.equals("true") ||op5.equals("false"))
                                            {
                                                o5 = java.lang.Boolean.getBoolean(op5);
                                            }
                                            else
                                            {
                                                throw new ExceptionModele("Enregistrement invalide op5(boolean invalide " + op5 +" ).");
                                            }
                                            begin = end + 1;
                                            boolean sold = java.lang.Boolean.getBoolean(record.substring(begin));
                                            setNumero(numSerie);
                                            setPrixAnnonce(prixAnn);
                                            setPrixCoutant(prixCou);
                                            setOption1(o1);
                                            setOption2(o2);
                                            setOption3(o3);
                                            setOption4(o4);
                                            setOption5(o5);
                                            setVendue(sold);
                                            this.couleur = couleur;
                                            enregistrementValide=true;
                                        }
                                    }
                                }
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

    /** Met la couleur
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

}
