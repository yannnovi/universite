package client;
import javax.swing.JFrame;
import java.awt.Dimension;
import javax.swing.JLabel;
import java.awt.Rectangle;
import javax.swing.JTextArea;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JEditorPane;

public class GuiFacture extends JFrame 
{
  private JLabel jLabel1 = new JLabel();
  private JTextArea jTextNumeroLivraison = new JTextArea();
  private JLabel jLabel2 = new JLabel();
  private JButton jButton1 = new JButton();
  private JLabel jLabel3 = new JLabel();
  private JLabel jLabel4 = new JLabel();
  private JTextArea jTextCodeUtilisateur = new JTextArea();
  private JTextArea jTextMotPasse = new JTextArea();
  private JEditorPane jEditorPane1 = new JEditorPane();

  public GuiFacture()
  {
    try
    {
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
    this.setSize(new Dimension(400, 211));
    jLabel1.setText("Numero livrasion");
    jLabel1.setBounds(new Rectangle(825, 220, 135, 15));
    jTextNumeroLivraison.setBounds(new Rectangle(165, 25, 85, 15));
    jLabel2.setText("Numero Livraison");
    jLabel2.setBounds(new Rectangle(35, 25, 105, 15));
    jButton1.setText("OK");
    jButton1.setBounds(new Rectangle(150, 140, 73, 23));
    jButton1.addActionListener(new ActionListener()
      {
        public void actionPerformed(ActionEvent e)
        {
          jButton1_actionPerformed(e);
        }
      });
    jLabel3.setText("Code utilisateur");
    jLabel3.setBounds(new Rectangle(35, 55, 110, 15));
    jLabel4.setText("Mot de passe");
    jLabel4.setBounds(new Rectangle(35, 90, 110, 15));
    jTextCodeUtilisateur.setBounds(new Rectangle(165, 55, 85, 15));
    jTextMotPasse.setBounds(new Rectangle(165, 85, 90, 15));
    jEditorPane1.setText("jEditorPane1");
    jEditorPane1.setBounds(new Rectangle(290, -20, 106, 20));
    this.getContentPane().add(jEditorPane1, null);
    this.getContentPane().add(jTextMotPasse, null);
    this.getContentPane().add(jTextCodeUtilisateur, null);
    this.getContentPane().add(jLabel4, null);
    this.getContentPane().add(jLabel3, null);
    this.getContentPane().add(jButton1, null);
    this.getContentPane().add(jLabel2, null);
    this.getContentPane().add(jTextNumeroLivraison, null);
    this.getContentPane().add(jLabel1, null);
  }

  private void jButton1_actionPerformed(ActionEvent e)
  {
    Livraison maLivraison=new Livraison();
    maLivraison.setNumeroLivraison(Integer.parseInt(jTextNumeroLivraison.getText()));
    
    String utilisateur=jTextCodeUtilisateur.getText();
    String motPasse = jTextMotPasse.getText();
    CourtierLivraison cl = new CourtierLivraison(utilisateur,motPasse);
    
    maLivraison=cl.EffectueRequeteLivraison(maLivraison);
    
    GuiFactureResultat gfr=new GuiFactureResultat(maLivraison);
    gfr.show();
    dispose();
  }
}