<jsp:useBean id="client" class="beans.Client" scope="session"/>
 
<HTML>
	<BODY>
		<%@ include file="header.jsp"%>
		<%
			int couleur=1;
			
			if ((request.getParameter("couleur")).equals("BLEU"))
			{
				couleur=1;
			}
			else if ((request.getParameter("couleur")).equals("VERT"))
			{
				couleur=2;
			}
			else if ((request.getParameter("couleur")).equals("ROUGE"))
			{
				couleur=3;
			}
			else
			{
				couleur = 4;
			}
			
			client.setCouleur(couleur);
			client.persisterMiseAJourCouleur();
			String redirectURL = "index.jsp";
			response.sendRedirect(redirectURL);
		%>
	</BODY>
</HTML>
