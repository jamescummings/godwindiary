<xsl:stylesheet version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
     xmlns:g="http://godwindiaries.bodleian.ox.ac.uk" 
xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="functions.xsl"/>
<xsl:strip-space elements="*"/>
<xsl:param name="type">foo</xsl:param>
<xsl:variable name="tableType" select="lower-case($type)"/>

<xsl:variable name="tableWord">
<xsl:choose>
<xsl:when test="//tei:table[1]/@type='venues'">People (as venues)</xsl:when>
<xsl:when test="//tei:table[1]/@type='biblTable'">Texts Godwin Read: Annotated Titles 1788-1836</xsl:when>
<xsl:when test="//tei:titleStmt/tei:title[1]"><xsl:value-of select="//tei:titleStmt/tei:title[1]"/></xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@type='eventListing']">
<xsl:choose>
<xsl:when test="//tei:table[1]/tei:head[@subtype='accts']">Events -- Accounts</xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@subtype='lect']">Events -- Lectures</xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@subtype='gardens']">Events -- Garden Visits</xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@subtype='death']">Events -- Deaths</xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@subtype='museo']">Events -- Museum Visits</xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@subtype='musical']">Events -- Musical</xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@subtype='exhib']">Events -- Exhibitions</xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@subtype='other']">Events -- Other Events</xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@subtype='parl']">Events -- Parliament</xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@subtype='persevent']">Events -- Personal Events</xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@subtype='theat']">Events -- Theatre Performances</xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@subtype='pershlth']">Events -- Health</xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@subtype='publ']">Events -- Public Events</xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@subtype='temp']">Events -- Temperature</xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@subtype='trial']">Events -- Trials</xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@subtype='weath']">Events -- Weather</xsl:when>
<xsl:otherwise>Event Listing</xsl:otherwise>
</xsl:choose>
</xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@type='mealListing']">
	<xsl:choose>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='D']">Meals -- Dines </xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='DG']">Meals -- Dines (At Godwin's)</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='B']">Meals -- Breakfasts </xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='BG']">Meals -- Breakfasts (At Godwin's)</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='S']">Meals -- Sups </xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='SG']">Meals -- Sups (At Godwin's)</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='TG']">Meals -- Tea (At Godwin's)</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='TA']">Meals -- Tea </xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='OTHER']">Meals -- Other</xsl:when>
	</xsl:choose>

</xsl:when>
<xsl:when test="//tei:table[1]/tei:head[@type='textListing']">
	<xsl:choose>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='CALA']">Reading -- Texts Read Cala</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='DISC']">Reading -- Texts Discussed</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='LETTERRECVD']">Reading -- Letters Received</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='MENTION']">Reading -- Texts Mentioned</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='OTHER']">Reading -- Other</xsl:when>
	</xsl:choose>
</xsl:when>

<xsl:when test="//tei:table[1]/tei:head[@type='dWroteListing']">
	<xsl:choose>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='ALL']">Writing -- All Types</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='CALA']">Writing -- Texts Written Cala</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='CORR']">Writing -- Texts Corrected</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='EDIT']">Writing -- Texts Edited</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='INVENT']">Writing -- Texts Invented</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='LETTER']">Writing -- Letters Written</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='MEDITATE']">Writing -- Meditated on Writing</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='NOTES']">Writing -- Notes Made</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='REVISED']">Writing -- Texts Revised</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='SENT']">Writing -- Texts Sent</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='TRANSCR']">Writing -- Texts Transcribed</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='TRANSLATE']">Writing -- Texts Translated</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='WRITE']">Writing -- Texts Written</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='OTHER']">Writing -- Other</xsl:when>
	</xsl:choose>
</xsl:when>

