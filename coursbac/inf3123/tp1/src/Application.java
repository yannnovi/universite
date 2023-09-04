/*$Id: Application.java,v 1.11 2004/02/14 21:39:55 yann Exp $*/
package net.homeip.codeyann.inf3123.tp1;

import  java.io.*;

public class Application 
{
    // Cette fonction affiche une chaine sur une taille fixe. Si la 
    // chaine est plus petite que la taille maximum, la fonction
    // vas ecrire des espace blanc apres le champs.
    private static void afficheChamps(String champs,int longueurMaximum)
    {
        if(champs.length() > longueurMaximum)
        {
            System.out.print(champs.substring(1,longueurMaximum));
        }
        else
        {
            System.out.print(champs);
            for(int i=champs.length();i<longueurMaximum;++i)
            {
                System.out.print(" ");
            }
        }
    }

    // Affiche a l'ecran le resultat des dossiers. 
    // Fait aussi les statistiques sur le groupe.
    private static void afficheResultat(Dossier[] dossiers,int numDossierUtilise)
    {
        try
        {
            int longueurNom=25;
            int longueurPrenom=25;
            int longueurNote=10;
            int longueurCote=10;
            int numNoteA=0;
            int numNoteB=0;
            int numNoteC=0;
            int numNoteD=0;
            int numNoteE=0;
            Note plusBasseNote= new Note(100);
            Note plusHauteNote= new Note(0);
            double moyenne=0;
    
            afficheChamps("Nom",longueurNom);
            afficheChamps("Prenom",longueurPrenom);
            afficheChamps("Note",longueurNote);
            afficheChamps("Cote",longueurCote);
            System.out.print("\n");
    
            for(int i =0; i <numDossierUtilise;++i)
            {
                afficheChamps((dossiers[i].getEtudiant()).getNom() ,longueurNom);
                afficheChamps((dossiers[i].getEtudiant()).getPrenom(),longueurPrenom);
                afficheChamps(""+(dossiers[i].getFicheResultats()).getNoteGlobal(),longueurNote);
                afficheChamps(""+(dossiers[i].getFicheResultats()).getNoteGlobal().getCote(),longueurCote);
                System.out.print("\n");
                if((dossiers[i].getFicheResultats()).getNoteGlobal().getNote()>plusHauteNote.getNote())
                {
                    plusHauteNote=(dossiers[i].getFicheResultats()).getNoteGlobal();
                }
    
                if((dossiers[i].getFicheResultats()).getNoteGlobal().getNote()<plusBasseNote.getNote())
                {
                    plusBasseNote=(dossiers[i].getFicheResultats()).getNoteGlobal();
                }
    
                moyenne+= dossiers[i].getFicheResultats().getNoteGlobal().getNote();
    
                switch((dossiers[i].getFicheResultats()).getNoteGlobal().getCote() )
                {
                case 'A':
                    numNoteA++;
                    break;
                case 'B':
                    numNoteB++;
                    break;
                case 'C':
                    numNoteC++;
                    break;
                case 'D':
                    numNoteD++;
                    break;
                case 'E':
                    numNoteE++;
                    break;
                }
            }
    
            System.out.println("Plus haute note: " + plusHauteNote);
            System.out.println("Plus basse note: " + plusBasseNote);
            moyenne /= numDossierUtilise ;
            long longMoyenne=java.lang.Math.round(moyenne);
            System.out.println("Moyenne: " + longMoyenne +"%");
            System.out.println("A: " + numNoteA);
            System.out.println("B: " + numNoteB);
            System.out.println("C: " + numNoteC);
            System.out.println("D: " + numNoteD);
            System.out.println("E: " + numNoteE);
        }
        catch (ExceptionNote e)
        {
            System.out.println(e.getMessage());
        }

    }
    
    // Cette fonction lis un dossier un clavier.
    // Elle retourne un dossier qui peut etre null, je ne considere pas
    // un dossier invalide comme etant une exception.
    private static Dossier lireDossier(String record)
    {
        int begin=0;
        int end;
        boolean lus7Champs=false;
        Dossier dossier=null;
        char delim =':';   // the delimiter
        try
        {
            /* lis le nom*/
            if((end = record.indexOf(delim, begin)) >= 0)
            {
                String nom= record.substring(begin, end);
                begin = end + 1;
                /* lis le prenom */
                if((end = record.indexOf(delim, begin)) >= 0)
                {
                    String prenom= record.substring(begin, end);
                    begin = end + 1;

                    if((end = record.indexOf(delim, begin)) >= 0)
                    {
                        Note noteTP1 = new Note(record.substring(begin, end));
                        begin = end + 1;

                        if((end = record.indexOf(delim, begin)) >= 0)
                        {
                            Note noteTP2 = new Note(record.substring(begin, end));
                            begin = end + 1;

                            if((end = record.indexOf(delim, begin)) >= 0)
                            {
                                Note noteTP3= new Note(record.substring(begin, end));
                                begin = end + 1;

                                if((end = record.indexOf(delim, begin)) >= 0)
                                {
                                    Note noteIntra= new Note(record.substring(begin, end));                                        
                                    begin = end + 1;
                                    Note noteFinal= new Note(record.substring(begin));
                                    dossier = new Dossier(nom,prenom,noteTP1,noteTP2,noteTP3,noteIntra,noteFinal);
                                    lus7Champs=true;
                                }
                            }
                        }
                    }
                }
            }
            if(lus7Champs==false)
            {
                System.out.println("Dossier invalide: champs manquant");
            }
        }
        catch(NumberFormatException e)
        {
            System.out.println("Dossier invalide: champs non numerique");
        }
        catch(ExceptionNote e)
        {
            System.out.print("Dossier invalide: ");
            System.out.println(e.getMessage());
        }
        catch(ExceptionEtudiant e)
        {
            System.out.print("Dossier invalide: ");
            System.out.println(e.getMessage());
        }
        
        
        return dossier;
    }

    // boucle principal du programme.
    public static void main(String[] args)
    {
        System.out.println("Programme qui calcul des notes d'etudiants.\npar Yann Bourdeau (BOUY06097202)");
        System.out.println("Entrez des etudiants\nFormat: nom:prenom:notetp1:notetp2:notetp3:noteintra:notefinal");
        System.out.println("Ligne vide pour terminer");

        Dossier[] dossiers=new Dossier[100];
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        try
        {
            String record;
            String prompt="=>";
            int numDossier = 0; 
            System.out.print(prompt);
            while(((record = in.readLine()) != null) && (record.length() > 0) && (numDossier < 100))
            {
                dossiers[numDossier]=lireDossier(record);

                if(dossiers[numDossier]!=null)
                {
                    numDossier++;
                }
                System.out.print(prompt);    
            }

            afficheResultat(dossiers,numDossier);
        } 
        catch (IOException e)
        {
            System.out.println(e.getMessage());
        }
    }
}

