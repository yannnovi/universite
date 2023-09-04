<jsp:useBean id="produit" class="beans.Produit" />
<jsp:useBean id="client" class="beans.Client" scope="session"/>
<%@ page import= "java.sql.*" %>
 
<HTML>
	<HEAD>
		<TITLE>Emprunter</TITLE>
	</HEAD>

	<BODY>
		<%@ include file="header.jsp"%>
		
		<TABLE WIDTH="100%" HEIGHT="100%">
			<TR>
				<TD WIDTH="252">
					<%@ include file="loginConnu.jsp"%>
				</TD>
				
				<TD valign="TOP">
					<%
						if (client.getLogin())
						{
							boolean charger=produit.getProduitParId(Integer.parseInt(request.getParameter("article")));
							if(charger)
							{ 
								try
								{
									Class.forName("oracle.jdbc.driver.OracleDriver");
									Connection con = DriverManager.getConnection("jdbc:oracle:thin:@labunix.uqam.ca:1521:o8db","gc591821","raisinsec");
									Statement stmt = con.createStatement();
									if(produit.getQuantiteDisponible()>0)
									{
                      					String miseAJour="UPDATE articles SET qtedisponible = qtedisponible - 1  WHERE numarticle = "+produit.getNumero();
                      					int retour=stmt.executeUpdate(miseAJour);
	              						String insertion="INSERT INTO ARTICLEPRET VALUES("+client.getNumeroClient()+","+produit.getNumero()+",SYSDATE,SYSDATE + 14)";
                      					retour=stmt.executeUpdate(insertion);
										out.println("<H2>Votre emprunt a été enregistré.</H2>");
									}	
									else
									{
										String chercherPosition="SELECT max(position) as position from articlereservation WHERE numarticle = "+produit.getNumero();
										ResultSet rs=stmt.executeQuery(chercherPosition);
										int position=0;
										if(rs.next())
										{
											position=rs.getInt("position")+1;
										}
										String insertion="INSERT INTO ARTICLERESERVATION VALUES("+client.getNumeroClient()+","+produit.getNumero()+","+position+")";
                      					int retour=stmt.executeUpdate(insertion);
										out.println("<H2>Votre réservation a été enregistrée.</H2>");
									}
									con.close();
								}
								catch(Exception e)
								{
									out.println("<H2>Erreur: nous n'avons pas trouvé l'article que vous voulez emprunter.</H2>");
								}

							}
							else
							{
								out.println("<H2>Erreur: nous n'avons pas ajouté l'article à vos emprunts.</H2>");
							}
						}
						else
						{
							String redirectURL = "login2.jsp";
							response.sendRedirect(redirectURL);
						}
					%>
				</TD>
			</TR>
		</TABLE>
	</BODY>
</HTML>
