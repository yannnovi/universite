package beans;

import java.sql.*;
public class Produit implements java.io.Serializable
{
	private String nom;
        private int numero;
        private int prix;
        private int quantiteDisponible;
	private int quantiteCommandee;

        public String getNom()
        {
		return nom;
        }

        public void setNom(String nom)
        {
		this.nom=nom;
 	}

 	public int getNumero()
        {
                return numero;
        }
                                                                                
  	public void setNumero(int numero)
        {
                this.numero=numero;
        }
                                                                                
 	public int getPrix()
        {
                return prix;
        }
                                                                                
	public void setPrix(int prix)
        {
                this.prix=prix;
        }
                                                                                
	public int getQuantiteDisponible()
        {
                return quantiteDisponible;
        }
                                  
        public void setQuantiteDisponible(int quantiteDisponible)
        {
                this.quantiteDisponible=quantiteDisponible;
        }
	
	public int getQuantiteCommandee()
	{
		return quantiteCommandee;
	}
	
	public void setQuantiteCommandee(int quantiteCommandee)
	{
		this.quantiteCommandee=quantiteCommandee;
	}
	
	public boolean getProduitParId(int idArticle)
	{
		    try
                {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@labunix.uqam.ca:1521:o8db","gc591821","raisinsec");
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM articles WHERE NUMARTICLE = '"+idArticle+"'");
                        if(rs.next())
                        {
        			nom=rs.getString("nom");
        			numero=rs.getInt("numarticle");
        			prix=rs.getInt("prixunitaire");
        			quantiteDisponible=rs.getInt("qtedisponible");

                                con.close();
                                return true;
                        }
                        else
                        {
                                con.close();
                                return false;
                        }
                }
                catch (Exception e)
                {
                        return false;
                }
	}
};
