package beans;
import java.sql.*;
public class Client implements java.io.Serializable
{
	private int numeroClient;
	private String nom;
	private String motPasse;
	private String courriel;
	private String telephone;
	private boolean login;
	private int couleur=1;

	public Client()
	{
		login=false;
	}

	public int getNumeroClient()
       	{
		return numeroClient;
	}

        public String getNom()
        {
                return nom;
        }

        public void setNom(String nom)
        {
                this.nom=nom;
        }

        public String getMotPasse()
        {
                return motPasse;
        }
                                                                                
        public void setMotPasse(String motPasse)
        {
                this.motPasse=motPasse;
        }

        public String getCourriel()
        {
                return courriel;
        }
                                                                                
        public void setCourriel(String courriel)
        {
                this.courriel=courriel;
        }

        public String getTelephone()
        {
                return telephone;
        }
                                                                                
        public void setTelephone(String telephone)
        {
                this.telephone=telephone;
        }

	public void setCouleur(int couleur)
	{
		this.couleur=couleur;
	}

	public int getCouleur()
	{
		return couleur;
	}

	public boolean persister()
	{
		try
                {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@labunix.uqam.ca:1521:o8db","gc591821","raisinsec");
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT MAX(numclient) as maxnumclient FROM clients");
			if(rs.next())
			{
				numeroClient=rs.getInt("maxnumclient")+1;
			}
			String insertion="INSERT INTO CLIENTS VALUES("+numeroClient+",'"+nom+"','"+motPasse+"','"+telephone+"','"+courriel+"',"+couleur+")";
			int retour=stmt.executeUpdate(insertion);
                        con.close();
			return true;
                }
                catch (Exception e)
                {
			return false;
                }
	}

	public boolean chargerClientParCourriel(String courriel,String motDePasse)
	{
		try
                {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@labunix.uqam.ca:1521:o8db","gc591821","raisinsec");
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM clients WHERE COURRIEL = '"+courriel+"'");
                        if(rs.next())
                        {
                                numeroClient=rs.getInt("numclient");
                		nom=rs.getString("nom");
			        motPasse=rs.getString("motpasse");
       				courriel=rs.getString("courriel");
        			telephone=rs.getString("telephone");
				couleur=rs.getInt("couleur");	
                        	con.close();
			        if(motDePasse.equals(motPasse))
				{
			  		return true;
				}
				else
			 	{
					return false;
				}	
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

	public boolean getLogin()
	{
		return login;
	}

	public void setLogin(boolean login)
	{
		this.login=login;
	}	

	public boolean persisterMiseAJourCouleur()
        {
                try
                {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@labunix.uqam.ca:1521:o8db","gc591821","raisinsec");
                        Statement stmt = con.createStatement();
                        String changeCouleur="UPDATE CLIENTS SET couleur = "+couleur+" WHERE NUMCLIENT="+numeroClient;
                        int retour=stmt.executeUpdate(changeCouleur);
                        con.close();
                        return true;
                }
                catch (Exception e)
                {
                        return false;
                }
        }

};
