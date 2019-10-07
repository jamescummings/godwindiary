<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" >
        
    <!-- 
    
    This file to update imageList.xml  with year numbers for each pointer; Run when new diary map has been created because of new pagebreaks added to document.
    
    -->
    <!-- DiaryMap Document -->
    <xsl:variable name="doc" select="document('diaryMap.xml')"/>
 
 <!-- Copy all template -->
    <xsl:template match="@*|node()|comment()|processing-instruction()" priority="-1">
        <xsl:copy><xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/></xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:ptr" xmlns="http://www.tei-c.org/ns/1.0">
     <xsl:variable name="fol" select="@target"/>
    <xsl:variable name="year"><xsl:value-of select="$doc//pb[@n = $fol][1]/ancestor::year[1]/@xml:id[1]"/></xsl:variable>
        <ptr target="{$fol}" n="{$year}"/>
    </xsl:template>
    
</xsl:stylesheet>
