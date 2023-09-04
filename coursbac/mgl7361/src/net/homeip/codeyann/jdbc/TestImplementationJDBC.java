package net.homeip.codeyann.jdbc;

import net.homeip.codeyann.metier.*;
import java.sql.*;
import java.lang.Class;
public final class TestImplementationJDBC implements TestInterface 
{
	private Connection dbConn;

    public TestImplementationJDBC() 
	{
           
	}

	public boolean init()
	{
		try
		{
			
			Class.forName("org.postgresql.Driver");
		
			String url = "jdbc:postgresql://codeyann.homeip.net/test?user=pers&password=pers";
			dbConn = DriverManager.getConnection(url);
			//PersisteTypes.detruireTable(dbConn);
			PersisteTypes.creerTable(dbConn);
			PersisteAssociationB.creerTable(dbConn);
			PersisteAssociationA.creerTable(dbConn);
		}
		catch (Exception e)
		{
			System.out.println("KABOOM!:" + e);
			return false;
		}
		return true;
	}
	
	public boolean testTypeDonneesPersistes()
	{
		try
		{
			PersisteTypes pers= new PersisteTypes(dbConn,new net.homeip.codeyann.metier.Types('a',(byte)1,(short)2,3,(long)4,(float)5.5,(double)6.6,true ));
			pers.persiste();

			PersisteTypes persLecture= new PersisteTypes(dbConn);
			persLecture.retrouve('a');
			if(pers.getTypes().compareTo(persLecture.getTypes())==0)
			{
				return true;
			}
	
		}
		catch (Exception e)
		{
			System.out.println("KABOOML:  " + e);
		}
		return false;
	}
	
	public boolean testRestrictionTypeDonnesPersistes() 
	{
		try
		{
			PersisteTypes pers= new PersisteTypes(dbConn,new net.homeip.codeyann.metier.Types('b',(byte)1,(short)2,3,(long)4,(float)5.5,(double)6.6,true ));
			pers.persiste();

			PersisteTypes persLecture= new PersisteTypes(dbConn);
			persLecture.retrouve('b');
			if(pers.getTypes().compareTo(persLecture.getTypes())==0)
			{
				return true;
			}
	
		}
		catch (Exception e)
		{
			System.out.println("KABOOML:  " + e);
		}
		
		return false;
	}
	
	public boolean testConversionTypeDonneesAutomatique()
	{
		// disponible setOBject mais on a pas implémenter dans nos tests.
		return false;
	}
	
	public boolean testSauvegardeAssociation()
	{
		try
		{
			AssociationA assA= new AssociationA(123);
			AssociationB assB= new AssociationB(666);
			assA.setAssociationB(assB);
			PersisteAssociationA persAssA = new PersisteAssociationA(dbConn,assA);
			persAssA.persiste();

			PersisteAssociationB persAssBLecture = new PersisteAssociationB(dbConn);
			persAssBLecture.retrouve(666);
			AssociationB assBLecture = persAssBLecture.getAssociationB();

			if(	assBLecture!=null && assBLecture.compareTo(assB)==0 )
			{
				return true;
			}
		}
		catch (Exception e)
		{
			System.out.println("KABOOUM SORTIE = " + e);
			
		}
		return false;
	}
	
	public boolean testSuppression1N()
	{
		//  pas supporter puisque on ne supporte pas la sauvegarde d"association".
		return false;
	}
	
	public boolean testHeritage()
	{
		// pas supporter pas notre implémentation. Il faudrait sauvergarder dans plusieurs tables pour que cela fonctionne commme il faut.
		return false;
	}
	
	public boolean testPolymorphisme()
	{
		// pas supporté pour notre implementation.
		return false;
	}
	
	public boolean testSauvegardeCollection()
	{
		return false;
	}
	
	public boolean testRequetageObjet()
	{
		return false;
	}
	
	public boolean testRequeteDynamique()
	{
		return false;
	}
	
	public boolean testRequetePolymorphes()
	{
		// pas supporté pour notre implémentation.
		return false;
	}
	
	
	public void terminate()
	{
		try
		{
			PersisteTypes.detruireTable(dbConn);
		}
		catch (Exception e)
		{
			System.out.println("KABOOUM SORTIE = " + e);
			
		}

		try
		{
			PersisteAssociationA.detruireTable(dbConn);
		}
		catch (Exception e)
		{
			System.out.println("KABOOUM SORTIE = " + e);
			
		}

		try
		{
			PersisteAssociationB.detruireTable(dbConn);
		}
		catch (Exception e)
		{
			System.out.println("KABOOUM SORTIE = " + e);
			
		}
		
		try
		{
			dbConn.close();
		}
		catch (Exception e)
		{
			System.out.println("KABOOUM SORTIE = " + e);
			
		}

	}

	
}
