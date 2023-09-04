package beans;
                                                                                                
import java.util.*;
import java.sql.*;
                                                                                                
public class ListeReservation implements java.io.Serializable
{
        private Vector liste;
        public Vector getListe(int numeroClient)
        {
		liste= new Vector();
            try
                {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@labunix.uqam.ca:1521:o8db","gc591821","raisinsec");
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM articlereservation where numclient="+numeroClient);
                        while(rs.next())
                        {
                                Reservation r=new Reservation();
                                r.setNumClient(rs.getInt("NumClient"));
                                r.setNumArticle(rs.getInt("numarticle"));
                                r.setPosition(rs.getInt("position"));
                                liste.add(r);
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
