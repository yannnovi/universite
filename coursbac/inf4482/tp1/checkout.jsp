<jsp:useBean id="panier" class="beans.Panier" scope="session"/>
<jsp:useBean id="client" class="beans.Client" scope="session"/>
 
<HTML>
	<HEAD>
		<TITLE>Checkout</TITLE>
	</HEAD>

	<BODY>
		<%@ include file="header.jsp"%>
		<TABLE WIDTH="100%" HEIGHT="100%">
			<TR>
				<TD WIDTH="252">
					<%@ include file="loginConnu.jsp"%>
				</TD>

				<TD valign="top">
					<%
						boolean succes=panier.persisterPanier(client.getNumeroClient());
						if(succes)
						{
							panier.viderPanierAvecCommande();
					%>
							<H2>Merci, votre commande a �t� enregistr�e !</H2><BR>
					<%
						}
						else
						{
					%>
							<H2>D�sol�, nous n'avons pas enregistr� votre commande !</H2><BR>
					<%
						}
					%>
				</TD>
			</TR>
		</TABLE>
	</BODY>
</HTML>
