<jsp:useBean id="client" class="beans.Client" scope="session"/>
 
<HTML>
	<HEAD>
		<TITLE>Inscription</TITLE>
	</HEAD>

	<BODY>
		<%@ include file="header.jsp"%>
		<H2>Inscription</H2>
		
		<TABLE>
			<FORM ACTION="inscriptionresultat.jsp" METHOD="POST">
				<TR>
					<TD>
						Nom:
					</TD>
					
					<TD>
						<INPUT TYPE="TEXT" name="Nom"><BR>
					</TD>
				</TR>

				<TR>
					<TD>
						Mot de passe: 
					</TD>
					
					<TD>
						<INPUT TYPE="PASSWORD" name="motdepasse"><BR>
					</TD>
				</TR>
				
				<TR>
					<TD>
						Confirmer mot de passe:
					</TD>

					<TD>
						<INPUT TYPE="PASSWORD" name="motdepasseconfirmer"><BR>
					</TD>
				</TR>

				<TR>
					<TD>
						Courriel :
					</TD>

					<TD>
						<INPUT TYPE="TEXT" name="courriel" value="<%=request.getParameter("Courriel")%>"><BR>
					</TD>
				</TR>

				<TR>
					<TD>
						Telephone:
					</TD>

					<TD>
						<INPUT TYPE="TEXT" name="telephone" ><BR>
					</TD>
				</TR>
			</TABLE>
			<INPUT TYPE="SUBMIT" NAME="Inscrire" VALUE="Inscrire">
		</FORM>
	</BODY>
</HTML>
