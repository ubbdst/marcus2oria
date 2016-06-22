<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:string="java.lang.String"
    xmlns:integer="java.lang.Integer" xmlns:md="java.security.MessageDigest"
    xmlns:byte="java.lang.Byte"
    xmlns:flub="http://data.ub.uib.no/ns/function-library"
    exclude-result-prefixes="xs  byte md integer string flub"
    version="2.0">
    
    <xsl:variable name="md_0" select="md:getInstance('MD5')"/>
    
    <xsl:function name="flub:md5String">
        <xsl:param name="string"/>
        <xsl:if test="string($string)">
            <xsl:variable name="md-reset" select="md:reset($md_0)"/>           
           <xsl:if test="string($md-reset)">
               <xsl:message><xsl:value-of select="$md-reset"/></xsl:message>
           </xsl:if>
            
            <xsl:variable name="stringToBytes" select="string:getBytes(string($string), 'UTF-8')"/>
            <xsl:variable name="digest" select="md:digest($md_0, $stringToBytes)"/>
            <xsl:variable name="hexStrings"
                select="
                for $byte in $digest
                return
                flub:addZeros(integer:toHexString($byte))"/>
            <xsl:value-of select="string-join($hexStrings, '')"/>
        </xsl:if>
    </xsl:function>
    
    <xsl:function name="flub:addZeros">
        <xsl:param name="string" as="xs:string?"/>
        <xsl:value-of
            select="
            if (string($string)) then
            replace($string, '^([0-9A-Za-z])$', '0$1')
            else
            '00'"
        />
    </xsl:function>
</xsl:stylesheet>