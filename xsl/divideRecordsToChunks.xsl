<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:flub="http://data.ub.uib.no/ns/function-library/"
    xmlns="http://www.openarchives.org/OAI/2.0/"
    exclude-result-prefixes="xs math flub"
    version="2.0">
    <!-- @todo? Ta inn datestamp alt på pnx generering-->
    <xsl:param name="file-size-in-bytes" as="xs:integer" select="178036"/>
    
    <xsl:variable name="file-size-limit" select="10000000"/>
    <xsl:variable name="extra-number" select="if ($file-size-in-bytes div $file-size-limit &lt; 5) then 1 else 2"/>
        
    <xsl:variable name="number-of-files-each-file" select="if ($file-size-in-bytes &gt; $file-size-limit) then flub:round_up(($file-size-in-bytes div $file-size-limit)+$extra-number) else 1"/>
    <xsl:variable name="number-of-posts" select="count(/*:OAI-PMH/*:ListRecords/*:record)"/>
    <xsl:variable name="number-per-xml" select="flub:round_up($number-of-posts div $number-of-files-each-file)" as="xs:integer"/>
    
   <xsl:key name="identifier" match="*:identifier" use="@id"/>    
   
    <xsl:variable name="current" select="/"/>
    <xsl:variable name="records" select="$current/*:OAI-PMH/*:ListRecords/*:record"/>
    <xsl:variable name="xml-name" select="replace(tokenize(base-uri(),'/')[last()],'\.[^\.]+','')"/>
    <xsl:variable name="identifiers" select="document(concat($project-base-uri,'/',$xml-name,'_identifiers.xml'))"/>
    <xsl:variable name="dummy">
        <root/>
    </xsl:variable>
    
    
    
    <!--assumes xsl position is in xsl folder-->
    <xsl:variable name="project-base-uri" select="string-join(tokenize(base-uri($dummy),'/')[position()=1 to last()-2],'/')"/>
    
    <!--<xsl:key name="record-per-xml" match="/*:OAI-PMH/*:ListRecords/*:record" use="flub:round_up((count(preceding-sibling::*:record)+1) div $number-per-xml)"/>-->
    
    <xsl:strip-space elements="*"/>
    <xsl:output method="xml" indent="yes"></xsl:output>
    <xsl:template match="/">
     <!--   <xsl:message>
        <xsl:sequence select="$current/key('record-per-xml',1)"/>
        </xsl:message>-->
       
        
<!--        <xsl:message><xsl:value-of select="key('record-per-xml',1,$current)[1]"/></xsl:message>
-->       
        <xsl:for-each select="1 to $number-of-files-each-file">
            <xsl:variable name="number" select="."/>
            <xsl:result-document href="{$project-base-uri}/output/pnx/{$xml-name}_{$number}{replace(string(current-dateTime()),'[+:]','_')}.xml">
             <OAI-PMH xmlns="http://www.openarchives.org/OAI/2.0/">
                    <responseDate><xsl:value-of select="current-dateTime()"/></responseDate>
                    <request/>

                 <xsl:variable name="position-end" select="($number-per-xml*.)"/>
                 <xsl:variable name="position-start" select="$position-end - $number-per-xml+1" />
                <xsl:message>start: <xsl:value-of select="$position-start"/> end: <xsl:value-of select="$position-end"/></xsl:message>
                 <xsl:variable name="counter" select="."/>
                    <ListRecords>
                        <xsl:choose>
                            <xsl:when test="$number != $number-of-files-each-file">
                                <xsl:apply-templates select="$records[position()=$position-start to $position-end]"/>
                                 
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates select="$records[position()=$position-start to last()]"/>
                                
                            </xsl:otherwise>
                        </xsl:choose>
                   
                    </ListRecords>
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
    
    <xsl:template match="*:header[not(*:datestamp)]" mode="copy">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates mode="copy"/>
            <xsl:call-template name="datestamp">
                <xsl:with-param name="identifier" select="*:identifier"/>
            </xsl:call-template>
        </xsl:copy>        
    </xsl:template> 
    <xsl:template match="*:datestamp">
        <xsl:copy>
            <xsl:call-template name="datestamp">
                <xsl:with-param name="identifier" select="preceding-sibling::*:identifier"/>
            </xsl:call-template>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template name="datestamp">
        <xsl:param name="identifier"/>
    <xsl:variable name="modified" select="key('identifier',$identifier,$identifiers)/@modified"/>
        <xsl:if test="not($modified)"><xsl:message terminate="yes">header datestamp error, identifier <xsl:value-of select="$identifier"/></xsl:message></xsl:if>
        <datestamp><xsl:value-of select="$modified"/></datestamp>    
    </xsl:template>
    
    <xsl:template match="*:record">
<!--           <xsl:message><xsl:value-of select="current-dateTime()"/></xsl:message>
-->        <xsl:copy>
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