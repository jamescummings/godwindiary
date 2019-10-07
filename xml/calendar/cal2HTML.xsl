<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    version="2.0">
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Nov 3, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> james</xd:p>
            <xd:p>Transform output of myCalendarYear.xsl to an HTML table</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:param name="cols" select="'2'"/>
    <xsl:variable name="columns" select="number($cols)"/>

    <xsl:output indent="yes"/>
    <xsl:variable name="year" select="/year/@n"/>

    <xsl:template match="/year">
        <div class="cal-year" xmlns="http://www.w3.org/1999/xhtml">
            <h2>
                <a href="{concat('/diary/', $year, '.html')}">
                    <xsl:value-of select="$year"/>
                </a>
            </h2>
            <table>
                <xsl:for-each-group select="month"
                    group-ending-with="month[position() mod $columns = 0]">
                    <tr class="cal-monthHeading">
                        <xsl:for-each select="current-group()">
                            <xsl:variable name="monthName">
                                <xsl:value-of select="descendant::monthName[1]"
                                />
                            </xsl:variable>
                            <xsl:variable name="monthNum">
                                <xsl:value-of select="descendant::monthNum[1]"/>
                            </xsl:variable>
                            <td class="cal-monthHeading">
                                <a class="cal-monthHeading"
                                    href="{concat('/diary/', $year, '-', $monthNum, '.html')}">
                                    <xsl:value-of select="$monthName"/>
                                </a>
                            </td>
                        </xsl:for-each>
                    </tr>
                    <tr>
                        <xsl:for-each select="current-group()">
                            <td class="cal-month">
                                <table>
                                    <thead>
                                        <tr class="cal-monthDayHeadings">
                                        <th class="cal-weekday">M</th>
                                        <th class="cal-weekday">T</th>
                                        <th class="cal-weekday">W</th>
                                        <th class="cal-weekday">Th</th>
                                        <th class="cal-weekday">F</th>
                                        <th class="cal-weekend">Sa</th>
                                        <th class="cal-weekend">Su</th>
                                        </tr>
                                    </thead>
                                    <xsl:apply-templates select="current()/week"
                                    />
                                </table>
                            </td>

                        </xsl:for-each>
                    </tr>
                </xsl:for-each-group>
            </table>
        </div>
    </xsl:template>

    <xsl:template match="month"> OOOPS </xsl:template>

    <xsl:template match="week">
        <tr class="cal-week">
            <!-- Monday -->
            <xsl:choose>
                <xsl:when test="day[dayName='Monday']">
                    <xsl:apply-templates select="day[dayName='Monday']"/>
                </xsl:when>
                <xsl:otherwise>
                    <td class="cal-empty">
                        <xsl:comment>Empty Day</xsl:comment>
                    </td>
                </xsl:otherwise>
            </xsl:choose>
            <!--Tuesday-->
            <xsl:choose>
                <xsl:when test="day[dayName='Tuesday']">
                    <xsl:apply-templates select="day[dayName='Tuesday']"/>
                </xsl:when>
                <xsl:otherwise>
                    <td class="cal-empty">
                        <xsl:comment>Empty Day</xsl:comment>
                    </td>
                </xsl:otherwise>
            </xsl:choose>
            <!-- Wednesday -->
            <xsl:choose>
                <xsl:when test="day[dayName='Wednesday']">
                    <xsl:apply-templates select="day[dayName='Wednesday']"/>
                </xsl:when>
                <xsl:otherwise>
                    <td class="cal-empty">
                        <xsl:comment>Empty Day</xsl:comment>
                    </td>
                </xsl:otherwise>
            </xsl:choose>
            <!-- Thursday-->
            <xsl:choose>
                <xsl:when test="day[dayName='Thursday']">
                    <xsl:apply-templates select="day[dayName='Thursday']"/>
                </xsl:when>
                <xsl:otherwise>
                    <td class="cal-empty">
                        <xsl:comment>Empty Day</xsl:comment>
                    </td>
                </xsl:otherwise>
            </xsl:choose>
            <!-- Friday -->
            <xsl:choose>
                <xsl:when test="day[dayName='Friday']">
                    <xsl:apply-templates select="day[dayName='Friday']"/>
                </xsl:when>
                <xsl:otherwise>
                    <td class="cal-empty">
                        <xsl:comment>Empty Day</xsl:comment>
                    </td>
                </xsl:otherwise>
            </xsl:choose>
            <!-- Saturday -->
            <xsl:choose>
                <xsl:when test="day[dayName='Saturday']">
                    <xsl:apply-templates select="day[dayName='Saturday']"/>
                </xsl:when>
                <xsl:otherwise>
                    <td class="cal-empty">
                        <xsl:comment>Empty Day</xsl:comment>
                    </td>
                </xsl:otherwise>
            </xsl:choose>
            <!-- Sunday -->
            <xsl:choose>
                <xsl:when test="day[dayName='Sunday']">
                    <xsl:apply-templates select="day[dayName='Sunday']"/>
                </xsl:when>
                <xsl:otherwise>
                    <td class="cal-empty">
                        <xsl:comment>Empty Day</xsl:comment>
                    </td>
                </xsl:otherwise>
            </xsl:choose>
        </tr>
    </xsl:template>

    <xsl:template match="day">
        <td>
            <xsl:attribute name="class">cal-dayNum<xsl:if
                    test="dayName='Saturday' or dayName='Sunday'"
                    >Weekend</xsl:if></xsl:attribute>
            <xsl:choose>
                <xsl:when test="diaryEntry/@exists='yes'">
                    <a href="{concat('/diary/',@value, '.html')}"
                        class="cal-dayLink">
                        <xsl:value-of select="format-number(dayNum,'#' )"/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="format-number(dayNum,'#' )"/>
                </xsl:otherwise>
            </xsl:choose>
        </td>
    </xsl:template>


</xsl:stylesheet>
