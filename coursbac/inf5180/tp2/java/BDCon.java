package client;
import java.sql.*;


public class BDCon 
{
  
  public BDCon(){}

  static public Connection getConnection(String utilisateur,String motPasse)throws SQLException,ClassNotFoundException
  {
    Connection uneConnection=null;

    
      Class.forName ("oracle.jdbc.driver.OracleDriver");
      uneConnection = DriverManager.getConnection ("jdbc:oracle:thin:@labunix.uqam.ca:1521:o8db" , utilisateur, motPasse);
    
    return uneConnection;

  }

  static public void closeConnection(Connection C)throws SQLException
  {
    C.close();
  }
}

