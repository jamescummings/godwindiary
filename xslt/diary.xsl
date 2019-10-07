<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
   xmlns:tei="http://www.tei-c.org/ns/1.0"
   xmlns:g="http://godwindiaries.bodleian.ox.ac.uk"
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="tei">
   <xsl:import href="functions.xsl"/>
   <xsl:preserve-space elements="*"/>
   <!--   <xsl:output method="xml" indent="yes" encoding="UTF8" doctype-public="-//W3C//DTD XHTML 1.1//EN"
   doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" /> -->
   <xsl:param name="date"/>

   <xsl:variable name="dateRequested" select="$date"/>

<xsl:variable name="list1796">
<xsl:copy-of select="document('http://godwin.oucs.ox.ac.uk:8081/get-diary-bit.xq?date=list1796')"/>
</xsl:variable>

   <xsl:variable name="year">
      <xsl:choose>
         <xsl:when test="contains($dateRequested, '-')">
            <xsl:value-of select="substring-before($dateRequested, '-')"/>
         </xsl:when>
<xsl:when test="$dateRequested='1796 List'">1796</xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$dateRequested"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="monthDay" select="substring-after($dateRequested, '-')"/>
   <xsl:variable name="monthNum">
      <xsl:choose>
         <xsl:when
            test="substring-before(substring-after($dateRequested, '-'), '-')">
            <xsl:value-of
               select="substring-before(substring-after($dateRequested, '-'), '-')"
            />
         </xsl:when>
         <xsl:when test="contains($dateRequested, '-')">
            <xsl:value-of select="substring-after($dateRequested, '-')"/>
         </xsl:when>
         <xsl:otherwise>NOT</xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="dayNum">
      <xsl:choose>
         <xsl:when test="contains($monthDay, '-')">
            <xsl:value-of select="substring-after($monthDay, '-')"/>
         </xsl:when>
         <xsl:otherwise>NOT</xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="monthName">
      <xsl:choose>
         <xsl:when test="$monthNum='01'">January</xsl:when>
         <xsl:when test="$monthNum='02'">February</xsl:when>
         <xsl:when test="$monthNum='03'">March</xsl:when>
         <xsl:when test="$monthNum='04'">April</xsl:when>
         <xsl:when test="$monthNum='05'">May</xsl:when>
         <xsl:when test="$monthNum='06'">June</xsl:when>
         <xsl:when test="$monthNum='07'">July</xsl:when>
         <xsl:when test="$monthNum='08'">August</xsl:when>
         <xsl:when test="$monthNum='09'">September</xsl:when>
         <xsl:when test="$monthNum='10'">October</xsl:when>
         <xsl:when test="$monthNum='11'">November</xsl:when>
         <xsl:when test="$monthNum='12'">December</xsl:when>
         <xsl:when test="$monthNum='NOT'">Other</xsl:when>
         <xsl:otherwise/>
      </xsl:choose>
   </xsl:variable>
   <xsl:variable name="dateText">
      <xsl:text> </xsl:text>
      <xsl:if test="not($dayNum='NOT')">
         <xsl:value-of select="format-number(number($dayNum), '#')"/>
         <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:if test="$monthName and not($monthName='Other')">
         <xsl:value-of select="$monthName"/>
         <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:choose>
<xsl:when test="$dateRequested='1796 List'">
1796 List
      </xsl:when>
