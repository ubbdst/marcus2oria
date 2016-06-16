<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:flub="http://data.ub.uib.no/ns/function-library/"
    exclude-result-prefixes="xs math flub"
    version="2.0">
    
    <xsl:param name="file-size-in-kb" as="xs:integer" select="178036"/>
    <xsl:variable name="extra-number" select="if ($file-size-in-kb div 10000 &lt; 5) then 1 else 2"/>
    <!-- ?? hvor streng er 10 mb grensen til primo? holder det slik som nå at det er en aproximate størrelse basert på prosent av størrelse i kb, og antall poster?-->
    
    <xsl:variable name="number-of-files-each-file" select="if ($file-size-in-kb &gt; 10000) then flub:round_up(($file-size-in-kb div 10000)+$extra-number) else 1"/>
    <xsl:variable name="number-of-posts" select="count(/OAI-PMH/ListRecords/record)"/>
    <xsl:variable name="number-per-xml" select="$number-of-posts div $number-of-files-each-file"/>
   
    <xsl:variable name="current" select="/"/>
    <xsl:variable name="dummy">
        <root/>
    </xsl:variable>
    
    <xsl:variable name="xml-name" select="replace(tokenize(base-uri(),'/')[last()],'\.^\.+','')"/>
    <xsl:variable name="xsl-base-uri" select="string-join(tokenize(base-uri($dummy),'/')[position()=1 to last()-1],'/')"/>
    
    <xsl:key name="record-per-xml" match="*:record" use="flub:round_up((count(preceding-sibling::record)+1) div $number-per-xml)"/>
    <xsl:strip-space elements="*"/>
    <xsl:output method="xml" indent="yes"></xsl:output>
    <xsl:template match="/">
      <xsl:for-each select="1 to $number-of-files-each-file">
            <xsl:result-document href="{$xsl-base-uri}/output/{$xml-name}_{.}{replace(string(current-dateTime()),'[+:]','_')}.xml">
                <OAI-PMH>
                    <listRecords>
                <xsl:apply-templates select="key('record-per-xml',.,$current)"/> 
                    </listRecords>
            </OAI-PMH>
            </xsl:result-document>
        </xsl:for-each>        
    </xsl:template>
    
    <xsl:template match="*" mode="copy">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates mode="copy"/>
        </xsl:copy>        
    </xsl:template>
    
    <xsl:template match="record">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
             <xsl:apply-templates mode="copy"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:function name="flub:round_up">
        <xsl:param name="value" as="xs:double"/>
        <xsl:variable name="negative-number" select="if ($value &lt; 0) then true() else false()"/>
        <xsl:variable name="fractionHasValue" as="xs:boolean" select="if (contains(string($value),'.')) then true() else false()"/>
        <xsl:sequence select="if ($fractionHasValue and not($negative-number)) then xs:integer(substring-before(string($value),'.'))+1 else xs:integer($value) "/>
    </xsl:function>
</xsl:stylesheet>