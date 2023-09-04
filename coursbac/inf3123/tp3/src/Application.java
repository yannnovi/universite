/*$Id: Application.java,v 1.7 2004/04/27 16:15:25 yann Exp $*/

package tp3;

// package tp3;
import  java.io.*;
import java.util.*;
/** Cette classe implemante les menus de l'application
 */
public class Application 
{
    private Set vendeurs= new HashSet(); // Ensemble de tous les vendeurs
    private Map localisateurVendeur= new HashMap(); // map qui permet de localiser un vendeur.
    
    private Set automobiles= new HashSet(); // Ensemble de toutes les voitures
    private Map localisateurAutomobile = new HashMap(); // map qui permet de localiser une voiture

    private Set transactions= new HashSet(); // Ensemble de toutes les transactions

    public Application(String fichierVendeur,String fichierAutomobile,String fichierTransaction)
    {
        if(!lireFichierVendeur(fichierVendeur))
        {
             System.exit(0);
        }

        if(!lireFichierAutomobile(fichierAutomobile))
        {
             System.exit(0);
        }

        if(!lireFichierTransaction(fichierTransaction))
        {
            System.exit(0);
        }
    }

    /**
     * Retourne un vendeur selon le code vendeur
     * @param codeVendeur Le code du vendeur
     */
    public Vendeur trouveVendeur(String codeVendeur)
    {
        return (Vendeur) localisateurVendeur.get(codeVendeur);

    }

    /** Lis le fichier de vendeur (inclus les clients) en memoire
    * 
    * @param fichierVendeur Le nom du fichier de vendeurs
    */
    private boolean lireFichierVendeur(String fichierVendeur)
    {
        boolean fichierLus=false;
        System.out.println("-------------------------------------------------------------------------------");
        System.out.println("Lecture fichier vendeur.");
        try 
        {
            BufferedReader in = new BufferedReader(new FileReader(fichierVendeur)); 
            try
            {
                String record;
                char delim =':';   // the delimiter
                boolean toEnd=false;
                Vendeur vendeur=null;
                while ((record = in.readLine()) != null && !toEnd) 
                {
                    int begin=0;
                    int end;
                    
                    boolean enregistrementLus=false;
                    fichierLus=true;
                    if((end = record.indexOf(delim, begin)) >= 0)
                    {
                        String type= record.substring(begin, end);
                        begin = end + 1;
    
                        if(type.equals("client"))
                        {
                            if((end = record.indexOf(delim, begin)) >= 0)
                            {
                                String nom= record.substring(begin, end);
                                begin = end + 1;
                                if((end = record.indexOf(delim, begin)) >= 0)
                                {
                                    String prenom= record.substring(begin, end);
                                    begin = end + 1;
                                    if((end = record.indexOf(delim, begin)) >= 0)
                                    {
                                        String adresse= record.substring(begin, end);
                                        begin = end + 1;
                                        if((end = record.indexOf(delim, begin)) >= 0)
                                        {
                                            String commentaire= record.substring(begin, end);
                                            begin = end + 1;
    
                                            String telephone= record.substring(begin);
    
                                            Client client=new Client(nom,prenom,adresse,commentaire,telephone);
                                            if(vendeur!=null)
                                            {
                                                vendeur.ajoutClient(client);
                                                System.out.println("Client ajoute: "+client);
                                                enregistrementLus=true;
                                            }
                                        }
                                    }
                                }
                            }
    
                            
                        }
                        else
                        {
                            if(type.equals("vendeur"))
                            {
                                if((end = record.indexOf(delim, begin)) >= 0)
                                {
                                   String numeroEmploye= record.substring(begin, end);
                                    begin = end + 1;
                                    if((end = record.indexOf(delim, begin)) >= 0)
                                    {
                                        String nom= record.substring(begin, end);
                                        begin = end + 1;
        
                                        String prenom= record.substring(begin);
        
                                        // Ajoute le vendeur
                                        vendeur = new Vendeur(numeroEmploye,nom,prenom);
                                        vendeurs.add(vendeur);
                                        localisateurVendeur.put(vendeur.getNumeroEmploye(),vendeur);
                                        enregistrementLus=true;
                                        System.out.println("Vendeur ajoute: " + vendeur);
                                    }
                                }
                            }
                            else
                            {
                                toEnd=true;
                                fichierLus=false;
                                System.err.println("Enregistrement invalide.");
                            }
                        }
                    }
                    
                    if(!enregistrementLus)
                    {
                        toEnd=true;
                        fichierLus=false;
                        System.err.println("Enregistrement invalide.");
                    }
                }
            }
            finally
            {
                in.close();
            }
        } 
        catch (IOException e) 
        {
            System.err.println("Impossible de lire fichier:"+e.toString());
            fichierLus=false;
        }
        catch(ExceptionVendeur e)
        {
            System.err.println("Impossible d'ajouter le vendeur: " + e);
            fichierLus=false;
        }
        catch(ExceptionPersonne e)
        {
            System.err.println("Impossible d'ajouter la personne: " + e);
            fichierLus=false;
        }
        catch(ExceptionClient e)
        {
            System.err.println("Impossible d'ajouter le client: " + e);
            fichierLus=false;
        }
       return fichierLus;
    }
   /**
    *
    */ 
    public Automobile trouveAutomobile(String noSerie)
        {
            return (Automobile) localisateurAutomobile.get(noSerie);
        }
    /**
     *
     */
    public Set getListeAutomobiles()
    {
        return automobiles;
    }


