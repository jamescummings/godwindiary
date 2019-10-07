<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
	 xmlns:ex="http://simile.mit.edu/" 
	              xmlns:g="http://godwin.oucs.ox.ac.uk" 
		      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
		      <xsl:import href="functions.xsl"/>

   <xsl:output method="xml" indent="no" encoding="UTF8" omit-xml-declaration="yes" />

<xsl:param name="pid" select="'WOR01'"/>

<xsl:variable name="person" select="$pid"/>
<xsl:variable name="url" select="concat('http://godwindiary.bodleian.ox.ac.uk/get-persName.xq?id=',$pid)"/> 
<!-- <xsl:variable name="url" select="concat('http://godwin.oucs.ox.ac.uk:8081/get-persName.xq?id=',$pid)"/> -->
<!--<xsl:variable name="url" select="concat('http://silva.domus.cummingsfamily.org.uk/get-persName.xq?id=',$pid)"/> -->
<xsl:variable name="persName" select="document($url)"/>
<xsl:variable name="renderedName" select="$persName//tei:ab[@type='renderedName']"/>

   <xsl:template match="/">
   <html >
      <head>
	      <title><xsl:value-of select="$renderedName"/>: Meals and Meetings with Godwin</title>
         <link href="{concat('/mmbrowser/', $person, '.js')}" type="application/json" rel="exhibit/data" />
         
<!--         <script src="http://static.simile.mit.edu/exhibit/api-2.0/exhibit-api.js"
            type="text/javascript"></script>
   -->


<script src="http://api.simile-widgets.org/exhibit/2.2.0/exhibit-api.js"></script>

<!-- timeline extension -->
<!-- <script src="http://api.simile-widgets.org/exhibit/2.2.0/extensions/time/time-extension.js"></script> -->

<!-- calendar extension -->
<!--<script src="http://api.simile-widgets.org/exhibit/2.2.0/extensions/calendar/calendar-extension.js"></script>-->


<!-- Script additions -->
<script type="text/javascript">
    var zebraStyler = function(item, database, tr) {
          if (tr.rowIndex % 2) {
            tr.style.background = '#eee';
          } else {
            tr.style.background = '#ccc';
          }
    }
      </script>
      <script type="text/javascript">
	      $(document).ready(function() 
	      $('.moreLess').click(function(ev) { 
		$('#moreHelpText').toggle(); 
		$('.moreLess').toggle(); 
		}));
      </script>
 <!--     <script type="text/javascript">

	      $().ready(function() {
	        $('#helpText').each(function(){
		  
		  var hiddenElements = $(this).children('p:gt(10)').hide();
		  if (hiddenElements.size() > 0) {
		  	  var showCaption = 'more';
			  	  $(this).children('p:gt(10)').hide();
				  $(this).after('<a style="color:red;" href="#" class="more">' + showCaption + '</a>');
			  	}
			  });
		    
		    $('.more').toggle(function(e){
	        e.preventDefault();
		$(this).prev('p').children('p:gt(10)').slideToggle();
	    $(this).text('less');
      },
        function() {
	hiddenElements.hide();
    $(this).text('more');	
      }); 
      });

      </script>
-->
<!--
  <script type="text/javascript">
    var timeGeometer = function(grid) {
        return new Timeplot.DefaultTimeGeometry({
            gridColor: grid,
            axisLabelsPlacement: "top"
        });
    };

    var valueGeometer = function(grid) {
        return new Timeplot.DefaultValueGeometry({
            gridColor: grid,
            axisLabelsPlacement: "left",
            gridType: "short",
            min: 0.225,
            max: 0.775
        });
    };
    </script>
-->
<!--
<style text="text/javascript">
	$(document).ready(function() {
	var adjustheight = 20;
	$("#adjust").toggle(function() {
	$('#mytext').css('height', 'auto').css('overflow', 'visible');
	$(this).text("less");
	}, function() {
	$('#mytext').css('height', adjustheight).css('overflow', 'hidden');
	$(this).text("more");
	});
	});
</style>
   -->   
         <style type="text/css">
         </style>
      </head>
      <body>
         <div>

		 <h1><a href="{concat('/people/', $pid, '.html')}"><xsl:value-of select="$renderedName"/></a>: Meals and Meetings with Godwin</h1>

		 <p id="helpText" class="helpText" ><span class="bold">Help: </span> Once loaded, click on the entries in the facets on the right-hand side to filter the items in the table. Clicking multiple entries in a single facet finds items with either of these entries. Names with a * indicate people who have not currently been identified.  <span id="moreHelpText" style="display:none;">Three facets for 'participants' have been provided to allow for boolean 'And' searches that require both these participants (or any of multiple sets of participants) to be filtered.  The number of particiants can be filtered by using a slider to narrow down the range. The date link leads to that day in the diary.  A timeline view plots the meals/meetings on a timeline. The top band is divided by month and the bottom band by decade. The lighter area on the bottom band indicates the time period you are currently viewing.  Drag either band to the left (or right) to move along the timeline and display other meals/meetings (indicated by marks on the bottom band).  Clicking on a particular event in the timeline pops up a list of information concerning it. </span> <span class="moreLess">More</span> <span class="moreLess" style="display:none;">Less</span> </p> 

	 <div ex:role="collection" ex:itemTypes="Meal,Meeting" id="meetingsCollection" >
	 </div>

	 <table xmlns:ex="http://simile.mit.edu/"> 
