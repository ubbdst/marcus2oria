<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:flub="http://data.ub.uib.no/ns/function-library/" exclude-result-prefixes="xs"
    version="2.0">
    <!--subfields in Primo: 
        comments from: https://knowledge.exlibrisgroup.com/Primo/Product_Documentation/Technical_Guide/The_PNX_Record/Subfields_in_the_PNX
        
       The character denotes the content and is persistent across PNX fields.
-->
    <xsl:function name="flub:setSubfield">
        <xsl:param name="subfield"/>
        <xsl:param name="value"/>
        <xsl:choose>
            <xsl:when test="matches($subfield, '^([ACDIKLOSTUV]|[0-9]+)$')">
                <xsl:value-of select="concat('$$', $subfield, $value)"/>
            </xsl:when>
            <xsl:otherwise><xsl:message terminate="yes"> subfield <xsl:value-of select="$subfield"/>
                    not found in documentation. </xsl:message></xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    <!--C
    A constant that displays before the field. This delimiter can be used only in the Display section for the following fields: identifier, relation, and description.
    The constant can be a code (lower case with no spaces or special characters). The code is translated to a name for display in the Front End using the Display Constants code table. If the text added has no translation in the code table, it will display as entered in the rules.
    
    V
    Value of the field (to distinguish between the value of the field and the display text or constant).
    -->
    <xsl:function name="flub:subFieldConstantAndValue">
        <xsl:param name="constant"/>
        <xsl:param name="value"/>
        <xsl:value-of
            select="concat(flub:setSubfield('C', $constant), flub:setSubfield('V', $value))"/>
    </xsl:function> 
    
    <!--    D Text that displays instead of the field—for example, for URLS). I Institution
        -->
    <!-- U URL-->
    <xsl:function name="flub:subfieldSetDisplayAndUrl">
        <xsl:param name="display"/>
        <xsl:param name="url"/>
        <xsl:value-of
            select="concat(flub:setSubfield('D', $display), flub:setSubfield('U', $url))"/>
    </xsl:function>
    
    <!-- Not implemented specifics for:-->
    <!--code K Key for FRBR
    L Library code 
    O Origin of the field used in Deduped records - the sourceid.
    S Status
    T Template code -->
    
    </xsl:stylesheet>