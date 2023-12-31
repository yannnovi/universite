/*
 * GuiCommission.java
 *
 * Created on 26 avril 2004, 22:57
 */
package tp3; 
import java.io.*;
import javax.swing.*;
import java.util.*;

/**
 * <p>Title: Classe GuiCommission</p>
 * <p>Description: Classe GUI</p>
 * <p>Copyright: Copyright (c) 2004</p>
 * @author Framcis Goyer (GOYF14037303)
 * @version 1.0
 */

public class GuiCommission extends javax.swing.JFrame {

    /** Creates new form GuiCommission */
    public GuiCommission(Vendeur v, Application app)throws ExceptionGuiVendeur
    {
        if (v==null)
        {
            throw new ExceptionGuiVendeur("Le vendeur ne peut etre null. ");
        }
        else if(app==null){
            throw new ExceptionGuiVendeur("l'app ne pas etre null.");
        }
        this.v=v;
        this.app=app;
        initComponents();
        noVendeur.setText(v.getNumeroEmploye());
        nomVendeur.setText((v.getPrenom() +" "+ v.getNom()));
        calculeCommission();
    }

    /** Calcule toutes les commissions des vendeurs
    */
    public void calculeCommission()
    {
        Set transactions=app.getListeTransaction();
        Iterator iter = transactions.iterator();
        int comm = 0; //commission
        while(iter.hasNext())
        {
            Transaction tr= (Transaction) iter.next();
            if(tr.getNumeroEmployeVendeur().equals(v.getNumeroEmploye()))
                {
                    Automobile auto= (Automobile) app.trouveAutomobile(tr.getNumeroSerieAutomobile());
                    if(auto != null)
                    {
                        comm = comm + (tr.getPrix()- auto.getPrixCoutant());
                    }
                }
            }
            commission.setText(String.valueOf(comm));
        }


    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    private void initComponents() {//GEN-BEGIN:initComponents
        java.awt.GridBagConstraints gridBagConstraints;

        jPanel1 = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        jPanel2 = new javax.swing.JPanel();
        jLabel2 = new javax.swing.JLabel();
        noVendeur = new javax.swing.JTextField();
        jPanel6 = new javax.swing.JPanel();
        jPanel3 = new javax.swing.JPanel();
        jPanel4 = new javax.swing.JPanel();
        jLabel3 = new javax.swing.JLabel();
        nomVendeur = new javax.swing.JTextField();
        jPanel5 = new javax.swing.JPanel();
        jPanel7 = new javax.swing.JPanel();
        jPanel8 = new javax.swing.JPanel();
        jLabel4 = new javax.swing.JLabel();
        commission = new javax.swing.JTextField();
        jPanel12 = new javax.swing.JPanel();
        jPanel9 = new javax.swing.JPanel();
        jPanel10 = new javax.swing.JPanel();
        btnAnnuler = new javax.swing.JButton();
        jPanel11 = new javax.swing.JPanel();
        jMenuBar1 = new javax.swing.JMenuBar();
        jMenu1 = new javax.swing.JMenu();
        menuQuitter = new javax.swing.JMenuItem();

        getContentPane().setLayout(new java.awt.GridBagLayout());

        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent evt) {
                exitForm(evt);
            }
        });

        jPanel1.setLayout(new java.awt.GridBagLayout());

        jLabel1.setFont(new java.awt.Font("MS Sans Serif", 0, 18));
        jLabel1.setText("Fiche Commission");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 4;
        gridBagConstraints.ipady = 6;
        gridBagConstraints.insets = new java.awt.Insets(3, 3, 3, 3);
        jPanel1.add(jLabel1, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 244;
        gridBagConstraints.ipady = 14;
        gridBagConstraints.insets = new java.awt.Insets(3, 3, 3, 3);
        getContentPane().add(jPanel1, gridBagConstraints);

        jPanel2.setLayout(null);

        jLabel2.setText("No. Vendeur");
        jPanel2.add(jLabel2);
        jLabel2.setBounds(0, 0, 100, 20);

        noVendeur.setBackground(new java.awt.Color(224, 223, 227));
        jPanel2.add(noVendeur);
        noVendeur.setBounds(100, 0, 60, 20);

        jPanel2.add(jPanel6);
        jPanel6.setBounds(160, 0, 240, 20);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.ipadx = 399;
        gridBagConstraints.ipady = 19;
        gridBagConstraints.insets = new java.awt.Insets(3, 3, 3, 3);
        getContentPane().add(jPanel2, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.ipadx = 390;
        gridBagConstraints.insets = new java.awt.Insets(3, 3, 3, 3);
        getContentPane().add(jPanel3, gridBagConstraints);

        jPanel4.setLayout(null);

        jLabel3.setText(" Nom du Vendeur");
        jPanel4.add(jLabel3);
        jLabel3.setBounds(0, 0, 100, 20);

        nomVendeur.setBackground(new java.awt.Color(224, 223, 227));
        jPanel4.add(nomVendeur);
        nomVendeur.setBounds(100, 0, 180, 20);

        jPanel4.add(jPanel5);
        jPanel5.setBounds(280, 0, 120, 20);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.ipadx = 399;
        gridBagConstraints.ipady = 19;
        gridBagConstraints.insets = new java.awt.Insets(3, 3, 3, 3);
        getContentPane().add(jPanel4, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 4;
        gridBagConstraints.ipadx = 390;
        gridBagConstraints.insets = new java.awt.Insets(3, 3, 3, 3);
        getContentPane().add(jPanel7, gridBagConstraints);

        jPanel8.setLayout(null);

        jLabel4.setText("Commissions ");
        jPanel8.add(jLabel4);
        jLabel4.setBounds(0, 0, 100, 20);

        jPanel8.add(commission);
        commission.setBounds(100, 0, 180, 20);

        jPanel8.add(jPanel12);
        jPanel12.setBounds(280, 0, 120, 20);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 5;
        gridBagConstraints.ipadx = 399;
        gridBagConstraints.ipady = 19;
        gridBagConstraints.insets = new java.awt.Insets(3, 3, 3, 3);
        getContentPane().add(jPanel8, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 6;
        gridBagConstraints.ipadx = 390;
        gridBagConstraints.insets = new java.awt.Insets(3, 3, 3, 3);
        getContentPane().add(jPanel9, gridBagConstraints);

        jPanel10.setLayout(new java.awt.GridBagLayout());

        btnAnnuler.setLabel("Annuler");
        btnAnnuler.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                btnAnnulerMouseClicked(evt);
            }
        });

        jPanel10.add(btnAnnuler, new java.awt.GridBagConstraints());

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 7;
        gridBagConstraints.ipadx = 323;
        gridBagConstraints.ipady = 1;
        gridBagConstraints.insets = new java.awt.Insets(3, 3, 3, 3);
        getContentPane().add(jPanel10, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 8;
        gridBagConstraints.ipadx = 390;
        gridBagConstraints.ipady = 10;
        gridBagConstraints.insets = new java.awt.Insets(3, 3, 3, 3);
        getContentPane().add(jPanel11, gridBagConstraints);

        jMenu1.setText("Menu");
        menuQuitter.setLabel("Quitter");
        menuQuitter.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                menuQuitterMouseClicked(evt);
            }
        });

        jMenu1.add(menuQuitter);

        jMenuBar1.add(jMenu1);

        setJMenuBar(jMenuBar1);

        pack();
    }//GEN-END:initComponents

    private void menuQuitterMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_menuQuitterMouseClicked
        // TODO add your handling code here:
        dispose();
    }//GEN-LAST:event_menuQuitterMouseClicked

    private void btnAnnulerMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnAnnulerMouseClicked
        // TODO add your handling code here:
        dispose();
    }//GEN-LAST:event_btnAnnulerMouseClicked

    /** Exit the Application */
    private void exitForm(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_exitForm
        System.exit(0);
    }//GEN-LAST:event_exitForm

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnAnnuler;
    private javax.swing.JTextField commission;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JMenu jMenu1;
    private javax.swing.JMenuBar jMenuBar1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel10;
    private javax.swing.JPanel jPanel11;
    private javax.swing.JPanel jPanel12;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JPanel jPanel6;
    private javax.swing.JPanel jPanel7;
    private javax.swing.JPanel jPanel8;
    private javax.swing.JPanel jPanel9;
    private javax.swing.JMenuItem menuQuitter;
    private javax.swing.JTextField noVendeur;
    private javax.swing.JTextField nomVendeur;
    // End of variables declaration//GEN-END:variables
    static private Application app;
    private Vendeur v;
}
