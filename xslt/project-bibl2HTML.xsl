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
      <title> Bibliography</title>
<!--      <link href="/godwin.css" media="screen" rel="stylesheet" type="text/css"/> -->

      </head>
      <body>
          <div class="listBibl">
          <h2> Bibliography</h2>

	  <div id="toc">
		  <ul>
			  <li><a href="#BooksandArticles">Books and Articles</a></li>
			  <li><a href="#Archives">Archives</a></li>
		    <li><a href="#NewspapersAndPeriodicals">Newspapers and Periodicals</a></li>
			  <li><a href="#OnlineSources">Online Sources</a></li>
		  </ul>

	  </div>
          <xsl:apply-templates/>
          </div>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="tei:teiHeader"/>

  <xsl:template match="tei:body/tei:div/tei:head"><h3><xsl:apply-templates/>  <a href="#top" class="navArrow" title="Go to Top"><img src="/dataTables/images/sort_asc.png" border="0"/></a></h3></xsl:template>
      
  <xsl:template match="tei:TEI| tei:listBibl| tei:body"><xsl:apply-templates/></xsl:template>
  <xsl:template match="tei:div"><div id="{@xml:id}"><xsl:apply-templates/></div></xsl:template>
  
  <xsl:template match="tei:bibl">
  <p class="bibl">
    <xsl:apply-templates/>
    </p>
  </xsl:template>
  
  <xsl:template match="tei:ref">
    <a href="{@target}"><xsl:apply-templates/></a>
  </xsl:template>
  
  <xsl:template match="tei:ptr">
	  <a href="{@target}"><xsl:value-of select="@target"/></a>
  </xsl:template>

  
  <xsl:template match="tei:title|tei:author">
    <span class="{name()}"><xsl:apply-templates/></span>
  </xsl:template>
  
  <xsl:template match="tei:lb">
    <br />
  </xsl:template>
  
  
  
  <xsl:template match="tei:hi[@rend]">
    <span class="{@rend}"><xsl:apply-templates/></span>
  </xsl:template>
  
  <xsl:template match="tei:hi[@rend='sup']">
    <sup><xsl:apply-templates/></sup>
  </xsl:template>
  <xsl:template match="tei:hi[@rend='superscript']">
    <sup><xsl:apply-templates/></sup>
  </xsl:template>

  
</xsl:stylesheet>