<xsl:otherwise><xsl:value-of select="$year"/></xsl:otherwise>
</xsl:choose>
      <xsl:text> </xsl:text>
   </xsl:variable>
   <xsl:variable name="dateName">
      <xsl:choose>
         <xsl:when
            test="string-length($dateRequested)-string-length(translate($dateRequested, '-','')) = 2"
            >day</xsl:when>
         <xsl:when
            test="string-length($dateRequested)-string-length(translate($dateRequested, '-','')) = 1"
            >month</xsl:when>
         <xsl:when
            test="string-length($dateRequested)-string-length(translate($dateRequested, '-','')) = 0"
            >year</xsl:when>
         <xsl:otherwise/>
      </xsl:choose>
   </xsl:variable>


   <xsl:template match="/" priority="10">
      <!--      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"> -->
      <html>
         <xsl:comment>NOTE: THIS IS A GENERATED VERSION, AND SIMPLIFIED, THE
            REAL VERSION IS A YEAR-LONG DIARY FILE IN TEI XML.</xsl:comment>
         <head>
            <title>Diary entry for <xsl:value-of select="$dateText" /></title>
            <link type="text/css"
               href="/css/godwin-theme/jquery-ui-1.7.2.custom.css"
               rel="stylesheet"/>
            <link href="/godwin.css" media="screen" rel="stylesheet"
               type="text/css"/>
            <!--         <link href="/sliding-element.css" media="screen"
               rel="stylesheet" type="text/css"/>
	       -->
            <!--      <link href="/tooltip-screen.css" media="screen"
               rel="stylesheet" type="text/css"/>-->

            <script type="text/javascript">
$(document).ready(function()
{


<!--
                        slide("#sliding-navigation", 25, 15, 150, .8);-->
<!--
                        $('#displayToggles').toggle();-->

	$("#formatting").click(function(){
	  $('.persName, .dWrote, p.dDay, .dTopic, .dText, .red, .pencil, .foreign, .deleted, .placeName, .unidentifiedPersName').toggleClass("normal");
	  });

	$("#people").click(function(){
	  $('.persName, .unidentifiedPersName').toggleClass("people");
	  });

	$("#places").click(function(){
	  $('.placeName').toggleClass("places");
	  });

	$("#meals").click(function(){
	  $('.dMeal').toggleClass("meals");
	  });

	$("#meetings").click(function(){
	  $('.dMeeting').toggleClass("meetings");
	  });

	$("#texts").click(function(){
	  $('.dText').toggleClass("texts");
	  });

	$("#wrote").click(function(){
	  $('.dWrote').toggleClass("wrote");
	  });

	$("#topics").click(function(){
	  $('.dTopic').toggleClass("topics");
	  });

	$("#events").click(function(){
	  $('.dEvent').toggleClass("events");
	  });

	  $('#buttonToggle').click(function(){
	       $('#displayToggles').toggle();
	          });

	  $('#navToggle').click(function(){
	       $('.navToggles').toggle();
	          });

});

<!--
                        function slide(navigation_id, pad_out, pad_in, time, multiplier) {
                            // creates the target paths
                            var list_elements = navigation_id + " li.sliding-element";
                            var link_elements = list_elements + " a";
                            
                            // initiates the timer used for the sliding animation
                            var timer = 0;
                            
                            // creates the slide animation for all list elements
                            $(list_elements).each(function (i) {
                                // margin left = - ([width of element] + [total vertical padding of element])
                                $(this).css("margin-left", "-180px");
                                // updates timer
                                timer = (timer * multiplier + time);
                                $(this).animate({
                                    marginLeft: "0"
                                },
                                timer);
                                $(this).animate({
                                    marginLeft: "15px"
                                },
                                timer);
                                $(this).animate({
                                    marginLeft: "0"
                                },
                                timer);
                            });
                            
                            // creates the hover-slide effect for all link elements
                            $(link_elements).each(function (i) {
                                $(this).hover(
                                function () {
                                    $(this).animate({
                                        paddingLeft: pad_out
                                    },
                                    150);
                                },
                                function () {
                                    $(this).animate({
                                        paddingLeft: pad_in
                                    },
                                    150);
                                });
                            });
                        }-->

</script>

         </head>
         <body>

            <div class="diaryEntry">
               <h2>Diary entry for <xsl:value-of select="$dateText" /></h2>
