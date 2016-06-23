<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"  xmlns:flub="http://data.ub.uib.no/ns/function-library"
    exclude-result-prefixes="xs flub" version="2.0">
    <xsl:include href="lib/md5.xsl"/>
    <xsl:strip-space elements="*"/>
    <xsl:param name="identifiers" as="xs:string"/>
    
   
    <xsl:output method="xml"/>
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

    <xsl:variable name="base-xsl-uri"
        select="string-join(tokenize(base-uri($dummy), '/'), '/')[1 to position() = last() - 1]"/>
    <!-- opprett en property for harvested dato i ant og sett inn som parameter-->
    <!--<xsl:key name="identifier" match="record/header/identifier" use="."/>-->
    <xsl:key name="identifier" match="*:identifier" use="@id"/>
    <xsl:key name="oai-identifier" match="*:record" use="*:header/*:identifier"/>
    <!--<xsl:key name="not-in-mapping" match=""/>-->
    <xsl:variable name="oai-pmh" select="/"/>
    <!-- if not identifiers already exists, lookup key in dummy record-->
    <xsl:variable name="identifier-doc"
        select="(document(concat($base-xsl-uri, '../',$identifiers)),$dummy)[1]"/>

    <xsl:template match="*:record" priority="1.9">
        <xsl:message>test</xsl:message>
    </xsl:template>


    <!-- handling all matches in listRecords-->
    <xsl:template match="*:record" priority="2.0">
        <xsl:value-of select="$indent"/>
        <xsl:variable name="md5" select="flub:md5String(string(.))"/>
        <xsl:variable name="id" select="*:header/*:identifier"/>
        <xsl:variable name="identifier" select="key('identifier', $id, $identifier-doc)"/>
        <!-- if status is deleted or md5 value has changed, boolean to update modified-->
        <xsl:variable name="isDifferent"
            select="$identifier/@status = 'deleted' or $identifier/@md5 != $md5"/>
       <xsl:value-of select="ad"/>
        <identifier id="{*:header/*:identifier}" status="active">
            <xsl:attribute name="modified"
                select="
                    if ($isDifferent or
                    not(string($identifier/@modified)))
                    then 
                    format-dateTime(adjust-dateTime-to-timezone(current-dateTime(),xs:dayTimeDuration('PT0H')),'[Y0001]-[M01]-[D01]T[H01]:[m01]:[s01][Z]')
                    else
                        $identifier/@modified"/>
            <xsl:attribute name="md5" select="$md5"/>
        </identifier>
        <xsl:value-of select="$newline"/>
    </xsl:template>


    <xsl:template match="/">
        <xsl:value-of select="$newline"/>
        <identifiers>

            <xsl:value-of select="$newline"/>
            <xsl:apply-templates select="$identifier-doc" mode="update-identifiers"/>
            <xsl:apply-templates/>
        </identifiers>
    </xsl:template>

    <xsl:template match="*" priority="1.0">
        <xsl:apply-templates/>
    </xsl:template>

    <!--handle not present records, copy if already deleted, 
        add deleted status and new modified time if deleted. -->
    <xsl:template match="*:identifier" mode="update-identifiers">
        <xsl:value-of select="$indent"/>
        <xsl:variable name="record" select="key('oai-identifier', @id, $oai-pmh)"/>
        <xsl:variable name="currentMd5" select="flub:md5String($record)"/>
        <xsl:if test="not($record)">
            <xsl:copy>
                <xsl:choose>
                    <xsl:when test="@status = 'deleted'">
                        <xsl:copy-of select="@*"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="id" select="@id"/>
                        <xsl:attribute name="status" select="'deleted'"/>
                        <xsl:attribute name="modified" select="format-dateTime(adjust-dateTime-to-timezone(current-dateTime(),xs:dayTimeDuration('PT0H')),'[Y0001]-[M01]-[D01]T[H01]:[m01]:[s01][Z]')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:copy>
            <xsl:value-of select="$newline"/>
        </xsl:if>
        
    </xsl:template>

   

</xsl:stylesheet>