<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns:g="http://godwin.oucs.ox.ac.uk"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="tei xsl g"
    version="2.0"
    >
<xsl:import href="functions.xsl"/>
    
    <xsl:output method="text" encoding="utf-8" />
    
 <xsl:variable name="apos">'</xsl:variable>
 <xsl:variable name="divider">&#x007c;</xsl:variable>

 
 <xsl:template match="//tei:div[@type]">
 {  
properties: {
        "participants" : {
        valueType: "item" },
        "label" : {
        valueType: "date" },
        "numParticipants" : {
        valueType: "number" }
	},
"items" : [
<xsl:variable name="allparts">
<xsl:for-each select="//tei:persName">
<xsl:sort select="@ref"/>
<xsl:variable name="currentContent" select="."/>
<xsl:choose>
	<xsl:when test="contains(substring-after(substring-before(@ref, '.html'), '/people/'), $divider) and not(contains(@ref, concat($divider, $divider)))">
		<xsl:variable name="refStripped" select="substring-after(substring-before(normalize-space(@ref), '.html'), 'people/')"/> 
		<xsl:for-each select="tokenize($refStripped, '\|')">
			<persName xmlns="http://www.tei-c.org/ns/1.0" ref="{concat('/people/',.,'.html')}"><xsl:value-of select="$currentContent"/></persName>
</xsl:for-each>
	</xsl:when>
	<xsl:when test="not(@ref)">
		<xsl:variable name="fakeRef" select="lower-case(replace(normalize-space(.), '[&amp;,\(\)\[\] ]+', '_'))"/>
		<persName xmlns="http://www.tei-c.org/ns/1.0" ref="{$fakeRef}" type="unidentified"><xsl:value-of select="$currentContent"/></persName>
	</xsl:when>
<xsl:otherwise>
<xsl:copy-of select="."/>
</xsl:otherwise>
</xsl:choose>
</xsl:for-each></xsl:variable>

<xsl:variable name="uniqueParts"><xsl:for-each select="$allparts//tei:persName">
<xsl:sort select="@ref"/>
<xsl:variable name="ref" select="@ref"/>
<xsl:if test="not(preceding-sibling::tei:persName/@ref=$ref)">
<xsl:copy-of select="."/>
</xsl:if>
</xsl:for-each>
</xsl:variable>
<xsl:for-each select="$uniqueParts//tei:persName">
<xsl:variable name="pid">
	<xsl:choose>
		<xsl:when test="@type='unidentified'"><xsl:value-of select="@ref"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="substring-after(substring-before(@ref[1], '.html'), '/people/')"/></xsl:otherwise>
	</xsl:choose>
</xsl:variable> 
<xsl:variable name="url" select="concat('http://godwindiary.bodleian.ox.ac.uk/get-persName.xq?id=',$pid)"/>
<!-- <xsl:variable name="url" select="concat('http://godwin.oucs.ox.ac.uk:8081/get-persName.xq?id=',$pid)"/> -->
<!--<xsl:variable name="url" select="concat('http://silva.domus.cummingsfamily.org.uk/get-persName.xq?id=',$pid)"/> -->
<xsl:variable name="renderedName">
	<xsl:choose>
		<xsl:when test="@type='unidentified'"> <xsl:value-of select="replace(normalize-space(.),'&#34;', '')"/>*</xsl:when>
		<xsl:otherwise>
<xsl:variable name="persName" select="document($url)"/>
<xsl:value-of select="$persName//tei:ab[@type='shortName']"/></xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="URI">
	<xsl:choose>
		<xsl:when test="@type='unidentified'"><xsl:value-of select="concat('http://godwindiary.bodleian.ox.ac.uk/people/unidentified/', $pid, '.html')"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="concat('http://godwindiary.bodleian.ox.ac.uk/person/', $pid, '.html')"/></xsl:otherwise>
</xsl:choose>
</xsl:variable>
{ "type":"participants",
"id":"<xsl:value-of select="$pid"/>",
"label":"<xsl:copy-of select="$renderedName"/>",
"URI":"<xsl:value-of select="$URI"/>"
}, </xsl:for-each>
{"type":"participants",
"id":"GOD00",
"URI":"http://godwindiary.bodleian.ox.ac.uk/person/GOD00.html",
"label":"William Godwin"},
{ "type":"participants",
"id":"Unknown",
"label":"Unknown"
},
{ "type":"participants",
"id":"UnCoded",
"label":"UnCoded"
},
        <xsl:apply-templates select="tei:list"/>
]
}
    </xsl:template>
    
    <xsl:template match="//tei:div/tei:list">
        <xsl:variable name="num"><xsl:number/></xsl:variable>
	<xsl:variable name="date"><xsl:value-of select="normalize-space(tei:item[@n='date'])"/></xsl:variable>
  {
  "label":"<xsl:value-of select="$date"/>",
  "type": "<xsl:value-of select="substring(@type,2)"/>",
  "id": "<xsl:value-of select="generate-id()"/>",
  <xsl:apply-templates select="tei:item[not(@n='id')]"/>
  }<xsl:call-template name="punctuate-list"/>
    </xsl:template>

    <xsl:template match="tei:item[@n='numParticipants']">
	   <!-- <xsl:variable name="num">|
		    <xsl:for-each select="../tei:item[n='meetingCopy']//tei:persName">
			    <xsl:choose>
				    <xsl:when test=".[@ref][not(parent::tei:seg/@type='dTopic')]">|<xsl:value-of select="@ref"/></xsl:when>
				    <xsl:otherwise>|<xsl:value-of select="."/></xsl:otherwise>
			    </xsl:choose>
		    </xsl:for-each>
	    </xsl:variable>-->
    	<!--<xsl:variable name="countNum"><xsl:value-of select="count(tokenize($num, '|'))"/></xsl:variable>-->
     "numParticipants":"<xsl:value-of select="number(.)"/>",
    </xsl:template>
    
    
    
    <xsl:template match="//tei:div/tei:list/tei:item[not(@n='participants')]" priority="-10">
     "<xsl:value-of select="@n"/>": "<xsl:value-of select="translate(., $apos, '')"/>"<xsl:call-template name="punctuate-list"/><xsl:text>
