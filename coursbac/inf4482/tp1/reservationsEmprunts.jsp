<jsp:useBean id="listeEmprunt" class="beans.ListeEmprunt"/>
<jsp:useBean id="listeReservation" class="beans.ListeReservation"/>
<jsp:useBean id="client" class="beans.Client" scope="session"/>
<%@ page import="java.util.*" %>
<%@ page import="beans.*" %>

<HTML>
	<HEAD>
		<TITLE>Emprunts et réservations</TITLE>
	</HEAD>

	<BODY>
		<%@ include file="header.jsp"%>
		<TABLE WIDTH="100%" HEIGHT="100%">
			<TR>
				<TD HEIGHT="100%" WIDTH="252">
					<%@ include file="loginConnu.jsp"%>
				</TD>

				<TD valign="TOP">				
					<H2>Vos emprunts</H2>
					<TABLE border="1">
						<TR>
							<TD>Produit</TD><TD>Date Debut</TD><TD>Date Fin</TD>
						</TR>
							<%
								Vector listeDesEmprunts=listeEmprunt.getListe(client.getNumeroClient());
								Enumeration enum=listeDesEmprunts.elements();
								while(enum.hasMoreElements())
								{
									out.println("<TR>");
									out.println("<TD>");
									Produit p= new Produit();
									Emprunt e=(Emprunt)enum.nextElement(); 
									p.getProduitParId(e.getNumArticle());
									out.println(p.getNom());
									out.println("</TD>");
									out.println("<TD>");
									out.print(e.getDateDebut());
									out.println("</TD>");
									out.println("<TD>");
									out.print(e.getDateFin());
									out.println("</TD>");
									out.println("</TR>");
								}
							%>
					</TABLE>
					
					<BR>
					
					<H2>Vos réservations</H2>
					<TABLE border="1">
						<TR>
							<TD>Produit</TD><TD>Rang (liste d'attente)</TD>
						</TR>
							<%
								Vector listeDesReservations=listeReservation.getListe(client.getNumeroClient());
								enum=listeDesReservations.elements();
								while(enum.hasMoreElements())
								{
									out.println("<TR>");
									out.println("<TD>");
									Reservation r=(Reservation)enum.nextElement();
									Produit p= new Produit();
									p.getProduitParId(r.getNumArticle());
									out.println(p.getNom());
									out.println("</TD>");
									out.println("<TD>");
									out.println(r.getPosition());
									out.println("</TD>");
									out.println("</TR>");
								}
							%>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
	</BODY>
</HTML>