<xsl:if test="not(//tei:divGen[@type='list1796'])">
               <form class="display" id="displayToggles" >
                  <span class="formattingBox">
                     <input type="checkbox" id="formatting" checked="true"
                        >Formatting</input>
                  </span>
                  <span class="peopleBox">
                     <input type="checkbox" id="people">People</input>
                  </span>
                  <span class="placesBox">
                     <input type="checkbox" id="places">Places</input>
                  </span>
                  <span class="mealsBox">
                     <input type="checkbox" id="meals" class="mealsBox"
                        >Meals</input>
                  </span>
                  <span class="meetingsBox">
                     <input type="checkbox" id="meetings" class="meetingsBox"
                        >Meetings</input>
                  </span>
                  <span class="textsBox">
                     <input type="checkbox" id="texts" class="textsBox"
                        >Reading</input>
                  </span>
                  <span class="wroteBox">
                     <input type="checkbox" id="wrote" class="wroteBox"
                        >Writing</input>
                  </span>
                  <span class="topicsBox">
                     <input type="checkbox" id="topics" class="topicsBox"
                        >Topics</input>
                  </span>
                  <span class="eventsBox">
                     <input type="checkbox" id="events" class="eventsBox"
                        >Events</input>
                  </span>
               </form>
               <span title="Toggle display of formatting controls"
                  id="buttonToggle">
                  <span class="plusMinus">+/-</span>
               </span>
               <xsl:apply-templates
                  select=".//tei:ab[contains(@type, '-nav')][1]"/>
</xsl:if>

               <div class="diaryContent">
<xsl:if test="/tei:div/tei:ab[@type='day-nav']/tei:ptr[@type='startingFolio']">
<xsl:variable name="fakePB">
<pb xmlns="http://www.tei-c.org/ns/1.0" n="{substring-after(/tei:div/tei:ab[@type='day-nav']/tei:ptr[@type='startingFolio']/@target, '/folio/')}"/>
</xsl:variable>
<xsl:apply-templates select="$fakePB/tei:pb" />
</xsl:if>

                  <xsl:apply-templates
                     select="tei:div/*[not(contains(@type, '-nav'))] "/>
                  <xsl:if test="//tei:divGen[@type='list1796']"><xsl:apply-templates
                     select="/tei:TEI/tei:text/tei:body/tei:div"/></xsl:if>
<xsl:apply-templates select="/tei:TEI/tei:text/tei:body/tei:divGen"/>

</div>

            </div>
