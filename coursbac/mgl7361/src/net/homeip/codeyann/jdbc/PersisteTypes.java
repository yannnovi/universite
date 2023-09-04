package net.homeip.codeyann.jdbc;

import net.homeip.codeyann.metier.*;
import java.sql.*;
import org.postgresql.util.*;

public final class PersisteTypes 
{
	private net.homeip.codeyann.metier.Types types;
	private Connection con;

	
	public PersisteTypes(Connection con)
	{
		this.con=con;
		types=null;
	}
	
    public PersisteTypes(Connection con,net.homeip.codeyann.metier.Types types) 
	{
		this.con=con;
        this.types=types;
    }

	public net.homeip.codeyann.metier.Types getTypes()
	{
		return types;
	}	

	public void persiste() throws SQLException
	{
		
		PreparedStatement st = con.prepareStatement("INSERT INTO types (testchar,testbyte,testshort,testint,testlong,testfloat,testdouble,testboolean) VALUES (?,?,?,?,?,?,?,?) ");
		st.setString(1, ""+types.getChar());
		st.setString(2, ""+types.getByte());
		st.setShort(3,types.getShort());
		st.setInt(4,types.getInt());
		st.setLong(5,types.getLong());
		st.setFloat(6,types.getFloat());
		st.setDouble(7,types.getDouble());
		st.setBoolean(8,types.getBoolean());
		st.executeUpdate();
		st.close();
	}
	
	public void retrouve(char testValeur) throws SQLException
	{
		PreparedStatement st = con.prepareStatement("SELECT * from types where testchar = ?");
		st.setString(1,""+ testValeur);
		ResultSet rs=st.executeQuery();
		
		while(rs.next())
		{

			char testChar=rs.getString(1).charAt(0);

			byte testByte=(byte)rs.getShort(2);

			short testShort=rs.getShort(3);

			int testInt=rs.getInt(4);

			long testLong=rs.getLong(5);

			float testFloat=rs.getFloat(6);

			double testDouble=rs.getDouble(7);

			boolean testBoolean=rs.getBoolean(8);
			
			types=new net.homeip.codeyann.metier.Types(testChar,testByte,testShort,testInt,testLong,testFloat,testDouble,testBoolean);
		}
		st.close();
	}
	
	public static void creerTable(Connection con) throws SQLException
	{
		Statement st = con.createStatement();
		st.execute("CREATE TABLE types(testchar char NOT NULL,testbyte char,testshort smallint,testint integer,testlong bigint,testfloat real,testdouble double precision,testboolean boolean,PRIMARY KEY(testchar))");
		st.close();
		
	}
	
	public static void detruireTable(Connection con) throws SQLException
	{
		Statement st = con.createStatement();
		st.execute("DROP TABLE types");
		st.close();
	}
}
