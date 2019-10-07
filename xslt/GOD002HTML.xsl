<xsl:stylesheet version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
     xmlns:g="http://godwindiaries.bodleian.ox.ac.uk" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="functions.xsl"/>
  <xsl:strip-space elements="*"/>



<!-- phrase level transformation to span -->
  <xsl:template match="tei:title">
    <span class="{name()}"><xsl:apply-templates/></span>
  </xsl:template>
  


  <!-- A  page of TEI Person information -->
  <xsl:template match="/">
    <html>
      <head>
        <title>William Godwin's Works</title>
	<link type="text/css" href="/css/godwin-theme/jquery-ui-1.7.2.custom.css" rel="stylesheet" />	
        <link type="text/css" rel="stylesheet" href="/godwin.css"/>
		<script type="text/javascript" src="/js/jquery-1.3.2.min.js"></script>
		<script type="text/javascript" src="/js/jquery-ui-1.7.2.custom.min.js"></script>
      </head>
      <body>


<xsl:apply-templates select=".//tei:person"/>

</body>
</html>

</xsl:template>

<xsl:template match="tei:person">
  <xsl:variable name="id" select="@xml:id"/>
        <!--<div class="person" id="{concat($id, 'top')}" >
		<h2> William Godwin </h2>

          <div id="{concat(@xml:id, '-bio')}">
            <ul>
              <xsl:apply-templates select="tei:persName[string-length(normalize-space(.))&gt;4]"/>
              <xsl:apply-templates select="@sex"/>
              <xsl:apply-templates select="tei:birth[string-length(normalize-space(.))&gt;4 or @when]"/>
              <xsl:apply-templates select="tei:death[string-length(normalize-space(.))&gt;4 or @when]"/>
              <xsl:apply-templates select="tei:occupation[string-length(normalize-space(.))&gt;4]"/>
              <xsl:apply-templates select="tei:education[string-length(normalize-space(.))&gt;4]"/>
              <xsl:apply-templates select="tei:floruit[string-length(normalize-space(.))&gt;4]"/>
              <xsl:apply-templates select="tei:faith[string-length(normalize-space(.))&gt;4]"/>
              <xsl:apply-templates select="tei:state[string-length(normalize-space(.))&gt;4]"/>
              <xsl:apply-templates select="tei:trait[string-length(normalize-space(.))&gt;4]"/>
            </ul>
          </div>
         --> 

<xsl:variable name="types">
			<li><a href="other">Advertisements and catalogues</a></li>
			<li><a href="edited">Edited or revised works of others</a></li>
			<li><a href="journalism">Journalistic items</a></li>
			<li><a href="MS">Manuscripts</a></li>
			<li><a href="novel">Novels</a></li>
			<li><a href="pamphlet">Pamphlets</a></li>
			<li><a href="play">Plays</a></li>
			<li><a href="printedbook">Printed book</a></li>
</xsl:variable>
          
          <div id="{concat(@xml:id, '-bibl')}">
            <xsl:for-each select="tei:note[@type='works']/tei:listBibl[tei:head]">
	     <xsl:variable name="biblType" select="@type"/> 
<div id="{@type}">
              <h2><xsl:value-of select="tei:head"/></h2>
                <xsl:for-each-group select="tei:bibl" group-by="@type[not(.='unknown')]">
                  <xsl:sort select="$types/li/a[@href=current-grouping-key()]/text()" order="ascending"/>
                  <div id="{concat($biblType, '-', @type)}">
                    <h3>
                      <xsl:choose>
                        <xsl:when test="current-grouping-key()='journalism'">Journalistic Items</xsl:when>
                        <xsl:when test="current-grouping-key()='MS'">Manuscripts</xsl:when>
                        <xsl:when test="current-grouping-key()='novel'">Novels</xsl:when>
                        <xsl:when test="current-grouping-key()='pamphlet'">Pamphlets</xsl:when>
                        <xsl:when test="current-grouping-key()='perf'">Performances</xsl:when>
                        <xsl:when test="current-grouping-key()='play'">Plays</xsl:when>
                        <xsl:when test="current-grouping-key()='poem'">Poetry</xsl:when>
                        <xsl:when test="current-grouping-key()='printedbook'">Printed Books</xsl:when>
                        <xsl:when test="current-grouping-key()='other'">Advertisements and catalogues</xsl:when>
                      </xsl:choose> <a href="#top" class="navArrow" title="Go to Top">
                        <img src="/dataTables/images/sort_asc.png" border="0"/>
                      </a>
