<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd tei"
    version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> May 11, 2011</xd:p>
            <xd:p><xd:b>Author:</xd:b> jamesc</xd:p>
            <xd:p>transform bibl.xml into table for display.</xd:p>
        </xd:desc>
    </xd:doc>

<xsl:output encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <xsl:copy><xsl:apply-templates select="node()|comment()|processing-instruction()"/></xsl:copy>
    </xsl:template>
    
    
<!-- copy everything-->
    <xsl:template match="@*|node()|comment()|processing-instruction()" priority="-1">
        <xsl:copy><xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/></xsl:copy>
    </xsl:template>
    
    
    <!-- listBibl -->
    
    <xsl:template match="tei:listBibl">
        <table type="biblTable">
            <head>Texts Godwin Read: Annotated Title List: 1788-1836</head>
	    <row rend="label"><cell>First Mention</cell><cell>Reference</cell><cell>Author</cell><cell>Title</cell><cell>Date</cell><cell>Notes</cell></row>
        <xsl:apply-templates/>    
        </table>
    </xsl:template>
    
    
    <!-- bibl -->
    <xsl:template match="tei:bibl">
        <row>
		<cell n="mention"><date when="{substring-before(substring-after(tei:seg[@type='reference']/tei:ref[1]/@target,'/diary/'), '.html')}"/></cell>
            <cell n="reference"><xsl:value-of select="substring-before(tei:seg[@type='reference'], '(')"/></cell>
            <cell n="author"><xsl:copy-of select="tei:author[1]"/></cell>
	    <cell n="title">
		    <ref target="{concat('/bibl/', @xml:id, '.html')}">
			    <xsl:variable name="string" select="tei:title[1]"/>
			    <xsl:variable name="stringLen" select="string-length($string)"/>
			    <xsl:choose>
				    <xsl:when test="$stringLen &gt; 100"><xsl:value-of select="substring($string, 1, 100)"/>…</xsl:when>
				    <xsl:otherwise><xsl:value-of select="$string"/></xsl:otherwise>
				    </xsl:choose>
			    </ref></cell>
            <cell n="date"><xsl:value-of select="tei:date[1]"/></cell>
	    <cell n="notes">
		    <ref target="{concat('/bibl/', @xml:id, '.html')}">
			    <xsl:variable name="content"><xsl:apply-templates/></xsl:variable> 
			    <xsl:variable name="string" select="normalize-space($content)"/>
			    <xsl:variable name="stringLen" select="string-length($string)"/>
			    <xsl:choose>
				    <xsl:when test="$stringLen &gt; 50"><xsl:value-of select="substring($string, 1, 50)"/>…</xsl:when>
				    <xsl:otherwise><xsl:value-of select="$string"/></xsl:otherwise>
				    </xsl:choose>
			    </ref></cell>
</row>
    </xsl:template>
    
    <xsl:template match="tei:bibl/tei:seg[@type='reference']"/>
    <xsl:template match="tei:bibl/tei:author[1]"/>
    <xsl:template match="tei:bibl/tei:title[1]"/>
    <xsl:template match="tei:bibl/tei:date[1]" priority="5"/>
    <xsl:template match="tei:bibl//tei:date" priority="1"><xsl:apply-templates/></xsl:template>
    
</xsl:stylesheet>
