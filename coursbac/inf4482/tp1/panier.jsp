<jsp:useBean id="panier" class="beans.Panier" scope="session"/>
<jsp:useBean id="client" class="beans.Client" scope="session"/>
<%@ page import="java.util.*" %>
 
<HTML>
	<HEAD>
		<TITLE>Panier</TITLE>
	</HEAD>

	<BODY>
	<%@ include file="header.jsp"%>
		<TABLE WIDTH="100%" HEIGHT="100%">
			<TR>
				<TD WIDTH="252">
					<%@ include file="loginConnu.jsp"%>
				</TD>

				<TD valign="TOP">
					<H2>Votre panier</H2>
					<TABLE border="1">
						<% 
							Vector v=panier.getPanier();
							Enumeration enum=v.elements();

							out.print("<TR>");
							out.print("<TD>Nom</TD><TD>prix</TD><TD>Quantite</TD><TD>Total</TD><TD>Supprimer</TD>");
							out.print("</TR>");
							int somme=0;
							while(enum.hasMoreElements())
							{
								out.print("<TR>");
								beans.Produit p=(beans.Produit)enum.nextElement();
								out.print("<TD>");
								out.print(p.getNom());
								out.print("</TD>");
								out.print("<TD>");
								out.print(""+p.getPrix());
								out.print("</TD>");
								out.print("<TD>");
								out.print(""+p.getQuantiteCommandee());
								out.print("</TD>");
								out.print("<TD>");
								out.print(""+(p.getPrix()*p.getQuantiteCommandee() ));
								somme+=p.getPrix()*p.getQuantiteCommandee();
								out.print("</TD>");
								out.print("<TD>");
								out.print("<FORM ACTION=\"supprimer.jsp\" METHOD=\"POST\"");
								out.print("<INPUT TYPE=\"hidden\" NAME=\"Achat\" VALUE=\""+p.getNumero() +"\">");
								out.print("<INPUT TYPE=\"hidden\" NAME=\"Quantite\" VALUE=\""+ p.getQuantiteCommandee()+"\">");
								out.print(" <INPUT TYPE=\"SUBMIT\" NAME=\"supprimerBouton\" VALUE=\"Supprimer\">");
								out.print("</FORM>");
								out.print("</TD>");
								out.print("</TR>");
							}
						%>
					</TABLE>
					
					<BR>
					Montant total: <%=somme%>
					<BR>
					
					<FORM ACTION="checkout.jsp" METHOD="GET">
						<INPUT TYPE="SUBMIT"
						<%
							if(panier.getNombreProduit()==0)
							{
								out.print(" DISABLED ");
							}		
						%>
							NAME="checkout" VALUE="Commander">
					</FORM>
				</TD>
			</TR>
		</TABLE>
	</BODY>
</HTML>