</h3>

<xsl:if test="current-grouping-key()='MS' and ancestor::tei:listBibl/@type='works'">
<p class="helpText">The following items were unpublished in Godwin's lifetime. Some have since been published (including two tragedies listed under 'Plays'), some are extant in the Abinger Collection or elsewhere, and some have been lost.</p>

</xsl:if>
<ul>
                    <xsl:for-each select="current-group()[not(current-grouping-key()='unknown')]">
                      <xsl:sort select="tei:date[1]"/>
                      <xsl:sort select="tei:title[1]"/>
		      <li id="{@xml:id}"><xsl:apply-templates /></li>
                    </xsl:for-each>
</ul>
                  </div>
                </xsl:for-each-group>
</div>
            </xsl:for-each>
          </div>
            
<div class="XML-Link"><a class="XML-link" href="{concat('/people/',$id ,'.xml')}"><img src="/images/xml_icon.gif" border="0" alt="XML" height="16" width="40"/></a></div>
<!--</div> -->

  </xsl:template>

<!--<xsl:template match="tei:listBibl/tei:bibl"><xsl:apply-templates/></xsl:template> -->

  <!-- Bib dealt with up there. -->
  <xsl:template match="tei:person/tei:bibl"/>

<xsl:template match="@sex">
<li><span class="label">Gender: </span><xsl:choose>
<xsl:when test=".='1'">Male</xsl:when>
<xsl:when test=".='2'">Female</xsl:when>
<xsl:when test=".='0'">Unknown</xsl:when>
<xsl:when test=".='9'">Not Applicable</xsl:when>
<xsl:when test=".=''">Not Specified</xsl:when>
<xsl:otherwise>Not Specified</xsl:otherwise>
</xsl:choose></li>
</xsl:template>


  <xsl:template match="tei:person/tei:persName">
	  <li><span class="label">Name: </span>
<xsl:if test="tei:surname[text()]"><xsl:value-of select="tei:surname"/>,<xsl:text> </xsl:text> </xsl:if>
<xsl:for-each select="tei:*[not(name()='surname')][not(name()='addName')]">
<xsl:value-of select="."/><xsl:text> </xsl:text>
  </xsl:for-each>
  <xsl:if test="tei:addName[text()]">(<xsl:value-of select="tei:addName[text()]"/>)</xsl:if>
  </li>
  </xsl:template>

  <xsl:template match="tei:person/tei:birth">
<xsl:if test="(not(normalize-space(.)='') or not(normalize-space(.)=' ')) and (@when or @notBefore or @notAfter)">
<li><span class="label">Birth Date: </span>
<xsl:choose>
    <xsl:when test="@when and not(@when='1000')"> <xsl:value-of select="g:date(@when)"/> </xsl:when>
<xsl:when test="@notBefore and @notAfter">
Not Before: <xsl:value-of select="g:date(@notBefore)"/><xsl:text> -  Not After: </xsl:text> <xsl:value-of select="g:date(@notAfter)"/> </xsl:when>
<xsl:when test="not(@notBefore) and @notAfter">
 Not After: <xsl:value-of select="g:date(@notAfter)"/></xsl:when>
<xsl:when test="@notBefore and not(@notAfter)">
Not Before: <xsl:value-of select="g:date(@notBefore)"/> </xsl:when>
<xsl:otherwise> <xsl:value-of select="."/></xsl:otherwise>
</xsl:choose>
<xsl:if test="not(normalize-space(.)='' or normalize-space(.)=' ') and string-length(.[not(tei:placeName)])&gt;5">
[<xsl:apply-templates/>]
</xsl:if>
</li>
</xsl:if>
  </xsl:template>

  <xsl:template match="tei:person/tei:death">
<xsl:if test="(not(normalize-space(.)='') or not(normalize-space(.)=' ')) and (@when or @notBefore or @notAfter)">
<li><span class="label">Death Date: </span>
<xsl:choose>
    <xsl:when test="@when and not(@when='1000')"> <xsl:value-of select="g:date(@when)"/> </xsl:when>
