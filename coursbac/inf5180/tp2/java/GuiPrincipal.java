package client;
import javax.swing.JFrame;
import java.awt.Dimension;
import javax.swing.JButton;
import java.awt.Rectangle;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class GuiPrincipal extends JFrame 
{
  private JButton jButton1 = new JButton();
  private JButton jButton2 = new JButton();
  private JButton Quitter = new JButton();

  public GuiPrincipal()
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
    this.setSize(new Dimension(260, 169));
    jButton1.setText("Inscrire Paiement");
    jButton1.setBounds(new Rectangle(40, 25, 135, 25));
    jButton1.addActionListener(new ActionListener()
      {
        public void actionPerformed(ActionEvent e)
        {
          jButton1_actionPerformed(e);
        }
      });
      
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent evt) {
                exitForm(evt);
            }
        });

    
      
    jButton2.setText("Facture");
    jButton2.setBounds(new Rectangle(40, 60, 135, 25));
    jButton2.addActionListener(new ActionListener()
      {
        public void actionPerformed(ActionEvent e)
        {
          jButton2_actionPerformed(e);
        }
      });    
    Quitter.setText("Quitter");
    Quitter.setBounds(new Rectangle(40, 100, 135, 25));
    Quitter.addActionListener(new ActionListener()
      {
        public void actionPerformed(ActionEvent e)
        {
          Quitter_actionPerformed(e);
        }
      });
    this.getContentPane().add(Quitter, null);
    this.getContentPane().add(jButton2, null);
    this.getContentPane().add(jButton1, null);
  }

  private void jButton1_actionPerformed(ActionEvent e)
  {
    GuiChoixPaiement g=new GuiChoixPaiement();
    g.show();
  }
      /** Exit the Application */
    private void exitForm(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_exitForm
        System.exit(0);
    }//GEN-LAST:event_exitForm

  private void jButton2_actionPerformed(ActionEvent e)
  {
    GuiFacture guiFacture = new GuiFacture();
    guiFacture.show();
  }

  private void Quitter_actionPerformed(ActionEvent e)
  {
  System.exit(0);
  }
  
  
}