<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
     xmlns:g="http://godwindiaries.bodleian.ox.ac.uk" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:v=
    "urn:schemas-microsoft-com:vml"
        exclude-result-prefixes="#all">
    <!-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> -->
        
<!--    <xsl:output omit-xml-declaration="no" method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" 
        indent="yes" encoding="UTF-8"/>-->
<xsl:import href="functions.xsl"/>
    
    <xsl:template match="/tei:TEI">
        
       <!-- <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" > -->
<html>
            <xsl:comment>NOTE: THIS IS A GENERATED VERSION, AND SIMPLIFIED, THE XML FILE IS THE REAL
                VERSION</xsl:comment>
            <head>
                <title>
                    <xsl:value-of select="//tei:titleStmt/tei:title"/>
                </title>
                <link href="/godwin.css" media="screen" rel="stylesheet" type="text/css"/> 
<xsl:if test="//tei:table/@rend">
                <script type="text/javascript" src="http://www.google.com/jsapi"> </script>


                <script type="text/javascript">
                        <xsl:apply-templates select=".//tei:table" mode="gv"/>
                        
                </script></xsl:if>
                
                <xsl:if test="//tei:figure[@type='mainImg']" >
                    
                    <style type="text/css">
                        v\:* {
                        behavior:url(#default#VML);
                        }
                    </style>
                    
                    
                    <script src="http://maps.google.com/maps?file=api&amp;v=2.x&amp;key=ABQIAAAAYkPzlHw33JJvTmXRkBzeShQgKOVxwn0LjiIYFKZkcifnzx7pahR357x1RTLEWA1XZZRUAOT-ctp2jw"
                        type="text/javascript"></script>
                    <script type="text/javascript">
                        //<![CDATA[

    var centreLat=0.0;
    var centreLon=0.0;
    var initialZoom=2;
    var imageWraps=true; //SET THIS TO false TO PREVENT THE IMAGE WRAPPING AROUND
    var map; //the GMap2 itself

/////////////////////
//Custom projection
/////////////////////
    function CustomProjection(a,b){
	this.imageDimension=65536;
	this.pixelsPerLonDegree=[];
	this.pixelOrigin=[];
	this.tileBounds=[];
	this.tileSize=256;
        this.isWrapped=b;
	var b=this.tileSize;
	var c=1;
	for(var d=0;d<a;d++){
          var e=b/2;
          this.pixelsPerLonDegree.push(b/360);
          this.pixelOrigin.push(new GPoint(e,e));
          this.tileBounds.push(c);
          b*=2;
          c*=2
        }
    }
 
    CustomProjection.prototype=new GProjection();
  
    CustomProjection.prototype.fromLatLngToPixel=function(latlng,zoom){
        var c=Math.round(this.pixelOrigin[zoom].x+latlng.lng()*this.pixelsPerLonDegree[zoom]);
        var d=Math.round(this.pixelOrigin[zoom].y+(-2*latlng.lat())*this.pixelsPerLonDegree[zoom]);
        return new GPoint(c,d)
    };

    CustomProjection.prototype.fromPixelToLatLng=function(pixel,zoom,unbounded){
        var d=(pixel.x-this.pixelOrigin[zoom].x)/this.pixelsPerLonDegree[zoom];
        var e=-0.5*(pixel.y-this.pixelOrigin[zoom].y)/this.pixelsPerLonDegree[zoom];
        return new GLatLng(e,d,unbounded)
    };

    CustomProjection.prototype.tileCheckRange=function(tile,zoom,tilesize){
        var tileBounds=this.tileBounds[zoom];
	if (tile.y<0 || tile.y >= tileBounds) {return false;}
        if (this.isWrapped) {
		if (tile.x<0 || tile.x>=tileBounds) { 
			tile.x = tile.x%tileBounds; 
			if (tile.x < 0) {tile.x+=tileBounds} 
		}
	}
	else { 
        	if (tile.x<0 || tile.x>=tileBounds) {return false;}
	}  
  	return true;
    }
      
    CustomProjection.prototype.getWrapWidth=function(zoom) {
        return this.tileBounds[zoom]*this.tileSize;
    }
////////////////////////////////////////////////////////////////////////////

    function customGetTileURL(a,b) {
      //converts tile x,y into keyhole string

      var c=Math.pow(2,b);

        var d=a.x;
        var e=a.y;
        var f="t";
        for(var g=0;g<b;g++){
            c=c/2;
            if(e<c){
                if(d<c){f+="q"}
                else{f+="r";d-=c}
            }
            else{
                if(d<c){f+="t";e-=c}
                else{f+="s";d-=c;e-=c}
            }
        }
        return "/i/e.196_0004r-hi-tiles/"+f+".jpg"
    }


    function getWindowHeight() {
        if (window.self&&self.innerHeight) {
            return self.innerHeight;
        }
        if (document.documentElement&&document.documentElement.clientHeight) {
            return document.documentElement.clientHeight;
        }
        return 0;
    }

    function resizeMapDiv() {
        //Resize the height of the div containing the map.
        //Do not call any map methods here as the resize is called before the map is created.
    	var d=document.getElementById("map");
        var offsetTop=0;
        for (var elem=d; elem!=null; elem=elem.offsetParent) {
            offsetTop+=elem.offsetTop;
        }
        var height=getWindowHeight()-offsetTop-16;
        if (height>=0) {
            d.style.height=height+"px";
        }
    }


    function load() {
      if (GBrowserIsCompatible()) {
        resizeMapDiv();
        var copyright = new GCopyright(1,
                              new GLatLngBounds(new GLatLng(-90, -180),
                                                new GLatLng(90, 180)),
                              0,
                              "<a href=\"http://www.casa.ucl.ac.uk\">CASA</a>");
        var copyrightCollection = new GCopyrightCollection("GMapImgCutter");
        copyrightCollection.addCopyright(copyright);

        //create a custom picture layer
        var pic_tileLayers = [ new GTileLayer(copyrightCollection , 0, 17)];
        pic_tileLayers[0].getTileUrl = customGetTileURL;
        pic_tileLayers[0].isPng = function() { return false; };
        pic_tileLayers[0].getOpacity = function() { return 1.0; };
        var proj=new CustomProjection(6,imageWraps);
        var pic_customMap = new GMapType(pic_tileLayers, proj, "Pic",
            {maxResolution:5, minResolution:0, errorMessage:"Data not available"});


        //Now create the custom map. Would normally be G_NORMAL_MAP,G_SATELLITE_MAP,G_HYBRID_MAP
        map = new GMap2(document.getElementById("map"),{mapTypes:[pic_customMap]});
        map.addControl(new GLargeMapControl());
        map.addControl(new GMapTypeControl());
	map.addControl(new GOverviewMapControl());
        map.enableDoubleClickZoom();
	map.enableContinuousZoom();
	map.enableScrollWheelZoom();
        map.setCenter(new GLatLng(centreLat, centreLon), initialZoom, pic_customMap);

/////////////////////////////////////////////////////////////////////////////////////
//Add any markers here e.g.
//      map.addOverlay(new GMarker(new GLatLng(x,y)));
/////////////////////////////////////////////////////////////////////////////////////

      }
    }

    //]]>
                    </script>
                </xsl:if>
<xsl:if test="//tei:table">
  <script type="text/javascript" src="/jquery-latest.js"><xsl:comment>Fake comment</xsl:comment></script> 
  <script type="text/javascript" src="/dataTables/js/jquery.dataTables.js"><xsl:comment> Fake comment</xsl:comment> </script>
</xsl:if>
<xsl:for-each select="//tei:table">
<xsl:variable name="id"><xsl:variable name="num"><xsl:number/></xsl:variable>
<xsl:choose>
<xsl:when test="$num=1">#myTable</xsl:when>
<xsl:when test="$num &gt; 1"><xsl:value-of select="concat('#myTable', $num)"/></xsl:when>
</xsl:choose>
</xsl:variable>
<script type="text/javascript">
$(document).ready(function() {
$('<xsl:value-of select="$id"/>').dataTable(
{
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
</xsl:for-each>

<xsl:if test="//tei:table">
<link rel="stylesheet" type="text/css" href="/dataTables/css/demo_table.css" > </link>
<link rel="stylesheet" type="text/css" href="/dataTables/css/demo_page.css" > </link>
<link rel="stylesheet" type="text/css" href="/godwin-dataTable.css" > </link>
</xsl:if>


<xsl:if test="//tei:body[@rend='splashPage']"><xsl:copy-of select="document('googleAnalytics.xml')"/>
<meta http-equiv="refresh" content="5;url=http://godwindiary.bodleian.ox.ac.uk/index2.html" />
</xsl:if>
                
            </head>
           <xsl:apply-templates/>
           
        </html>
    </xsl:template>


    <xsl:template match="tei:author"/>

    <xsl:template match="tei:text">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="tei:body">
        <body><xsl:if test="@rend"><xsl:attribute name="class" select="@rend"/></xsl:if>
            <xsl:if test="//tei:figure[@type='mainImg']">
                <xsl:attribute name="onresize">resizeMapDiv()</xsl:attribute>
                <xsl:attribute name="onload">load()</xsl:attribute>
                <xsl:attribute name="onunload">GUnload()</xsl:attribute>
                </xsl:if>
           <xsl:if test="not(@rend='splashPage')"><h1><xsl:if test="//tei:titleStmt/tei:title[1]/@rend"><xsl:attribute name="class" select="//tei:titleStmt/tei:title[1]/@rend"/></xsl:if><xsl:value-of select="//tei:titleStmt/tei:title[1]"/></h1>
            <xsl:if test="//tei:title[@type='sub']"><h2><xsl:value-of select="//tei:titleStmt/tei:title[@type='sub']"/></h2></xsl:if>
</xsl:if>
            <xsl:apply-templates/>
        </body>
    </xsl:template>

    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates select="@*|node()"/>
        </p>
    </xsl:template>



    <xsl:template match="tei:teiHeader"/>


    <xsl:template match="tei:ref">
        <a href="{@target}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template match="tei:div[not(@xml:id)]">
        <div id="{generate-id(.)}">
            <xsl:apply-templates select="@*|node()|comment()"/>
        </div>
    </xsl:template>

    <xsl:template match="tei:div[@xml:id]">
        <div id="{@xml:id}">
            <xsl:apply-templates select="@*|node()|comment()"/>
        </div>
    </xsl:template>

    <xsl:template match="@xml:id">
        <xsl:attribute name="id">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

<xsl:template match="tei:table[not(@xml:id='list1796')]">
        <table style="border:thin black solid;">
<xsl:attribute name="id"><xsl:variable name="num"><xsl:number/></xsl:variable>
<xsl:choose>
<xsl:when test="$num=1">myTable</xsl:when>
<xsl:when test="$num &gt; 1"><xsl:value-of select="concat('myTable', $num)"/></xsl:when>
</xsl:choose>
</xsl:attribute>
         <xsl:apply-templates select="tei:row[1]"/>
        <tbody>
         <xsl:apply-templates select="tei:row[not(position()=1)]"/>
        </tbody> 

        </table>
    </xsl:template>

 <xsl:template match="tei:row[1]">
    <thead><xsl:if test="@rend"><xsl:attribute name="class"><xsl:value-of select="@rend"/></xsl:attribute></xsl:if>
    <xsl:for-each select="tei:cell"><th n="label"><xsl:apply-templates /></th></xsl:for-each>
    </thead>
  </xsl:template>
  
 <xsl:template match="tei:row">
    <tr><xsl:if test="@rend"><xsl:attribute name="class"><xsl:value-of select="@rend"/></xsl:attribute></xsl:if>
    <xsl:apply-templates />
    </tr>
  </xsl:template>
  
  <xsl:template match="tei:cell[ancestor::tei:row/@rend='label']">
    <th><xsl:if test="@n"><xsl:attribute name="class"><xsl:value-of select="@n"/></xsl:attribute></xsl:if>
      <xsl:apply-templates />
    </th>
  </xsl:template>

  <xsl:template match="tei:cell[ancestor::tei:row[1]]">
    <th><xsl:if test="@n"><xsl:attribute name="class"><xsl:value-of select="@n"/></xsl:attribute></xsl:if>
      <xsl:apply-templates />
    </th>
  </xsl:template>

    <xsl:template match="tei:cell[not(ancestor::tei:table/@rend='glist1796Table')]">
    <td><xsl:if test="@n"><xsl:attribute name="class"><xsl:value-of select="@n"/></xsl:attribute></xsl:if>
      <xsl:apply-templates />
    </td>
  </xsl:template>


    <xsl:template match="tei:row[@type='headers']/tei:cell">
        <th style="border:thin black solid;">
            <xsl:apply-templates/>
        </th>
    </xsl:template>
    
        
    <xsl:template match="tei:table" mode="gv">
        <xsl:choose>
            <xsl:when test="@rend='gv_columnchart'">
                <xsl:variable name="firstHeading" select="tei:row[@type='headers']/tei:cell[1]"/>
                <xsl:variable name="rows" select="count(tei:row[not(@type='headers')])"/>
                <xsl:text>google.load("visualization", "1", {packages:["columnchart"]});
                    google.setOnLoadCallback(drawChart);
                    function drawChart() {
                    var data = new google.visualization.DataTable();
                    data.addColumn('string', '</xsl:text><xsl:value-of select="$firstHeading" />');<xsl:for-each select="tei:row[@type='headers']/tei:cell[position() > 1]">
                        data.addColumn('number', '<xsl:value-of select="."/>');</xsl:for-each>data.addRows(<xsl:value-of select="$rows"/>);
                <xsl:for-each select="tei:row[not(@type='headers')]">
                    <xsl:variable name="pos" select="position()-1"/>
                    <xsl:for-each select="tei:cell">
                        <xsl:choose>
                            <xsl:when test="position()=1"><xsl:text>data.setValue(</xsl:text><xsl:value-of select="$pos"/>, <xsl:value-of select="position()-1"/>, '<xsl:value-of select="."/>');</xsl:when>
                            <xsl:otherwise><xsl:text>data.setValue(</xsl:text><xsl:value-of select="$pos"/>, <xsl:value-of select="position()-1"/>, <xsl:value-of select="."/>);</xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each></xsl:for-each>
                <xsl:text>
                    var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
                    chart.draw(data, { height:350, is3D: true, title: 'Some Random Chart Title'});
                    }
                </xsl:text>
            </xsl:when>
            <xsl:when test="@rend='gv_barchart'">
                <xsl:variable name="firstHeading" select="tei:row[@type='headers']/tei:cell[1]"/>
                <xsl:variable name="rows" select="count(tei:row[not(@type='headers')])"/>
                <xsl:text>google.load("visualization", "1", {packages:["barchart"]});
                    google.setOnLoadCallback(drawChart);
                    function drawChart() {
                    var data = new google.visualization.DataTable();
                    data.addColumn('string', '</xsl:text><xsl:value-of select="$firstHeading" />');<xsl:for-each select="tei:row[@type='headers']/tei:cell[position() > 1]">
                        data.addColumn('number', '<xsl:value-of select="."/>');</xsl:for-each>data.addRows(<xsl:value-of select="$rows"/>);
                <xsl:for-each select="tei:row[not(@type='headers')]">
                    <xsl:variable name="pos" select="position()-1"/>
                    <xsl:for-each select="tei:cell">
                        <xsl:choose>
                            <xsl:when test="position()=1"><xsl:text>data.setValue(</xsl:text><xsl:value-of select="$pos"/>, <xsl:value-of select="position()-1"/>, '<xsl:value-of select="."/>');</xsl:when>
                            <xsl:otherwise><xsl:text>data.setValue(</xsl:text><xsl:value-of select="$pos"/>, <xsl:value-of select="position()-1"/>, <xsl:value-of select="."/>);</xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each></xsl:for-each>
                <xsl:text>
                    var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
                    chart.draw(data, { height:880, width:600, is3D: true, title: 'Some Random Chart Title'});
                    }
                </xsl:text>
                
            </xsl:when>
        </xsl:choose>
        
        </xsl:template>
    
    
    <!--
        data.addColumn('string', 'Year');
        data.addColumn('number', 'Sales');
        data.addColumn('number', 'Expenses');
        data.addRows(4);
        data.setValue(0, 0, '2004');
        data.setValue(0, 1, 1000);margin-left:auto; margin-right:auto;
        data.setValue(0, 2, 400);
        data.setValue(1, 0, '2005');
        data.setValue(1, 1, 1170);
        data.setValue(1, 2, 460);
        data.setValue(2, 0, '2006');
        data.setValue(2, 1, 660);
        data.setValue(2, 2, 1120);
        data.setValue(3, 0, '2007');
        data.setValue(3, 1, 1030);
        data.setValue(3, 2, 540); -->
    <!--
    <xsl:template match="tei:row" mode="gv_columchart">
        <tr>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    
    <xsl:template match="tei:cell" mode="gv_columchart">
        <td style="border:thin black solid;">
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    
    <xsl:template match="tei:row[@type='headers']/tei:cell" mode="gv_columchart">data.addColumn('number', '<xsl:value-of select="."/>');</xsl:template>
    -->
    
    
    
    
    <xsl:template match="tei:figure[tei:figDesc]">
        <img src="{tei:graphic/@url}" border="0px;" alt="{normalize-space(tei:figDesc)}" title="{normalize-space(tei:figDesc)}" ><xsl:if test="@rend"><xsl:attribute name="class" select="@rend"/></xsl:if><xsl:apply-templates select="@*"/></img>
     </xsl:template>


    <xsl:template match="tei:figure[@type='mainImg']">
        <div id="map" style="width:60%;"></div>
    </xsl:template>

    <xsl:template match="tei:graphic[@url]"><img src="{@url}" border="0"><xsl:if test="@rend"><xsl:attribute name="class" select="@rend"/></xsl:if><xsl:if test="tei:desc"><xsl:attribute name="alt" select="tei:desc"/></xsl:if></img></xsl:template>
    
    <xsl:template match="tei:head">
<xsl:choose>
<xsl:when test="ancestor::tei:body/@rend='splashPage'">
<h1 class="splashPage"><xsl:apply-templates/></h1>
</xsl:when>
    <xsl:otherwise>    <xsl:variable name="depth">
            <xsl:choose>
                <xsl:when test="count(ancestor::*) -3 &gt; 6">6</xsl:when>
                <xsl:otherwise> <xsl:value-of select="count(ancestor::*) -3"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
	<xsl:element name="{concat('h',$depth)}"><xsl:apply-templates />
	  <a href="#top" class="navArrow" title="Go to Top
		  "><img src="/dataTables/images/sort_asc.png" border="0"/></a></xsl:element>
</xsl:otherwise>
</xsl:choose>
    </xsl:template>
    

    <xsl:template match="tei:lb"><br /></xsl:template>
    

<xsl:template match="tei:list[not(@type)] | tei:list[@type='unordered']">
    <ul><xsl:apply-templates/></ul>
</xsl:template>
    
    <xsl:template match="tei:item">
        <li><xsl:apply-templates select="@*|node()" /></li>
    </xsl:template>

<xsl:template match="tei:listBibl"><div><xsl:apply-templates/></div></xsl:template>
    
<xsl:template match="tei:bibl"><p class="bibl"><xsl:apply-templates/></p></xsl:template>
<xsl:template match="tei:title"><span class="title"><xsl:apply-templates/></span></xsl:template>
    



<xsl:template match="@type">
    <xsl:attribute name="class"><xsl:value-of select="."/></xsl:attribute>
</xsl:template>

<xsl:template match="@rend">
<xsl:attribute name="class"><xsl:value-of select="."/></xsl:attribute>
</xsl:template>

<xsl:template match="tei:list[ancestor::tei:text/@n='imageList']"><p class="folioList"><xsl:apply-templates/></p></xsl:template>
    
<xsl:template match="tei:item[ancestor::tei:text/@n='imageList']"><xsl:apply-templates/></xsl:template>
    
    <xsl:template match="tei:ptr[ancestor::tei:text/@n='imageList']">
 <xsl:variable name="folio">
        <xsl:call-template name="removeLeadingZeros">
            <xsl:with-param name="string">
                <xsl:value-of select="substring-after(@target, '_')"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:variable>
        <a href="/folio/{@target}"><xsl:value-of select="$folio"/></a>
    </xsl:template>


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

    
<xsl:template match="tei:divGen[@type='1796List']">
<xsl:variable name="list1796" select="document('http://godwin.oucs.ox.ac.uk:8081/get-diary-bit.xq?date=list1796')//tei:div[@xml:id='glist1796']"/>
<xsl:apply-templates select="$list1796/*"/>
</xsl:template>

<xsl:template match="tei:divGen[@type='freeSearch']">
<div class="searchbox"> 
  <form id="searchform" method="get"
	action="http://googlesearch.oucs.ox.ac.uk/search"> 
    <fieldset>
      <legend>Search William Godwin's Diary (freetext)</legend> 
      <input type="hidden" name="as_sitesearch" value="godwindiary.bodleian.ox.ac.uk"/>
      <input name="UnitPicture"   type="hidden" value="http://godwindiary.bodleian.ox.ac.uk/images/godwin-logo-sml-white.png"/>
      <input name="client" value="oxford" type="hidden"/> 
      <input name="proxystylesheet" value="oxford" type="hidden"/> 
      <input name="Unit" value="William Godwins Diary" type="hidden"/>
      <input name="q" id="input-search" size="25" onfocus="clearsearch();" maxlength="2048" value="Search Website"  type="text"/>
      <input name="Go" value="Go!" type="submit"/>
    </fieldset>
  </form>
</div>
</xsl:template>



<xsl:template match="tei:divGen[@type='toc']">
    <div id="toc">
        <h2>Table of Contents</h2>
        <p class="toc">
        <xsl:apply-templates select="//tei:div[tei:head]" mode="maketoc"/>
            </p>
        </div>
</xsl:template>
    
    <xsl:template match="tei:div[tei:head]" mode="maketoc">
        <a  href="#{generate-id(.)}" class="tocEntry"><xsl:number format="1.1.1.1" level="multiple" count="tei:div[tei:head]"/>. <xsl:value-of select="tei:head"/></a><br/>
    </xsl:template>
    
<xsl:template match="tei:gi">&lt;<xsl:apply-templates/>&gt;</xsl:template>
    
    <xsl:template match="tei:hi">
        <span><xsl:choose>
            <xsl:when test="@rend"><xsl:attribute name="class"><xsl:value-of select="concat('hi ', @rend)"/></xsl:attribute></xsl:when>
            <xsl:otherwise><xsl:attribute name="class">hi bold</xsl:attribute></xsl:otherwise>
        </xsl:choose>
            <xsl:apply-templates/></span>
    </xsl:template>
    
    
    
    <!--<xsl:template match="*" priority="-10"><span class="warning">WARNING ELEMENT "<xsl:value-of select="name()"/>" NOT CATERED FOR!</span></xsl:template>-->
    
<xsl:template match="tei:divGen[@type='twitterFeed']">
    <div id="twitterFeed">
<!--
	    <script src="http://widgets.twimg.com/j/2/widget.js">
		    <xsl:comment>space</xsl:comment>
	    </script>
	    <script>
new TWTR.Widget({
version: 2,
type: 'profile',
rpp: 10,
interval: 6000,
width: '200',
height: 'auto',
theme: {
      shell: {
            background: '#002147',
	          color: '#ffffff'
      },
          tweets: {
	        background: '#ffffff',
      color: '#444444',
            links: 'blue'
	        }
  },
    features: {
        scrollbar: true,
	    loop: false,
	        live: true,
    hashtags: true,
        timestamp: true,
	    avatars: false,
	        behavior: 'all'
  }
  }).render().setUser('godwindiary').start();
  </script>
-->

<p>
<a class="twitter-timeline" data-dnt="true" href="https://twitter.com/godwindiary" data-widget-id="345188606824034304">Tweets by @godwindiary</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>

</p>
    </div>
</xsl:template>

</xsl:stylesheet>
