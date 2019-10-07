<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs tei" version="2.0">
    
    <!--
    Produce useful  output for any 4-digit year.
    -->
    
    <xsl:output method="xml" indent="yes"/>

<!-- Accept any year=YYYY defaulting to 1788, can also accept -0030 for 30BC etc. but only deals
    with 4-digit dates  -->
    <xsl:param name="year" select="'1788'"/>

    <xsl:param name="format" select="'xml'"/>

    <xsl:variable name="diary" select="collection('../../svn/godwin.oucs.ox.ac.uk/working/xml/godwinfiles.xml')"/>

    <!-- Assume we are starting at 1st of Jan for any year given also assume Gregorian calendar, but
    this can be changed below if necessary-->
    <xsl:variable name="startdate" select="xs:date(concat($year, '-01-01'))"/>

    <!-- Create 1 year sequence of xs:date numbers incrementing from $year-01-01  -->
    <xsl:variable name="date-sequence" as="xs:date+">
        <xsl:sequence select="$startdate"/>
        <!-- must be 365 day sequence  after 1 Jan to deal with leap years  -->
        <xsl:for-each select="1 to 365">
            <xsl:variable name="days" select="xs:dayTimeDuration(concat('P',.,'D'))"/>
            <xsl:sequence select="$startdate + $days"/>
        </xsl:for-each>
    </xsl:variable>

    <!-- Main template, create calendar element, with month, week, and day hierarchy inside it outputting all
        relevant date things I can think of -->
    <xsl:template name="main">
<xsl:variable name="year">
    <xsl:variable name="selected-year" select="year-from-date($date-sequence[1])"/>
        <year n="{$selected-year}">
      <xsl:variable name="dates">
                <xsl:for-each select="$date-sequence">
                    <xsl:variable name="currentDate" select="."/>
                    <!-- simple test to ignore extra day on end if not leap year -->
                    <xsl:if test="year-from-date(.) = $selected-year">
                        <day value="{$currentDate}">
                            <!-- Year, losing plus or minus but staying 4 digit format-date used
                                rather than year-from-date() etc. to specify leading zeros -->
                            <yearNum>
                                <xsl:value-of select="format-date($currentDate, '[Y01]')"/>
                            </yearNum>
                            <!-- Era, comes out AD or BC in this calendar -->
                            <era>
                                <xsl:value-of select="format-date($currentDate, '[E]')"/>
                            </era>
                            <!-- Month number, leading zero -->
                            <monthNum>
                                <xsl:value-of select="format-date($currentDate, '[M01]')"/>
                            </monthNum>
                            <!-- Month Name, title case -->
                            <monthName>
                                <xsl:value-of select="format-date($currentDate, '[MNn]')"/>
                            </monthName>
                            <!-- Day number leading zero -->
                            <dayNum>
                                <xsl:value-of select="format-date($currentDate,'[D01]' )"/>
                            </dayNum>
                            <!-- Day name, title case -->
                            <dayName>
                                <xsl:value-of select="format-date($currentDate,'[F]' )"/>
                            </dayName>
                            <!-- Week number,  sometimes first week in year starts with '53' or '52' depending on
                                whether leap year and when year starts with fri/sat/sun   -->
                            <weekNum>
                                <xsl:value-of select="format-date($currentDate, '[W01]')"/>
                            </weekNum>
			    <xsl:variable name="diaryEntry">
				    <xsl:choose>
					    <xsl:when test="$diary//tei:date/@when=$currentDate">yes</xsl:when>
					    <xsl:otherwise>no</xsl:otherwise>
				    </xsl:choose>
			    </xsl:variable>
			    <diaryEntry exists="{$diaryEntry}"/>
                        </day>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <!-- If I was being clever I'd do this all in one thing, but  let's group this into
                months and weeks separately -->
            <xsl:variable name="dates-with-months-and-weeks">
                <!-- Group each day by monthNum -->
                <xsl:for-each-group select="$dates/day" group-by="monthNum">
                    <month>
                        <!-- Group current set of month's days but their weekNum -->
                        <xsl:for-each-group select="current-group()" group-adjacent="weekNum">
                            <week>
                                <!-- copy current group in here -->
                                <xsl:copy-of select="current-group()"/>
                            </week>
                        </xsl:for-each-group>
                    </month>
                </xsl:for-each-group>
            </xsl:variable>

            <!-- So put out an xml copy of the last variable  -->
            <xsl:copy-of select="$dates-with-months-and-weeks"/>
        </year>
</xsl:variable>
<xsl:variable name="html">
<xsl:apply-templates select="$year" mode="html"/>
</xsl:variable>

<xsl:choose>
<xsl:when test="$format='xml'"><xsl:copy-of select="$year"/></xsl:when>
<xsl:when test="$format='html'"><xsl:copy-of select="$html"/></xsl:when>
<xsl:otherwise>format must be 'xml' or 'html'</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="year" mode="html">
<html>
<body>
<table>
<tr><td><xsl:value-of select="$year"/></td></tr>
  <xsl:for-each-group select="month"
               group-ending-with="month[position() mod 3 = 0]">
      <tr>
        <xsl:for-each select="current-group()">
<xsl:apply-templates select="current()" mode="html"/>

        </xsl:for-each>
      </tr>
    </xsl:for-each-group>

</table>

</body>
</html>
</xsl:template>
<xsl:template match="month" mode="html">
<td><table><tr><td><xsl:value-of select=".//monthName[1]"/></td></tr></table></td>
</xsl:template>

</xsl:stylesheet>
