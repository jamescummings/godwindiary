<xsl:stylesheet version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
     xmlns:g="http://godwindiaries.bodleian.ox.ac.uk" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="functions.xsl"/>
  <xsl:strip-space elements="*"/>



<!-- phrase level transformation to span -->
  <xsl:template match="tei:title">
    <span class="{name()}"><xsl:apply-templates/></span>
  </xsl:template>
  
  <xsl:variable name="renderedName">
	  <xsl:for-each select="//tei:person/@xml:id">
		  <xsl:if test="position()&gt;1"> and </xsl:if>
		  <xsl:variable name="url" select="concat('http://godwindiary.bodleian.ox.ac.uk/get-persName.xq?id=', .)"/>
		  <xsl:value-of select="document($url)//tei:ab[@type='renderedName']"/>
	  </xsl:for-each>
</xsl:variable>


  <!-- A  page of TEI Person information -->
  <xsl:template match="/">
    <html>
      <head>
	      <title>Person record for <xsl:value-of select="$renderedName"/></title>
	<link type="text/css" href="/css/godwin-theme/jquery-ui-1.7.2.custom.css" rel="stylesheet" />	
        <link type="text/css" rel="stylesheet" href="/godwin.css"/>
		<script type="text/javascript" src="/js/jquery-1.3.2.min.js"></script>
		<script type="text/javascript" src="/js/jquery-ui-1.7.2.custom.min.js"></script>
