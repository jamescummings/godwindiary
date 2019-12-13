<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all"
    version="2.0">
    <xsl:output indent="yes"/>
    <xsl:template name="main">
        <xsl:param name="path2collection"
            >file:///home/jamesc/svn/godwin.oucs.ox.ac.uk/web/diary/</xsl:param>
        <xsl:variable name="path">
            <xsl:value-of
                select="concat($path2collection,'?select=1*.xml;recurse=yes;on-error=warning')"/>
        </xsl:variable>
        <xsl:variable name="docs" select="collection($path)"/>
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>William Godwin's Diaries</title>
                        <author>William Godwin</author>
                        <principal>Mark Philp</principal>
                        <funder>Leverhulme Foundation and the John Fell OUP Research Fund</funder>
                    </titleStmt>
                    <publicationStmt>
                        <idno>
                            <ref target="http://godwindiary.bodleian.ox.ac.uk/"
                                >http://godwindiary.bodleian.ox.ac.uk/</ref>
                        </idno>
                        <authority>Published by the Godwin Diaries Project, University of
                            Oxford</authority>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Transcribed from William Godwin's diaries</p>
                    </sourceDesc>
                </fileDesc>
                <revisionDesc>
                    <change when="2010-05-11T00:55:07.607+01:00">
                        <persName>Dr James Cummings</persName> generated this file.</change>
                </revisionDesc>
            </teiHeader>
            <text>
                <body>
                    <xsl:for-each select="$docs/tei:TEI">
                        <xsl:sort data-type="number" select=".//idno[1]"/>
                        <xsl:apply-templates select="."/>
                    </xsl:for-each>
                </body>
            </text>
        </TEI>
    </xsl:template>
    <!-- copy everything not matched default template  -->
    <xsl:template match="@*|node()|comment()|processing-instruction()" priority="-5">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="teiHeader|note"/>
    <xsl:template match="text|body|TEI|seg|ref|persName|placeName">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="div[@type='dYear']">
        <div type="dYear">
            <head>
                <xsl:value-of select="substring-after(@xml:id, 'g')"/>
            </head>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="div[@type='dMonth']">
        <div type="dMonth">
            <xsl:variable name="monthNum" select="number(substring-after(@xml:id, '-'))"/>
            <xsl:variable name="monthName">
                <xsl:choose>
                    <xsl:when test="$monthNum=01">January</xsl:when>
                    <xsl:when test="$monthNum=02">February</xsl:when>
                    <xsl:when test="$monthNum=03">March</xsl:when>
                    <xsl:when test="$monthNum=04">April</xsl:when>
                    <xsl:when test="$monthNum=05">May</xsl:when>
                    <xsl:when test="$monthNum=06">June</xsl:when>
                    <xsl:when test="$monthNum=07">July</xsl:when>
                    <xsl:when test="$monthNum=08">August</xsl:when>
                    <xsl:when test="$monthNum=09">September</xsl:when>
                    <xsl:when test="$monthNum=10">October</xsl:when>
                    <xsl:when test="$monthNum=11">November</xsl:when>
                    <xsl:when test="$monthNum=12">December</xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="year"> (<xsl:value-of
                    select="substring-after(substring-before(@xml:id, '-'), 'g')"/>) </xsl:variable>
            <head>
                <xsl:value-of select="$monthName"/>
                <xsl:text>  </xsl:text>
                <xsl:value-of select="$year"/>
            </head>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="ab[@type='dDay']">
        <p n="dDay">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="date">
        <xsl:copy>
            <hi>
                <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
            </hi>
        </xsl:copy>
    </xsl:template>
    <!--<xsl:template match="text()"><xsl:variable name="phase1"><xsl:analyze-string select="." regex="\s+">
        <xsl:matching-substring><xsl:text> </xsl:text></xsl:matching-substring>
        <xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring>
</xsl:analyze-string></xsl:variable>
    <xsl:variable name="phase2"><xsl:analyze-string select="$phase1" regex="[' ']*\.[' ']*">
        <xsl:matching-substring>. </xsl:matching-substring>
        <xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring>
    </xsl:analyze-string></xsl:variable><xsl:value-of select="$phase2"/>
    </xsl:template> 
-->
    <xsl:template match="text()">
        <xsl:variable name="phase1">
            <xsl:analyze-string select="." regex="\s+([;.:,])">
                <xsl:matching-substring><xsl:value-of select="regex-group(1)"/></xsl:matching-substring>
                <xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring>
            </xsl:analyze-string>
            </xsl:variable>
        <!--
        <xsl:variable name="phase2">
            <xsl:analyze-string select="$phase1" regex="[' ']*\.[' ']*">
                <xsl:matching-substring>. </xsl:matching-substring>
                <xsl:non-matching-substring>
                    <xsl:value-of select="."/>
                </xsl:non-matching-substring>
            </xsl:analyze-string>
        </xsl:variable>-->
        <xsl:value-of select="$phase1"/>
    </xsl:template>
    <xsl:template match="emph[@rend='deleted']">
        <del>
            <xsl:apply-templates/>
        </del>
    </xsl:template>
</xsl:stylesheet>
