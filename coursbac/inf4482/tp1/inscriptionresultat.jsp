<jsp:useBean id="client" class="beans.Client" scope="session"/>
  
<HTML>
	<HEAD>
		<TITLE>Inscription - résultat</TITLE>
	</HEAD>

	<BODY>
		<%@ include file="header.jsp"%>
		<%
			if((request.getParameter("motdepasse")).equals(request.getParameter("motdepasseconfirmer")))
			{
		%>
			<jsp:setProperty name="client" property="nom" value="<%=request.getParameter(\"Nom\")%>"/>
			<jsp:setProperty name="client" property="telephone" value="<%=request.getParameter(\"telephone\")%>"/>
			<jsp:setProperty name="client" property="courriel" value="<%=request.getParameter(\"courriel\")%>"/>
			<jsp:setProperty name="client" property="motPasse" value="<%=request.getParameter(\"motdepasse\")%>"/>
			<jsp:setProperty name="client" property="couleur" value="1"/>
		<% 
				if(client.persister())
				{
					client.setLogin(true);
		%>
					<jsp:useBean id="panier" class="beans.Panier" scope="session"/>
					<TABLE HEIGHT="100%" WIDTH="100%">
						<TR>
							<TD WIDTH="252">
								<%@ include file="loginConnu.jsp"%>
							</TD>
						
							<TD valign="TOP">
								<H2>Vous maintenant êtes inscrit.</H2><BR>
							</TD>
						</TR>
					</TABLE>
		<% 
				} 
				else 
				{ 
		%>
					<H2>Erreur: nous n'avons pas complété votre inscription.</H2>
		<%
				}
		%>
		<%
			}
			else
			{
		%>
				<H2>Erreur: votre mot de passe n'a pu être confirmé.</H2><BR>
		<%
			}
		%>
	</BODY>
</HTML>
