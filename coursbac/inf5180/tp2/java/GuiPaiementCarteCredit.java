package client;
import javax.swing.JFrame;
import java.awt.Dimension;
import javax.swing.JLabel;
import java.awt.Rectangle;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import java.lang.Object;

public class GuiPaiementCarteCredit extends JFrame 
{
  private JLabel jLabel1 = new JLabel();
  private JLabel jLabel2 = new JLabel();
  private JLabel jLabel3 = new JLabel();
  private JLabel jLabel4 = new JLabel();
  private JLabel jLabel5 = new JLabel();
  private JLabel jLabel6 = new JLabel();
  private JLabel jLabel7 = new JLabel();
  private JButton boutonOK = new JButton();
  private JTextField montantPaye = new JTextField();
  private JTextField typeCarteCredit = new JTextField();
  private JTextField numeroCarte = new JTextField();
  private JTextField moisExpiration = new JTextField();
  private JTextField numeroFacture = new JTextField();
  private JTextField anneeExpiration = new JTextField();
  private JTextField numeroAutorisation = new JTextField();
  private JLabel jLabel8 = new JLabel();
  private JLabel jLabel9 = new JLabel();
  private JTextField utilisateur = new JTextField();
  private JTextField motPasse = new JTextField();

  public GuiPaiementCarteCredit()
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
    this.setSize(new Dimension(400, 273));
    jLabel1.setText("Numero Facture");
    jLabel1.setBounds(new Rectangle(15, 10, 150, 20));
    jLabel2.setText("Montant Paye");
    jLabel2.setBounds(new Rectangle(15, 35, 110, 15));
    jLabel3.setText("Type Carte Credit");
    jLabel3.setBounds(new Rectangle(15, 55, 100, 15));
    jLabel4.setText("Numero Carte Credit");
    jLabel4.setBounds(new Rectangle(15, 75, 130, 15));
    jLabel5.setText("Mois Expiration");
    jLabel5.setBounds(new Rectangle(15, 95, 100, 15));
    jLabel6.setText("Annee Expiration");
    jLabel6.setBounds(new Rectangle(15, 115, 115, 15));
    jLabel6.setToolTipText("null");
    jLabel7.setText("Numero Autorisation");
    jLabel7.setBounds(new Rectangle(15, 130, 135, 20));
    boutonOK.setText("OK");
    boutonOK.setBounds(new Rectangle(150, 205, 73, 23));
    boutonOK.addActionListener(new ActionListener()
      {
        public void actionPerformed(ActionEvent e)
        {
          boutonOK_actionPerformed(e);
        }
      });
    montantPaye.setBounds(new Rectangle(150, 35, 215, 15));
    typeCarteCredit.setBounds(new Rectangle(150, 55, 215, 15));
    numeroCarte.setBounds(new Rectangle(150, 75, 215, 15));
    moisExpiration.setBounds(new Rectangle(150, 95, 215, 15));
    numeroFacture.setBounds(new Rectangle(150, 10, 215, 20));
    anneeExpiration.setBounds(new Rectangle(150, 115, 215, 15));
    numeroAutorisation.setBounds(new Rectangle(150, 135, 215, 15));
    jLabel8.setText("Utilisateur");
    jLabel8.setBounds(new Rectangle(15, 160, 135, 15));
    jLabel9.setText("Mot de Passe");
    jLabel9.setBounds(new Rectangle(15, 180, 135, 15));
    utilisateur.setBounds(new Rectangle(150, 160, 215, 15));
    motPasse.setBounds(new Rectangle(150, 180, 215, 15));
    this.getContentPane().add(motPasse, null);
    this.getContentPane().add(utilisateur, null);
    this.getContentPane().add(jLabel9, null);
    this.getContentPane().add(jLabel8, null);
    this.getContentPane().add(numeroAutorisation, null);
    this.getContentPane().add(anneeExpiration, null);
    this.getContentPane().add(numeroFacture, null);
    this.getContentPane().add(moisExpiration, null);
    this.getContentPane().add(numeroCarte, null);
    this.getContentPane().add(typeCarteCredit, null);
    this.getContentPane().add(montantPaye, null);
    this.getContentPane().add(boutonOK, null);
    this.getContentPane().add(jLabel7, null);
    this.getContentPane().add(jLabel6, null);
    this.getContentPane().add(jLabel5, null);
    this.getContentPane().add(jLabel4, null);
    this.getContentPane().add(jLabel3, null);
    this.getContentPane().add(jLabel2, null);
    this.getContentPane().add(jLabel1, null);
  }

  private void boutonOK_actionPerformed(ActionEvent e)
  {
    PaiementCarteCredit p = new PaiementCarteCredit();
    p.setNumeroAutorisation(Integer.parseInt(numeroAutorisation.getText()));
    p.setExpirationAnnee(anneeExpiration.getText());
    p.setExpirationMois(moisExpiration.getText());
    p.setNumeroFacture(Integer.parseInt(numeroFacture.getText() ));
    p.setNumero(numeroCarte.getText());
    p.setType(typeCarteCredit.getText());
    p.setMontantPaye( Float.parseFloat (montantPaye.getText()));
    
    CourtierPaiement c=new CourtierPaiement(utilisateur.getText(),motPasse.getText());
    c.effectuerPaiementCarteCredit(p);
    dispose();
  }
}