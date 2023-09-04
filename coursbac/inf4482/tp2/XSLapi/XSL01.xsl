<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/TR/WD-xsl">
	<xsl:template match="/">
		<H2>Tri selon numéro de produit:</H2>
		<TABLE BORDER="1" CELLPADDING="5">
			<THEAD>
				<TH>Numéro</TH>
				<TH>Nom</TH>
				<TH>Prix unitaire</TH>
				<TH>Qte disponible</TH>
			</THEAD>
			
			<xsl:for-each select="produits/produit">
				<xsl:sort select="numero" data-type="number"/>
					<TR align="center">
						<TD>
							<xsl:value-of select="numero"/>
						</TD>
						<TD>
							<xsl:value-of select="nom"/>                
						</TD>
						<TD>
							<xsl:value-of select="prix"/>
						</TD>
						<TD>
							<xsl:value-of select="qtedisponible"/>
						</TD>
					</TR>				
         </xsl:for-each>
      </TABLE>
   </xsl:template>
</xsl:stylesheet>
