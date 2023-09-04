package client;
import javax.swing.JFrame;
import java.awt.Dimension;
import java.awt.Button;
import java.awt.Rectangle;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Label;
import java.awt.TextArea;
import java.awt.TextField;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JTextArea;
import javax.swing.JList;
import  java.io.*;
import java.util.*;
import javax.swing.JTextField;

public class GuiFactureResultat extends JFrame 
{
  private Livraison l;
  private JButton ok = new JButton();
  private JLabel jLabel1 = new JLabel();
  private JLabel jLabel2 = new JLabel();
  private JTextArea noFacture = new JTextArea();
  private JTextArea noLivraison = new JTextArea();
  private JList listeArticle = new JList();
  private JLabel jLabel3 = new JLabel();
  private JLabel jLabel4 = new JLabel();
  private JLabel jLabel5 = new JLabel();
  private JTextField montantTotal = new JTextField();
  private JTextField montantEscompte = new JTextField();
  public GuiFactureResultat(Livraison l)
  {
    try
    {
      this.l=l;
      jbInit();
     
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }

  }

  private void jbInit() throws Exception
  {
    this.getContentPane().setLayout(null);
    this.setSize(new Dimension(400, 315));
    this.setTitle("Facture Resultat");
    ok.setText("ok");
    ok.setBounds(new Rectangle(145, 250, 75, 25));
    ok.addActionListener(new ActionListener()
      {
        public void actionPerformed(ActionEvent e)
        {
          ok_actionPerformed(e);
        }
      });
    jLabel1.setText("Facture");
    jLabel1.setBounds(new Rectangle(25, 20, 80, 15));
    jLabel2.setText("Livraison");
    jLabel2.setBounds(new Rectangle(25, 45, 80, 15));
    noFacture.setBounds(new Rectangle(145, 20, 70, 17));
    
    noFacture.setText(""+l.getNumeroFacture());
    noFacture.setEditable(false);
    
    noLivraison.setBounds(new Rectangle(145, 50, 70, 17));
    noLivraison.setText(""+l.getNumeroLivraison());
    noLivraison.setEditable(false);
    listeArticle.setBounds(new Rectangle(25, 100, 345, 90));
    Set articles=l.getArticles();
    Iterator iter = articles.iterator();
    Vector v = new Vector(10,5);
    noFacture.setEnabled(false);
    jLabel3.setText("Numero Article, Quantite, Prix Unitaire, Rabais");
    jLabel3.setBounds(new Rectangle(25, 80, 345, 15));
    jLabel4.setText("Montant Total");
    jLabel4.setBounds(new Rectangle(30, 200, 110, 15));
    jLabel5.setText("Montant Total Apres Escompte");
    jLabel5.setBounds(new Rectangle(30, 225, 195, 15));
    montantTotal.setBounds(new Rectangle(225, 200, 140, 15));
    montantTotal.setEditable(false);
    montantEscompte.setBounds(new Rectangle(225, 225, 140, 15));
    montantEscompte.setEditable(false);
    float montant=0;
    float montantEsc=0;
    while(iter.hasNext())
    {
        ArticleLivraison a=(ArticleLivraison) iter.next();
        if(a != null)
        {
          montant += a.getPrixUnitaire() * a.getQuantite();
          montantEsc += (a.getPrixUnitaire() * (1-a.getPrixUnitaireRabais()) ) * a.getQuantite();
          v.add(a);
        }
   }
   listeArticle.setListData(v); 
   montantTotal.setText("" + montant +"$");
   montantEscompte.setText("" + montantEsc+"$");
   
    this.getContentPane().add(montantEscompte, null);
    this.getContentPane().add(montantTotal, null);
    this.getContentPane().add(jLabel5, null);
    this.getContentPane().add(jLabel4, null);
    this.getContentPane().add(jLabel3, null);
    this.getContentPane().add(listeArticle, null);
    this.getContentPane().add(noLivraison, null);
    this.getContentPane().add(noFacture, null);
    this.getContentPane().add(jLabel2, null);
    this.getContentPane().add(jLabel1, null);
    this.getContentPane().add(ok, null);
  }

  private void button1_actionPerformed(ActionEvent e)
  {
  dispose();
  }

  private void numLivraison_actionPerformed(ActionEvent e)
  {
  }

  private void ok_actionPerformed(ActionEvent e)
  {
  dispose();
  }
}