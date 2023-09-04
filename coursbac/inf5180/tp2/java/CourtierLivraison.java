
package client;
import java.sql.*;
import javax.swing.*;

public class CourtierLivraison 
{
  private String utilisateur;
  private String motPasse;
  public CourtierLivraison(String utilisateur,String motPasse)
  {
    this.utilisateur=utilisateur;
    this.motPasse=motPasse;
  }
  
  Livraison EffectueRequeteLivraison(Livraison source)
  {
  Livraison l = new Livraison();
    try
    {
      
      Connection connexion=client.BDCon.getConnection(utilisateur,motPasse);
      String reqSQL=(
         "SELECT livraison.numero_livraison,facture.numero_facture,article.numero_article,article.PRIX_UNITAIRE,articlelivraison.QUANTITE_LIVRAISON,DECODE(articlespecial.RABAIS_ARTICLE,NULL,0.0,articlespecial.RABAIS_ARTICLE) "
         +
         "FROM livraison,article,facture,articlelivraison,ARTICLESPECIAL "
         +         
         "WHERE livraison.numero_livraison = " + source.getNumeroLivraison()  + " "
         +
         "AND facture.numero_livraison = livraison.numero_livraison AND articlelivraison.numero_livraison = livraison.numero_livraison AND article.numero_article = articlelivraison.numero_article AND article.numero_article = articlespecial.numero_article(+)"
         );
         
        Statement selectus=connexion.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY );
      ResultSet resultatSelect = selectus.executeQuery(reqSQL);
      while(resultatSelect.next())
      {
    
        l.setNumeroLivraison(resultatSelect.getInt(1));
        l.setNumeroFacture(resultatSelect.getInt(2));
        ArticleLivraison a = new ArticleLivraison();
        a.setNumeroArticle(resultatSelect.getInt(3));
        a.setQuantite(resultatSelect.getInt(5));
        a.setPrixUnitaire(resultatSelect.getFloat(4));
        a.setPrixUnitaireRabais(resultatSelect.getFloat(6));
        l.ajoutArticleLivraison(a);
      }
      client.BDCon.closeConnection(connexion);
      return l;
    }
    catch (Exception e) {  
            JOptionPane.showMessageDialog(null, "Exception: " + e, "alert", JOptionPane.ERROR_MESSAGE); 
            return null;
        }  
   

 
  }
  

}