<xsl:when test="@notBefore and @notAfter">
Not Before: <xsl:value-of select="g:date(@notBefore)"/><xsl:text> -  Not After: </xsl:text> <xsl:value-of select="g:date(@notAfter)"/> </xsl:when>
<xsl:when test="not(@notBefore) and @notAfter">
 Not After: <xsl:value-of select="g:date(@notAfter)"/></xsl:when>
<xsl:when test="@notBefore and not(@notAfter)">
Not Before: <xsl:value-of select="g:date(@notBefore)"/> </xsl:when>
<xsl:otherwise> <xsl:value-of select="."/></xsl:otherwise>
</xsl:choose>
<xsl:if test="not(normalize-space(.)='' or normalize-space(.)=' ')">
[<xsl:apply-templates/>]
</xsl:if>
</li>
</xsl:if>
  </xsl:template>


  <xsl:template match="tei:person/tei:death/tei:placeName | tei:person/tei:birth/tei:placeName"/>

  <xsl:template match="tei:person/tei:floruit">
    <xsl:if test="@from and @to">
      <tr>
        <td class="label">Floruit Dates</td>
        <td class="data">Flourished between <xsl:value-of select="@from"/> and <xsl:value-of
            select="@to"/>
          <xsl:apply-templates/>
        </td>
      </tr>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:person/tei:occupation[text()]">
      <li><span class="label">Occupation: </span><xsl:apply-templates/></li>
  </xsl:template>


  <xsl:template match="tei:person/tei:education[text()]">
      <li><span class="label">Education: </span><xsl:apply-templates/></li>
  </xsl:template>


  <xsl:template match="tei:person/tei:affiliation[text()]">
      <li><span class="label">Affiliation: </span><xsl:apply-templates/></li>
  </xsl:template>

  <xsl:template match="tei:person/tei:faith[text()]">
      <li><span class="label">Faith: </span><xsl:apply-templates/></li>
  </xsl:template>


  <xsl:template match="tei:person/tei:state[text()]">
      <li><span class="label">State: </span><xsl:apply-templates/></li>
  </xsl:template>

  <xsl:template match="tei:person/tei:trait[text()]">
      <li><span class="label">Trait: </span><xsl:apply-templates/></li>
  </xsl:template>


  <xsl:template name="getDates">
    <xsl:choose>
      <xsl:when test="@from and @to">
        <br/>
        <span class="small">(<xsl:value-of select="concat(g:date(@from), ' - ', g:date(@to))"/>)</span>
      </xsl:when>
      <xsl:when test="@from and not(@to)">
        <br/>
        <span class="small">(<xsl:value-of select="concat('From: ', g:date(@from))"/>)</span>
      </xsl:when>
      <xsl:when test="not(@from) and @to">
        <br/>
        <span class="small">(<xsl:value-of select="concat('To:
          ', g:date(@to))"/>)</span>
      </xsl:when>
      <xsl:when test="@when">
        <br/>
        <span class="small">(<xsl:value-of select="concat('At:
          ', g:date(@when))"/>)</span>
      </xsl:when>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="tei:person/tei:event[@type][text()]">
      <li><span class="label"><xsl:value-of select="@type"/>: </span><xsl:apply-templates/></li>
  </xsl:template>


  <xsl:template match="tei:person/tei:note">
  <p class="personNote"><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="tei:persname[@ref]">
    <a href="{@ref}">
      <xsl:apply-templates/>
    </a>
  </xsl:template>


  <xsl:template match="tei:person/tei:*[.//text()]" priority="-1">
      <li><span class="label"><xsl:value-of select="name()"/>: </span><xsl:apply-templates/></li>
</xsl:template>

<xsl:template match="tei:p|tei:ab">
<p><xsl:apply-templates/></p>
</xsl:template>


  <xsl:template name="getTitle">
    <xsl:choose>
      <xsl:when test="ancestor-or-self::tei:TEI">
        <xsl:value-of
          select="ancestor-or-self::tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1]"/>
      </xsl:when>
      <xsl:when test="ancestor-or-self::tei:person">
        <xsl:call-template name="getName"/>
      </xsl:when>
      <xsl:otherwise>ERROR: No title or persName</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="getName">
    <xsl:variable name="text"><xsl:choose>
      <xsl:when
        test="ancestor-or-self::tei:person/tei:persName[1]/tei:forename
        and ancestor-or-self::tei:person/tei:persName[1]/tei:surname">
        <xsl:value-of
          select="concat(ancestor-or-self::tei:person/tei:persName[1]/tei:surname,
          ', ', ancestor-or-self::tei:person/tei:persName[1]/tei:forename, ' ')"/><xsl:text> </xsl:text>
        <xsl:for-each select="ancestor-or-self::tei:person/tei:persName[1]/tei:*[not(name()='forename' or name()='surname')]">
          <xsl:value-of select="."/><xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="ancestor-or-self::tei:person/tei:persName[1]"/>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="@key">
        <xsl:variable name="ref"><xsl:value-of select="translate(normalize-space(@key), ' ', '|')"/></xsl:variable>
        <a href="{concat('/authors/', $ref, '.html')}"><xsl:value-of select="$text"/></a>
      </xsl:when>
      <xsl:otherwise><xsl:value-of select="$text"/></xsl:otherwise>
    </xsl:choose>
    
    
  </xsl:template>
  
  <xsl:template name="getID">
    <xsl:value-of select="ancestor-or-self::tei:person/@xml:id"/>
  </xsl:template>


<xsl:template match="tei:p//tei:persName[@key]">
<xsl:variable name="ref"><xsl:value-of select="translate(normalize-space(@key), ' ', '|')"/></xsl:variable>
<a href="{concat('/people/', $ref, '.html')}"><xsl:apply-templates/></a>
</xsl:template>

<xsl:template match="tei:lb"><br/></xsl:template>

<xsl:template match="tei:ref[@target]"><a href="{@target}"><xsl:apply-templates/></a></xsl:template>


  <xsl:template match="tei:bibl/tei:title"><xsl:text> </xsl:text> 
    <span class="title"><xsl:apply-templates/></span>
    <xsl:text> </xsl:text> 
  </xsl:template>
  
  <xsl:template match="tei:bibl[@xml:id]/tei:title"><xsl:text> </xsl:text> 
	  <span class="title"><a href="{concat('/works/', parent::tei:bibl/@xml:id, '.html')}"><xsl:apply-templates/></a></span>
    <xsl:text> </xsl:text> 
  </xsl:template>
  
  <xsl:template match="tei:bibl/tei:forename" priority="5"><xsl:text> </xsl:text> 
    <span class="forename"> <xsl:apply-templates/> </span>
    <xsl:text> </xsl:text> 
  </xsl:template>
  
  <xsl:template match="tei:bibl/tei:surname" priority="5"><xsl:text> </xsl:text> 
    <span class="surname"> <xsl:apply-templates/> </span>
    <xsl:text> </xsl:text> 
  </xsl:template>
  
  
  <xsl:template match="tei:bibl/tei:title[@type='alt'][string-length(normalize-space(.))&gt;3]"><xsl:text> </xsl:text> 
    [<span class="title subtitle"><xsl:apply-templates/></span>]
    <xsl:text> </xsl:text> 
  </xsl:template>
  
  <xsl:template match="tei:bibl/tei:date[@when][not(string-length(normalize-space(.))&gt;=3)]"><xsl:text> </xsl:text> 
    (<span class="workDate"><xsl:value-of select="g:date(@when)"/></span>)
    <xsl:text> </xsl:text> 
  </xsl:template>
  
  
  <xsl:template match="tei:bibl/tei:date[@when][string-length(normalize-space(.))&gt;=3]"><xsl:text> </xsl:text> 
    (<span class="workDate"><xsl:value-of select="g:date(@when)"/>: <xsl:apply-templates/></span>)
    <xsl:text> </xsl:text> 
  </xsl:template>
  
  
  <xsl:template match="tei:bibl/tei:date[not(@when)][string-length(normalize-space(.))&gt;=3]"><xsl:text> </xsl:text> 
    (<span class="workDate"><xsl:apply-templates/></span>)
    <xsl:text> </xsl:text> 
  </xsl:template>
  

</xsl:stylesheet>