</xsl:text>
    </xsl:template>
        
        
 <xsl:template match="tei:item[@n='venue']">
  "<xsl:value-of select="@n"/>":      "<xsl:choose>
	  <xsl:when test="tei:persName[tei:placeName/@type='venue'][1]/@ref">
		  <xsl:choose>
			  <xsl:when test="contains(@ref, '&#x007c;')">
				  <xsl:variable name="refStripped" select="substring-after(substring-before(@ref, '.html'), 'people/')"/><xsl:value-of select="substring-before($refStripped, '&#x007c;')"/>", "<xsl:value-of select="substring-after($refStripped, '&#x007c;')"/></xsl:when>
			  <xsl:otherwise>
		  <xsl:value-of select="substring-after(substring-before(tei:persName[tei:placeName/@type='venue'][1]/@ref, '.html'), 'people/')"/>
			  </xsl:otherwise>
		  </xsl:choose>
	  </xsl:when>
	  <xsl:when test="tei:persName[tei:placeName/@type='venue'][not(@ref)]"><xsl:value-of select="lower-case(replace(normalize-space(.), '[&amp;,\(\)\[\] ]+', '_'))"/></xsl:when>
	  <!--	  <xsl:when test="tei:persName[tei:placeName/@type='venue'][not(@ref)]"><xsl:value-of select="tei:persName[tei:placeName/@type='venue'][not(@ref]"/></xsl:when> -->
	  <xsl:otherwise>Unknown</xsl:otherwise>
  </xsl:choose>"<!--<xsl:call-template name="punctuate-list"/>-->
  <xsl:text>
  </xsl:text>
 </xsl:template>
        
    
 <xsl:template match="//tei:div/tei:list/tei:item[@n='participants']">
	 <!--participants: [<xsl:apply-templates select="tei:persName"/>]<xsl:call-template name="punctuate-list"/><xsl:text> -->
