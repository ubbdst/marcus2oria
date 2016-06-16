<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:param name="date-of-last-harvest"/>
    <xsl:strip-space elements="*"/>
    <xsl:output method="xml"></xsl:output>
    <!-- kjør ut en rest på dokumenter som skal slettes (i -->
    <!-- dersom i xml men ikke -->
    <xsl:variable name="dummy">
        <node/>
    </xsl:variable>
    
    <xsl:variable name="newline">
        <xsl:text>
</xsl:text>
    </xsl:variable>
    
    <xsl:variable name="indent">
        <xsl:text>     </xsl:text>
    </xsl:variable>
    
    <xsl:variable name="base-xsl-uri" select="string-join(tokenize(base-uri($dummy),'/'),'/')[1 to position()= last()-1]"/>
    <!-- opprett en property for harvested dato i ant og sett inn som parameter-->
    <xsl:key name="identifier" match="record/header/identifier" use="."/>
    <xsl:key name="identifier" match="identifiers/identifer" use="@id"/>
    
    <!--<xsl:key name="not-in-mapping" match=""/>-->
    <xsl:variable name="oai-pmh" select="/"/>
    <xsl:variable name="identifier-doc" select="document(concat($base-xsl-uri,'../identifiers.xml'))">
        
    </xsl:variable>
    
    <xsl:template match="record" priority="1.9"></xsl:template>
    
    
    
    <xsl:template match="record[not(key('identifier',header/identifier))]" priority="2.0">
        <xsl:value-of select="$indent"/>        
        <identifier id="{header/identifier}" status="active" datetime="{current-dateTime()}"/>
<xsl:value-of select="$newline"/>    </xsl:template>
    
   
    <xsl:template match="/">
        <xsl:value-of select="$newline"/>
        <identifiers>
            <xsl:value-of select="$newline"/>
        <xsl:apply-templates select="$identifier-doc" mode="update-identifiers"/>
        <xsl:apply-templates/>
        </identifiers>
    </xsl:template>
    
    <xsl:template match="identifier" mode="update-identifiers">
        <xsl:value-of select="$indent"/><xsl:copy>           
            <xsl:attribute name="status" select="if (not(key('identifier',@id,$oai-pmh))) then 'deleted' else 'active'"/>
            <xsl:copy-of select="@* except @status"/>
            
        </xsl:copy>
<xsl:value-of select="$newline"/>        
    </xsl:template>
    
    
    
    
</xsl:stylesheet>