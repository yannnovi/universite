<HTML> 
	<TABLE WIDTH="100%" HEIGHT="100%">
		<TR>
			<TD background="pic/sidebar<%= client.getCouleur()%>.jpg" valign="top">
				<FONT color="white"><H3> Bonjour <%=client.getNom()%></H3>
				<HR>
				<a href="panier.jsp"> <FONT color="yellow"> Votre panier</a><BR>
				<a href="reservationsEmprunts.jsp"><FONT color="yellow">Vos emprunts, <BR><FONT color="yellow">vos réservations</a><BR>
				<a href="logout.jsp"><FONT color="yellow">Déconnecter</a><BR>
				<HR>

				<FORM ACTION="changercouleur.jsp" METHOD="POST">
					<SELECT NAME=couleur>
						<OPTION
						<%
							if (client.getCouleur()==1)
							{
								out.print("SELECTED");
							}
						%>
						>BLEU
						<OPTION
						<%
							if (client.getCouleur()==2)
							{
								out.print("SELECTED");
							}
						%>
						>VERT
						<OPTION
						<%
							if (client.getCouleur()==3)
							{
								out.print("SELECTED");
							}
						%>
						>ROUGE
						<OPTION
						<%
							if (client.getCouleur()==4)
							{
								out.print("SELECTED");
							}
						%>
						>NOIR
					</SELECT>

					<INPUT TYPE=submit value="Préference">
				</FORM>
			</TD>
		</TR>
	</TABLE>
</HTML>
