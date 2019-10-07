<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml"
    exclude-result-prefixes="tei">
<xsl:import href="functions.xsl"/>
 <xsl:output method="html"  encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"  />

    <xsl:param name="image">e.196_0004r</xsl:param>
    <xsl:variable name="img" select="$image"/>
    <xsl:variable name="classmark">Dep. <xsl:value-of select="substring-before($img, '_')"/></xsl:variable>
    <xsl:variable name="folio-old">
        <xsl:value-of select="translate(substring-after($img, '_'), '0','')"/>
    </xsl:variable>
    <xsl:variable name="imageName"><xsl:value-of select="$classmark"/>, fol. <xsl:value-of
    select="$folio"/></xsl:variable>
    
    <xsl:variable name="folio">
        <xsl:call-template name="removeLeadingZeros">
            <xsl:with-param name="string">
                <xsl:value-of select="substring-after($img, '_')"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:template name="removeLeadingZeros">
        <xsl:param name="string"/>
        <xsl:choose>
            <xsl:when test="starts-with($string,'0')">
                <xsl:call-template name="removeLeadingZeros">
                    <xsl:with-param name="string">
                        <xsl:value-of select="substring-after($string,'0' )"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$string"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
    <xsl:variable name="prev">
        <xsl:value-of select="//tei:ptr[@target=$img]/preceding::tei:ptr[1]/@target"/>
    </xsl:variable>
    <xsl:variable name="next">
        <xsl:value-of select="//tei:ptr[@target=$img]/following::tei:ptr[1]/@target"/>
    </xsl:variable>
    <xsl:variable name="nextVol">
        <xsl:value-of select="//tei:ptr[@target=$img]/following::tei:list[1]/tei:item[1]/tei:ptr[1]/@target"/>
    </xsl:variable>
    <xsl:variable name="prevVol">
        <xsl:value-of select="//tei:ptr[@target=$img]/preceding::tei:list[1]/tei:item[1]/tei:ptr[1]/@target"/>
    </xsl:variable>

    <xsl:variable name="current" select="//tei:ptr[@target=$img][1]"/>
	    <xsl:variable name="diaryLink">
	<xsl:choose>
	<xsl:when test="not($current/@n ='') and not(contains($current/@n, ' '))"><a href="{concat('/diary/', substring-after($current/@n, 'g'), '.html#', $img)}">Diary Text</a></xsl:when>
	<xsl:otherwise><xsl:comment>No diary link available for this image.</xsl:comment>No Diary Link</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>

    <xsl:template match="/">
        <html xmlns:v="urn:schemas-microsoft-com:vml" xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                <title><xsl:value-of select="$imageName"/></title>
                <link href="/godwin.css" media="screen" rel="stylesheet" type="text/css" /><style type="text/css">
                 /**/
                    v\:* {
                    behavior:url(#default#VML);
                    }
                    /**/
                </style>
                <script type="text/javascript">
                    var godwinFolio = "<xsl:value-of select="$img"/>";
                </script>
                <script src="http://maps.google.com/maps?file=api&amp;v=2.x&amp;key=ABQIAAAAYkPzlHw33JJvTmXRkBzeShQgKOVxwn0LjiIYFKZkcifnzx7pahR357x1RTLEWA1XZZRUAOT-ctp2jw"
                    type="text/javascript"></script>
                <!--<script src="http://maps.google.com/maps?file=api&amp;v=2.x&amp;key=ABQIAAAAfVSW5YHNNIOpxzm1mckwdBTArAjUt0qwVJizevcH1xrUXdEbqBQgiUzbheXXwCs1YvPjdyi2DYqpQg"
                    type="text/javascript"></script>-->
                <script type="text/javascript">
                    var godwinFolio = "<xsl:value-of select="$img"/>";
                </script>
                <script type="text/javascript" src="/gmap.js">
                        
                        //test
                    </script>  </head>
            <body onresize="resizeMapDiv()" onload="load()" onunload="GUnload()">
                <h1><xsl:value-of select="$imageName"/></h1>
		<h2 class="center small"><xsl:value-of select="$img"/></h2>
		<div class="imageListNav"><a href="/folio/">Image List</a> -- <a href="{concat('/folioimages/', $img, '.jpg')}">Full Image</a>
			--  
			<xsl:copy-of select="$diaryLink"/>
	
		</div>
                <div class="navigation">
                    
                    <div class="prev">
                        <xsl:if test="$prev">
                        <a href="/folio/{$prev}"><img src="/i/{$prev}-thumb.jpg" alt="Previous Folio" /><br />Prev. Fol.
                    </a>
                    <xsl:if test="$prevVol">
                            <div class="prevVol"><a href="/folio/{$prevVol}"><img src="/i/{$prevVol}-thumb.jpg" alt="Previous Volume" /><br />Prev. Vol.
                            </a></div>
                            </xsl:if>
                    
                    </xsl:if>
                    <div class="volumeList">
                        <h4>Volume List:</h4>
                        <p> Jump to: 
                            <xsl:for-each select="/tei:TEI/tei:text/tei:body/tei:div[tei:list/tei:item/tei:ptr]">
                                <xsl:variable name="volume"><xsl:value-of select="concat('e.', substring-after(tei:head, 'e.'))"/></xsl:variable>
                                <xsl:variable name="volumeLink"><xsl:value-of select="concat('/folio/', tei:list[1]/tei:item[1]/tei:ptr/@target)"/></xsl:variable>
                                <a href="{$volumeLink}"><xsl:value-of select="$volume"/></a><xsl:call-template name="punctuate-list"/>    
                             </xsl:for-each>
                            </p>
                    </div>
                    </div>
                </div>
                
                    
                    <!--<div class="imageDropList">
                        <form method="post">
                        <select id="imageDropList" onchange="onmouseup=&quot;location=''+this.options[this.selectedIndex].value;&quot;">
                            <option value="http://www.test.com/test.html"><a href="/folio/">test</a></option>
                            <option onclick="http://www.example.com/test.html"><a href="/folio/">test2</a></option>
                            <option><a href="http://godwin.oucs.ox.ac.uk/folio/">test3</a></option>
                        </select>
                            </form>
                            </div>-->
                    
                    
                <div class="navigation">    
                    <xsl:if test="$next">
                    <div class="next"><a href="/folio/{$next}"><img src="/i/{$next}-thumb.jpg" alt="Next Folio" /><br />Next Fol.
                    </a>
                        
                        <xsl:if test="$nextVol">
                            <div class="nextVol"><a href="/folio/{$nextVol}"><img src="/i/{$nextVol}-thumb.jpg" alt="Next Volume" /><br />Next Vol.
                            </a></div>
                        </xsl:if>
                    </div>
                    </xsl:if>
                </div>
                <div id="map"></div>
                
                <div class="navigation">
                    
                </div>
            </body>
        </html>  
    </xsl:template>
    
    
    <xsl:template name="punctuate-list">
        <xsl:choose>
            <xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when> 
            <xsl:when test="position()=last()-1"><xsl:text>, and </xsl:text></xsl:when>
            <xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
</xsl:stylesheet>

    
