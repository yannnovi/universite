package net.homeip.codeyann.jdbc;

import net.homeip.codeyann.metier.*;
import java.sql.*;
import org.postgresql.util.*;

public final class PersisteAssociationB 
{
	private Connection con;
	AssociationB assB;
	
    public PersisteAssociationB(Connection con) 
	{
        this.con=con;
    }

    public PersisteAssociationB(Connection con,AssociationB assB) 
	{
        this.con=con;
		this.assB=assB;
    }

	public AssociationB getAssociationB()
	{
		return assB;
	}
	
	public void persiste() throws SQLException
	{
		
		PreparedStatement st = con.prepareStatement("INSERT INTO AssociationB (index) VALUES (?) ");
		st.setInt(1,assB.getIndex());
		st.executeUpdate();
		st.close();
	}
	
	public void retrouve(int index) throws SQLException
	{
		PreparedStatement st = con.prepareStatement("SELECT * from AssociationB where index = ?");
		st.setInt(1,index);
		ResultSet rs=st.executeQuery();
		
		while(rs.next())
		{

			index=rs.getInt(1);

			
			assB=new AssociationB(index);
		}
		st.close();
		
	}
	
	
	public static void creerTable(Connection con) throws SQLException
	{
		Statement st = con.createStatement();
		st.execute("CREATE TABLE AssociationB(index int NOT NULL,data char, PRIMARY KEY(index))");
		st.close();
		
	}
	
	public static void detruireTable(Connection con) throws SQLException
	{
		Statement st = con.createStatement();
		st.execute("DROP TABLE AssociationB");
		st.close();
	}


}