<xsl:comment>[if IE]&gt;&lt;script language="javascript" type="text/javascript"
src="/excanvas.js"&gt; /** **/&lt;/script&gt;&lt;![endif]</xsl:comment>
          <script type="text/javascript" src="/dataTables/js/jquery.dataTables.js"><xsl:comment> Fake comment</xsl:comment> </script>
		<script type="text/javascript" src="/js/jquery.flot.js"></script>
		<script type="text/javascript">
			$(function(){
<xsl:for-each select="//tei:person">
	<xsl:text>$('</xsl:text><xsl:value-of select="concat('#', @xml:id, 'tabs')"/><xsl:text>').tabs();</xsl:text>

var <xsl:value-of select="concat(@xml:id, 'data')"/>=[<xsl:for-each select="./tei:ab[@type='appearancesInDiary']/tei:ab">
            <xsl:variable name="dateCount"><xsl:choose>
                    <xsl:when test="tei:date"><xsl:value-of select="count(tei:date)"/></xsl:when>
                    <xsl:otherwise>null</xsl:otherwise>
                </xsl:choose></xsl:variable>
            <xsl:value-of select="concat('[',@n,',',$dateCount, ']')"/>,</xsl:for-each>];
  
  
 <!-- [<xsl:value-of select="normalize-space(.//tei:ab[@type='results'])"/>];-->

var plot = $.plot($("<xsl:value-of select="concat('#', @xml:id, 'placeholder')"/>"),
[ { data: <xsl:value-of select="concat(@xml:id, 'data')"/>, label: "Appearances/Year", color:"#2e4c6f", clickable:true, hoverable:true, 
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



$("<xsl:value-of select="concat('#', @xml:id, 'placeholder')"/>").bind("plotclick", function (event, pos, item) {
//     axis coordinates for other axes, if present, are in pos.x2, pos.x3, ...
 //    if you need global screen coordinates, they are pos.pageX, pos.pageY

if (item) {
$('html, body').animate({ scrollTop: $("<xsl:value-of select="concat('#', @xml:id, 'app')"/>" + item.datapoint[0]).offset().top }, 500);
//window.open("#app" + item.datapoint[0]);
//$("#clicktext").text("Click In" + item.datapoint[0] + " there were " + item.datapoint[1] + " meetings.");
}
});

$("<xsl:value-of select="concat('#', @xml:id, 'placeholder')"/>").bind("plothover", function (event, pos, item) {
if (item) {
$("<xsl:value-of select="concat('#', @xml:id, 'hovertext')"/>").text(": in " + item.datapoint[0] + " this person appears " + item.datapoint[1] + " times.");
}


});

<!--
	  $('<xsl:value-of select="concat('#', @xml:id, 'toggle')"/>').click(function(){
	       $('<xsl:value-of select="concat('#', @xml:id, 'tabs')"/>').toggle();
	          });
-->

<!--
$('<xsl:value-of select="concat('#', @xml:id, 'tabs')"/>').tabs({
select: function(event, ui) {
var tabid = ui.tab.id;
if( tabid='mmbrowserLink'){
window.location.href = 'http://www.google.com';
return false;
}
return true;
}
});
-->
<!--
$('<xsl:value-of select="concat('#', @xml:id, 'tabs')"/>').tabs({
select: function() {
window.location.href = $(this).attr('href');	//go to link from a tag.
}
});
-->
<!--$('#mmbrowserLink').attr('href', '<xsl:value-of select="concat('http://godwindiary.bodleian.ox.ac.uk/mmbrowser/', @xml:id, '.html')"/>');
     -->
</xsl:for-each>
$('#myTable').dataTable(
{
"sDom": 'flprtip',
"sPaginationType": "full_numbers",
        "bAutoWidth": false,
	"bStateSave": true,
	"bProcessing": true,
	"bSortClasses": false,
	"iCookieDuration": 300,
"oLanguage": {
"sSearch": 'Search Filter',
"sLengthMenu": 'Display <select> \
	<option value="10">10</option> \
	<option value="25">25</option> \
	<option value="50">50</option> \
	<option value="100">100</option> \
	<option value="250">250</option> \
	<option value="-1">All</option> \
	</select> records '
                }
}
);

});      
</script>
          
          <link rel="stylesheet" type="text/css" href="/dataTables/css/demo_table.css" > </link>
          <link rel="stylesheet" type="text/css" href="/dataTables/css/demo_page.css" > </link>
          <link rel="stylesheet" type="text/css" href="/godwin-dataTable.css" > </link>
      </head>
      <body>


<xsl:apply-templates select=".//tei:person"/>

</body>
</html>

</xsl:template>

<xsl:template match="tei:person">
  <xsl:variable name="id" select="@xml:id"/>
        <div class="person" id="{concat($id, 'top')}" >
		<h2> <xsl:if test="tei:persName/tei:surname[text()]"><xsl:value-of select="tei:persName/tei:surname"/>,<xsl:text> </xsl:text> </xsl:if>
			<xsl:for-each select="tei:persName/tei:*[not(name()='surname')][not(name()='addName')]"> <xsl:value-of select="."/><xsl:text> </xsl:text> </xsl:for-each>
			<xsl:if test="tei:persName/tei:addName[text()]">(<xsl:value-of select="tei:persName/tei:addName[text()]"/>)</xsl:if>
			<!--		  <span title="Toggle display person" id="{concat($id, 'toggle')}" class="personToggle"><span class="plusMinus">+/-</span></span>-->
		</h2>
<div id="{concat(@xml:id, 'tabs')}">
<ul>
<li><a href="{concat('#',@xml:id,'-appearances')}">Diary Appearances</a></li>
<li><a href="{concat('#',@xml:id,'-bio')}">Biographical Details</a></li>
<li><a href="{concat('#',@xml:id,'-notes')}">Editorial Notes</a></li>
<li><a href="{concat('#',@xml:id,'-bibl')}">Bibliography</a></li>
 <li><a href="{concat('#',@xml:id,'-acquaintances')}">Acquaintances</a></li>
<!--<li><a id="mmbrowserLink" class="followtablink"  target="_blank" href="{concat('/mmbrowser/',@xml:id,'.html')}">Meals and Meeting</a></li>-->
</ul>

  <div id="{concat(@xml:id, '-appearances')}">
    <xsl:choose>
      <xsl:when test="tei:ab[@type='appearancesInDiary']">

        <div id="{concat(@xml:id, 'placeholder')}" style="width:550px;height:250px"></div>
	      <div class="flotCaption"><p>
	        Hover over a bar to see number of appearances/year<span id="{concat(@xml:id, 'hovertext')}">.</span>
			      <br/> 
			      Click on a bar to jump to that year.
	      </p>
	        <p>
	          <xsl:variable name="numMentions" select="count(tei:ab[@type='appearancesInDiary']/tei:ab/tei:date)"/>
	          <xsl:variable name="numVenues" select="count(tei:ab[@type='appearancesInDiary']/tei:ab/tei:date[@n='venue'])"/>
	          <xsl:variable name="numNotAtHomes" select="count(tei:ab[@type='appearancesInDiary']/tei:ab/tei:date[@type='nah'])"/>
	          
		  This person is mentioned in the diary a total of <xsl:value-of select="$numMentions"/> time<xsl:if test="$numMentions &gt; 1">s</xsl:if>,
		  <xsl:if test="$numNotAtHomes &gt; 0">
			  but was not at home (<span class="notAtHomeinline">N</span>) <xsl:value-of select="$numNotAtHomes"/>
			  time<xsl:if test="$numNotAtHomes &gt; 1">s</xsl:if>, 
		  </xsl:if>
		  and 
	          was a venue (<span class="venueVinline">V</span>) <xsl:value-of select="$numVenues"/> time<xsl:choose><xsl:when test="$numVenues=0 or $numVenues &gt; 1">s</xsl:when><xsl:otherwise/></xsl:choose>.</p>

	  <p>You may also examine their <a href="{concat('/mmbrowser/', @xml:id, '.html')}">meals and meetings</a> in more detail.</p>
	      </div>
	      <div>
		      <xsl:for-each select="tei:ab[@type='appearancesInDiary']/tei:ab[tei:date]">
		        <h4 id="{concat($id, 'app', @n)}"><xsl:value-of select="@n"/> <a href="{concat('#', $id, 'top')}" class="navArrow" title="Go to Top"><img src="/dataTables/images/sort_asc.png" border="0"/></a></h4>
			<p class="appearances">
		<xsl:for-each select="tei:date[position() mod 4 = 1]">
				<xsl:for-each select=".|following-sibling::tei:date[position() &lt; 4]">
					<span class="appearance"><a href="{concat('/diary/', @when, '.html')}" class="appearanceDate"><xsl:value-of select="g:date(@when)"/></a><xsl:text>  </xsl:text>
<xsl:if test="@type='nah' or @n='venue'">(<xsl:if test="@type='nah'"><span class="notAtHomeN">N</span></xsl:if>
				<xsl:if test="@n='venue'"><span class="venueV">V</span></xsl:if>)
			</xsl:if>
			</span>
			</xsl:for-each>
			<!--<br/> -->
    </xsl:for-each>
    </p>

          </xsl:for-each>
</div>
      </xsl:when>
      <xsl:otherwise>No appearances in the diary found</xsl:otherwise>
    </xsl:choose>
    
  </div>
  
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


<div id="{concat(@xml:id, '-notes')}">
<xsl:choose>
<xsl:when test="tei:note">
<xsl:apply-templates select="tei:note"/>
</xsl:when>
<xsl:otherwise><p>No notes currently available</p></xsl:otherwise>
</xsl:choose>
</div>

  
<div id="{concat(@xml:id, '-bibl')}">
<xsl:choose>
<xsl:when test="tei:bibl">
                  <ul>
                    <xsl:for-each select="tei:bibl">
                      <xsl:sort select="@type"/>
                      <xsl:sort select="tei:author"/>
                      <li>
                        <xsl:apply-templates/>
                      </li>
                    </xsl:for-each>
</ul>

</xsl:when>
<xsl:otherwise><p>No bibliographic items currently available</p></xsl:otherwise>
</xsl:choose>
</div>
    
    <div id="{concat(@xml:id, '-acquaintances')}">
        <xsl:variable name="get-relationships" select="concat('http://godwindiary.bodleian.ox.ac.uk/get-personRelations.xq?id=', @xml:id)"/>
        <xsl:variable name="relationships">
            <xsl:copy-of select="doc($get-relationships)"/>
         </xsl:variable>
        <p>This table lists the people this person is most frequently noted with in the diary.</p>
      <div class="table">  <table id="myTable" class="dataTable">
            <thead>
                <tr class="label"><th>Name</th><th>Number of Meetings</th></tr>
            </thead>
            <xsl:for-each select="$relationships/tei:list/tei:persName">
            <xsl:variable name="url" select="concat('http://godwindiary.bodleian.ox.ac.uk/get-persName.xq?id=', @ref)"/>
               <tr><td><xsl:value-of select="document($url)//tei:ab[@type='renderedName']"/></td> <td><xsl:value-of select="@n"/></td></tr>
               </xsl:for-each>
            </table>
    </div>
    </div>
    
    
<!--
<div id="{concat(@xml:id, '-other2')}">
<p>other2 stuff here</p>
</div>

<div id="{concat(@xml:id, '-other3')}">
<p>other3 stuff here</p>
</div>

<div id="{concat(@xml:id, '-other4')}">
<p>other4 stuff here</p>
</div>

<div id="{concat(@xml:id, '-other5')}">
<p>other5 stuff here</p>
</div>
-->

</div>
<div class="XML-Link"><a class="XML-link" href="{concat('/people/',$id ,'.xml')}"><img src="/images/xml_icon.gif" border="0" alt="XML" height="16" width="40"/></a></div>
</div>

  </xsl:template>

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


</xsl:stylesheet>