       /** Lis le fichier automobile en memoire
    *
    * @param fichierAutomobile Le nom du fichier des automobiles
    */
    private boolean lireFichierAutomobile(String fichierAutomobile)
    {
        boolean fichierLus=false;
        System.out.println("-------------------------------------------------------------------------------");
        System.out.println("Lecture fichier automobile.");

        try
        {
            BufferedReader in = new BufferedReader(new FileReader(fichierAutomobile));
            try
            {
                String record;
                char delim = ':';
                boolean toEnd = false;

                while ((record = in.readLine()) != null && !toEnd)
                {
                    int begin = 0;
                    int end;
                    fichierLus = true;
                    Automobile auto = null;
                    if ((end = record.indexOf(delim, begin)) >= 0)
                    {
                        String type = record.substring(begin, end);
                        begin = end + 1;
                        if (type.equals("renault5") )
                        {
                            auto = (Automobile) new Renault5(record.substring(begin));
                        }
                        else
                        {
                            if (type.equals("miniaustin"))
                            {
                                auto = (Automobile) new MiniAustin(record.substring(begin));
                            }
                            else
                            {
                                if (type.equals("pinto"))
                                {
                                    auto = (Automobile) new Pinto(record.substring(begin));

                                }
                                else
                                {
                                    if (type.equals("amcgremlin"))
                                    {
                                        auto= (Automobile) new AmcGremlin(record.substring(begin));
                                    }
                                    else
                                    {
                                        if (type.equals("batmobile") )
                                        {
                                            auto= (Automobile) new Batmobile(record.substring(begin));
                                        }
                                        else
                                        {
                                            if (type.equals("papemobile"))
                                            {
                                                auto= (Automobile) new Papemobile(record.substring(begin));
                                            }
                                            else
                                            {
                                                toEnd = true;
                                                fichierLus = false;
                                                System.err.println("Enregistrement invalide: type invalide.");
                                            }
                                        }


                                    }
                                }
                            }
                        }

                        if(!toEnd)
                        {

                           Automobile tempAuto= (Automobile) localisateurAutomobile.get(auto.getNumero());
                           if(tempAuto==null)
                           {
                               automobiles.add(auto);
                               localisateurAutomobile.put(auto.getNumero(),auto);
                               System.out.println("Automobile ajoute:" + type);
                           }
                           else
                           {
                               toEnd = true;
                               fichierLus = false;
                               System.err.println("Enregistrement invalide: Voiture deja existante");
                           }
                        }

                    }
                    else
                    {
                        toEnd = true;
                        fichierLus = false;
                        System.err.println("Enregistrement invalide: ligne vide");
                    }
                }
            }
            finally
            {
                in.close();
            }


        }
        catch (IOException e)
        {
            System.err.println("Impossible de lire fichier:"+e);
            fichierLus=false;
        }
        catch (ExceptionAuto e)
        {
            System.err.println("Impossible de creer automobile:"+e);
            fichierLus=false;
        }
        catch (ExceptionModele e)
        {
            System.err.println("Impossible de creer automobile:"+e);
            fichierLus=false;
        }
        catch (ExceptionType e)
        {
            System.err.println("Impossible de creer automobile:"+e);
            fichierLus=false;
        }
        return fichierLus;
    }

