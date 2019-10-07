<xsl:stylesheet version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="#all">


<!-- A  TEI list file to HTML file; 
  assumptions:
  - list is the root element
  - there is a list/head element with the title
  - it is a simple item list
-->
  <xsl:template match="/tei:list">
<!--  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" > -->
<html>
    <xsl:comment>NOTE: THIS IS A GENERATED VERSION, AND SIMPLIFIED, THE XML FILE IS THE REAL
      VERSION</xsl:comment>
    <head>
      <title><xsl:value-of select="tei:head"/></title>
<!--            <link href="/godwin.css" media="screen" rel="stylesheet" type="text/css"/> -->
      </head>
      <body>
          <div class="listBibl">
          <h2><xsl:value-of select="tei:head"/></h2>
            <ul>
             <xsl:apply-templates/>
              </ul>
          </div>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="tei:teiHeader | tei:head"/>
      
  <xsl:template match="tei:div | tei:body"><xsl:apply-templates/></xsl:template>
  
  <xsl:template match="tei:ref">
    <a href="{@target}"><xsl:apply-templates/></a>
  </xsl:template>


  <xsl:template match="tei:item">
    <li><xsl:apply-templates/></li>
  </xsl:template>


  <xsl:template match="tei:list">
    <ul><xsl:apply-templates/></ul>
  </xsl:template>
  

<xsl:template match="tei:persName">
<xsl:choose>
<xsl:when test="@ref">
<a href="{@ref}"><xsl:apply-templates/></a>
</xsl:when>
<xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
</xsl:choose>
</xsl:template>


<xsl:template match="tei:seg[@type='label']"><span class="label"><xsl:apply-templates/></span><xsl:text>  </xsl:text>  </xsl:template>

</xsl:stylesheet>
