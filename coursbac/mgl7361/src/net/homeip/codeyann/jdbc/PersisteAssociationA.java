package net.homeip.codeyann.jdbc;

import net.homeip.codeyann.metier.*;
import java.sql.*;
import org.postgresql.util.*;

public final class PersisteAssociationA 
{
	private Connection con;
	AssociationA assA;
	
	public PersisteAssociationA(Connection con)
	{
		this.con=con;
		assA=null;
	}
	
	public PersisteAssociationA(Connection con,AssociationA assA) 
	{
		this.con=con;
        this.assA=assA;
    }

	public AssociationA getAssociationA()
	{
		return assA;
	}
	
	public void persiste() throws SQLException
	{
		PreparedStatement st;
		
		if(assA.getAssociationB()!=null)
		{

			PersisteAssociationB persAssB = new PersisteAssociationB(con,assA.getAssociationB());
			persAssB.persiste();			
			st = con.prepareStatement("INSERT INTO  AssociationA (index,indexb) VALUES (?,?) ");
			st.setInt(1,assA.getIndex());
			st.setInt(2,assA.getAssociationB().getIndex());
		}
		else
		{
			st = con.prepareStatement("INSERT INTO  AssociationA (index,indexb) VALUES (?,NULL) ");
			st.setInt(1,assA.getIndex());
		}
		st.executeUpdate();
		st.close();
	}
	
	public void retrouve(int index) throws SQLException
	{
		PreparedStatement st = con.prepareStatement("SELECT * from  AssociationA where index = ?");
		st.setInt(1,index);
		ResultSet rs=st.executeQuery();
		
		AssociationB assB=null;
		while(rs.next())
		{
			index=rs.getInt(1);
			int indexb=rs.getInt(2);
			if(!rs.wasNull())
			{
				PersisteAssociationB persAssB= new PersisteAssociationB(con);
				persAssB.retrouve(indexb);
				assB=persAssB.getAssociationB();
			}
			
			
			assA=new AssociationA(index);
			assA.setAssociationB(assB);
		}
		st.close();
		
	}
	
	
	public static void creerTable(Connection con) throws SQLException
	{
		Statement st = con.createStatement();
		// Il faudrait implémenter l'association vers C
		st.execute("CREATE TABLE AssociationA(index int NOT NULL, indexb int,indexc int, PRIMARY KEY(index),FOREIGN KEY(indexb) references AssociationB(index))");
		st.close();
		
	}
	
	public static void detruireTable(Connection con) throws SQLException
	{
		Statement st = con.createStatement();
		st.execute("DROP TABLE AssociationA");
		st.close();
	}
}
