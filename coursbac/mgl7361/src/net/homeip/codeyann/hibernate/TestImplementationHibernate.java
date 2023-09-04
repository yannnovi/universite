package net.homeip.codeyann.hibernate;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

import java.lang.Class;
import net.homeip.codeyann.metier.*;

public class TestImplementationHibernate implements TestInterface
{
	private static Session m_session;
	
	public boolean init()
	{		
		System.out.println("Launch JDBC init to drop/create table ================");	
		String url = "jdbc:postgresql://codeyann.homeip.net/test?user=pers&password=pers";
		Connection dbConn = null;
		try
		{
			Class.forName("org.postgresql.Driver");
			dbConn = DriverManager.getConnection(url);
			
			try
			{
				detruireTable(dbConn);
				dbConn.commit();
			}
			catch(SQLException sqle)
			{
				System.out.println("JDBC drop table failed ================");
			}
			
			try
			{
				creerTable(dbConn);
				dbConn.commit();
			}
			catch(SQLException sqle)
			{
				System.out.println("JDBC create table failed ================");
			}		
			
			dbConn.close();
		}
		catch (Exception e)
		{
			System.out.println("JDBC init failed ================");
			if (dbConn != null)
			{
				try
				{
					dbConn.close();
				}
				catch (SQLException sqle)
				{				
				}
			}
		}

		
		System.out.println("Hibernate test debut ================");		
		return true;
	}
	
	private boolean persistType(char key)
	{
		net.homeip.codeyann.metier.Types typesToAdd = new net.homeip.codeyann.metier.Types(key,(byte)1,(short)2,3,(long)4,(float)5.5,(double)6.6,true);
		
		m_session = HibernateUtil.getSessionFactory().openSession();
		m_session.beginTransaction();
		m_session.save(typesToAdd);
		m_session.getTransaction().commit();
	
		net.homeip.codeyann.metier.Types typesSaved = (net.homeip.codeyann.metier.Types)m_session.
			get(net.homeip.codeyann.metier.Types.class, new Character(key));
		return typesSaved != null;
	}
	
	public boolean testTypeDonneesPersistes()
	{
		return persistType('a');
	}
		
	public boolean testRestrictionTypeDonnesPersistes()
	{
		return persistType('b');
	}
	
	public boolean testConversionTypeDonneesAutomatique()
	{
		return persistType('c');
	}
	
	public boolean testSauvegardeAssociation()
	{
		AssociationA assA= new AssociationA(123);
		AssociationB assB= new AssociationB(666);
		AssociationC assC= new AssociationC(777 );
		assA.setAssociationB(assB);
		assA.setAssociationC(assC);

		m_session.beginTransaction();
		m_session.save(assA);
		m_session.getTransaction().commit();
		
		AssociationB AssociationBSaved = (AssociationB)m_session.
			get(AssociationB.class, new Integer(666));
		return AssociationBSaved != null;
	}
	
	public boolean testSuppression1N()
	{
		AssociationA assA= new AssociationA(124);
		AssociationB assB= new AssociationB(125);
		AssociationC assC= new AssociationC(126);
		assA.setAssociationB(assB);
		assA.setAssociationC(assC);
		
		m_session.beginTransaction();
		m_session.save(assA);
		m_session.getTransaction().commit();
		
		m_session.beginTransaction();
		m_session.delete(assA);
		m_session.getTransaction().commit();
		
		AssociationB AssociationBSaved = (AssociationB)m_session.
			get(AssociationB.class, new Integer(125));

		AssociationC AssociationCSaved = (AssociationC)m_session.
			get(AssociationC.class, new Integer(126));
	
		return AssociationBSaved == null && AssociationCSaved == null;
	}
	
	public boolean testHeritage()
	{
		HeritageEnfant enfant = new HeritageEnfant(132,133);
		
		m_session.beginTransaction();
		m_session.save(enfant);
		m_session.getTransaction().commit();	 
		
		HeritageParent parentSaved = (HeritageParent)m_session.get(HeritageParent.class, new Integer(133));
		return parentSaved.getIndex() == ((HeritageParent)enfant).getIndex();		
	}
	
