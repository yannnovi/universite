<jsp:useBean id="client" class="beans.Client" scope="session"/>
<jsp:useBean id="panier" class="beans.Panier" scope="session"/>
<jsp:useBean id="produit" class="beans.Produit" />
 
<HTML>
	<HEAD>
		<TITLE>Acheter</TITLE>
	</HEAD>

	<BODY>
		<%@ include file="header.jsp"%>

		<% 
			try
			{
				if (client.getLogin())
				{
					String parm=request.getParameter("Achat");
					if(parm !=null)
					{
						boolean charger=produit.getProduitParId(Integer.parseInt(parm));
						if(charger)
						{
							String parmQuantite=request.getParameter("Quantite");
							if(parmQuantite != null && !parmQuantite.equals("") )
							{
								int quantite=Integer.parseInt(parmQuantite);
								if(quantite >0)
								{
									produit.setQuantiteCommandee(quantite);
									boolean ajouter=panier.ajouterAuPanier(produit);
										if(ajouter==false)
										{
											%><H2>Erreur: nous n'avons pas ajout� l'article � votre panier, la quantit� en stock est insuffisante.</H2><%
										}
										else
										{
											String redirectURL = "index.jsp";
        										response.sendRedirect(redirectURL);
										}
								}
								else
								{
									out.println("<H2>Erreur: vous devez entrer une quantit� positive.</H2>"); 
								}	
							}
							else
							{
									out.println("<H2>Erreur: vous devez entrer une quantit� � acheter pour le produit s�lectionn�.</H2>"); 
							}
						}
						else
						{
							%><H2>Erreur: nous n'avons pas trouv� l'article que vous voulez acheter.</H2><%
						}
					}
					else
					{
						out.println("<H2>Erreur: le param�tre \"Achat\" est inexistant</H2>");
					}
				}
				else
				{
					String redirectURL = "login2.jsp";
					response.sendRedirect(redirectURL);
				}
			}
			catch(NumberFormatException e)
			{
				out.println("<H2>Erreur: le caract�re entr� pour la quantit� � acheter est invalide.</H2>");
			}
			catch(Exception e)
			{
					out.println("Erreur:"+e);
			}
		%>
	</BODY>
</HTML>
