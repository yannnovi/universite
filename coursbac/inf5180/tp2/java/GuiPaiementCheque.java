package client;
import javax.swing.JFrame;
import java.awt.Dimension;
import javax.swing.JButton;
import java.awt.Rectangle;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JLabel;
import javax.swing.JTextField;

public class GuiPaiementCheque extends JFrame 
{
  private JButton boutonOK = new JButton();
  private JLabel jLabel1 = new JLabel();
  private JLabel jLabel2 = new JLabel();
  private JLabel jLabel3 = new JLabel();
  private JLabel jLabel4 = new JLabel();
  private JLabel jLabel5 = new JLabel();
  private JLabel jLabel6 = new JLabel();
  private JLabel jLabel7 = new JLabel();
  private JLabel jLabel8 = new JLabel();
  private JTextField numeroFacture = new JTextField();
  private JTextField montantPaye = new JTextField();
  private JTextField numeroCheque = new JTextField();
  private JTextField dateCheque = new JTextField();
  private JTextField numeroCompte = new JTextField();
  private JTextField identifiantBanque = new JTextField();
  private JTextField utilisateur = new JTextField();
  private JTextField motPasse = new JTextField();

  public GuiPaiementCheque()
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
    this.setSize(new Dimension(400, 236));
    boutonOK.setText("OK");
    boutonOK.setBounds(new Rectangle(150, 170, 73, 23));
    boutonOK.addActionListener(new ActionListener()
      {
        public void actionPerformed(ActionEvent e)
        {
          boutonOK_actionPerformed(e);
        }
      });
    jLabel1.setText("Numero Facture");
    jLabel1.setBounds(new Rectangle(10, 15, 145, 15));
    jLabel2.setText("Montant Paye");
    jLabel2.setBounds(new Rectangle(10, 30, 145, 15));
    jLabel3.setText("Numero Cheque");
    jLabel3.setBounds(new Rectangle(10, 45, 130, 15));
    jLabel4.setText("Date Cheque(YYYY/MM/DD)");
    jLabel4.setBounds(new Rectangle(10, 60, 165, 15));
    jLabel5.setText("Numero Compte");
    jLabel5.setBounds(new Rectangle(10, 75, 170, 15));
    jLabel6.setText("Identifiant Banque");
    jLabel6.setBounds(new Rectangle(10, 90, 175, 15));
    jLabel7.setText("Utilisateur");
    jLabel7.setBounds(new Rectangle(10, 115, 145, 15));
    jLabel8.setText("Mot De Passe");
    jLabel8.setBounds(new Rectangle(10, 130, 185, 15));
    numeroFacture.setBounds(new Rectangle(215, 10, 170, 15));
    montantPaye.setBounds(new Rectangle(215, 25, 170, 15));
    numeroCheque.setBounds(new Rectangle(215, 40, 170, 15));
    dateCheque.setBounds(new Rectangle(215, 60, 170, 15));
    numeroCompte.setBounds(new Rectangle(215, 75, 170, 15));
    identifiantBanque.setBounds(new Rectangle(215, 90, 170, 15));
    utilisateur.setBounds(new Rectangle(215, 115, 170, 15));
    motPasse.setBounds(new Rectangle(215, 130, 170, 15));
    this.getContentPane().add(motPasse, null);
    this.getContentPane().add(utilisateur, null);
    this.getContentPane().add(identifiantBanque, null);
    this.getContentPane().add(numeroCompte, null);
    this.getContentPane().add(dateCheque, null);
    this.getContentPane().add(numeroCheque, null);
    this.getContentPane().add(montantPaye, null);
    this.getContentPane().add(numeroFacture, null);
    this.getContentPane().add(jLabel8, null);
    this.getContentPane().add(jLabel7, null);
    this.getContentPane().add(jLabel6, null);
    this.getContentPane().add(jLabel5, null);
    this.getContentPane().add(jLabel4, null);
    this.getContentPane().add(jLabel3, null);
    this.getContentPane().add(jLabel2, null);
    this.getContentPane().add(jLabel1, null);
    this.getContentPane().add(boutonOK, null);
  }

  private void boutonOK_actionPerformed(ActionEvent e)
  {
    PaiementCheque p=new PaiementCheque();
    p.setBanque(Integer.parseInt(identifiantBanque.getText() ));
    p.setCompte(Integer.parseInt(numeroCompte.getText() ));
    p.setDateCheque(dateCheque.getText());
    p.setNumeroCheque(Integer.parseInt(numeroCheque.getText() ));
    p.setMontantPaye(Float.parseFloat (montantPaye.getText() ));
    p.setNumeroFacture(Integer.parseInt(numeroFacture.getText() ));
    CourtierPaiement c=new CourtierPaiement(utilisateur.getText(),motPasse.getText());
    c.effectuerPaiementCheque(p);
    dispose();
  }
}