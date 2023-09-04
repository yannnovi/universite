package net.homeip.codeyann.exist;

import net.homeip.codeyann.metier.AssociationA;
import net.homeip.codeyann.metier.AssociationB;
import net.homeip.codeyann.metier.AssociationC;
import net.homeip.codeyann.metier.CollectionTest;
import net.homeip.codeyann.metier.HeritageEnfant;
import net.homeip.codeyann.metier.HeritageParent;
import net.homeip.codeyann.metier.TestInterface;

import org.w3c.dom.Document;
import org.xmldb.api.base.Resource;
import org.xmldb.api.base.ResourceIterator;
import org.xmldb.api.base.ResourceSet;
import org.xmldb.api.base.XMLDBException;
import org.xmldb.api.modules.XMLResource;

import com.thoughtworks.xstream.XStream;


public final class TestImplementationExist implements TestInterface 
{
	private XStream xstream;

	public TestImplementationExist() 
	{
        
    }

	public boolean init()
	{
   		xstream = new XStream();
		return true;
	}
	
	
	private boolean persistType(char key, String ressourceId)
	{
		// Java Object to XML
		net.homeip.codeyann.metier.Types typesToAdd = 
			new net.homeip.codeyann.metier.Types(key,(byte)1,(short)2,3,(long)4,(float)5.5,(double)6.6,true);			
		String objAsXmlString = xstream.toXML(typesToAdd);
		
		// Create XMLDocument
		Document doc = ExistUtil.CreateXMLDocument(objAsXmlString);

        // Insert XML Document
		ExistUtil.InsertXMLDocument(doc, ressourceId);

		// Retrieve XML Document
		Document docSaved = ExistUtil.RetrieveXMLDocument(ressourceId);
		String stringObj = ExistUtil.ConvertDocumentToString(docSaved);
		net.homeip.codeyann.metier.Types typesSaved = 
			(net.homeip.codeyann.metier.Types)xstream.fromXML(stringObj);
		
		return typesToAdd.compareTo(typesSaved) == 0;
	}
	
	public boolean testTypeDonneesPersistes()
	{  				
		return persistType('a', "Type_A");
	}
	
	public boolean testRestrictionTypeDonnesPersistes()
	{ 
		return persistType('b', "Type_B");
	}
	
	public boolean testConversionTypeDonneesAutomatique()
	{
		// avec librairie XStream!
		return persistType('c', "Type_C");
	}
	
	public boolean testSauvegardeAssociation()
	{
		// Java Object to XML
		AssociationA assA= new AssociationA(123);
		AssociationB assB= new AssociationB(666);
		AssociationC assC= new AssociationC(777 );
		assA.setAssociationB(assB);
		assA.setAssociationC(assC);	
		String objAsXmlString = xstream.toXML(assA);
		
		// Create XMLDocument
		Document doc = ExistUtil.CreateXMLDocument(objAsXmlString);

        // Insert XML Document
		String resourceId = "Association1";
		ExistUtil.InsertXMLDocument(doc, resourceId);

		// Retrieve XML Document
		Document docSaved = ExistUtil.RetrieveXMLDocument(resourceId);
		String stringObj = ExistUtil.ConvertDocumentToString(docSaved);
		AssociationA associationSaved = (AssociationA)xstream.fromXML(stringObj);
		
		//return assA.getAssociationB().compareTo(associationSaved.getAssociationB()) == 0 &&
		//	assA.getAssociationC().compareTo(associationSaved.getAssociationC()) == 0;
		
		return false; // Add a copy of B and C.
	}
	
	public boolean testSuppression1N()
	{
		String resourceId = "Association1";
		
		// Remove Resource
		ExistUtil.RemoveXMLRessource(resourceId);
		
		// Retrieve XML Document
		Document docSaved = ExistUtil.RetrieveXMLDocument(resourceId);

		//return docSaved == null;
                //supprime une ressource avec tous les objets dans ce document sans distinction.
		return false; //association pas supporté
	}
	
