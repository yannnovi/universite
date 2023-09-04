<jsp:useBean id="client" class="beans.Client" scope="session"/>
 
<HTML>
	<BODY>
		<%@ include file="header.jsp"%>
		<TABLE height="100%">
			<TR>
				<TD>
					<%@ include file="loginInconnu.html"%>
				</TD>
				<TD valign="TOP">
					<H2>Vous n'êtes pas connecté ...</H2>
				</TD>
			</TR>
		</TABLE>
	</BODY>
</HTML>
