package beans;

import java.util.*;
import java.sql.*;
public class Panier implements java.io.Serializable
{
	private Vector panier;

	public Panier()
	{
		panier=new Vector();
	}

	public Vector getPanier()
	{
		return panier;
	}
	public void viderPanierAvecCommande()
	{
			panier.clear();
	}

	public void viderPanierSansCommande()
	{
		if(panier!=null)
		{
			Enumeration enum=panier.elements();
			while(enum.hasMoreElements())
			{
				Produit p=(Produit)enum.nextElement();
				try
				{
					 Class.forName("oracle.jdbc.driver.OracleDriver");
		                         Connection con = DriverManager.getConnection("jdbc:oracle:thin:@labunix.uqam.ca:1521:o8db","gc591821","raisinsec");
                		        Statement stmt = con.createStatement();
 					String insertion="UPDATE articles SET qtedisponible = qtedisponible+ "+(p.getQuantiteCommandee())+" WHERE numarticle = "+p.getNumero();
                        		int retour=stmt.executeUpdate(insertion);

                        		con.close();
				}	
				catch(Exception e)
				{
				}
			}
			panier.clear();
		}
	}

	public boolean ajouterAuPanier(Produit p)
	{
		if(p.getQuantiteDisponible()<p.getQuantiteCommandee())
		{
			return false;
		}
		else
		{
		   try
	           {	
			Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@labunix.uqam.ca:1521:o8db","gc591821","raisinsec");
                        Statement stmt = con.createStatement();
 String insertion="UPDATE articles SET qtedisponible = "+(p.getQuantiteDisponible()-p.getQuantiteCommandee())+" WHERE numarticle = "+p.getNumero();
                        int retour=stmt.executeUpdate(insertion);
                        con.close();
			panier.add(p);
                        return true;
		    }
	            catch(Exception e)
	            {
			System.out.println("erreur:"+e);
			return false;
                    }	
		}
	}

	public boolean retirerDuPanier(int numeroProduit,int quantite)
	{
		Enumeration enum=panier.elements();
		boolean trouve=false;
		Produit p=null;
		while(enum.hasMoreElements() && !trouve)
		{
			p=(Produit)enum.nextElement();
			if(p.getNumero()==numeroProduit &&
                           p.getQuantiteCommandee()==quantite)
			{
				trouve=true;
			}	
		}
		if(trouve)
		{
			try
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");
                        	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@labunix.uqam.ca:1521:o8db","gc591821","raisinsec");
                        	Statement stmt = con.createStatement();
 				String insertion="UPDATE articles SET qtedisponible = qtedisponible + "+quantite+" WHERE numarticle = "+p.getNumero();
                        	int retour=stmt.executeUpdate(insertion);
                        	con.close();
                        	panier.remove(p);
                        	return true;
			}
			catch(Exception e)
			{
				return false;
			}
		}
		else
		{
			return false;
		}	
	}

	public boolean persisterPanier(int numeroClient)
	{
        	try
                {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@labunix.uqam.ca:1521:o8db","gc591821","raisinsec");
                        Statement stmt = con.createStatement();
		  	Enumeration enum=panier.elements();
			boolean succes=true;
			while(enum.hasMoreElements())
			{
				Produit p=(Produit)enum.nextElement();
				
                        	String insertion="INSERT INTO COMMANDES VALUES("+numeroClient+","+p.getNumero()+",SYSDATE,"+p.getQuantiteCommandee()+")";
                        	int retour=stmt.executeUpdate(insertion);
				if(retour != 1)
				{
					succes=false;
				}
			}
                        con.close();
                        return succes;
		}
                catch (Exception e)
                {
                        return false;
                }
	}

	public int getNombreProduit()
	{
		return panier.size();
	}
};
