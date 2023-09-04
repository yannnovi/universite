/*
 * GuiListeTransaction.java
 *
 * Created on 26 avril 2004, 18:36
 */
 
package tp3;
import java.io.*;
import javax.swing.*;
import java.util.*;

/**
 * <p>Title: Classe GuiListeTransaction</p>
 * <p>Description: Classe GUI</p>
 * <p>Copyright: Copyright (c) 2004</p>
 * @author Framcis Goyer (GOYF14037303)
 * @version 1.0
 */

public class GuiListeTransaction extends javax.swing.JFrame {

    /** Creates new form GuiListeTransaction */
    public GuiListeTransaction(Application app) throws ExceptionGuiListe
    {
        if (app==null)
        {
            throw new ExceptionGuiListe("La liste de transaction ne peut pas etre nul.");
        }
        this.app=app;
        initComponents();
        refreshListeTransaction();
    }

    public void refreshListeTransaction()
    {
       Vector v = new Vector(10,5);
       Set transactions=this.app.getListeTransaction();
       Iterator iter = transactions.iterator();
       while(iter.hasNext())
       {
           Transaction transaction = (Transaction) iter.next();
           if(transaction != null)
           {
               v.add(transaction);
           }
       }
       listeTransaction.setListData(v);
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
        jScrollPane1 = new javax.swing.JScrollPane();
        listeTransaction = new javax.swing.JList();
        jPanel5 = new javax.swing.JPanel();
        btnAnnuler = new javax.swing.JButton();
        jPanel6 = new javax.swing.JPanel();
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
        jLabel1.setText("Liste des transactions");
        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 6;
        gridBagConstraints.ipady = 6;
        gridBagConstraints.insets = new java.awt.Insets(3, 3, 3, 3);
        jPanel1.add(jLabel1, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.ipadx = 214;
        gridBagConstraints.ipady = 14;
        gridBagConstraints.insets = new java.awt.Insets(3, 3, 3, 3);
        getContentPane().add(jPanel1, gridBagConstraints);

        jPanel2.setLayout(null);

        jScrollPane1.setViewportView(listeTransaction);

        jPanel2.add(jScrollPane1);
        jScrollPane1.setBounds(0, 0, 400, 190);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.ipadx = 399;
        gridBagConstraints.ipady = 189;
        gridBagConstraints.insets = new java.awt.Insets(3, 3, 3, 3);
        getContentPane().add(jPanel2, gridBagConstraints);

        jPanel5.setLayout(new java.awt.GridBagLayout());

        btnAnnuler.setLabel("Annuler");
        btnAnnuler.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                btnAnnulerMouseClicked(evt);
            }
        });

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 0;
        gridBagConstraints.insets = new java.awt.Insets(3, 3, 3, 3);
        jPanel5.add(btnAnnuler, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 2;
        gridBagConstraints.ipadx = 323;
        gridBagConstraints.ipady = 1;
        gridBagConstraints.insets = new java.awt.Insets(3, 3, 3, 3);
        getContentPane().add(jPanel5, gridBagConstraints);

        gridBagConstraints = new java.awt.GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 3;
        gridBagConstraints.ipadx = 390;
        gridBagConstraints.ipady = 20;
        gridBagConstraints.insets = new java.awt.Insets(3, 3, 3, 3);
        getContentPane().add(jPanel6, gridBagConstraints);

        jMenu1.setText("Menu");
        menuQuitter.setLabel("Quitter");
        jMenu1.add(menuQuitter);

        jMenuBar1.add(jMenu1);

        setJMenuBar(jMenuBar1);

        pack();
    }//GEN-END:initComponents

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
    private javax.swing.JLabel jLabel1;
    private javax.swing.JMenu jMenu1;
    private javax.swing.JMenuBar jMenuBar1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JPanel jPanel6;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JList listeTransaction;
    private javax.swing.JMenuItem menuQuitter;
    // End of variables declaration//GEN-END:variables
    //static private Transaction tr;
    static private Application app;
}