	public boolean testHeritage()
	{
		HeritageEnfant enfant = new HeritageEnfant(132,133);
		String objAsXmlString = xstream.toXML(enfant);
		
		// Create XMLDocument
		Document doc = ExistUtil.CreateXMLDocument(objAsXmlString);

        // Insert XML Document
		String ressourceId = "Heritage1";
		ExistUtil.InsertXMLDocument(doc, ressourceId);	 
		
		// Retrieve XML Document
		Document docSaved = ExistUtil.RetrieveXMLDocument(ressourceId);
		String stringObj = ExistUtil.ConvertDocumentToString(docSaved);
		HeritageParent parentSaved = (HeritageParent)xstream.fromXML(stringObj);
		
		return parentSaved.compareTo(((HeritageParent)enfant)) == 0;
	}
	
	public boolean testPolymorphisme()
	{
		HeritageEnfant enfant = new HeritageEnfant(134,135);
		String objAsXmlString = xstream.toXML((HeritageParent)enfant);
		
		// Create XMLDocument
		Document doc = ExistUtil.CreateXMLDocument(objAsXmlString);

        // Insert XML Document
		String ressourceId = "Polymorphisme1";
		ExistUtil.InsertXMLDocument(doc, ressourceId);	 
		
		// Retrieve XML Document
		Document docSaved = ExistUtil.RetrieveXMLDocument(ressourceId);
		String stringObj = ExistUtil.ConvertDocumentToString(docSaved);
		HeritageParent parentSaved = (HeritageEnfant)xstream.fromXML(stringObj);
		
		return parentSaved.compareTo(enfant) == 0;
	}
	
	public boolean testSauvegardeCollection()
	{
		CollectionTest col = new CollectionTest(136);
		col.initCollection();
		String objAsXmlString = xstream.toXML(col);
		
		// Create XMLDocument
		Document doc = ExistUtil.CreateXMLDocument(objAsXmlString);

        // Insert XML Document
		String ressourceId = "Collection1";
		ExistUtil.InsertXMLDocument(doc, ressourceId);	
		
		// Retrieve XML Document
		Document docSaved = ExistUtil.RetrieveXMLDocument(ressourceId);
		String stringObj = ExistUtil.ConvertDocumentToString(docSaved);
		CollectionTest collectionSaved = (CollectionTest)xstream.fromXML(stringObj);
		
		return col.compareTo(collectionSaved) == 0;
	}
	
	public boolean testRequetageObjet()
	{

		net.homeip.codeyann.metier.Types typesToAdd = 
			new net.homeip.codeyann.metier.Types('a',(byte)1,(short)2,3,(long)4,(float)5.5,(double)6.6,true);			
		
		try
		{
			String query=  "/net.homeip.codeyann.metier.Types[testChar='a']";
			ResourceSet resultSet = ExistUtil.xQuery(query ); //TODO : path

			
			ResourceIterator results = resultSet.getIterator();
	        while (results.hasMoreResources()) 
	        {
	        	XMLResource resource = (XMLResource) results.nextResource();
				
	
	        	net.homeip.codeyann.metier.Types type = 
	        		(net.homeip.codeyann.metier.Types)xstream.fromXML(resource.getContent().toString()); //TODO : it works ????????
	        	
				if(typesToAdd.compareTo(type)==0)
				{
					return true;
				}
	           //TODO compare object
	        }
		}
		catch (XMLDBException xmle)
		{			
			System.out.println("KABOOM = " +xmle );
			
		}
		
		return false;
	}
	
	public boolean testRequeteDynamique()
	{
		
		return testRequetageObjet();
	}
	
	public boolean testRequetePolymorphes()
	{
		HeritageEnfant enfantSauvegarde = new HeritageEnfant(132,133);

		try
		{
			String query=  "/net.homeip.codeyann.metier.HeritageEnfant[index[@defined-in= \"net.homeip.codeyann.metier.HeritageParent\"]=132]";
			ResourceSet resultSet = ExistUtil.xQuery(query ); //TODO : path

			
			ResourceIterator results = resultSet.getIterator();
	        while (results.hasMoreResources()) 
	        {
	        	XMLResource resource = (XMLResource) results.nextResource();
				
	
	        	HeritageEnfant nouveauEnfant =  
	        		(HeritageEnfant)xstream.fromXML(resource.getContent().toString()); //TODO : it works ????????
	        	
				if(enfantSauvegarde.compareTo(nouveauEnfant)==0)
				{
					return true;
				}
	           //TODO compare object
	        }
		}
		catch (XMLDBException xmle)
		{			
			System.out.println("KABOOM = " +xmle );
			
		}

		
		return false;
	}
	
	
	public void terminate()
	{
		ExistUtil.closeDatabase();
	}

}