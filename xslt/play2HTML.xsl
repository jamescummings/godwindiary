<xsl:stylesheet version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:g="http://godwindiaries.bodleian.ox.ac.uk"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="functions.xsl"/>
    <xsl:strip-space elements="*"/>

<xsl:variable name="titles">
                    <xsl:copy-of select="/tei:div/tei:bibl[1]//tei:title[1]"/>
 </xsl:variable>
<xsl:variable name="title" select="$titles/tei:title[1]" />
<xsl:variable name="author" select="/tei:div/tei:person/tei:persName"/>

    <xsl:template match="/tei:div">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title> Play record for <xsl:value-of select="$title"/></title>
                <link type="text/css" href="/css/godwin-theme/jquery-ui-1.7.2.custom.css" rel="stylesheet"/>
                <link type="text/css" rel="stylesheet" href="/godwin.css"/>
                <script type="text/javascript" src="/js/jquery-1.3.2.min.js"/>
                <script type="text/javascript" src="/js/jquery-ui-1.7.2.custom.min.js"/>
                <xsl:comment>[if IE]&gt;&lt;script language="javascript" type="text/javascript" src="/excanvas.js"&gt;
                    /** **/&lt;/script&gt;&lt;![endif]</xsl:comment>
                <script type="text/javascript" src="/js/jquery.flot.js"/>
                <script type="text/javascript">
			$(function(){
			<xsl:text>$('#bibl1tabs').tabs();</xsl:text>

				var bibl1data=[<xsl:for-each select="//tei:ab[@type='appearancesInDiary']/tei:ab">
			<xsl:variable name="dateCount"><xsl:choose>
			<xsl:when test="tei:date"><xsl:value-of select="count(tei:date)"/></xsl:when>
			<xsl:otherwise>null</xsl:otherwise>
</xsl:choose></xsl:variable>
<xsl:value-of select="concat('[',@n,',',$dateCount, ']')"/>,</xsl:for-each>]; 
  
  
 <!--
[ < xsl: value - of select = "normalize-space(.//tei:ab[@type='results'])" / >];-->

 var plot = $.plot($("#bibl1placeholder"),
	 [ { data: bibl1data, label: "Appearances/Year", color:"#2e4c6f", clickable:true, hoverable:true,
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

	 
	 
	 $("#bibl1placeholder").bind("plotclick", function (event, pos, item) {
	 //     axis coordinates for other axes, if present, are in pos.x2, pos.x3, ...
	  //    if you need global screen coordinates, they are pos.pageX, pos.pageY

	  if (item) {
	  $('html, body').animate({ scrollTop: $("#bibl1app" + item.datapoint[0]).offset().top }, 500);
	  //window.open("#app" + item.datapoint[0]);
	  //$("#clicktext").text("Click In" + item.datapoint[0] + " there were " + item.datapoint[1] + " appearances.");
	  }
	  });

	  $("#bibl1placeholder").bind("plothover", function (event, pos, item) {
	  if (item) {
	  $("bibl1hovertext").text(": in " + item.datapoint[0] + " this work appears " + item.datapoint[1] + " times.");
	  }
	  });
});      
  </script>
        </head>
            <body>
                <xsl:apply-templates select="tei:bibl"/>
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
            <xsl:call-template name="getName"/>
        </a>
        <xsl:text> </xsl:text>
    </xsl:template>

    <!--<xsl:template match="tei:p|tei:ab">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
-->

    <xsl:template name="getTitle">
        <xsl:choose>
            <xsl:when test="ancestor-or-self::tei:TEI">
                <xsl:value-of select="ancestor-or-self::tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1]"/>
            </xsl:when>
            <xsl:when test="ancestor-or-self::tei:person">
                <xsl:call-template name="getName"/>
            </xsl:when>
            <xsl:otherwise>ERROR: No title or persName</xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template name="getName">
        <xsl:variable name="text">
            <xsl:choose>
                <xsl:when test="tei:forename/text()
        and tei:surname/text()">
                    <xsl:value-of select="concat(tei:surname,
          ', ', tei:forename, ' ')"/>
                    <xsl:for-each select="tei:*[not(name()='forename' or name()='surname')]">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="."/>
                        <xsl:text> </xsl:text>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:for-each select="node()">
                        <xsl:text> </xsl:text>
                        <xsl:apply-templates select="."/>
                        <xsl:text> </xsl:text>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="normalize-space($text)"/>
    </xsl:template>

    <xsl:template name="getID">
        <xsl:value-of select="ancestor-or-self::tei:person/@xml:id"/>
    </xsl:template>

    <xsl:template match="/tei:div/tei:bibl">
        <xsl:variable name="biblID" select="'bibl1'"/>
        <div class="bibl" id="{concat($biblID, 'tabs')}">
            <h2>
                <span class="italic"><xsl:value-of select="$title"/></span>
                by 
                <xsl:apply-templates select="$author"/>
            </h2>
            <ul>
                <li>
                    <a href="{concat('#bibl',position(),'-appearances')}">Mentions in Diary</a>
                </li>
                <li>
                    <a href="{concat('#bibl',position(),'-bibl')}">Bibliographic Information</a>
                </li>
                <!--<li><a id="mmbrowserLink" class="followtablink"  target="_blank" href="{concat('/mmbrowser/',@xml:id,'.html')}">Meals and Meeting</a></li>-->
            </ul>


            <div id="{concat($biblID, '-appearances')}">
                <div id="{concat($biblID,'placeholder')}" style="width:550px;height:250px"/>
                <div class="flotCaption">
                    <p> Hover over a bar to see number of mentions/year<span
                            id="{concat('bibl', position(), 'hovertext')}">.</span><br/> Click on a bar to jump to that
                            year.<xsl:variable name="numMentions"
                            select="count(//tei:ab[@type='appearancesInDiary']//tei:date)"/><br/>This work is mentioned
                        in the diary a total of <xsl:value-of select="$numMentions"/> time<xsl:if
                            test="$numMentions &gt; 1">s</xsl:if>. </p>
                </div>
                <xsl:for-each select="//tei:ab[@type='appearancesInDiary']/tei:ab[tei:date]">
                    <div>
                        <h4 id="{concat($biblID, 'app', @n)}">
                            <xsl:value-of select="@n"/>
                            <a href="{concat('#', $biblID, 'top')}" class="navArrow" title="Go to Top">
                                <img src="/dataTables/images/sort_asc.png" border="0"/>
                            </a>
                        </h4>
                        <p class="appearances">
                            <xsl:for-each select="tei:date[position() mod 4 = 1]">
                                <xsl:for-each select=".|following-sibling::tei:date[position() &lt; 4]">
                                    <span class="appearance">
                                        <a href="{concat('/diary/', @when, '.html')}" class="appearanceDate">
                                            <xsl:value-of select="g:date(@when)"/>
                                        </a>
                                        <xsl:text>  </xsl:text>
                                    </span>
                                </xsl:for-each>
                                <!-- <br/> -->
                            </xsl:for-each>
                        </p>
                    </div>
                </xsl:for-each>
            </div>


            <div id="{concat($biblID,'-bibl')}">
                <xsl:apply-templates select="/tei:div/tei:person/node()"/>
                <xsl:apply-templates select="/tei:div/tei:bibl/node()"/>
            </div>
        </div>
        
        
<span class="XML-link">
                  <a class="XML-link"
                     href="{concat('/plays/', @xml:id, '.xml')}">
                     <img src="/images/xml_icon.gif" alt="XML" height="16"
                        width="40"/>
                  </a>
               </span>
    </xsl:template>

    <xsl:template match="tei:bibl/tei:author[@ref]">
        <a href="{@ref}" class="authorName">
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template match="tei:bibl/tei:forename | tei:bibl/tei:surname">
        <xsl:text> </xsl:text>
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
    </xsl:template>


    <xsl:template match="tei:bibl/tei:author/tei:persName">
        <span class="persName">
            <xsl:call-template name="getName"/>
        </span>
    </xsl:template>

<xsl:template match="tei:person//tei:listBibl"/>

<xsl:template match="tei:person/tei:persName">
   <a class="nameLink" href="{concat('/dramatists/', parent::tei:person/@xml:id, '.html')}"><xsl:call-template name="getName"/></a> 
</xsl:template>


    
    <xsl:template match="tei:publisher">
        <span class="publisher">
            <xsl:text> </xsl:text>
            <xsl:apply-templates/>
        </span>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>



    <xsl:template match="tei:title">
        <xsl:text> </xsl:text>
        <span class="title">
            <xsl:apply-templates/>
        </span>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template match="tei:bibl/tei:title">
        <xsl:text> </xsl:text>
        <span class="title">
            <xsl:apply-templates/>
        </span>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template match="tei:bibl/tei:title[@type='alt'][string-length(normalize-space(.))&gt;3]"><xsl:text> </xsl:text>
            [<span class="title subtitle"><xsl:apply-templates/></span>] <xsl:text> </xsl:text>
    </xsl:template>


    <xsl:template match="tei:bibl/tei:date[@when][not(string-length(normalize-space(.))&gt;=3)]"><xsl:text> </xsl:text>
            (<span class="workDate"><xsl:value-of select="g:date(@when)"/></span>) <xsl:text> </xsl:text>
    </xsl:template>


    <xsl:template match="tei:bibl/tei:date[@when][string-length(normalize-space(.))&gt;=3]"><xsl:text> </xsl:text>
            (<span class="workDate"><xsl:value-of select="g:date(@when)"/>: <xsl:apply-templates/></span>)
        <xsl:text> </xsl:text>
    </xsl:template>


    <xsl:template match="tei:bibl/tei:date[not(@when)][string-length(normalize-space(.))&gt;=3]"><xsl:text> </xsl:text>
            (<span class="workDate"><xsl:apply-templates/></span>) <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template match="tei:ab[@type='appearancesInDiary'][tei:ab/tei:date]">
        <h3>Mentions in Diary</h3>
        <ul class="appearancesInDiary">
            <xsl:for-each select=".//tei:date">
                <li>
                    <a href="{concat('/diary/', @when,'.html')}">
                        <xsl:value-of select="g:date(@when)"/>
                    </a>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>

</xsl:stylesheet>
