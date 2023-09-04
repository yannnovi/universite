<jsp:useBean id="client" class="beans.Client" scope="session"/>
 
<HTML>
	<BODY>
		<%@ include file="header.jsp"%>
		<% 
			boolean charger=false;
			charger=client.chargerClientParCourriel(request.getParameter("Courriel"),request.getParameter("MotDePasse"));
			if (charger)
			{
		%>
				<jsp:useBean id="panier" class="beans.Panier" scope="session"/>
		<%
				client.setLogin(true);
				String redirectURL = "index.jsp";
				response.sendRedirect(redirectURL);
			}
			else
			{
		%>
			<H2>Erreur d'authentification ...<BR>
			mot de passe ou utilisateur invalide.</H2><BR>	
		<%
			} 
		%>
	</BODY>
</HTML>
