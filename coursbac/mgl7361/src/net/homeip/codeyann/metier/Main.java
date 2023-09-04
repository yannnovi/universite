package net.homeip.codeyann.metier;
import net.homeip.codeyann.db4o.TestImplementationDB4O;
import net.homeip.codeyann.hibernate.TestImplementationHibernate;
import net.homeip.codeyann.jdbc.TestImplementationJDBC;
import net.homeip.codeyann.exist.*;
import java.lang.Object;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.lang.Integer;

class Main 
{
	
  public static void main (String[] args)
  {
	int choix;
	boolean toEnd=false;
   	System.out.println("Test de persistance par Jean-Claude Viau et Yann Bourdeau!");	
	do
	{
		TestInterface test=null;
		try
		{
			choix=lireChoix();	
		}
		catch (Exception e)
		{
			return;
		}
		
		switch(choix)
		{
			case 1:
			// hibernate
			test = new TestImplementationHibernate();
			break;
		
			case 2:
			//DB4O
			test= new TestImplementationDB4O(); 
			break;
		
			case 3:
			test= new TestImplementationExist();
			//BD XML
			break;
		
			case 4:
			//JDBC
			test= new TestImplementationJDBC();
			break;
			
			default:
			toEnd=true;
			break;
		
		}	
		if(test!=null)
		{
			try
			{
				process(test);	
			}
			catch (Exception e)
			{
				System.out.println("Exception, anormal termination.");
				System.out.println("MSG: " + e.getMessage());
				test.terminate();
			}
			catch (ExceptionInInitializerError ex)
			{
				System.out.println("Exception, anormal termination.");
				System.out.println("MSG: " + ex.getMessage());
				test.terminate();
			}			
		}
	 }
	while(!toEnd);
  }

// faudrait tout refaire cette crap comme il faut!
	private static int lireChoix()
	{
	 	BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

		String choix = null;
		try
		{
			System.out.println("1: hibernate, 2: DB4O, 3: XML, 4:JDBC, autre touche: quitter");
			
			choix=br.readLine();
			return new Integer(choix);
		}
		catch (IOException ioe)
		{
			System.out.println("Problème à la lecture");
			System.exit(1);
		}
		return 0;

	}
	
	private static void process(TestInterface test)
	{
		int testReussis=0;
		int testFait=0;
		
		test.init();
		
		System.out.println("Test 1: Type de persistance");
		if(test.testTypeDonneesPersistes())
		{
			testReussis++;
			System.out.println("Reussis!");
			
		}
		else
		{
			System.out.println("Echoue!");
			
		}
		testFait++;
	
		System.out.println("Test 2: Restriction Type de persistance");
		if(test.testRestrictionTypeDonnesPersistes())
		{
			testReussis++;
			System.out.println("Reussis!");
			
		}
		else
		{
			System.out.println("Echoue!");
			
		}
		testFait++;

		System.out.println("Test 3: Conversion de type donné automatique");	
		if(test.testConversionTypeDonneesAutomatique())
		{
			testReussis++;
			System.out.println("Reussis!");
			
		}
		else
		{
			System.out.println("Echoue!");
			
		}
		testFait++;

		System.out.println("Test 4: Sauvegarde association");	
		if(test.testSauvegardeAssociation())
		{
			testReussis++;
			System.out.println("Reussis!");
			
		}
		else
		{
			System.out.println("Echoue!");
			
		}
		testFait++;

		System.out.println("Test 5: Suppression 1-n");	
		if(test.testSuppression1N())
		{
			testReussis++;
			System.out.println("Reussis!");
			
		}
		else
		{
			System.out.println("Echoue!");
			
		}
		testFait++;

		System.out.println("Test 6: Sauvegarde Heritage");	
		if(test.testHeritage())
		{
			testReussis++;
			System.out.println("Reussis!");
			
		}
		else
		{
			System.out.println("Echoue!");
			
		}
		testFait++;

		System.out.println("Test 7: Sauvegarde Polymorphisme");	
		if(test.testPolymorphisme())
		{
			testReussis++;
			System.out.println("Reussis!");
			
		}
		else
		{
			System.out.println("Echoue!");
			
		}
		testFait++;

		System.out.println("Test 8: Sauvegarde Collection");	
		if(test.testSauvegardeCollection())
		{
			testReussis++;
			System.out.println("Reussis!");
			
		}
		else
		{
			System.out.println("Echoue!");
			
		}
		testFait++;

		System.out.println("Test 9: Requetage");	
		if(test.testRequetageObjet())
		{
			testReussis++;
			System.out.println("Reussis!");
			
		}
		else
		{
			System.out.println("Echoue!");
			
		}
		testFait++;

		System.out.println("Test 10: Requetage Dynamique?");	
		if(test.testRequeteDynamique())
		{
			testReussis++;
			System.out.println("Reussis!");
			
		}
		else
		{
			System.out.println("Echoue!");
			
		}
		testFait++;
		
		System.out.println("Test 11: Requetage polymorphe");	
		if(test.testRequetePolymorphes())
		{
			testReussis++;
			System.out.println("Reussis!");
			
		}
		else
		{
			System.out.println("Echoue!");
			
		}
		testFait++;
	
			
		test.terminate();
		
		System.out.println("Ce format a reussis " + testReussis + " sur " + testFait + " tests.");
		
	}
}