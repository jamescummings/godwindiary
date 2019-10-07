<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml"
    exclude-result-prefixes="tei">
<xsl:import href="functions.xsl"/>
 <xsl:output encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" />

     <xsl:template match="/">
         <xsl:for-each select="//tei:ptr">
        <xsl:variable name="img" select="@target"/>
        <xsl:variable name="classmark">Dep. <xsl:value-of select="substring-before($img, '_')"/></xsl:variable>
        <xsl:variable name="folio">
	<xsl:choose>
         <xsl:when test="starts-with(substring-after($img, '_'), '000')"><xsl:value-of select="substring-after($img, '_000')"/></xsl:when>
         <xsl:when test="starts-with(substring-after($img, '_'), '00')"><xsl:value-of select="substring-after($img, '_00')"/></xsl:when>
         <xsl:when test="starts-with(substring-after($img, '_'), '0')"><xsl:value-of select="substring-after($img, '_0')"/></xsl:when>
<xsl:otherwise><xsl:value-of select="substring-after($img, '_')"/></xsl:otherwise>
</xsl:choose>
        </xsl:variable>
        <xsl:variable name="imageName"><xsl:value-of select="$classmark"/>, fol. <xsl:value-of
            select="$folio"/></xsl:variable>
        <xsl:variable name="prev">
            <xsl:value-of select="//tei:ptr[@target=$img]/preceding::tei:ptr[1]/@target"/>
        </xsl:variable>
        <xsl:variable name="next">
            <xsl:value-of select="//tei:ptr[@target=$img]/following::tei:ptr[1]/@target"/>
        </xsl:variable>
             <xsl:result-document href="{concat($img, '.html')}" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><html xmlns="http://www.w3.org/1999/xhtml" xmlns:v=
            "urn:schemas-microsoft-com:vml">
            <head>
                <meta http-equiv="content-type" content=
                    "text/html/xml; charset=utf-8" />
                <title>Godwin: <xsl:value-of select="$imageName"/></title>
                <link href="/godwin.css" media="screen" rel="stylesheet" type="text/css"/>
                
                
                <!--<script src=
                    "http://maps.google.com/maps?file=api&amp;v=2.x&amp;key=ABQIAAAAYkPzlHw33JJvTmXRkBzeShQgKOVxwn0LjiIYFKZkcifnzx7pahR357x1RTLEWA1XZZRUAOT-ctp2jw"
                    type="text/javascript">
                </script>
-->
               <!-- <script src=
                    "http://maps.google.com/maps?file=api&amp;v=2.x&amp;key=ABQIAAAAfVSW5YHNNIOpxzm1mckwdBTC7nHu5nalJD7oj7RUXLEjnDH5cRS6aT5u45tdYxlDzECEiUxsXgSYhw"
                    type="text/javascript">
                </script>
               --> 
                <script type="text/javascript">
                    var godwinFolio = "<xsl:value-of select="$img"/>";
                </script>
                
                <script type="text/javascript" src="/gmap.js"></script>
            </head>
            <body onresize="resizeMapDiv()" onload="load()" onunload="GUnload()">
                <h1><xsl:value-of select="$imageName"/></h1>
                <div class="navigation">
                    <xsl:if test="$prev">
                        <div class="prev">
                        <a href="{concat('/folio/', $prev)}">
                            <img src="{concat('/i/',$prev,'-thumb.jpg')}" alt="Previous Folio"/><br/>Prev.
                        </a></div>
                        </xsl:if>
                    <xsl:if test="$next">
                        <div class="next">
                            <a href="{concat('/folio/', $next)}">
                                <img src="{concat('/i/',$prev,'-thumb.jpg')}" alt="Next Folio"/><br/>Next
                            </a></div>
                    </xsl:if>
                    
                </div>
                <div id="map"></div>
            </body>
        </html>
        </xsl:result-document>
             </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
