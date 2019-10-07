<xsl:stylesheet version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
     xmlns:g="http://godwindiaries.bodleian.ox.ac.uk" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:strip-space elements="*"/>
<xsl:import href="functions.xsl"/>

<!--

<ab type="unidentifiedPerson" n="0">
      <persName ref="/people/unidentified/ryan.html">ryan</persName>
	    <date when="1834-07-06"/>
		  <date when="1817-04-15"/>
			<date when="1817-04-20"/>
			      <date when="1817-05-23"/>
				    <date when="1817-09-12"/>
				    </persName></ab>

-->


  <xsl:template match="/">
    <html>
      <head>
	      <title>Unidentified Person Record: "<xsl:value-of select="//tei:persName[1]"/>; William Godwin's Diary</title>
	<link type="text/css" href="/css/godwin-theme/jquery-ui-1.7.2.custom.css" rel="stylesheet" />	
        <link type="text/css" rel="stylesheet" href="/godwin.css"/>
      </head>
      <body>
<xsl:for-each select="//tei:ab[@type='unidentifiedPerson']">
<h1><xsl:apply-templates select="tei:persName[1]"/></h1>

<h3>Appearances In Diary:</h3>
<ul>
<xsl:for-each select="tei:date">
	<xsl:sort select="@when"/>
	<li><a href="{concat('/diary/', tei:date/@when, '.html')}"><xsl:value-of select="g:date(tei:date/@when)"/></a>
		<span class="appearance"><a href="{concat('/diary/', @when, '.html')}" class="appearanceDate"><xsl:value-of select="g:date(@when)"/></a><xsl:text>  </xsl:text><xsl:if test="@type='nah' or @n='venue'">(<xsl:if test="@type='nah'"><span class="notAtHomeN">N</span></xsl:if> <xsl:if test="@n='venue'"><span class="venueV">V</span></xsl:if>) </xsl:if></span></li>
</xsl:for-each>
</ul>

</xsl:for-each>
</body>
</html>

</xsl:template>

<xsl:template match="tei:persName[@ref]">
<a href="{@ref}"><xsl:apply-templates/></a>
</xsl:template>
    
    <xsl:template match="text()"><xsl:value-of select="normalize-space(.)"/>
        
    </xsl:template>
</xsl:stylesheet>
