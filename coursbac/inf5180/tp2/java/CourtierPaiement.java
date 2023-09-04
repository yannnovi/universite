package client;
import java.sql.*;
import javax.swing.*;


public class CourtierPaiement 
{
  private String utilisateur;
  private String motPasse;
  public CourtierPaiement(String utilisateur,String motPasse)
  {
    this.utilisateur=utilisateur;
    this.motPasse=motPasse;
  }
  
  void effectuerPaiementCarteCredit(PaiementCarteCredit p)
  {
    try
    {
      Connection connexion=client.BDCon.getConnection(utilisateur,motPasse);
     
      String insertCommande = ("INSERT INTO paiement VALUES (" + p.getNumeroFacture() + ",SYSDATE, " + p.getMontantPaye() + ", 'cc'" +
                ",'" + p.getType() + "','" + p.getNumero() + "',TO_DATE('"+p.getExpirationAnnee()+"/"+p.getExpirationMois()+"','YY/MM')," +
                p.getNumeroAutorisation() +",NULL,NULL,NULL,NULL)");
     
      Statement unEnonceComm = connexion.createStatement ();
    
      int n =  unEnonceComm.executeUpdate(insertCommande);
      client.BDCon.closeConnection(connexion);
      
    }
     catch (Exception e) 
     {  
            JOptionPane.showMessageDialog(null, "Exception: " + e, "alert", JOptionPane.ERROR_MESSAGE); 
 
     }  
  }
  
  void effectuerPaiementCheque(PaiementCheque p)
  {
    try
    {
      Connection connexion=client.BDCon.getConnection(utilisateur,motPasse);
     
      String insertCommande = ("INSERT INTO paiement VALUES (" + p.getNumeroFacture() + ",SYSDATE, " + p.getMontantPaye() + ", 'ch'" +
                ",NULL,NULL,NULL,NULL" +
                ","+p.getNumeroCheque() +",TO_DATE('" + p.getDateCheque()  +"','YYYY/MM/DD')," + p.getCompte()  + "," + p.getBanque()  +")");
     
     
      Statement unEnonceComm = connexion.createStatement ();
    
      int n =  unEnonceComm.executeUpdate(insertCommande);
      client.BDCon.closeConnection(connexion);
      
    }
     catch (Exception e) 
     {  
            JOptionPane.showMessageDialog(null, "Exception: " + e, "alert", JOptionPane.ERROR_MESSAGE); 
 
     }    
  
  }
}