<xsl:variable name="dateURI">
<xsl:choose>
<xsl:when test="//tei:divGen[@type='list1796']">1796list</xsl:when>
<xsl:otherwise><xsl:value-of select="$dateRequested"/></xsl:otherwise>
</xsl:choose>
</xsl:variable>

               <span class="XML-link">
                  <a class="XML-link"
                     href="{concat('/diary/', $dateURI, '.xml')}">
                     <img src="/images/xml_icon.gif" alt="XML" height="16"
                        width="40"/>
                  </a>
               </span>


         </body>
      </html>
   </xsl:template>

   <xsl:template match="tei:teiHeader"/>


   <xsl:template match="tei:text|tei:body">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="tei:ab[contains(@type, '-nav')]">
      <div class="{@type}" id="diaryNav">
         <span id="navToggle" class="plusMinus" title="Toggle Calendar Display"
            style="float:right;">+/-</span>
         <div id="calendarDiv" class="navToggles">
            <h3
            style="text-align:center;clear:both;margin-left:10%; margin-right:10%;"
            class="navToggles">
            <xsl:if
               test="not(tei:ptr[@type='yearPrev']/@target = '/diary/.html')">
               <a href="{tei:ptr[@type='yearPrev']/@target}" class="diaryNav"
                  style="text-decoration:none;" title="Previous Year"
                  >&#x2190;</a>
               <xsl:text> &#x00A0; &#x00A0; &#x00A0; &#x00A0; </xsl:text>
            </xsl:if>
            <a href="{concat('/diary/', $year, '.html')}" class="diaryNavYear"
               style="text-align:center;text-decoration:none;">
               <xsl:value-of select="$year"/>
            </a>

            <xsl:text> &#x00A0; &#x00A0;</xsl:text>
	    <a href="/diary/" style="text-decoration:none;" title="All Years">&#x2191;</a>
            <xsl:text> &#x00A0; &#x00A0; &#x00A0; &#x00A0; </xsl:text>
            <xsl:if
               test="not(tei:ptr[@type='yearNext']/@target = '/diary/.html')">
               <a href="{tei:ptr[@type='yearNext']/@target}" class="diaryNav"
                  style="text-decoration:none;" title="Next Year">&#x2192;</a>
            </xsl:if>
         </h3>
         <xsl:variable name="calendarFile"
            select="document(concat('../xml/calendar/', $year, '-2.html'))/html:div/html:table"/>
         
            <xsl:copy-of select="$calendarFile"/>
         </div>
         <!--
         <ul id="sliding-navigation">
            <li class="sliding-element" id="navToggle">
               <h3>Diary Navigation  <span class="plusMinus">+/-</span></h3>
            </li>
            <li class="sliding-element navToggles">
		    <a href="#top">Go To Top  <img src="/dataTables/images/sort_asc.png" border="0" align="bottom" class="navArrow"/></a>
            </li>
            <li class="sliding-element navToggles">
               <a href="{concat('/diary/', $year, '.html')}">Year View</a>
            </li>
            <li class="sliding-element navToggles">
               <xsl:variable name="thisMonthNum">
                  <xsl:choose>
                     <xsl:when test="$monthNum='NOT' and $year='1788'"
                        >04</xsl:when>
                     <xsl:when test="$monthNum='NOT'">01</xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="$monthNum"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:variable>
               <a
                  href="{concat('/diary/', $year, '-', $thisMonthNum, '.html')}"
                  >Month View</a>
            </li>
            <li class="sliding-element navToggles">
               <xsl:variable name="thisMonthNum">
                  <xsl:choose>
                     <xsl:when test="$monthNum='NOT' and $year='1788'"
                        >04</xsl:when>
                     <xsl:when test="$monthNum='NOT'">01</xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="$monthNum"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:variable>
               <xsl:variable name="thisDayNum">
                  <xsl:choose>
                     <xsl:when test="$dayNum='NOT' and $year='1788'"
                        >06</xsl:when>
                     <xsl:when test="$dayNum='NOT'">01</xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="$dayNum"/>
                     </xsl:otherwise>
                  </xsl:choose>

               </xsl:variable>
               <a
                  href="{concat('/diary/', $year, '-', $thisMonthNum, '-', $thisDayNum, '.html')}"
                  >Day View</a>
            </li>

            <xsl:apply-templates
               select="tei:ptr[not(@target='/diary/.html')][not(@target='/folio/')]"
            />
    <span class="XML-link"><span class="XML-link"><a class="XML-link" href="{concat('/diary/', $dateRequested, '.xml')}"><img src="/images/xml_icon.gif" alt="XML" height="16" width="40"/></a></span></span>
 </ul>
 -->

      </div>
   </xsl:template>
   <!--  <xsl:template match="tei:ptr">
      <li class="sliding-element navToggles">
         <xsl:choose>
            <xsl:when test="@type='startingFolio'">
               <a href="{@target}" class="diaryNav">Starting Folio</a>
            </xsl:when>
            <xsl:when test="@type='dayPrev'">
               <a href="{@target}" class="diaryNav">Previous Day</a>
            </xsl:when>
            <xsl:when test="@type='monthPrev'">
               <a href="{@target}" class="diaryNav">Previous Month</a>
            </xsl:when>
            <xsl:when test="@type='yearPrev'">
               <a href="{@target}" class="diaryNav">Previous Year</a>
            </xsl:when>
            <xsl:when test="@type='dayNext'">
               <a href="{@target}" class="diaryNav">Next Day</a>
            </xsl:when>
            <xsl:when test="@type='monthNext'">
               <a href="{@target}" class="diaryNav">Next Month</a>
            </xsl:when>
            <xsl:when test="@type='yearNext'">
               <a href="{@target}" class="diaryNav">Next Year</a>
            </xsl:when>
         </xsl:choose>
      </li>
   </xsl:template>
