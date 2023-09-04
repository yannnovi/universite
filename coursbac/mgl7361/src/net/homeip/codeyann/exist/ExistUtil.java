package net.homeip.codeyann.exist;

import java.io.StringReader;
import java.io.StringWriter;

import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xmldb.api.DatabaseManager;
import org.xmldb.api.base.*;
import org.xmldb.api.modules.XMLResource;
import org.xmldb.api.modules.XPathQueryService;

public class ExistUtil 
{		
	private static Database database = null;
	final static String user ="pers";
	final static String pwd ="pers";
	final static String uri ="exist://codeyann.homeip.net:9088/xmlrpc/db/";
	final static String collectionName ="Types";
	
    static 
    {
		try
		{
			if (database == null)
			{
				// initialize database driver
		    	String driver = "org.exist.xmldb.DatabaseImpl";
		   		Class cl = Class.forName(driver);
		   		database = (Database) cl.newInstance();
		   		DatabaseManager.registerDatabase(database);
			}			
		}
		catch (Exception e)
		{
			System.out.println("ERROR: Database initialization.");
			System.out.println("MSG: " + e.getMessage());
		}
    }

    public static Document RetrieveXMLDocument(String ressourceName)
    {
    	Document document = null;
    	
    	try
    	{
	    	Collection collection = database.getCollection(uri+collectionName, user, pwd);
	    	XMLResource resource = (XMLResource) collection.getResource(ressourceName);
	    	
	    	if (resource != null)
	    	{
	    		document = (Document)resource.getContentAsDOM();
	    	}
    	}
		catch(XMLDBException e)
		{
			System.out.println("ERROR: Retrieve Document.");
			System.out.println("MSG: " + e);				
		}
		
		return document;
    }
    
	public static String getURI()
	{
		return uri;
	}
	
	public static String getCollectionName()
	{
		return collectionName;
	}
	
	public static boolean InsertXMLDocument(Document document, String ressourceName)
	{
		if (database == null)
		{
			System.out.println("ERROR: Couldnt insert, initialize the database before.");			
		}		
		else if (document != null)
		{
			try
			{
				Collection collection = database.getCollection(uri+collectionName, user, pwd);
				XMLResource resource = (XMLResource)collection.createResource(ressourceName, XMLResource.RESOURCE_TYPE);
				resource.setContentAsDOM(document);
				collection.storeResource(resource);
				return true;
			}
			catch(XMLDBException e)
			{
				System.out.println("ERROR: Insert Document.");
				System.out.println("MSG: " + e);				
			}
		}
		
		return false;
	}
	
	public static boolean RemoveXMLRessource(String resourceID)
	{
		if (database == null)
		{
			System.out.println("ERROR: Couldnt insert, initialize the database before.");			
		}		
		else
		{
			try
			{
				Collection collection = database.getCollection(uri+collectionName, user, pwd);
				XMLResource resource = (XMLResource)collection.getResource(resourceID);
				collection.removeResource(resource);
				return true;
			}
			catch(XMLDBException e)
			{
				System.out.println("ERROR: Remove Document.");
				System.out.println("MSG: " + e);				
			}
		}
		
		return false;
	}
	
	public static Document CreateXMLDocument(String stringObject)
	{
		Document document = null;
		try
		{
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();       
	        DocumentBuilder builder = factory.newDocumentBuilder();
	        document = builder.parse(new InputSource(new StringReader(stringObject)));	
		}
		catch (Exception e)
		{
			System.out.println("ERROR: XML Document creation.");
			System.out.println("MSG: " + e);			
		}	
		
		return document;
	}
	
	public static String ConvertDocumentToString(Document document)
	{
		try
		{
			DOMSource domSource = new DOMSource(document);
            StringWriter writer = new StringWriter();
            StreamResult result = new StreamResult(writer);
            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            transformer.transform(domSource, result);
            return writer.toString();	
		}
		catch (Exception e)
		{
			System.out.println("ERROR: Convert XML Document to string");
			System.out.println("MSG: " + e);			
		}	
		
		return null;
	}
	
	public static ResourceSet xQuery(String xpath)
	{
		try
		{
			Collection collection = database.getCollection(uri + collectionName, user, pwd);
			XPathQueryService queryService = (XPathQueryService) collection.getService("XPathQueryService","1.0");
			return queryService.query(xpath);				
		}
		catch (Exception e)
		{
			System.out.println("ERROR: Query Failed.");
			System.out.println("MSG: " + e);			
		}	
		
		return null;
	}
	
	public static void closeDatabase()
	{
		if(database != null)
		{
			try
			{
				DatabaseManager.deregisterDatabase(database);
			}
			catch(XMLDBException xmle)
			{
				System.out.println("ERROR: Couldnt unregister the database.");
				System.out.println("MSG: " + xmle.getMessage());				
			}
		}
	}		
}