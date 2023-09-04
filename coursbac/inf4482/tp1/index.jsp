<jsp:useBean id="liste" class="beans.ListeProduits"/>
<jsp:useBean id="client" class="beans.Client" scope="session"/>
<%@ page import="java.util.*" %>
<%@ page import="beans.*" %>
 
<HTML>
	<HEAD>
		<TITLE> Chez Eric et Yann</TITLE>
	</HEAD>
	
	<BODY>
		<%@ include file="header.jsp"%>
		<TABLE WIDTH="100%" HEIGHT="100%">
			<TR>
				<TD valign="top" WIDTH="252">
					<%
						if(client.getLogin())
						{
					%>
							<TOP><%@ include file="loginConnu.jsp"%></TOP>
					<%
						}
						else 
						{ 
					%>
							<%@ include file="loginInconnu.html"%>
					<%
						}
					%>
				</TD>

				<TD valign="TOP">
					<H2>Catalogue</H2>

					<%
						Vector l=liste.getListe();

						Enumeration enum=l.elements();
						Produit p;

						out.println("<TABLE border=\"1\">");
						out.println("<TR><TD>Nom</TD>");
						out.println("<TD>Prix</TD>");
						out.println("<TD>Qte en stock</TD>");
						out.println("<TD>Qte à acheter</TD>");
						out.println("<TD>Emprunter</TD></TR>");

						while(enum.hasMoreElements())
						{
							p=(Produit) enum.nextElement();
							out.println("<TR>");
							String idArticle=""+p.getNumero();
							String nomArticle=p.getNom();
							String prix=""+p.getPrix();
							String quantiteDisponible=""+p.getQuantiteDisponible();
							out.println("<TD>"+nomArticle+ "</TD>");
							out.println("<TD>"+prix+ "</TD>");
							out.println("<TD>"+quantiteDisponible+ "</TD>");
							out.println("<TD align=\"center\">");
							out.println("<FORM NAME=\"acheter"+idArticle+"\" ACTION=\"acheter.jsp\" METHOD=\"POST\"");
							out.println("<INPUT TYPE=\"hidden\" NAME=\"Achat\" VALUE=\""+idArticle +"\">");
							out.println("<INPUT TYPE=\"TEXT\" NAME=\"Quantite\" MAXLENGTH=\"2\" size=\"3\"> ");
							out.println(" <INPUT TYPE=\"SUBMIT\" NAME=\"Achatbouton\" VALUE=\"Acheter\">");
							out.println("<INPUT TYPE=\"hidden\" NAME=\"Achat\" VALUE=\""+idArticle +"\">");
							out.println("</FORM>");
							out.println("</TD>");
							out.println("<TD>");
							out.println("<FORM ACTION=\"emprunter.jsp\" METHOD=\"POST\"");
							out.println("<INPUT TYPE=\"hidden\" NAME=\"article\" VALUE=\""+idArticle +"\">");
							out.println(" <INPUT TYPE=\"SUBMIT\" NAME=\"emprunterbouton\" VALUE=\"Emprunter\">");
							out.println("</FORM>");
							out.println("</TD>");
							out.println("</TR>");
						}

						out.print("</TABLE>");
					%>
				</TD>
			</TR>
		</TABLE>
	</BODY>
</HTML>