-->

   <xsl:template match="tei:div">
      <xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="tei:div[@type='dYear']">
      <div class="dYear" id="{@xml:id}">
         <xsl:apply-templates/>
      </div>
   </xsl:template>

   <xsl:template match="tei:div[@type='dMonth']">
      <xsl:variable name="monthNumber">
         <xsl:value-of select="substring-after(@xml:id, '-')"/>
      </xsl:variable>
      <xsl:variable name="monthNameIs">
         <xsl:choose>
            <xsl:when test="$monthNumber=01">January</xsl:when>
            <xsl:when test="$monthNumber=02">February</xsl:when>
            <xsl:when test="$monthNumber=03">March</xsl:when>
            <xsl:when test="$monthNumber=04">April</xsl:when>
            <xsl:when test="$monthNumber=05">May</xsl:when>
            <xsl:when test="$monthNumber=06">June</xsl:when>
            <xsl:when test="$monthNumber=07">July</xsl:when>
            <xsl:when test="$monthNumber=08">August</xsl:when>
            <xsl:when test="$monthNumber=09">September</xsl:when>
            <xsl:when test="$monthNumber=10">October</xsl:when>
            <xsl:when test="$monthNumber=11">November</xsl:when>
            <xsl:when test="$monthNumber=12">December</xsl:when>
            <xsl:when test="$monthNumber='NOT'"/>
            <xsl:otherwise/>
         </xsl:choose>
      </xsl:variable>
      <div class="dMonth" id="{@xml:id}">
         <h3>
            <xsl:value-of select="$monthNameIs"/>
            <a href="#top" class="navArrow" title="Go to Top">
               <img src="/dataTables/images/sort_asc.png" border="0"/>
            </a>
         </h3>
         <xsl:apply-templates/>
      </div>
   </xsl:template>



   <xsl:template match="tei:p">
      <p>
         <xsl:apply-templates/>
      </p>
   </xsl:template>

   <xsl:template match="tei:unclear">
      <span class="unclear" title="{@reason}"
         >&lt;<xsl:apply-templates/>&gt;</span>
   </xsl:template>
   <xsl:template match="tei:add">
      <span class="add{@place}">
         <xsl:apply-templates/>
      </span>
   </xsl:template>

   <xsl:template match="tei:persName" priority="5">
      <xsl:choose>
         <xsl:when test="@ref">
            <a href="{@ref}" class="persName hasPersName">
               <xsl:apply-templates/>
            </a>
         </xsl:when>
         <xsl:otherwise>
            <a href="{concat('/people/unidentified/', replace(lower-case(.), '[^a-z0-9]', '') ,'.html')}"
               class="unidentifiedPersName">
               <xsl:apply-templates/>
            </a>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>



   <xsl:template match="tei:placeName|tei:del|tei:orgName">
      <span class="{local-name()}">
         <xsl:apply-templates/>
      </span>
   </xsl:template>

   <xsl:template match="tei:persName[@type]">
      <xsl:choose>
         <xsl:when test="@type='nah'">
            <span class="persNamenah">
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:when test="@type='nit'">
            <span class="persNamenit">
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <span class="persNameOther">
               <xsl:apply-templates/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>


   <!-- outdated, should all be seg -->
   <xsl:template
      match="tei:dMeeting|tei:dMeal|tei:dTopic|tei:dEvent|tei:dEventG|tei:dEntertainment|tei:dText|tei:dWrote|tei:title|tei:author">
      <span class="{local-name()}" title="{@type}">
         <xsl:apply-templates/>
      </span>
   </xsl:template>

   <xsl:template match="tei:seg">
      <xsl:variable name="classes">
         <xsl:value-of select="concat(@type, ' ', @subtype, ' ', @rend)"/>
      </xsl:variable>
      <span class="{$classes}">
         <xsl:comment>
            <xsl:value-of select="$classes"/>
         </xsl:comment>
         <xsl:apply-templates/>
      </span>
   </xsl:template>

   <xsl:template match="tei:note[@type='ed']">
      <xsl:comment>ED: <xsl:apply-templates/></xsl:comment>
   </xsl:template>


   <xsl:template match="tei:note[@type='check']">
      <xsl:comment>CHECK: <xsl:apply-templates/></xsl:comment>
   </xsl:template>

   <xsl:template match="tei:note">
      <xsl:comment>NOTE: <xsl:apply-templates/></xsl:comment>
   </xsl:template>


   <xsl:template match="tei:hi[@rend='sup'][text()]" priority="5">
      <sup>
         <xsl:apply-templates select="@*|node()"/>
      </sup>
   </xsl:template>


   <xsl:template match="tei:hi[@rend='sub'][text()]" priority="5">
      <sub>
         <xsl:apply-templates select="@*|node()"/>
      </sub>
   </xsl:template>

   <xsl:template match="tei:emph">
      <span class="emph">
         <xsl:apply-templates/>
      </span>
   </xsl:template>

   <xsl:template match="tei:date[@when]">
      <span class="dDayNav" title="{g:date(@when)}">