    /**
     *
     */
    public Set getListeTransaction()
    {
        return transactions;
    }
  
    /** Lis le fichier transaction en memoire
    * 
    * @param fichierAutomobile Le nom du fichier des automobiles
    */
    private boolean lireFichierTransaction(String fichierTransaction)
    {
        boolean fichierLus=false;
        System.out.println("-------------------------------------------------------------------------------");
        System.out.println("Lecture fichier transaction.");

        try
        {
            BufferedReader in = new BufferedReader(new FileReader(fichierTransaction)); 
            try
            {
               String record;
               char delim =':';   // the delimiter
               boolean toEnd=false;
               fichierLus=true;
               while ((record = in.readLine()) != null && !toEnd) 
               {
                   boolean enregistrementLus=false;
                   int begin=0;
                   int end;
                   if((end = record.indexOf(delim, begin)) >= 0)
                   {
                       String chaineDate= record.substring(begin, end);
                       begin = end + 1;
                       if(chaineDate.length() ==8)
                       {
                           Integer annee= new Integer(chaineDate.substring(0,4));
                           Integer mois= new Integer(chaineDate.substring(4,6));
                           Integer jour= new Integer(chaineDate.substring(6,8));
                           Calendar dateTransaction=new GregorianCalendar(annee.intValue(),mois.intValue()-1,jour.intValue());
                           if((end = record.indexOf(delim, begin)) >= 0)
                           {
                               String codeVendeur= record.substring(begin, end);
                               begin = end + 1;
                               if((end = record.indexOf(delim, begin)) >= 0)
                               {
                                   String numeroSerieVoiture= record.substring(begin, end);
                                   begin = end + 1;
                                   if((end = record.indexOf(delim, begin)) >= 0)
                                   {
                                       String numeroClient= record.substring(begin, end);
                                       begin = end + 1;
                                       Integer prixVente= new Integer(record.substring(begin));
                                       
                                       Vendeur vendeur = (Vendeur) localisateurVendeur.get(codeVendeur);
                                       if(vendeur!=null)
                                       {
                                           Client client=vendeur.getClient(numeroClient);
                                           if(client != null)
                                           {
                                               Automobile auto=(Automobile)localisateurAutomobile.get(numeroSerieVoiture);
                                               if(!auto.getVendue())
                                               {
                                                   if(prixVente.intValue() >= auto.getPrixCoutant())
                                                   {
                                                       Transaction transac = new Transaction(dateTransaction,prixVente.intValue(),vendeur.getNumeroEmploye(),client.getIdentifiantClient(),auto.getNumero());
                                                       auto.setVendue(true);
                                                       enregistrementLus=true;
                                                       transactions.add(transac);
                                                       System.out.println("Transaction ajoute: " + transac);
                                                   }
                                                   else
                                                   {
                                                       System.err.println("Une voiture ne peut pas etre vendus moins cher que le prix coutant.");
                                                   }
                                               }
                                               else
                                               {
                                                   System.err.println("La voiture est deja vendue.");
                                               }
                                           }
                                           else
                                           {
                                               System.err.println("Le client n'existe pas pour ce vendeur.");
                                           }
                                           
                                       }
                                       else
                                       {
                                           System.err.println("Le vendeur n'existe pas.");
                                       }
                                   }
                               }
                           }
                       }
                   }

                   if(!enregistrementLus)
                   {
                       toEnd=true;
                       fichierLus=false;
                       System.err.println("Enregistrement invalide.");
                   }

               }

            }
            finally
            {
                in.close();
            }
        }
        catch (IOException e) 
        {
            System.err.println("Impossible de lire fichier:"+e);
            fichierLus=false;
        }
        catch (ExceptionVendeur e)
        {
            System.err.println("Erreur classe vendeur:"+e);
            fichierLus=false;
        }
        catch (ExceptionTransaction e)
        {
            System.err.println("Erreur classe transaction:"+e);
            fichierLus=false;
        }

        return fichierLus;

    }

    

}
