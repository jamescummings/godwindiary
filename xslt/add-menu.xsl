<xsl:stylesheet version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
xmlns="http://www.w3.org/1999/xhtml"
xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"  encoding="UTF-8" indent="yes" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
 
<xsl:template match="@*|node()|comment()|processing-instruction()" priority="-1">
 <xsl:copy><xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/></xsl:copy>
</xsl:template>

<xsl:template match="html:body | body">
<body>
<xsl:apply-templates select="@*"/>
 <anchor id="top" name="top"/>
 <div class="godwinHeaderDiv">
  <h1 class="godwinHeader"><a href="/index2.html" style="text-decoration:none;padding:none;border:none;"><img alt="William Godwin's Diary" title="William Godwin's Diary Home Page" src="/images/godwin-logo-sml-white.png" border="0" style="border:none;padding:none;" /></a><!--<a href="/index2.html">William Godwin's Diary</a>--><!--<img id="betaLogo" src="/images/beta.gif" height="35" width="35" title="Beta: This website is in a beta state, use are your own risk."/>--></h1>
 <xsl:copy-of select="document('../xml/nav.xml')"/>
  </div>
  <div class="pageBody"><xsl:apply-templates/></div>
<div class="footer" style="text-align:center;">
	<hr/>
<p><a title="godwin.diary@politics.ox.ac.uk" href="mailto:godwin.diary@politics.ox.ac.uk">Contact</a> -- <a rel="license" href="http://creativecommons.org/licenses/by-nc/3.0/"><img alt="Creative Commons Licence" style="border-width:0;vertical-align:bottom;" src="/images/ccbync.png" /></a> -- <a href="/tech.html#cookies">Cookies/Privacy</a>
</p>
</div>
</body>
</xsl:template>

<xsl:template match="html:head | head">
<head>
<xsl:apply-templates select="@*"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="William Godwin's Diary website contains transcription and high resolution images of the diary of William Godwin written from 1788-1836. William Godwin was married to Mary Wollstonecraft and father of Mary Shelley"/>
<meta name="keywords" content="William,Godwin,Diary,Mary,Wollstonecraft,Shelley,politics,TEI,XML,bodleian,OUCS"/>
<meta name="generator" content="TEI P5 XML + XSLT + eXist + Apache Cocoon"/>
 <link rel="stylesheet" type="text/css" href="/godwin.css" > </link>
 <!--<link rel="stylesheet" type="text/css" href="/tooltip-screen.css" > </link>-->

<link rel="stylesheet" type="text/css" href="/ddsmoothmenu.css" > </link>
<link rel="stylesheet" type="text/css" href="/ddsmoothmenu-v.css" > </link>
 
<script type="text/javascript" src="/js/ddsmoothmenu.js">
/***********************************************
* Smooth Navigational Menu- (c) Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
***********************************************/
</script>
<script type="text/javascript" src="/js/jquery-1.3.2.min.js">/***/ </script>

<script type="text/javascript" src="/js/jquery-ui-1.7.2.custom.min.js">/***/ </script> 

<script type="text/javascript" src="/js/scrolltop.js">/***/ </script> 

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.2.6/jquery.min.js">/***/ </script>
 
 <script type="text/javascript" src="/js/ddsmoothmenu.js">
/***********************************************
* Smooth Navigational Menu- (c) Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
***********************************************/
</script>

<script type="text/javascript">
<xsl:text>ddsmoothmenu.init({
	mainmenuid: "smoothmenu1", //menu DIV id
	orientation: 'h', //Horizontal or vertical menu: Set to "h" or "v"
	classname: 'ddsmoothmenu', //class added to menu's outer DIV
	customtheme: ["#002147", "#900"],
	contentsource: "markup" //"markup" or ["container_id", "path_to_menu_file"]
})</xsl:text>
</script>
 
<script type="text/javascript">
$(function(){
$("#input-search").focus(function() {
$(this).attr("value","");
}); });
</script>
 
<xsl:apply-templates select="node()|comment()|processing-instruction()"/>

<xsl:copy-of select="document('googleAnalytics.xml')"/>

</head>
</xsl:template>


<!--
<xsl:template match="html:div[@id='twitterFeed'] | div[@id='twitterFeed']">
 <div id="twitter_div">
  <script src="http://widgets.twimg.com/j/2/widget.js"></script>
  <script>
new TWTR.Widget({
  version: 2,
  type: 'profile',
  rpp: 20,
  interval: 5000,
  width: 250,
  height: 300,
  theme: {
    shell: {
      background: '#002147',
      color: '#ffffff'
    },
    tweets: {
      background: '#FFF',
      color: '#000',      links: '#4aed05'
    }
  },
  features: {
    scrollbar: true,
    loop: false,
    live: true,
    hashtags: true,
    timestamp: true,
    avatars: true,
    behavior: 'default'
  }
}).render().setUser('godwindiary').start();
</script>
 </div>
 
 
</xsl:template>-->
</xsl:stylesheet>