<xsl:when test="//tei:table[1]/tei:head[@type='meetingListing']">
	<xsl:choose>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='ADV']">Meetings -- Adveni</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='APRES']">Meetings -- Après Diner</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='APRESG']">Meetings -- Après Diner (at Godwin's)</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='AUS']">Meetings -- Au Soir</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='C']">Meetings -- Godwin on X</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='CG']">Meetings -- X calls (on Godwin)</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='CGN']">Meetings -- X/Y/Z call (on Godwin)</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='CN']">Meetings -- Godwin and X/Y/Z call (on someone)</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='DO']">Meetings -- Do with X</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='INV']">Meetings -- Invited</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='M']">Meetings -- Godwin meets X</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='NAME']">Meetings -- Named</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='PPC']">Meetings -- Pour prendre congé</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='PPCG']">Meetings -- Pour prendre congé (at Godwin's)</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='PR']">Meetings -- X present</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='SEE']">Meetings -- Godwin sees X</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='SEND4']">Meetings -- Send for</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='SITTO']">Meetings -- Sit to</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='SLEEPAT']">Meetings -- Sleep at</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='SLEEPS']">Meetings -- Sleeps (At Godwin's)</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='SLEEPOTHER']">Meetings -- Others sleep elsewhere</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='SK']">Meetings -- Seek</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='TOHAVE']">Meetings -- Meeting intended</xsl:when>
		<xsl:when test="//tei:table[1]/tei:head[@subtype='OTHER']">Meetings -- Other</xsl:when>
	</xsl:choose>
</xsl:when>