"participants":	[ <xsl:apply-templates select="tei:persName"/>, "GOD00"],
 </xsl:template>
 
    
    
    <xsl:template match="tei:persName">
	    <xsl:variable name="id"><xsl:choose>
			    <xsl:when test="@ref">
				    <xsl:choose>
					    <xsl:when test="contains(@ref, '&#x007c;')">
						       <xsl:variable name="refStripped" select="substring-after(substring-before(@ref, '.html'), 'people/')"/><xsl:value-of select="substring-before($refStripped, '&#x007c;')"/>", "<xsl:value-of select="substring-after($refStripped, '&#x007c;')"/></xsl:when> 
			<xsl:otherwise><xsl:value-of select="substring-after(substring-before(@ref, '.html'), 'people/')"/></xsl:otherwise>
			    </xsl:choose></xsl:when>
			    <xsl:otherwise><xsl:value-of select="lower-case(replace(normalize-space(.), '[&amp;,\(\)\[\] ]+', '_'))"/></xsl:otherwise>
     </xsl:choose></xsl:variable>
     "<xsl:value-of select="$id"/>"<xsl:call-template name="punctuate-list"/>
    </xsl:template>
    
    
    <xsl:template match="//tei:div/tei:list/tei:item/tei:list/tei:item">
   "<xsl:apply-templates/>"<xsl:call-template name="punctuate-list"/>
    </xsl:template>
    
    
    <xsl:template match="tei:item[@n='meetingCopy']"/>

    <xsl:template match="tei:item[@n='subtype']">
	    <xsl:variable name="subtype" select="lower-case(normalize-space(.))"/>
	    <xsl:text>"subtype": "</xsl:text><xsl:choose>
		    <xsl:when test="$subtype='b'">Breakfasts</xsl:when>
		    <xsl:when test="$subtype='bg'">Breakfasts At Godwin's</xsl:when>
		    <xsl:when test="$subtype='d'">Dines</xsl:when>
		    <xsl:when test="$subtype='dg'">Dines At Godwin's</xsl:when>
		    <xsl:when test="$subtype='s'">Sups</xsl:when>
		    <xsl:when test="$subtype='sg'">Sups At Godwin's</xsl:when>
		    <xsl:when test="$subtype='ta'">Tea</xsl:when>
		    <xsl:when test="$subtype='tg'">Tea At Godwin's</xsl:when>
		    <xsl:when test="$subtype='adv'">Adveni</xsl:when>
		    <xsl:when test="$subtype='apres'">Après</xsl:when>
		    <xsl:when test="$subtype='apresg'">Après At Godwin's</xsl:when>
		    <xsl:when test="$subtype='aus'">Au Soir</xsl:when>
		    <xsl:when test="$subtype='c'">Call On</xsl:when>
		    <xsl:when test="$subtype='cg'">Call On Godwin</xsl:when>
		    <xsl:when test="$subtype='cn'">Call On Someone with Others</xsl:when>
		    <xsl:when test="$subtype='cgn'">People Call On Godwin</xsl:when>
		    <xsl:when test="$subtype='do'">Do Something</xsl:when>
		    <xsl:when test="$subtype='inv'">Invited</xsl:when>
		    <xsl:when test="$subtype='m'">Meet With</xsl:when>
		    <xsl:when test="$subtype='name'">Named</xsl:when>
		    <xsl:when test="$subtype='do'">Do Something</xsl:when>
		    <xsl:when test="$subtype='ppc'">Pour Prendre Congé</xsl:when>
		    <xsl:when test="$subtype='ppcg'">Pour Prendre Congé At Godwin's</xsl:when>
		    <xsl:when test="$subtype='pr'">Present</xsl:when>
		    <xsl:when test="$subtype='s'">See</xsl:when>
		    <xsl:when test="$subtype='send4'">Send For</xsl:when>
		    <xsl:when test="$subtype='sitto'">Sit To</xsl:when>
		    <xsl:when test="$subtype='sleepat'">Sleep At</xsl:when>
		    <xsl:when test="$subtype='sleeps'">Sleeps</xsl:when>
		    <xsl:when test="$subtype='sleepother'">Someone Sleeps Elsewhere</xsl:when>
		    <xsl:when test="$subtype='sk'">Seek</xsl:when>
		    <xsl:when test="$subtype='tohave'">To Have Done Something</xsl:when>
		    <xsl:when test="$subtype='other'">Other</xsl:when>
		    <xsl:when test="$subtype='uncertain'">Uncertain</xsl:when>
		    <xsl:when test="$subtype='unknown'">Unknown</xsl:when>

		    <xsl:otherwise><xsl:value-of select="normalize-space(.)"/></xsl:otherwise> 
		    </xsl:choose><xsl:text>"</xsl:text><xsl:call-template name="punctuate-list"/><xsl:text>
</xsl:text>
    </xsl:template>

    
    
    <xsl:template name="punctuate-list"><xsl:choose>
            <xsl:when test="position()=last()"/> 
            <xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise>
    </xsl:choose></xsl:template>
    
    
</xsl:stylesheet>
