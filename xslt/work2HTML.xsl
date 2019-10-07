<xsl:stylesheet version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
     xmlns:g="http://godwindiaries.bodleian.ox.ac.uk" 
     xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="functions.xsl"/>
  <xsl:strip-space elements="*"/>
  


  <!-- A  page of TEI Person information -->
  <xsl:template match="/">
	  <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
	      <title> Work record
		      <xsl:choose>
			      <xsl:when test="count(//tei:bibl) gt 1"> 
				      for <xsl:for-each select="/tei:listBibl/tei:bibl[tei:title/text()]">
					      <xsl:value-of select="tei:title[text()][1]"/> <xsl:if test="not(last())"> and </xsl:if>
				      </xsl:for-each>
			      </xsl:when>
			      <xsl:otherwise> for <xsl:value-of select="/tei:listBibl/tei:bibl[1]/tei:title[text()][1]"/></xsl:otherwise>

		      </xsl:choose>
	      </title>
	      <link type="text/css" href="/css/godwin-theme/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
		      <link type="text/css" rel="stylesheet" href="/godwin.css"/>
		      <script type="text/javascript" src="/js/jquery-1.3.2.min.js"></script>
		      <script type="text/javascript" src="/js/jquery-ui-1.7.2.custom.min.js"></script>
	<xsl:comment>[if IE]&gt;&lt;script language="javascript" type="text/javascript"
		src="/excanvas.js"&gt; /** **/&lt;/script&gt;&lt;![endif]</xsl:comment>
	<script type="text/javascript" src="/js/jquery.flot.js"></script>
	<script type="text/javascript">
			$(function(){
			<xsl:for-each select="/tei:listBibl/tei:bibl">
				<xsl:text>$('</xsl:text><xsl:value-of select="concat('#bibl', position(), 'tabs')"/><xsl:text>').tabs();</xsl:text>

				var <xsl:value-of select="concat('bibl',position(), 'data')"/>=[<xsl:for-each select="./tei:ab[@type='appearancesInDiary']/tei:ab">
					<xsl:variable name="dateCount"><xsl:choose>
							<xsl:when test="tei:date"><xsl:value-of select="count(tei:date)"/></xsl:when>
							<xsl:otherwise>null</xsl:otherwise>
</xsl:choose></xsl:variable>
<xsl:value-of select="concat('[',@n,',',$dateCount, ']')"/>,</xsl:for-each>];
  
  
 <!-- [<xsl:value-of select="normalize-space(.//tei:ab[@type='results'])"/>];-->

 var plot = $.plot($("<xsl:value-of select="concat('#bibl', position(), 'placeholder')"/>"),
	 [ { data: <xsl:value-of select="concat('bibl', position(), 'data')"/>, label: "Appearances/Year", color:"#2e4c6f", clickable:true, hoverable:true,
	 bars: { show: true, barWidth:0.75, align:"center", clickable:true, hoverable:true},
	 } ]
	 ,
	 {
	 //series: { lines: { show: true }, points: { show: true } },
	 //bars: { show: true, barWidth:0.5, align:"left", clickable:true, hoverable:true, color:"#900"},
	 grid: { show:true, hoverable: true, clickable: true, backgroundColor:{colors:["#EEEEFF", "#FFFFFF"]} },
	 legend: {position:"nw", backgroundColor:"transparent"},
	 yaxis:{minTickSize:1},
	 });

	 
	 
	 $("<xsl:value-of select="concat('#bibl', position(), 'placeholder')"/>").bind("plotclick", function (event, pos, item) {
	 //     axis coordinates for other axes, if present, are in pos.x2, pos.x3, ...
	  //    if you need global screen coordinates, they are pos.pageX, pos.pageY

	  if (item) {
	  $('html, body').animate({ scrollTop: $("<xsl:value-of select="concat('#bibl', position(), 'app')"/>" + item.datapoint[0]).offset().top }, 500);
	  //window.open("#app" + item.datapoint[0]);
	  //$("#clicktext").text("Click In" + item.datapoint[0] + " there were " + item.datapoint[1] + " appearances.");
	  }
	  });

	  $("<xsl:value-of select="concat('#bibl', position(), 'placeholder')"/>").bind("plothover", function (event, pos, item) {
	  if (item) {
	  $("<xsl:value-of select="concat('#bibl', position(), 'hovertext')"/>").text(": in " + item.datapoint[0] + " this work appears " + item.datapoint[1] + " times.");
	  }
	  });

  </xsl:for-each>

  });      
  </script>


      </head>
      <body>


<xsl:apply-templates select=".//tei:bibl"/>

</body>
</html>

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



  <xsl:template match="tei:persname[@ref]">
    <a href="{@ref}">
      <xsl:apply-templates/>
    </a><xsl:text> </xsl:text>
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
        test="tei:forename/text()
        and tei:surname/text()">
        <xsl:value-of
          select="concat(tei:surname,
          ', ', tei:forename, ' ')"/>
        <xsl:for-each select="tei:*[not(name()='forename' or name()='surname')]">
          <xsl:text> </xsl:text>
          <xsl:value-of select="."/><xsl:text> </xsl:text>
        </xsl:for-each>
        </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="normalize-space($text)"/>
        </xsl:template>
  
  <xsl:template name="getID">
    <xsl:value-of select="ancestor-or-self::tei:person/@xml:id"/>
  </xsl:template>

