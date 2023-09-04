package beans;

import java.util.*;
import java.sql.*;

public class ListeEmprunt implements java.io.Serializable
{
	private Vector liste;
	public Vector getListe(int numeroClient)
	{
		liste=new Vector();
	    try
                {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@labunix.uqam.ca:1521:o8db","gc591821","raisinsec");
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM articlepret where numclient="+numeroClient);
                        while(rs.next())
                        {
                                Emprunt e=new Emprunt();
                                e.setNumClient(rs.getInt("NumClient"));
                                e.setNumArticle(rs.getInt("numarticle"));
                                e.setDateDebut(rs.getDate("datedebut"));
                                e.setDateFin(rs.getDate("datefin"));
                                liste.add(e);
                        }
                        con.close();
                        return liste;
                }
                catch (Exception e)
                {
                        return null;
                }

	}
}
