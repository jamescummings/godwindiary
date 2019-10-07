<xsl:stylesheet version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
     xmlns:g="http://godwindiaries.bodleian.ox.ac.uk" 
     xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- <xsl:import href="functions.xsl"/> -->
  <xsl:strip-space elements="*"/>

  <xsl:variable name="type" select="/tei:list/@type"/>
  <xsl:variable name="typePhrase">
	  <xsl:choose>
		  <xsl:when test="$type='people'">People</xsl:when>
		  <xsl:when test="$type='events'">Events</xsl:when>
		  <xsl:when test="$type='reading'">Reading</xsl:when>
		  <xsl:when test="$type='writing'">Writing</xsl:when>
		  <xsl:when test="$type='meals'">Meals</xsl:when>
		  <xsl:when test="$type='meetings'">Meetings</xsl:when>
		  <xsl:otherwise>People</xsl:otherwise>
	  </xsl:choose>
  </xsl:variable>


  <xsl:variable name="subtype" select="/tei:list/@subtype"/>

  <xsl:variable name="subtypePhrase">
	  <xsl:choose>
<xsl:when test="$type='people' and $subtype='identified'">Identified People</xsl:when>
<xsl:when test="$type='people' and $subtype='unidentified'">Unidentified People</xsl:when>
<xsl:when test="$type='people' and $subtype='nah'">People Not At Home</xsl:when>
	<xsl:when test="$type='events' and $subtype='accts'">Accounts</xsl:when> 
	<xsl:when test="$type='events' and $subtype='death'">Deaths</xsl:when>  
	<xsl:when test="$type='events' and $subtype='exhib'">Exhibitions</xsl:when>  
	<xsl:when test="$type='events' and $subtype='gardens'">Gardens</xsl:when>  
	<xsl:when test="$type='events' and $subtype='lect'">Lectures</xsl:when>  
	<xsl:when test="$type='events' and $subtype='museo'">Museums and Libraries</xsl:when>  
	<xsl:when test="$type='events' and $subtype='musical'">Musicals</xsl:when>  
	<xsl:when test="$type='events' and $subtype='persevent'">Personal Events</xsl:when>  
	<xsl:when test="$type='events' and $subtype='pershlth'">Personal Health</xsl:when>  
	<xsl:when test="$type='events' and $subtype='publ'">Public Events</xsl:when>  
	<xsl:when test="$type='events' and $subtype='temp'">Temperature</xsl:when>  
	<xsl:when test="$type='events' and $subtype='theat'">Theatre</xsl:when>  
	<xsl:when test="$type='events' and $subtype='topics'">Topics</xsl:when>  
	<xsl:when test="$type='events' and $subtype='trial'">Trials</xsl:when>  
	<xsl:when test="$type='events' and $subtype='weath'">Weather</xsl:when>  
	<xsl:when test="$type='events' and $subtype='other'">Other Events</xsl:when> 
	<xsl:when test="$type='reading' and $subtype='read'">Texts Read</xsl:when>
	<xsl:when test="$type='reading' and $subtype='cala'">Texts Read Cala</xsl:when>
	<xsl:when test="$type='reading' and $subtype='mention'">Texts Mentioned</xsl:when>
	<xsl:when test="$type='reading' and $subtype='disc'">Texts Discussed</xsl:when>
	<xsl:when test="$type='reading' and $subtype='letterRecvd'">Letter Received</xsl:when>
	<xsl:when test="$type='writing' and $subtype='write'">Texts Written</xsl:when>
	<xsl:when test="$type='writing' and $subtype='cala'">Texts Written Cala</xsl:when>
	<xsl:when test="$type='writing' and $subtype='corr'">Texts Corrected</xsl:when>
	<xsl:when test="$type='writing' and $subtype='edit'">Texts Edited</xsl:when>
	<xsl:when test="$type='writing' and $subtype='invent'">Texts Invented</xsl:when>
	<xsl:when test="$type='writing' and $subtype='revised'">Texts Revised</xsl:when>
	<xsl:when test="$type='writing' and $subtype='sent'">Texts Sent</xsl:when>
	<xsl:when test="$type='writing' and $subtype='transcr'">Texts Transcribed</xsl:when>
	<xsl:when test="$type='writing' and $subtype='translate'">Texts Translated</xsl:when>
	<xsl:when test="$type='writing' and $subtype='meditate'">Meditated on Writing</xsl:when>
	<xsl:when test="$type='writing' and $subtype='notes'">Notes Made</xsl:when>
	<xsl:when test="$type='writing' and $subtype='letter'">Letter Written</xsl:when>
	<xsl:when test="$type='writing' and $subtype='other'">Other Writing</xsl:when>
	<xsl:when test="$type='meals' and $subtype='bg'">Breakfasts (at Godwin's)</xsl:when>
	<xsl:when test="$type='meals' and $subtype='b'">Breakfasts</xsl:when>
	<xsl:when test="$type='meals' and $subtype='tg'">Tea (at Godwin's)</xsl:when>
	<xsl:when test="$type='meals' and $subtype='ta'">Tea</xsl:when>
	<xsl:when test="$type='meals' and $subtype='dg'">Dines (at Godwin's)</xsl:when>
	<xsl:when test="$type='meals' and $subtype='d'">Dines</xsl:when>
	<xsl:when test="$type='meals' and $subtype='sg'">Sups (at Godwin's)</xsl:when>
	<xsl:when test="$type='meals' and $subtype='s'">Sups</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='c'">Godwin calls on X</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='m'">Godwin meets X</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='see'">Godwin sees X</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='cn'">Godwin and X/Y/Z call (on someone)</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='cg'">X calls (on Godwin)</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='cgn'">X/Y/Z call (on Godwin)</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='apres'">Après dinner</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='apresg'">Après dinner (at Godwin's)</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='aus'">Au soir</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='sleepat'">Sleep at</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='sleeps'">Sleeps (at Godwin's)</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='sleepother'">Others sleep elsewhere</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='do'">Do with X</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='inv'">Invited</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='ppc'">Pour prendre congé</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='ppcg'">Pour prendre congé (at Godwin's)</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='sitto'">Sit to</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='sk'">Seek</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='send4'">Send for</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='tohave'">Meeting intended</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='pr'">X present</xsl:when>
	<xsl:when test="$type='meetings' and $subtype='other'">Other meeting</xsl:when>
	<xsl:otherwise>Identified People</xsl:otherwise>			      
</xsl:choose>
</xsl:variable>
			      


  <xsl:template match="/">
	  <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
	      <title>Godwin Diary: Basic Statistics for <xsl:value-of select="$subtypePhrase"/> Mentioned</title>
	      <link type="text/css" href="/css/godwin-theme/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
		      <link type="text/css" rel="stylesheet" href="/godwin.css"/>
		      <script type="text/javascript" src="/js/jquery-1.3.2.min.js"></script>
		      <script type="text/javascript" src="/js/jquery-ui-1.7.2.custom.min.js"></script>
	<xsl:comment>[if IE]&gt;&lt;script language="javascript" type="text/javascript"
		src="/excanvas.js"&gt; /** **/&lt;/script&gt;&lt;![endif]</xsl:comment>
	<script type="text/javascript" src="/js/jquery.flot.js"></script>
	<script type="text/javascript">
		$(function(){ var data=[<xsl:for-each select="/tei:list/tei:item"><xsl:value-of select="concat('[',@n,',',., ']')"/>,</xsl:for-each>];
  
  
 var plot = $.plot($("#placeholder"),
	 [ { data: data, label: "Mentions/Year", color:"#2e4c6f", clickable:false, hoverable:true,
	 bars: { show: true, barWidth:0.75, align:"center", clickable:false, hoverable:true},
	 } ]
	 ,
	 {
	 //series: { lines: { show: true }, points: { show: true } },
	 //bars: { show: true, barWidth:0.5, align:"left", clickable:false, hoverable:true, color:"#900"},
	 grid: { show:true, hoverable: true, clickable: false, backgroundColor:{colors:["#EEEEFF", "#FFFFFF"]} },
	 legend: {position:"nw", backgroundColor:"transparent"},
	 yaxis:{minTickSize:1},
	 });

	 $("#placeholder").bind("plotclick", function (event, pos, item) {
	 //     axis coordinates for other axes, if present, are in pos.x2, pos.x3, ...
	  //    if you need global screen coordinates, they are pos.pageX, pos.pageY

	  if (item) {
	  $('html, body').animate({ scrollTop: $("#app" + item.datapoint[0]).offset().top }, 500);
	  //window.open("#app" + item.datapoint[0]);
	  //$("#clicktext").text("Click In" + item.datapoint[0] + " there were " + item.datapoint[1] + " meetings.");
	  }
	  });

	  $("#placeholder").bind("plothover", function (event, pos, item) {
	  if (item) {
	  $("#hovertext").text(": in " + item.datapoint[0] + " <xsl:value-of select="$type"/> are recorded " + item.datapoint[1] + " times.");
	  }
	  });

	  });
	 
  </script>


      </head>
      <body>

	      <h2>Mentions of <xsl:value-of select="$subtypePhrase"/> by Year</h2>
	      <div id="placeholder" style="width:550px;height:250px">

		      <span>  </span> 
	      </div>
					<div class="flotCaption"><p>
							Hover over a bar to see number of mentions/year<span id="hovertext">.</span>
			      </p>
			      <p>
				      <xsl:variable name="numMentions" select="sum(/tei:list/tei:item)"/>

				      Instances of <xsl:value-of select="$subtypePhrase"/> are recorded in the diary a total of <xsl:value-of select="$numMentions"/> times.
			      </p>

		      </div>

		      <div>

			      <p>Other subdivisions of <a href="{concat('/stats/', $type, '.html')}"><xsl:value-of select="$typePhrase"/></a> include: 
				      <xsl:choose>
					      <xsl:when test="$type='people'">
						      <a href="/stats/people/identified.html">Identified</a>,  
						      <a href="/stats/people/unidentified.html">Unidentified</a>,  or 
						      <a href="/stats/people/nah.html">Not At Home</a>.
					      </xsl:when>
			      
					      <xsl:when test="$type='events'">
						      <a href="/stats/events/accts.html">Accounts</a>, 
						      <a href="/stats/events/death.html">Deaths</a>,  
						      <a href="/stats/events/exhib.html">Exhibitions</a>,  
						      <a href="/stats/events/gardens.html">Gardens</a>,  
						      <a href="/stats/events/lect.html">Lectures</a>,  
						      <a href="/stats/events/museo.html">Museums and Libraries</a>,  
						      <a href="/stats/events/musical.html">Musicals</a>,  
						      <a href="/stats/events/persevent.html">Personal Events</a>,  
						      <a href="/stats/events/pershlth.html">Personal Health</a>,  
						      <a href="/stats/events/publ.html">Public Events</a>,  
						      <a href="/stats/events/temp.html">Temperature</a>,  
						      <a href="/stats/events/theat.html">Theatre</a>,  
						      <a href="/stats/events/topics.html">Topics</a>,  
						      <a href="/stats/events/trial.html">Trials</a>,  
						      <a href="/stats/events/weath.html">Weather</a>,  or 
						      <a href="/stats/events/other.html">Other Events</a>. 
					      </xsl:when>
			      
					      <xsl:when test="$type='reading'">
						      <a href="/stats/reading/read.html">Texts Read</a>, 
						      <a href="/stats/reading/cala.html">Texts Read Cala</a>, 
						      <a href="/stats/reading/mention.html">Texts Mentioned</a>, 
						      <a href="/stats/reading/disc.html">Texts Discussed</a>, or  
						      <a href="/stats/reading/letterRecvd.html">Letter Received</a>. 
					      </xsl:when>
			      
					      <xsl:when test="$type='writing'">
						      <a href="/stats/writing/write.html">Texts Written</a>, 
						      <a href="/stats/writing/cala.html">Texts Written Cala</a>, 
						      <a href="/stats/writing/corr.html">Texts Corrected</a>,   
						      <a href="/stats/writing/edit.html">Texts Edited</a>,   
						      <a href="/stats/writing/invent.html">Texts Invented</a>,   
						      <a href="/stats/writing/revised.html">Texts Revised</a>,   
						      <a href="/stats/writing/sent.html">Texts Sent</a>,   
						      <a href="/stats/writing/transcr.html">Texts Transcribed</a>,   
						      <a href="/stats/writing/translate.html">Texts Translated</a>,   
						      <a href="/stats/writing/meditate.html">Meditated on Writing</a>,   
						      <a href="/stats/writing/notes.html">Notes Made</a>,   
						      <a href="/stats/writing/letter.html">Letter Written</a>, or  
						      <a href="/stats/writing/other.html">Other</a>. 
					      </xsl:when>
			      
					      <xsl:when test="$type='meals'">
						      <a href="/stats/meals/bg.html">Breakfasts (at Godwin's)</a>, 
						      <a href="/stats/meals/b.html">Breakfasts</a>,   
						      <a href="/stats/meals/tg.html">Tea (at Godwin's) </a>, 
						      <a href="/stats/meals/ta.html">Tea</a>, 
						      <a href="/stats/meals/dg.html">Dines (at Godwin's)</a>, 
						      <a href="/stats/meals/d.html">Dines</a>, 
						      <a href="/stats/meals/sg.html">Sups (at Godwin's)</a>, or
						      <a href="/stats/meals/s.html">Sups</a>. 
					      </xsl:when>
			      
					      <xsl:when test="$type='meetings'">
						      <a href="/stats/meetings/c.html">Godwin calls on X</a>, 
						      <a href="/stats/meetings/m.html">Godwin meets X</a>,   
						      <a href="/stats/meetings/see.html">Godwin sees X</a>,   
						      <a href="/stats/meetings/cn.html">Godwin and X/Y/Z call (on someone)</a>,   
						      <a href="/stats/meetings/cg.html">X calls (on Godwin)</a>,   
						      <a href="/stats/meetings/cgn.html">X/Y/Z call (on Godwin)</a>,   
						      <a href="/stats/meetings/apres.html">Après dinner</a>,   
						      <a href="/stats/meetings/apresg.html">Après dinner (at Godwin's)</a>,   
						      <a href="/stats/meetings/aus.html">Au soir</a>,   
						      <a href="/stats/meetings/sleepat.html">Sleep at</a>,   
						      <a href="/stats/meetings/sleeps.html">Sleeps (at Godwin's)</a>,   
						      <a href="/stats/meetings/sleepother.html">Others sleep elsewhere</a>,   
						      <a href="/stats/meetings/do.html">Do with X</a>,   
						      <a href="/stats/meetings/inv.html">Invited</a>,   
						      <a href="/stats/meetings/ppc.html">Pour prendre congé</a>,   
						      <a href="/stats/meetings/ppcg.html">Pour prendre congé (at Godwin's)</a>,   
						      <a href="/stats/meetings/sitto.html">Sit to</a>,   
						      <a href="/stats/meetings/sk.html">Seek</a>,   
						      <a href="/stats/meetings/send4.html">Send for</a>,   
						      <a href="/stats/meetings/tohave.html">Meeting intended</a>,   
						      <a href="/stats/meetings/pr.html">X present</a>, or  
						      <a href="/stats/meetings/other.html">Other</a>. 
					      </xsl:when>
			      
				      </xsl:choose>
			      
			      
			      </p> 



<p>Frequencies by year are available for the following categories:
<a href="/stats/people.html">People</a>,
<a href="/stats/events.html">Events</a>,
<a href="/stats/reading.html">Reading</a>,
<a href="/stats/writing.html">Writing</a>,
<a href="/stats/meals.html">Meals</a>, and
<a href="/stats/meetings.html">Meetings</a> 
</p>

		      
		      </div>



		      <!--
		      <div>
			      <h3>Instances</h3>
		      <p>
			      <xsl:for-each select="/tei:list/tei:item">
				      <span id="{concat('app', @n')"><span class="label"><xsl:value-of select="@n"/>:</span> <xsl:value-of select='.'/></span>
				      <xsl:text>     </xsl:text></xsl:for-each>

		      </p>
	      </div>
	      -->

	      </body>
      </html>

</xsl:template>  
  
  
</xsl:stylesheet>
