<jsp:useBean id="panier" class="beans.Panier" scope="session"/>
 
<HTML>
	<BODY>
		<%
			panier.retirerDuPanier(Integer.parseInt(request.getParameter("Achat")),Integer.parseInt(request.getParameter("Quantite")));
			String redirectURL = "panier.jsp";
			response.sendRedirect(redirectURL);
		%>
	</BODY>
</HTML>