<xsl:otherwise><xsl:value-of select="//tei:table[1]/tei:head"/></xsl:otherwise>
</xsl:choose> 
</xsl:variable>

  <!-- A  tei table to HTML file-->
  <xsl:template match="/">
    <html>
      <head>
	      <script type="text/javascript" src="/jquery-latest.js"><xsl:comment>Fake comment</xsl:comment></script> 
	<!--<script type="text/javascript" id="js">$(document).ready(function() {
	// call the tablesorter plugin
	$("#myTable").tablesorter({
		// sort on the first column and third column, order asc
		sortList: [[0,0]],
		 widgets: ['zebra']
	});
</script>
-->
<!--<script type="text/javascript" src="/jquery-tablesorter.js"></script> 
<script type="text/javascript" id="js">$(document).ready(function() {
	// call the tablesorter plugin
	$("#myTable").tablesorter({
		// sort on the first column and third column, order asc
		sortList: [[0,0]],
		 widgets: ['zebra']
	});
}); </script>
-->
<script type="text/javascript" src="/dataTables/js/jquery.dataTables.js"><xsl:comment> Fake comment</xsl:comment> </script>
<script type="text/javascript">
$(document).ready(function() {
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

	} );
</script>

<!-- 


"oLanguage": {
"sLengthMenu": 'Display <select><option value="10">10</option><option value="25">25</option><option value="50">50</option><option value="100">100</option><option value="250">250</option><option value="-1">All</option></select> records ',
                }


-->

<link rel="stylesheet" type="text/css" href="/dataTables/css/demo_table.css" > </link>
<link rel="stylesheet" type="text/css" href="/dataTables/css/demo_page.css" > </link>
<link rel="stylesheet" type="text/css" href="/godwin-dataTable.css" > </link>
<title> <xsl:value-of select="$tableWord"/></title>
</head>
<body>
<xsl:choose>
<xsl:when test="$tableType='IdentifiedPeople'">
<xsl:apply-templates select="//tei:table[tei:head/@type='IdentifiedPeople']"/>
</xsl:when>
<xsl:when test="$tableType='UnidentifiedPeople'">
<xsl:apply-templates select="//tei:table[tei:head/@type='UnidentifiedPeople']"/>
</xsl:when>
<xsl:otherwise><xsl:apply-templates select="//tei:table"/></xsl:otherwise>
</xsl:choose>
</body>
</html>
</xsl:template>

<xsl:template match="tei:table">
        <div class="table">
          <h2> <xsl:value-of select="$tableWord"/></h2>
          <table id="myTable" class="dataTable" >
	<thead>
	 <xsl:apply-templates select="tei:row[1]"/>
	</thead> 
	<tbody>
	 <xsl:apply-templates select="tei:row[not(position()=1)]"/>
	</tbody> 
          </table>
        </div>
  </xsl:template>
  
  <xsl:template match="tei:row"><tr><xsl:if test="@rend"><xsl:attribute name="class"><xsl:value-of select="@rend"/></xsl:attribute></xsl:if><xsl:apply-templates /></tr></xsl:template>
  
  <xsl:template match="tei:cell[ancestor::tei:row/@rend='label']"><th><xsl:if test="@n"><xsl:attribute name="class"><xsl:value-of select="@n"/></xsl:attribute></xsl:if><xsl:apply-templates /></th></xsl:template>

  <xsl:template match="tei:cell"><td><xsl:if test="@n"><xsl:attribute name="class"><xsl:value-of select="@n"/></xsl:attribute></xsl:if><xsl:apply-templates /></td></xsl:template>
  <xsl:template match="tei:cell[@n='count'][tei:seg/@type='nah' or tei:seg/@type='venue']"><td title="Number of mentions (inc. Venue or Not at home)"><xsl:if test="@n"><xsl:attribute name="class"><xsl:value-of select="@n"/></xsl:attribute></xsl:if><xsl:apply-templates /></td></xsl:template>
  <xsl:template match="tei:seg[@type='count']"><span class="bold"><xsl:value-of select="."/></span><xsl:text> </xsl:text> </xsl:template>
  <xsl:template match="tei:seg[@type='venueCount']">  <xsl:value-of select="."/> (<span class="venueV" title="Person as venue">V</span>) </xsl:template>
  <xsl:template match="tei:seg[@type='venue']">  (<xsl:value-of select="."/><span class="venueV" title="Person as venue">V</span>) </xsl:template>
  <xsl:template match="tei:seg[@type='nah']">  (<xsl:value-of select="."/><span class="notAtHomeN" title="Person was not home">N</span>) </xsl:template>
  <xsl:template match="tei:cell[@n='sex'][contains(., 'Unknown')]"><td><xsl:if test="@n"><xsl:attribute name="class"><xsl:value-of select="@n"/></xsl:attribute></xsl:if><span class="unknownSex"><xsl:apply-templates /></span></td></xsl:template>
  
  <xsl:template match="tei:persName">
	  <xsl:choose>
<xsl:when test="tei:surname or tei:addName or tei:forename or tei:roleName">
	  <xsl:if test="tei:surname[text()]"><xsl:value-of select="tei:surname"/>,<xsl:text> </xsl:text> </xsl:if>
    <xsl:for-each select="tei:*[not(name()='surname')][not(name()='addName')]">
      <xsl:value-of select="."/><xsl:text> </xsl:text>
    </xsl:for-each>
    <xsl:if test="tei:addName[text()]">(<xsl:value-of select="tei:addName[text()]"/>)</xsl:if>
    </xsl:when>
    <xsl:when test="@ref"><a class="persName" href="{@ref}"><xsl:apply-templates/></a></xsl:when>
    <xsl:otherwise>
        <xsl:variable name="strippedName"><xsl:value-of select="replace(lower-case(normalize-space(.)), '[^a-z0-9]', '')"/></xsl:variable>
        
	    <a href="{concat('/people/unidentified/', $strippedName,  '.html')}" class="unidentifiedPersName"> <xsl:apply-templates/></a></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tei:table[tei:head/@type='UnidentifiedPeople' or tei:head/@type='IdentifiedPeople']//tei:persName"><a class="persName" href="{@ref}"><xsl:apply-templates/></a></xsl:template>

  <xsl:template match="tei:birth | tei:death | tei:date">
	  <xsl:choose>
		  <xsl:when test="@when and not(@when='1000')"><span class="hidden"><xsl:value-of select="@when"/>: </span> <xsl:value-of select="g:date(@when)"/> </xsl:when>
		  <xsl:when test="@notBefore and @notAfter"><span class="hidden"><xsl:value-of select="@notBefore"/>: </span><span class="notBefore">Not Before:</span> <xsl:value-of select="g:date(@notBefore)"/> -  <br/><span class="notAfter">Not After: </span> <xsl:value-of select="g:date(@notAfter)"/> </xsl:when>
		  <xsl:when test="not(@notBefore) and @notAfter"><span class="hidden"><xsl:value-of select="@notAfter"/>: </span><span class="notAfter">Not After:</span> <xsl:value-of select="g:date(@notAfter)"/></xsl:when>
		  <xsl:when test="@notBefore and not(@notAfter)"><span class="hidden"><xsl:value-of select="@notBefore"/>: </span><span class="notBefore">Not Before:</span> <xsl:value-of select="g:date(@notBefore)"/> </xsl:when>
		  <xsl:when test="@when='1000'"><span class="unknownDate">Unknown</span></xsl:when>
		  <xsl:otherwise> <xsl:value-of select="."/></xsl:otherwise>
		  </xsl:choose>
		  <!--    <xsl:choose>
      <xsl:when test="@when='1000'"/>
      <xsl:otherwise><xsl:value-of select="g:date(@when)"/></xsl:otherwise>
    </xsl:choose>-->
<!--    <xsl:if test="tei:placeName[text()][not(text()=' ')]"><xsl:text> </xsl:text>  (<xsl:value-of select="tei:placeName"/>)</xsl:if>  -->
    </xsl:template>




<xsl:template match="tei:ref[@target]">
  <a href="{@target}"><xsl:apply-templates/></a>
  </xsl:template>

<xsl:template match="tei:foreign">
	<xsl:text>  
	</xsl:text>	<span class="foreign">  <xsl:apply-templates/></span>
  </xsl:template>

<xsl:template match="tei:date[@when][ancestor::tei:table/@type='badDiaryEntries']">
<a href="{concat('/diary/', @when, '.html')}"><xsl:value-of select="g:date(@when)"/></a>
</xsl:template>

<xsl:template match="tei:date[@when][ancestor::tei:table]">
	<a href="{concat('/diary/', @when, '.html')}"><xsl:comment><xsl:value-of select="@when"/></xsl:comment> <xsl:value-of select="g:date(@when)"/></a>
</xsl:template>

<xsl:template match="tei:occupation[text()]"><xsl:apply-templates/><xsl:text>; </xsl:text></xsl:template>

<xsl:template match="tei:ref[@type='dEvent' or @type='dEntertainment']"><xsl:apply-templates/></xsl:template>
<xsl:template match="tei:ref[@target][@type='dEvent' or @type='dEntertainment']" priority="1"> <span class="{concat(@type, ' ', @subtype)}"><xsl:apply-templates/></span><sup><a href="{translate(@target,' ', '|')}" class="eventRef">e</a></sup></xsl:template>

<xsl:template match="tei:ref[@type='dEvent' or @type='dEntertainment']//tei:persName">
<xsl:choose>
<xsl:when test="@ref">
<a href="{@ref}" class="persName"><xsl:apply-templates/></a>
</xsl:when>
<xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
</xsl:choose>
</xsl:template>
 
  <xsl:template match="tei:cell[count(tei:ref) &gt; 1]">
    <td>
      <xsl:for-each select="tei:ref"><xsl:apply-templates select="self::node()"/><br/></xsl:for-each>
    </td>
  </xsl:template>
  

  <xsl:template match="tei:lb"><br/></xsl:template>
  <xsl:template match="tei:hi[@rend]"><span class="{@rend}"><xsl:apply-templates/></span></xsl:template>
<xsl:template match="tei:cell/tei:list"><ul><xsl:apply-templates/></ul></xsl:template>
<xsl:template match="tei:cell/tei:list/tei:item"><li><xsl:apply-templates/><xsl:text>;  </xsl:text></li></xsl:template>

</xsl:stylesheet>