	public boolean testPolymorphisme()
	{
		HeritageEnfant enfant = new HeritageEnfant(134,135);
	  
	  	m_session.beginTransaction();
	    m_session.save(enfant);
	    m_session.getTransaction().commit();
    
	    HeritageParent parent2 = (HeritageEnfant)m_session.get(HeritageEnfant.class, new Integer(135));
	    
	    // Get child value
		return parent2.compareTo(enfant) == 0;
	}
	
	public boolean testSauvegardeCollection()
	{
		CollectionTest2 col = new CollectionTest2(1);
		
		HashMap h = new HashMap();
		h.put("key1", "value1");
		h.put("key2", "value2");
		col.setCollection(h);
           
		m_session.beginTransaction();
	    m_session.save(col);
	    m_session.getTransaction().commit();
		
	    CollectionTest2 collectionSaved = (CollectionTest2)m_session.get(CollectionTest2.class, new Integer(1));
		return collectionSaved.equals(col);
	}
	
	public boolean testRequetageObjet()
	{
		char key = 'a';
		net.homeip.codeyann.metier.Types typesSaved = (net.homeip.codeyann.metier.Types)m_session.
		get(net.homeip.codeyann.metier.Types.class, key);
		
		return typesSaved != null && typesSaved.getChar() == key;
	}
	
	public boolean testRequeteDynamique()
	{
		return testRequeteDynamique('a');
	}
	
	public boolean testRequeteDynamique(char key)
	{
		m_session.beginTransaction();
	    Query q = m_session.createQuery("from Types t where t.char = :var");
	    q.setCharacter("var", key);
	    List requeteDynamique = (List) q.list();
	    m_session.getTransaction().commit();
	    
	    return requeteDynamique.size() > 0;
	}
	
	public boolean testRequetePolymorphes()
	{
		m_session.beginTransaction();
	    Query q = m_session.createQuery("from HeritageParent");
	    List heritageList = (List) q.list();
	    m_session.getTransaction().commit();
	    
	    HeritageParent parent = (HeritageEnfant)heritageList.get(0);
	    HeritageParent parent2 = (HeritageEnfant)heritageList.get(1);
	    
	    // Get child value
		return parent.getIndex() == 133 && parent2.getIndex() == 135;
	}
	
	
	public void terminate()
	{
		if (m_session != null)
		{
			m_session.close();
		}
		
		System.out.println("Hibernate test fin ================");
	}

	public static void detruireTable(Connection con) throws SQLException
	{
		Statement st = con.createStatement();
		
		try
		{
			st.execute("DROP TABLE types");
		}
		catch (SQLException sqle)
		{
		}
	
		try
		{
			st.execute("DROP TABLE association_a");
		}
		catch (SQLException sqle)
		{
		}
		
		try
		{
			st.execute("DROP TABLE association_b");
		}
		catch (SQLException sqle)
		{
		}
		
		try
		{
			st.execute("DROP TABLE association_c");
		}
		catch (SQLException sqle)
		{
		}
		
		
		try
		{
			st.execute("DROP TABLE heritage");
		}
		catch (SQLException sqle)
		{
		}		
			
		try
		{
			st.execute("DROP TABLE collection_test");
		}
		catch (SQLException sqle)
		{
		}	
		
		try
		{
			st.execute("DROP TABLE collection_map");
		}
		catch (SQLException sqle)
		{
		}			
		
		st.close();
	}
	
	public static void creerTable(Connection con) throws SQLException
	{
		Statement st = con.createStatement();
		
		st.execute("CREATE TABLE types(testchar char NOT NULL,testbyte char,testshort smallint,testint integer,testlong bigint,testfloat real,testdouble double precision,testboolean boolean,PRIMARY KEY(testchar))");
		st.execute("CREATE TABLE association_a(indexa integer , indexb integer NOT NULL, indexc integer NOT NULL, PRIMARY KEY(indexa))");
		st.execute("CREATE TABLE association_b(index integer , PRIMARY KEY(index))");
		st.execute("CREATE TABLE association_c(index integer, PRIMARY KEY(index))");		
		st.execute("CREATE TABLE heritage(index_parent integer, index_enfant integer, heritage char(15), PRIMARY KEY(index_parent))");
		st.execute("CREATE TABLE collection_test(index integer, map_id char, PRIMARY KEY(index))");
		st.execute("CREATE TABLE collection_map(id integer, map_id char(30), map_value char(30))");
		
		st.close();		
	}	
}