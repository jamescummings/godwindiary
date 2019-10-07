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
      <title> Texts Godwin Read</title>
<!--      <link href="/godwin.css" media="screen" rel="stylesheet" type="text/css"/> -->
      </head>
      <body>
          <div class="listBibl">
          <h2> Texts Godwin Read</h2>
          <xsl:apply-templates/>
          </div>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="tei:teiHeader"/>
      
  <xsl:template match="tei:TEI| tei:body"><xsl:apply-templates/></xsl:template>
  <xsl:template match="tei:div"><div><xsl:apply-templates/></div></xsl:template>
  <xsl:template match="tei:body/tei:div/tei:head"><h3><xsl:apply-templates/></h3></xsl:template>
  
  <xsl:template match="tei:bibl">
  <div class="bibl" id="{@xml:id}">
<h3><xsl:value-of select="@xml:id"/></h3>
    <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="tei:ref">
    <a href="{@target}"><xsl:apply-templates/></a>
  </xsl:template>
  
  <xsl:template match="tei:ref[parent::tei:seg[@type='reference']]">
    <a href="{@target}"><xsl:value-of select="g:date(.)"/></a>
  </xsl:template>
  
  <xsl:template match="tei:title|tei:author">
    <span class="{name()}"><xsl:apply-templates/></span>
  </xsl:template>
  
  
  <xsl:template match="tei:date">
	  <xsl:text> </xsl:text>  <span class="{name()}" title="{g:date(@when)}"><xsl:apply-templates/></span>
  </xsl:template>
  
  <xsl:template match="tei:lb">
    <br />
  </xsl:template>
  
  
  
  <xsl:template match="tei:seg[@type]" priority="-1">
    <span class="{@type}"><xsl:apply-templates/></span>
  </xsl:template>
  
  
  
  <xsl:template match="tei:hi[@rend]" priority="-1">
    <span class="{@rend}"><xsl:apply-templates/></span>
  </xsl:template>
  
  
  <xsl:template match="tei:hi[@rend='superscript']" priority="100">
    <sup><xsl:apply-templates/></sup>
  </xsl:template>

  <xsl:template match="tei:seg[@type='appearancesInDiary']" priority="100">
	  <h3>Mentions in the Diary</h3>
	  <ul class="appearancesInDiary">
<xsl:for-each select="tei:date"><li><a href="{concat('/diary/', @when,'.html')}">
<xsl:value-of select="g:date(@when)"/></a></li></xsl:for-each>
</ul>

  </xsl:template>
  
<xsl:template match="tei:p"><p><xsl:apply-templates/></p></xsl:template>
  
  
</xsl:stylesheet>