<xsl:template match="tei:bibl">
<xsl:variable name="biblID" select="concat('bibl', position())"/>
	<div class="bibl" id="{concat($biblID, 'tabs')}"><h2><xsl:apply-templates select="tei:title[1][text()]"/> </h2>
			<ul>
				<li><a href="{concat('#bibl',position(),'-appearances')}">Mentions in Diary</a></li>
				<li><a href="{concat('#bibl',position(),'-bibl')}">Bibliographic Information</a></li>
				<!--<li><a id="mmbrowserLink" class="followtablink"  target="_blank" href="{concat('/mmbrowser/',@xml:id,'.html')}">Meals and Meeting</a></li>-->
				</ul>


				<div id="{concat($biblID, '-appearances')}">
					<div id="{concat($biblID,'placeholder')}" style="width:550px;height:250px"></div>
					<div class="flotCaption"><p>
							Hover over a bar to see number of mentions/year<span id="{concat('bibl', position(), 'hovertext')}">.</span>
							<br/>
				                              Click on a bar to jump to that year.
			      </p>
			      <p>
				      <xsl:variable name="numMentions" select="count(tei:ab[@type='appearancesInDiary']//tei:date)"/>

				      This work is mentioned in the diary a total of <xsl:value-of select="$numMentions"/> time<xsl:if test="$numMentions &gt; 1">s</xsl:if>.
			      </p>
		      </div>
 <xsl:for-each select="tei:ab[@type='appearancesInDiary']/tei:ab[tei:date]">
<div>
                        <h4 id="{concat($biblID, 'app', @n)}"><xsl:value-of select="@n"/> <a href="{concat('#', $biblID, 'top')}" class="navArrow" title="Go to Top"><img src="/dataTables/images/sort_asc.png" border="0"/></a></h4>
                        <p class="appearances">
                <xsl:for-each select="tei:date[position() mod 4 = 1]">
                                <xsl:for-each select=".|following-sibling::tei:date[position() &lt; 4]">
                                        <span class="appearance"><a href="{concat('/diary/', @when, '.html')}" class="appearanceDate"><xsl:value-of select="g:date(@when)"/></a><xsl:text>  </xsl:text>
                        </span>
                        </xsl:for-each>
                       <!-- <br/> -->
    </xsl:for-each>
</p>
</div>
</xsl:for-each>
</div>
					
					
				<div id="{concat($biblID,'-bibl')}"><xsl:apply-templates select="*[not(name()='ab')]"/></div>
	</div>

<span class="XML-link">
                  <a class="XML-link"
                     href="{concat('/works/', @xml:id, '.xml')}">
                     <img src="/images/xml_icon.gif" alt="XML" height="16"
                        width="40"/>
                  </a>
               </span>

</xsl:template>  
  
  <xsl:template match="tei:bibl/tei:author[@ref]">
    <a href="{@ref}" class="authorName"><xsl:apply-templates/></a>
  </xsl:template>

<xsl:template match="tei:bibl/tei:forename | tei:bibl/tei:surname">
<xsl:text> </xsl:text><xsl:apply-templates/><xsl:text> </xsl:text>
</xsl:template>


  <xsl:template match="tei:bibl/tei:author/tei:persName"><span class="persName"><xsl:call-template name="getName"/></span></xsl:template>
  

<xsl:template match="tei:publisher"><span class="publisher"><xsl:text> </xsl:text> <xsl:apply-templates></xsl:apply-templates></span><xsl:text> </xsl:text></xsl:template>

<xsl:template match="tei:lb"><br/></xsl:template>



  <xsl:template match="tei:title"><xsl:text> </xsl:text> 
    <span class="title"><xsl:apply-templates/></span>
    <xsl:text> </xsl:text> 
  </xsl:template>
  
  <xsl:template match="tei:bibl/tei:title"><xsl:text> </xsl:text> 
    <span class="title"><xsl:apply-templates/></span>
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

  <xsl:template match="tei:ab[@type='appearancesInDiary'][tei:ab/tei:date]">
	  <h3>Mentions in Diary</h3>
	  <ul class="appearancesInDiary">
		  <xsl:for-each select=".//tei:date"><li><a href="{concat('/diary/', @when,'.html')}"><xsl:value-of select="g:date(@when)"/></a></li></xsl:for-each>
		  </ul>
  </xsl:template>
  
</xsl:stylesheet>
