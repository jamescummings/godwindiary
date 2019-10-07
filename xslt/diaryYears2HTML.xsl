<xsl:stylesheet version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="#all">

<!-- A  TEI file to HTML file-->
  <xsl:template match="/tei:list">
<!--  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" > -->
<html>
    <xsl:comment>NOTE: THIS IS A GENERATED VERSION, AND SIMPLIFIED, THE XML FILE IS THE REAL
      VERSION</xsl:comment>
    <head>
      <title> Diary Years</title>
<!--            <link href="/godwin.css" media="screen" rel="stylesheet" type="text/css"/> -->

      </head>
      <body>
          <div class="listBibl">
          <h2> Diary Years</h2>

<div>
<p>
	<xsl:for-each-group select="//tei:list[@type='diaryYears']/tei:item[not(tei:lable/tei:ref/@target='/diary/.html')]"
		group-by="substring(tei:label, 1, 3)">
		<span class="bold"><xsl:value-of select="concat(current-grouping-key(), '0s: ')"/></span>
	
		<xsl:for-each select="current-group()">
			<a href="{concat('/diary/',tei:label, '.html')}" class="diaryYearsTOC"><xsl:value-of select="tei:label"/></a><xsl:text> </xsl:text>
</xsl:for-each>
<br/>
</xsl:for-each-group>
</p>
</div>
<!--          <xsl:apply-templates/> -->
          </div>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="tei:teiHeader"/>
      
  <xsl:template match="tei:div | tei:body"><xsl:apply-templates/></xsl:template>
  
  <xsl:template match="tei:ref">
    <a href="{@target}"><xsl:apply-templates/></a>
  </xsl:template>

<xsl:template match="tei:list[@type='diaryYears']/tei:item[not(tei:label/tei:ref/@target='/diary/.html')]">
<div id="{concat('g', tei:label)}">
<h3><xsl:apply-templates select="tei:label"/></h3>
<p class="monthList"><xsl:apply-templates select="tei:list[@type='diaryMonths']"/></p>
</div>
</xsl:template>

<xsl:template match="tei:list[@type='diaryMonths']">
<xsl:for-each select="tei:item/tei:ref">
<xsl:variable name="monthNum" select="."/>
 <xsl:variable name="monthName">
         <xsl:choose>
            <xsl:when test="$monthNum=01">January</xsl:when>
            <xsl:when test="$monthNum=02">February</xsl:when>
            <xsl:when test="$monthNum=03">March</xsl:when>
            <xsl:when test="$monthNum=04">April</xsl:when>
            <xsl:when test="$monthNum=05">May</xsl:when>
            <xsl:when test="$monthNum=06">June</xsl:when>
            <xsl:when test="$monthNum=07">July</xsl:when>
            <xsl:when test="$monthNum=08">August</xsl:when>
            <xsl:when test="$monthNum=09">September</xsl:when>
            <xsl:when test="$monthNum=10">October</xsl:when>
            <xsl:when test="$monthNum=11">November</xsl:when>
            <xsl:when test="$monthNum=12">December</xsl:when>
            <xsl:when test="$monthNum='NOT'">Other</xsl:when>
            <xsl:otherwise/>
         </xsl:choose>
      </xsl:variable>
      <a href="{@target}"><xsl:value-of select="$monthName"/></a> <xsl:text> </xsl:text><!--<xsl:choose>
<xsl:when test="position()=last()">.</xsl:when>
<xsl:otherwise>, </xsl:otherwise>
</xsl:choose>
-->
</xsl:for-each>
</xsl:template>


<xsl:template match="tei:persName">
<xsl:choose>
<xsl:when test="@ref">
<a href="{@ref}"><xsl:apply-templates/></a>
</xsl:when>
<xsl:otherwise><xsl:apply-templates/></xsl:otherwise>

</xsl:choose>

</xsl:template>
  
</xsl:stylesheet>
