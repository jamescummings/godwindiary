<xsl:stylesheet version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.w3.org/1999/xhtml"
     xmlns:g="http://godwindiaries.bodleian.ox.ac.uk" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding="utf-8"/>
<xsl:import href="functions.xsl"/>

<!-- A  TEI file to HTML file-->
  <xsl:template match="/">
<!--  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" >-->
<html>
    <xsl:comment>NOTE: THIS IS A GENERATED VERSION, AND SIMPLIFIED, THE XML FILE IS THE REAL
      VERSION</xsl:comment>
    <head>
      <title> Events </title>
<!--      <link href="/godwin.css" media="screen" rel="stylesheet" type="text/css"/> -->
      </head>
      <body>
          <div class="listEvent">
          <h2> Events</h2>
          <xsl:apply-templates/>
          </div>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="tei:teiHeader"/>
      
  <xsl:template match="tei:TEI| tei:div | tei:body"><xsl:apply-templates/></xsl:template>
  
  <xsl:template match="tei:event">
  <div class="event" id="{@xml:id}">
<!-- <h3><xsl:value-of select="@xml:id"/></h3> -->
    <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="tei:ref">
    <a href="{@target}"><xsl:apply-templates/></a>
  </xsl:template>
  
  <xsl:template match="tei:p">
    <p><xsl:apply-templates/></p>
  </xsl:template>
  
  <xsl:template match="tei:event/tei:ab/tei:label[1]">
    <h3><xsl:apply-templates/></h3>
  </xsl:template>
  
  <xsl:template match="tei:event/tei:ab/tei:placeName[1]">
    <h3><xsl:apply-templates/></h3>
  </xsl:template>
  
  <xsl:template match="tei:title|tei:author">
    <span class="{name()}"><xsl:apply-templates/></span>
  </xsl:template>
  
  
  <xsl:template match="tei:date">
    <span class="{name()}" title="{g:date(@when)}"><xsl:apply-templates/></span>
  </xsl:template>
  
  <xsl:template match="tei:lb">
    <br />
  </xsl:template>
  
  
  
  <xsl:template match="tei:seg[@type]">
    <span class="{@type}"><xsl:apply-templates/></span>
  </xsl:template>
  
  
  
  <xsl:template match="tei:hi[@rend]">
    <span class="{@rend}"><xsl:apply-templates/></span>
  </xsl:template>
  
  
  <xsl:template match="tei:hi[@rend='superscript']">
    <sup><xsl:apply-templates/></sup>
  </xsl:template>

<xsl:template match="tei:persName[@key]">
   <xsl:variable name="ref">
<xsl:choose>
<xsl:when test="contains(@key, ' ')">
<xsl:value-of select="translate(normalize-space(@key), ' ', '|')"/>
</xsl:when>
<xsl:otherwise><xsl:value-of select="normalize-space(@key)"/></xsl:otherwise>
</xsl:choose>
</xsl:variable>
        <a href="{concat('/people/', $ref, '.html')}"><xsl:apply-templates/></a>
</xsl:template>
  
  
  
</xsl:stylesheet>
