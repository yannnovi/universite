import java.sql.*;
import org.apache.xerces.dom.*;
import org.apache.xml.serialize.*;
import org.w3c.dom.*;
import java.util.*;
import java.io.*;

public class DomDB {

public static void main(String args[])
{
  try
  {
	Document doc=new DocumentImpl();

	Element produits = doc.createElement("produits");
  	produits.setAttribute("xmi:version", "2.0");
  	produits.setAttribute("xmlns:xmi", "http://www.omg.org/XMI");
  	doc.appendChild(produits);

      Class.forName("oracle.jdbc.driver.OracleDriver");
      Connection con = DriverManager.getConnection("jdbc:oracle:thin:@labunix.uqam.ca:1521:o8db","ca891445","raisinsec");
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery("SELECT * FROM articles");
      while(rs.next())
      {
	Element produit= doc.createElement("produit");
  	produits.appendChild(produit);
	
	Element numarticle=doc.createElement("numero");
	produit.appendChild(numarticle);
	Text numeroText = doc.createTextNode(""+rs.getInt("NumArticle"));
  	numarticle.appendChild(numeroText);

	Element nom=doc.createElement("nom");
        produit.appendChild(nom);
  	Text nomText = doc.createTextNode(rs.getString("Nom"));
        nom.appendChild(nomText);


	Element prix=doc.createElement("prix");
        produit.appendChild(prix);
  	Text prixText = doc.createTextNode(""+rs.getInt("prixunitaire"));
        prix.appendChild(prixText);

  	Element qteDisponible=doc.createElement("qtedisponible");
        produit.appendChild(qteDisponible);
	Text qteText = doc.createTextNode(""+rs.getInt("qtedisponible"));
        qteDisponible.appendChild(qteText);

      }
      con.close();
	OutputFormat format  = new OutputFormat(doc, "UTF-8", true);
  	FileWriter file = new FileWriter("DOMWrite1.xml");
  	XMLSerializer serial = new XMLSerializer(file, format);
  	serial.asDOMSerializer();

        serial.serialize(doc.getDocumentElement());
         file.close();
 }
 catch (Exception e)
 {
	System.out.println(""+e);
 }
}
}