<xsl:choose> <xsl:when test="/tei:div/tei:ab[@type='day-nav']"><xsl:attribute name="class">day-navDate</xsl:attribute></xsl:when>
<xsl:otherwise><xsl:attribute name="class">date</xsl:attribute></xsl:otherwise>
</xsl:choose>
         <a class="dateRef" href="{concat('/diary/', @when, '.html')}">
            <xsl:apply-templates/>
         </a>
<xsl:if test="/tei:div/tei:ab[@type='day-nav']/tei:ptr[@type='dayPrev']/@target">
&#x00A0;
&#x00A0;
<a title="Previous Day" style="text-decoration:none" href="{/tei:div/tei:ab[@type='day-nav']/tei:ptr[@type='dayPrev']/@target}">&#x2190;</a>
</xsl:if>
<xsl:if test="/tei:div/tei:ab[@type='day-nav']/tei:ptr[@type='dayNext']/@target">
&#x00A0;
&#x00A0;
<a title="Next Day" href="{/tei:div/tei:ab[@type='day-nav']/tei:ptr[@type='dayNext']/@target}" style="text-align:right;text-decoration:none">&#x2192;</a>
</xsl:if>
</span>
   </xsl:template>


   <xsl:template match="tei:ab[@type='dDay']">
      <p>
         <xsl:attribute name="class">
            <xsl:text>dDay </xsl:text>
            <xsl:choose>
               <xsl:when test="@subtype='NotLon'">NotLon</xsl:when>
               <xsl:otherwise>Lon</xsl:otherwise>
            </xsl:choose>
         </xsl:attribute>

         <xsl:apply-templates/>

         <xsl:if test="@subtype='NotLon'">
            <span class="NotLonRef">[Not in London]</span>
         </xsl:if>
      </p>
   </xsl:template>

   <xsl:template match="tei:pb">
      <xsl:variable name="img" select="@n"/>
      <xsl:variable name="classmark">Dep. <xsl:value-of
            select="substring-before($img, '_')"/></xsl:variable>
      <xsl:variable name="folio">
         <xsl:choose>
            <xsl:when test="starts-with(substring-after($img, '_'), '000')">
               <xsl:value-of select="substring-after($img, '_000')"/>
            </xsl:when>
            <xsl:when test="starts-with(substring-after($img, '_'), '00')">
               <xsl:value-of select="substring-after($img, '_00')"/>
            </xsl:when>
            <xsl:when test="starts-with(substring-after($img, '_'), '0')">
               <xsl:value-of select="substring-after($img, '_0')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="substring-after($img, '_')"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <xsl:variable name="imageName"><xsl:value-of select="$classmark"/>, fol.  <xsl:value-of select="$folio"/></xsl:variable>
      <span class="pb" id="{$img}">
         <a style="border:none;"
            href="{concat('/folio/', $img)}">
            <img style="border:none;text-align:center;width:25px;"
               src="{concat('/i/', $img, '-thumb.jpg')}"
               alt="{$imageName}" title="{$imageName}"/>
         </a>
         <br/>
         <span style="text-align:center;">[<a href="{concat('/folio/', $img)}"
               title="{$imageName}"><xsl:value-of
                  select="concat('fol. ', $folio)"/></a>] </span>
      </span>
   </xsl:template>





   <xsl:template
      match="tei:ref[@target][@type='dEvent' or @type='dEntertainment' or @type='dEventG']" priority="5">
      <xsl:variable name="classes">
         <xsl:value-of select="concat(@type, ' ', @subtype, ' ', @rend)"/>
      </xsl:variable>
      <span class="{$classes}">
         <xsl:comment>
            <xsl:value-of select="$classes"/>
         </xsl:comment>

         <xsl:apply-templates/>
      </span>
      <sup>
         <a href="{@target}" class="eventRef">e</a>
      </sup>
   </xsl:template>


   <xsl:template
      match="tei:ref[@target][@type='dEntertainment'][@subtype='Theat']" priority="100">
      <span class="{concat(@type, ' ', @subtype)}">
         <xsl:apply-templates/>
      </span>
      <sup>
         <a href="{@target}" class="eventRef">e</a>
      </sup>
   </xsl:template>

   <xsl:template match="tei:ref[@target]" priority="-1">
      <a href="{@target}" class="{@type} {@subtype}">
         <xsl:apply-templates/>
      </a>
   </xsl:template>

   <xsl:template match="tei:ref[not(@target)]" priority="-1">
      <span class="{@type} {@subtype}">
         <xsl:apply-templates/>
      </span>
   </xsl:template>

   <xsl:template match="@rend">
      <xsl:attribute name="class" select="."/>
   </xsl:template>

   <xsl:template match="tei:hi[text()]|tei:emph[text()]">
      <xsl:variable name="has">
         <xsl:if test="contains(@rend, 'deleted')"> hasDeleted </xsl:if>
         <xsl:if test="contains(@rend, 'red')"> hasRed </xsl:if>
         <xsl:if test="contains(@rend, 'pencil')"> hasPencil </xsl:if>
         <xsl:if test="contains(@rend, 'faint')"> hasFaint </xsl:if>
      </xsl:variable>
      <span class="{concat(name(), ' ', @rend, ' ', $has)}">

         <xsl:apply-templates/>
      </span>
   </xsl:template>

   <xsl:template match="tei:foreign">
      <span class="foreign hasForeign">
         <xsl:apply-templates select="@*|node()"/>
      </span>
   </xsl:template>


<xsl:template match="tei:div[n='2']"><div class="div2"><xsl:apply-templates/></div></xsl:template>

 <xsl:template match="tei:div[@xml:id='glist1796']"><div class="glist1796" id="glist1796"><xsl:apply-templates/></div></xsl:template>

<xsl:template match="tei:div[@xml:id='glist1796']//tei:table"><table class="glist1796Table"><xsl:apply-templates/></table></xsl:template>

   <xsl:template match="tei:div[@xml:id='glist1796']//tei:table/tei:row"><tr><xsl:apply-templates/></tr></xsl:template>
   <xsl:template match="tei:div[@xml:id='glist1796']//tei:table/tei:row/tei:cell"><td><xsl:apply-templates/></td></xsl:template>
   
   <xsl:template match="tei:p[@rend]"><p class="{@rend}"><xsl:apply-templates/></p></xsl:template>

<xsl:template match="tei:divGen[@type='list1796']">
<div id="list1796">
<xsl:apply-templates select="$list1796/tei:div/*[not(contains(self::tei:ab/@type, '-nav'))]"/>
</div>
</xsl:template>

<xsl:template match="tei:lb"><br/></xsl:template>
     
</xsl:stylesheet>
