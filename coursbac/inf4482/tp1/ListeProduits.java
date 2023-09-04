package beans;
import java.util.*;
import java.sql.*;
public class ListeProduits implements java.io.Serializable
{
	private Vector liste;
        public ListeProduits()
        {
        	liste=new Vector();
        }

	public Vector getListe()
	{
		try
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@labunix.uqam.ca:1521:o8db","gc591821","raisinsec");
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM articles");
			while(rs.next())
			{
				Produit p=new Produit();
			        p.setNumero(rs.getInt("NumArticle"));
				p.setNom(rs.getString("Nom"));
				p.setPrix(rs.getInt("prixunitaire"));
				p.setQuantiteDisponible(rs.getInt("qtedisponible"));
				liste.add(p);
			}
 			con.close();
			return liste;
		}
		catch (Exception e)
                {
			return null;
		}
	}

	public static void main(String args[])
	{
		ListeProduits l = new ListeProduits();
		Vector z=l.getListe();
		System.out.println(""+z.size());
	}	
};