<tr valign="top">
	<td ex:role="viewPanel" id="viewPanel" ex:collectionID="meetingsCollection" ex:formats="date{time-zone:0;template:'d MMMM yyyy';show:date;}">
  <!--
  <div ex:role="view" 
	      ex:viewClass="Calendar" 
	          ex:start=".label_value1"
		      ex:end=".label"
		          ex:eventLabel=".title"
			  ex:formats="date { mode: short; show: date-time; template: 'MM/dd/yyyy' } item { title: expression(.title) }">
	  </div>
	  -->
<div ex:role="view" 
ex:viewClass="Tabular"  
ex:label="View as Table"
ex:columns=".label, .type, .subtype, .numParticipants, .participants.label, venue.label" 
ex:columnLabels="Date, Type, Subtype, Number, Participants, Venue"
ex:rowStyler="zebraStyler"
ex:showToolbox="false"
ex:columnFormats="date, list, list, number, list, url"
ex:sortColumn="0"
ex:sortAscending="true"
ex:paginate="true"
ex:grouped="false" 
ex:collectionID="meetingsCollection"
ex:pageSize="10"
>
<table>
<tr ex:rowStyler="zebraStyler" >
<td width="20%"> <b><a  ex:href-content=".URI" class="link"><span ex:width="20%" ex:content=".label" ex:formats="date{time-zone:1;template:'d MMMM yyyy'; show:date}"></span></a></b></td>
<td><span ex:content=".type" class="type"></span></td>
<td><span ex:content=".subtype" class="subtype"></span></td>
<td><span ex:content=".numParticipants"></span></td>
<!--<td><span ex:content=".date"></span></td>-->
<td> <span ex:content=".participants.label"> </span></td>
<td> <span ex:content=".venue.label"> </span></td>
</tr>
</table>
</div>
<!-- <div ex:columns=".participants.label" ex:role="view" ex:label="View As Timeline" ex:topBandUnit="month" ex:bottomBandUnit="decade" ex:bottomBandPixelsPerUnit="200" ex:topBandPixelsPerUnit="150" ex:viewClass="Timeline" start=".label" ex:colorKey=".type" ex:showSummary="true" ex:showToolbox="false" ex:formats="date{time-zone:1; template:'d MMMM yyyy';show:date}"> 
	<div ex:role="lens" style="display:none"><ul>
			<li><span class="bold">Date: </span> <a ex:href-content=".URI" class="link"><span ex:content=".label" ex:formats="date{time-zone:1;template:'d MMMM yyyy'; show:date}"></span></a></li>
			<li><span class="bold">Type: </span> <span ex:content=".type"></span></li>
			<li><span class="bold">Subtype: </span> <span ex:content=".subtype"></span></li>
			<li><span class="bold">Venue: </span> <span ex:content=".venue.label"></span></li>
			<li><span class="bold">At Home: </span> <span ex:content=".nah"></span></li>
			<li><span class="bold">Participants: </span> <span ex:content=".participants.label"></span></li>
			<li><span class="bold">Number: </span> <span ex:content=".numParticipants"></span></li>
	</ul></div>

</div>
-->
</td>
<td width="25%" colspan="5">
	<!-- <div ex:facetLabel="Text Search" ex:role="facet" ex:facetClass="TextSearch"></div> -->
<div ex:collectionID="meetingsCollection" ex:facetLabel="Meeting or Meal" ex:itemTypes="Meal,Meeting" ex:scroll="false" ex:expression=".type" ex:role="facet"></div>
       <div  ex:collectionID="meetingsCollection"  ex:facetLabel="At Home?" ex:scroll="false" ex:expression=".nah" ex:role="facet"></div>
<div  ex:collectionID="meetingsCollection" ex:facetLabel="Subtype" ex:expression=".subtype" ex:role="facet"></div>
<div  ex:collectionID="meetingsCollection" ex:facetLabel="Participants" ex:expression=".participants.label" ex:role="facet"></div>
<div  ex:collectionID="meetingsCollection" ex:facetlabel="AND Participants #1" ex:expression=".participants.label" ex:role="facet"> </div>
<div  ex:collectionID="meetingsCollection" ex:facetlabel="AND Participants #2" ex:expression=".participants.label" ex:role="facet"> </div>
<div  ex:collectionID="meetingsCollection" ex:facetLabel="Venue" ex:expression=".venue.label" ex:role="facet"></div>
<div  ex:collectionID="meetingsCollection" ex:role="facet" ex:facetLabel="Number of Participants (Slider)" ex:expression=".numParticipants" ex:facetClass="Slider" ex:horizontal="true" ex:precision="1" ex:histogram="false">
    </div>
    <!--
<div  ex:collectionID="meetingsCollections" ex:role="facet" 
	   ex:facetClass="NumericRange"
	      ex:expression=".numParticipants" 
	      ex:interval="1">
       </div>
       -->
       <div ex:facetLabel="Number of Participants" ex:fixedOrder="0;1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20" ex:expression=".numParticipants" ex:role="facet"></div>
</td>
</tr>
</table>



         </div>
      </body>
   </html>
   </xsl:template>
  
</xsl:stylesheet>
