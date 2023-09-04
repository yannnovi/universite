<jsp:useBean id="client" class="beans.Client" scope="session"/>
<jsp:useBean id="panier" class="beans.Panier" scope="session"/>
 
<HTML>
	<BODY>
		<%
			panier.viderPanierSansCommande();
			client.setLogin(false);
			session.invalidate();
			String redirectURL = "index.jsp";
			response.sendRedirect(redirectURL);
		%>
	</BODY>
</HTML>
