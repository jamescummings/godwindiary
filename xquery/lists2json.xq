<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="tei"
    version="1.0"
    >
    
    <xsl:output method="text" encoding="utf-8" />
    
    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="tei:TEI/tei:text/tei:body/tei:listNym">
                <xsl:for-each select="tei:TEI/tei:text/tei:body/tei:listNym">
                    <xsl:value-of select="@rend"/>
                    <xsl:text>({
                        "names" : [
                    </xsl:text>
                    <xsl:for-each select="tei:nym">
                        <xsl:text> {"id": "</xsl:text>
                        <xsl:value-of select="@xml:id"/>
                        <xsl:text>",&#10;</xsl:text>
                        <xsl:text>  "query": "</xsl:text>
                        <xsl:value-of select="@n"/>
                        <xsl:text>",&#10;</xsl:text>
                        <xsl:text>  "greek": "</xsl:text>
                        <xsl:value-of select="tei:form"/>
                        <xsl:text>",&#10;</xsl:text>
                        <xsl:text>  "notBefore": "</xsl:text>
                        <xsl:value-of select="tei:p/tei:date/@notBefore"/>
                        <xsl:text>",&#10;</xsl:text>
                        <xsl:text>  "notAfter": "</xsl:text>
                        <xsl:value-of select="tei:p/tei:date/@notAfter"/>
                        <xsl:text>",&#10;</xsl:text>
                        <xsl:text>  "number": "</xsl:text>
                        <xsl:value-of select="tei:p/tei:num"/>
                        <xsl:text>"}</xsl:text>
                        <xsl:if test="following-sibling::tei:nym">,</xsl:if>
                        <xsl:text>&#10;</xsl:text>
                    </xsl:for-each>
                    <xsl:text>
                        ]
                        });
                    </xsl:text>
                </xsl:for-each>
            </xsl:when>
            <xsl:when test="tei:TEI/tei:text/tei:body/tei:listPerson">
                <xsl:for-each select="tei:TEI/tei:text/tei:body/tei:listPerson">
                    <xsl:choose>
                        <xsl:when test="@rend">
                            <xsl:value-of select="@rend"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>lgpn</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:text>({
                        "persons" : [
                    </xsl:text>
                    <xsl:for-each select="tei:person">
                        <xsl:text> {"id": "</xsl:text>
                        <xsl:value-of select="@xml:id"/>
                        <xsl:text>",&#10;</xsl:text>
                        <xsl:text>  "name": "</xsl:text>
                        <xsl:value-of select="tei:persName/tei:forename"/>
                        <xsl:text>",&#10;</xsl:text>
                        <xsl:text>  "place": "</xsl:text>
                        <xsl:value-of select="tei:birth/tei:placeName"/>
                        <xsl:text>",&#10;</xsl:text>
                        <xsl:text>  "notBefore": "</xsl:text>
                        <xsl:value-of select="tei:birth/@notBefore"/>
                        <xsl:text>",&#10;</xsl:text>
                        <xsl:text>  "notAfter": "</xsl:text>
                        <xsl:value-of select="tei:birth/@notAfter"/>
                        <xsl:text>"&#10;</xsl:text>
                        <xsl:text>}</xsl:text>
                        <xsl:if test="following-sibling::tei:person">,</xsl:if>
                        <xsl:text>&#10;</xsl:text>
                    </xsl:for-each>
                    <xsl:text>
                        ]
                        });
                    </xsl:text>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>lgpn({});</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
