package client;
import javax.swing.JFrame;
import java.awt.Dimension;
import javax.swing.JButton;
import java.awt.Rectangle;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class GuiChoixPaiement extends JFrame 
{
  private JButton boutonCarteCredit = new JButton();
  private JButton boutonCheque = new JButton();

  public GuiChoixPaiement()
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
    this.setSize(new Dimension(175, 170));
    boutonCarteCredit.setText("Carte Credit");
    boutonCarteCredit.setBounds(new Rectangle(10, 25, 145, 25));
    boutonCarteCredit.addActionListener(new ActionListener()
      {
        public void actionPerformed(ActionEvent e)
        {
          jButton1_actionPerformed(e);
        }
      });
    boutonCheque.setText("Cheque");
    boutonCheque.setBounds(new Rectangle(10, 75, 145, 25));
    boutonCheque.addActionListener(new ActionListener()
      {
        public void actionPerformed(ActionEvent e)
        {
          boutonCheque_actionPerformed(e);
        }
      });
    this.getContentPane().add(boutonCheque, null);
    this.getContentPane().add(boutonCarteCredit, null);
  }

  private void jButton1_actionPerformed(ActionEvent e)
  {
    GuiPaiementCarteCredit g=new GuiPaiementCarteCredit();
    g.show();
    dispose();
  }

  private void boutonCheque_actionPerformed(ActionEvent e)
  {
    GuiPaiementCheque g=new GuiPaiementCheque();
    g.show();
    dispose();
  }
}