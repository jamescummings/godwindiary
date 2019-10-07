<xsl:stylesheet version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
     xmlns:g="http://godwindiaries.bodleian.ox.ac.uk" 
              xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Date -->
<xsl:function name="g:date" 
     xmlns:g="http://godwindiaries.bodleian.ox.ac.uk">
  <xsl:param name="date" /> 
<xsl:variable name="type" select="count(tokenize($date, '-'))"/>
<xsl:choose>
<xsl:when test="$type=3">
<xsl:value-of select="format-number(number(substring-after(substring-after($date, '-'), '-')), '0')"/><xsl:text>&#xa0;</xsl:text>
<xsl:sequence select="
   ('January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December')
   [number(substring-before(substring-after($date,'-'),'-'))]"/><xsl:text>&#xa0;</xsl:text>
   <!--[substring-before(substring-after($date, '-'), '-')]"/><xsl:text> </xsl:text> -->
<xsl:value-of select="substring-before($date, '-')"/>
</xsl:when>
<xsl:when test="$type=2">
<xsl:sequence select="
   ('January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December')
   [number(substring-after($date, '-'))]"/><xsl:text>&#xa0;</xsl:text>
<xsl:value-of select="substring-before($date, '-')"/>
</xsl:when>
<xsl:otherwise><xsl:value-of select="$date"/></xsl:otherwise>
</xsl:choose>
</xsl:function>
 
 
 
 
 <xsl:function name="g:substring-after-last" as="xs:string"
     xmlns:g="http://godwindiaries.bodleian.ox.ac.uk" > 
  <xsl:param name="arg" as="xs:string?"/>
  <xsl:param name="delim" as="xs:string"/>
  
  <xsl:sequence
   select=" 
   replace ($arg,concat('^.*',g:escape-for-regex($delim)),'')
   "/>
  
 </xsl:function>
 
 <xsl:function name="g:escape-for-regex" as="xs:string" 
     xmlns:g="http://godwindiaries.bodleian.ox.ac.uk" >
  <xsl:param name="arg" as="xs:string?"/> 
  
  <xsl:sequence select=" 
   replace($arg,
   '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
   "/>
  
 </xsl:function>
 
 

</xsl:stylesheet>
