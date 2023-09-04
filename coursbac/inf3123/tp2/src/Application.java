/*$Id: Application.java,v 1.17 2004/04/19 14:40:08 yann Exp $*/

package tp2;

import  java.io.*;
import java.util.*;
/** Cette classe implemante les menus de l'application
 */
public class Application
{
    private static Set vendeurs= new HashSet(); // Ensemble de tous les vendeurs
    private static Map localisateurVendeur= new HashMap(); // map qui permet de localiser un vendeur.

    private static Set automobiles= new HashSet(); // Ensemble de toutes les voitures
    private static Map localisateurAutomobile = new HashMap(); // map qui permet de localiser une voiture

    private static Set transactions= new HashSet(); // Ensemble de toutes les transactions

    // Fait un tokeniser sur l'input du clavier.
    private static BufferedReader input=new BufferedReader(new InputStreamReader(System.in));


    /** boucle principal du programme.
     * @param args Liste des parametres recus de la ligne de commande.
     */
    public static void main(String[] args)
    {
        try
        {
            System.out.println("Programme de gestion de ventes automobiles.\npar Yann Bourdeau (BOUY06097202) et Francis Goyer (GOYF14037303) ");

            // Trouve les 3 noms de fichier.
            String fichierAutomobile="";
            String fichierVendeurs="";
            String fichierTransaction="";

            if (args.length>=3)
            {
                fichierAutomobile=args[0];
                fichierVendeurs=args[1];
                fichierTransaction=args[2];
            }
            else
            {
                System.out.println("Vous devez specifier trois nom de fichier sur la ligne de commande.");
                System.out.println("ex.: java application automobile.txt vendeurs.txt transaction.txt");
                return; // Quitte le programme.
            }


            if (lireFichierAutomobile(fichierAutomobile)==false)
            {
                return;
            }

            if (lireFichierVendeur(fichierVendeurs)==false)
            {
                return;
            }

            if (lireFichierTransaction(fichierTransaction) == false)
            {
                return;
            }

            calculeCommission();
            calculeInventaire();
            boolean toEnd=false; // Determine si la boucle doit terminer.

            // Boucle jusqu'a ce que l'utilisateur appuie sur Q
            while (!toEnd)
            {
                // Affiche le menu
                System.out.println("*******************************************************************************");
                System.out.println("MENU");
                System.out.println("A - Ajouter dossier vendeur");
                System.out.println("C - Consulter dossier vendeur");
                System.out.println("D - Ajouter client a un dossier vendeur");
                System.out.println("L - Localiser un dossier client d'un dossier vendeur");
                System.out.println("O - Calcul commission");
                System.out.println("I - Calcul inventaire");
                System.out.println("Q - Quitter");
                System.out.println("*******************************************************************************");
                System.out.print(">");

                String menu= input.readLine(); // Chaine temporaire qui contient ce l'utilisateur a tape.

                if (menu.equalsIgnoreCase("q"))
                {
                    // L'utilisateur desire terminer le programme.
                    toEnd=true;
                }
                else
                {
                    if (menu.equalsIgnoreCase("A"))
                    {
                        // Ajoute un dossier vendeur
                        ajoutVendeur();
                    }
                    else
                    {
                        if (menu.equalsIgnoreCase("C"))
                        {
                            consulterVendeur();
                        }
                        else
                        {
                            if (menu.equalsIgnoreCase("D"))
                            {
                                ajoutClientAVendeur();
                            }
                            else
                            {
                                if (menu.equalsIgnoreCase("L"))
                                {
                                    localiserClient();
                                }
                                else
                                {
                                    if (menu.equalsIgnoreCase("O"))
                                    {
                                        calculeCommission();
                                    }
                                    else
                                    {
                                        if (menu.equalsIgnoreCase("i"))
                                        {
                                            calculeInventaire();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        catch (IOException e)
        {
            System.err.println("Erreur d'echange de donnee: " + e);
        }
    }

    /** Ajoute un vendeur a la liste des vendeur
     *
     */
    private static void ajoutVendeur()
    {
        try
        {
            // Lis les champs au clavier
            System.out.print("Numero employe:");
            String numeroEmploye=input.readLine();
            System.out.print("Nom:");
            String nom=input.readLine();
            System.out.print("Prenom:");
            String prenom=input.readLine();


            Vendeur vendeur=new Vendeur(numeroEmploye,nom,prenom);

            if (localisateurVendeur.get(vendeur.getNumeroEmploye()) == null)
            {
                vendeurs.add(vendeur);
                localisateurVendeur.put(vendeur.getNumeroEmploye(),vendeur);
            }
            else
            {
                System.err.println("Le vendeur existe deja.");
            }
        }
        catch (IOException e)
        {
            System.err.println("Impossible de lire au clavier. Client pas creer." + e);
        }
        catch (ExceptionVendeur e)
        {
            System.err.println("Impossible d'ajouter le vendeur: " + e);
        }
        catch (ExceptionPersonne e)
        {
            System.err.println("Impossible d'ajouter le vendeur: " + e);
        }


    }

    /** Consulte un vendeur de la liste des vendeurs.
    *
    */
    private static void consulterVendeur()
    {
        try
        {
            // Lis les champs au clavier
            System.out.print("Numero employe:");
            String numeroEmploye=input.readLine();

            Vendeur vendeur=(Vendeur) localisateurVendeur.get(numeroEmploye);
            if (vendeur!=null)
            {
                System.out.println("Vendeur: " + vendeur) ;
            }
            else
            {
                System.err.println("Le vendeur n'existe pas.");
            }

        }
        catch (IOException e)
        {
            System.err.println("Impossible de lire au clavier. Vender non cree." + e);
        }
    }

    /** Ajoute un client a un vendeur
    *
    */
    private static void ajoutClientAVendeur()
    {
        // Lis les champs au clavier
        try
        {
            System.out.print("Numero employe:");
            String numeroEmploye=input.readLine();

            Vendeur vendeur=(Vendeur) localisateurVendeur.get(numeroEmploye);
            if (vendeur!=null)
            {
                System.out.print("Nom:");
                String nom=input.readLine();
                System.out.print("Prenom:");
                String prenom=input.readLine();
                System.out.print("Adresse:");
                String adresse=input.readLine();
                System.out.print("Commentaire:");
                String commentaire=input.readLine();
                System.out.print("Numero de telephone:");
                String numeroTelephone=input.readLine();

                Client client= new Client(nom,prenom,adresse,commentaire,numeroTelephone);
                vendeur.ajoutClient(client);
                System.out.println("Le client " + client.getIdentifiantClient()+ " a ete ajoute.");

            }
            else
            {
                System.err.println("Le vendeur n'existe pas.");
            }
        }
        catch (IOException e)
        {
            System.err.println("Impossible de lire au clavier. client non cree." + e);
        }
        catch (ExceptionClient e)
        {
            System.err.println("Impossible de creer le client: " + e);
        }
        catch (ExceptionVendeur e)
        {
            System.err.println("Impossible d'ajouter le client: " + e);
        }
        catch (ExceptionPersonne e)
        {
            System.err.println("Impossible de creer le client: " + e);
        }
    }

    /** Consulte un client d'un vendeur
    *
    */
    private static void localiserClient()
    {
        try
        {
            System.out.print("Numero employe:");
            String numeroEmploye=input.readLine();

            Vendeur vendeur=(Vendeur) localisateurVendeur.get(numeroEmploye);
            if (vendeur!=null)
            {
                System.out.print("Identifiant client:");
                String identifiant=input.readLine();
                Client client=vendeur.getClient(identifiant);
                if (client != null)
                {
                    System.out.println("Client: "  +  client);
                }
                else
                {
                    System.err.println("Le client n'existe pas.");
                }
            }
        }
        catch (IOException e)
        {
            System.err.println("Impossible de lire au clavier. client non cree." + e);
        }
        catch (ExceptionVendeur e)
        {
            System.err.println("Impossible de trouver le client: " + e);
        }

    }

    /** Lis le fichier de vendeur (inclus les clients) en memoire
    *
    * @param fichierVendeur Le nom du fichier de vendeurs
    */
    private static boolean lireFichierVendeur(String fichierVendeur)
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
                    if ((end = record.indexOf(delim, begin)) >= 0)
                    {
                        String type= record.substring(begin, end);
                        begin = end + 1;

                        if (type.equals("client"))
                        {
                            if ((end = record.indexOf(delim, begin)) >= 0)
                            {
                                String nom= record.substring(begin, end);
                                begin = end + 1;
                                if ((end = record.indexOf(delim, begin)) >= 0)
                                {
                                    String prenom= record.substring(begin, end);
                                    begin = end + 1;
                                    if ((end = record.indexOf(delim, begin)) >= 0)
                                    {
                                        String adresse= record.substring(begin, end);
                                        begin = end + 1;
                                        if ((end = record.indexOf(delim, begin)) >= 0)
                                        {
                                            String commentaire= record.substring(begin, end);
                                            begin = end + 1;

                                            String telephone= record.substring(begin);

                                            Client client=new Client(nom,prenom,adresse,commentaire,telephone);
                                            if (vendeur!=null)
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
                            if (type.equals("vendeur"))
                            {
                                if ((end = record.indexOf(delim, begin)) >= 0)
                                {
                                    String numeroEmploye= record.substring(begin, end);
                                    begin = end + 1;
                                    if ((end = record.indexOf(delim, begin)) >= 0)
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

                    if (!enregistrementLus)
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
        catch (ExceptionVendeur e)
        {
            System.err.println("Impossible d'ajouter le vendeur: " + e);
            fichierLus=false;
        }
        catch (ExceptionPersonne e)
        {
            System.err.println("Impossible d'ajouter la personne: " + e);
            fichierLus=false;
        }
        catch (ExceptionClient e)
        {
            System.err.println("Impossible d'ajouter le client: " + e);
            fichierLus=false;
        }
        return fichierLus;
    }

    /** Lis le fichier automobile en memoire
    *
    * @param fichierAutomobile Le nom du fichier des automobiles
    */
    private static boolean lireFichierAutomobile(String fichierAutomobile)
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
            System.err.println("Impossible dee creer automobile:"+e);
            fichierLus=false;
        }
        catch (ExceptionModele e)
        {
            System.err.println("Impossible dee creer automobile:"+e);
            fichierLus=false;
        }
        catch (ExceptionType e)
        {
            System.err.println("Impossible dee creer automobile:"+e);
            fichierLus=false;
        }
        return fichierLus;
    }

    /** Lis le fichier transaction en memoire
    *
    * @param fichierAutomobile Le nom du fichier des automobiles
    */
    static private boolean lireFichierTransaction(String fichierTransaction)
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
                    if ((end = record.indexOf(delim, begin)) >= 0)
                    {
                        String chaineDate= record.substring(begin, end);
                        begin = end + 1;
                        if (chaineDate.length() ==8)
                        {
                            Integer annee= new Integer(chaineDate.substring(0,4));
                            Integer mois= new Integer(chaineDate.substring(4,6));
                            Integer jour= new Integer(chaineDate.substring(6,8));
                            Calendar dateTransaction=new GregorianCalendar(annee.intValue(),mois.intValue()-1,jour.intValue());
                            if ((end = record.indexOf(delim, begin)) >= 0)
                            {
                                String codeVendeur= record.substring(begin, end);
                                begin = end + 1;
                                if ((end = record.indexOf(delim, begin)) >= 0)
                                {
                                    String numeroSerieVoiture= record.substring(begin, end);
                                    begin = end + 1;
                                    if ((end = record.indexOf(delim, begin)) >= 0)
                                    {
                                        String numeroClient= record.substring(begin, end);
                                        begin = end + 1;
                                        Integer prixVente= new Integer(record.substring(begin));

                                        Vendeur vendeur = (Vendeur) localisateurVendeur.get(codeVendeur);
                                        if (vendeur!=null)
                                        {
                                            Client client=vendeur.getClient(numeroClient);
                                            if (client != null)
                                            {
                                                Automobile auto=(Automobile)localisateurAutomobile.get(numeroSerieVoiture);
                                                if (auto != null)
                                                {
                                                    if (!auto.getVendue())
                                                    {
                                                        if (prixVente.intValue() >= auto.getPrixCoutant())
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
                                                    System.err.println("La voiture n'existe pas.");
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

                    if (!enregistrementLus)
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

    /** Calcule toutes les commissions des vendeurs
     */
    private static void calculeCommission()
    {
        System.out.println("-------------------------------------------------------------------------------");
        System.out.println("Commission");
        Iterator iter = vendeurs.iterator();
        while (iter.hasNext())
        {
            Vendeur vendeur=(Vendeur) iter.next();
            System.out.print(vendeur.getPrenom() + " " +vendeur.getNom() + ": ");
            float commission=0;
            Iterator iTransaction=transactions.iterator();
            while (iTransaction.hasNext())
            {
                Transaction transac=(Transaction) iTransaction.next();
                if (transac.getNumeroEmployeVendeur().equals(vendeur.getNumeroEmploye()))
                {
                    Automobile auto= (Automobile) localisateurAutomobile.get(transac.getNumeroSerieAutomobile());
                    if (auto != null)
                    {
                        commission+=(transac.getPrix() - auto.getPrixAnnonce()) * 0.15;
                    }
                }
            }
            System.out.println( commission + "$");
        }
    }

    /** Calcule l'inventaire de voiture
     */
    private static void calculeInventaire()
    {
        System.out.println("-------------------------------------------------------------------------------");
        System.out.println("Inventaire");
        int nombreAMCGremlin=0;
        int nombreBatmobile=0;
        int nombreMiniAustin=0;
        int nombrePapemobile=0;
        int nombrePinto=0;
        int nombreRenault5=0;
        int nombreVenduAMCGremlin=0;
        int nombreVenduBatmobile=0;
        int nombreVenduMiniAustin=0;
        int nombreVenduPapemobile=0;
        int nombreVenduPinto=0;
        int nombreVenduRenault5=0;
        Iterator iter=automobiles.iterator();
        while (iter.hasNext())
        {
            Automobile auto=(Automobile) iter.next();
            if (auto instanceof AmcGremlin)
            {
                nombreAMCGremlin++;
                if (auto.getVendue())
                {
                    nombreVenduAMCGremlin++;
                }

            }

            if (auto instanceof Batmobile)
            {
                nombreBatmobile++;
                if (auto.getVendue())
                {
                    nombreVenduBatmobile++;
                }

            }

            if (auto instanceof MiniAustin)
            {
                nombreMiniAustin++;
                if (auto.getVendue())
                {
                    nombreVenduMiniAustin++;
                }
            }

            if (auto instanceof Papemobile)
            {
                nombrePapemobile++;
                if (auto.getVendue())
                {
                    nombreVenduPapemobile++;
                }
            }

            if (auto instanceof Pinto)
            {
                nombrePinto++;
                if (auto.getVendue())
                {
                    nombreVenduPinto++;
                }
            }

            if (auto instanceof Renault5)
            {
                nombreRenault5++;
                if (auto.getVendue())
                {
                    nombreVenduRenault5++;
                }
            }

        }
        System.out.println("  Compactes");

        int pourcent =0;
        if (nombreMiniAustin >0)
        {
            pourcent=(int)(((float)nombreVenduMiniAustin / (float)nombreMiniAustin) * (float)100);
        }
        System.out.println("    Mini Austin: reste: " + (nombreMiniAustin - nombreVenduMiniAustin)+ " unite(s) , vendues :" + pourcent + "%");

        pourcent =0;
        if (nombreRenault5 >0)
        {
            pourcent=(int)(((float)nombreVenduRenault5 / (float)nombreRenault5) * (float)100);
        }
        System.out.println("    Renault5: reste: " + (nombreRenault5 - nombreVenduRenault5)+ " unite(s) , vendues :" + pourcent + "%");

        System.out.println("  Berlines");
        pourcent =0;
        if (nombreAMCGremlin>0)
        {
            pourcent=(int)(((float)nombreVenduAMCGremlin / (float)nombreAMCGremlin) * (float)100);
        }
        System.out.println("    AMC Gremlin: reste: " + (nombreAMCGremlin - nombreVenduAMCGremlin)+ " unite(s) , vendues :" + pourcent + "%");

        pourcent =0;
        if (nombrePinto>0)
        {
            pourcent=(int)(((float)nombreVenduPinto / (float)nombrePinto) * (float)100);
        }
        System.out.println("    Pinto: reste: " + (nombrePinto - nombreVenduPinto)+ " unite(s) , vendues :" + pourcent + "%");

        System.out.println("  Sport");

        pourcent =0;
        if (nombreBatmobile>0)
        {
            pourcent=(int)(((float)nombreVenduBatmobile / (float)nombreBatmobile) * (float)100);
        }
        System.out.println("    Batmobile: reste: " + (nombreBatmobile - nombreVenduBatmobile)+ " unite(s) , vendues :" + pourcent + "%");

        pourcent =0;
        if (nombrePapemobile>0)
        {
            pourcent=(int)(((float)nombreVenduPapemobile / (float)nombrePapemobile) * (float)100);
        }
        System.out.println("    Papemobile: reste: " + (nombrePapemobile - nombreVenduPapemobile)+ " unite(s) , vendues :" + pourcent + "%");

    }

}
