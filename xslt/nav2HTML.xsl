<xsl:stylesheet version="2.0" 
xmlns="http://www.w3.org/1999/xhtml"
xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:param name="link">Events</xsl:param>
<xsl:variable name="navLink" select="$link"/>

  <!-- A  page of nav -->
  <xsl:template match="/">
    <html>
      <head>
        <title>Godwin Project: <xsl:value-of select="$navLink"/></title>
      </head>
      <body>
<div>
<ul>
<xsl:copy-of select=".//html:li[lower-case(translate(html:a/text(), ' ', ''))=lower-case(translate($navLink, ' ', ''))]"/>
</ul>
</div>
</body>
</html>

</xsl:template>
</xsl:stylesheet>
