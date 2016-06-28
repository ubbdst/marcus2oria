<?xml version="1.0" encoding="UTF-8"?>
<!-- Stilark for å fange opp om objekter har blitt slettet fra høsting til høsting
     Tar inn en identifier.xml fil, kopierer poster der hvor md5 av hele enkeltposten er identisk (uten elementnavn)
     Oppdaterer modified date, der md5 er endret siden tidligere.
     Legger til ny identifier post, dersom OAI post ikke er i identifier.xml.
     Det endrer også status på poster som finnes i identifier.xml men som ikke finnes i oai til deleted.
     Er avhengig av Saxon9B (eller betalingsversjonene PE, EE for bruk av refleksiv java (md5 for sammenligning av poster))-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"  xmlns:flub="http://data.ub.uib.no/ns/function-library"
    exclude-result-prefixes="xs flub" version="2.0">
    <xsl:include href="lib/md5.xsl"/>
    <xsl:strip-space elements="*"/>
    <!-- forventer filnavn på identifier xml fil-->
    <xsl:param name="identifiers" as="xs:string"/>

    <xsl:output method="xml"/>
   <!-- dummy xml for bruk av keys uten ..._identifier.xml-->
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
        
    <xsl:key name="identifier" match="*:identifier" use="@id"/>
    <xsl:key name="oai-identifier" match="*:record" use="*:header/*:identifier"/>
    
    <xsl:variable name="oai-pmh" select="/"/>
    <!-- Dersom ikke identifiers eksisterer, bruk key på dummy record (ingen treff)-->
    <xsl:variable name="identifier-doc"
        select="(document(concat($base-xsl-uri, '../',$identifiers)),$dummy)[1]"/>

    <!-- håndterer alle treff under listRecords i OAI input-->
    <xsl:template match="*:record" priority="2.0">
        <xsl:value-of select="$indent"/>
        <xsl:variable name="md5" select="flub:md5String(string(.))"/>
        <xsl:variable name="id" select="*:header/*:identifier"/>
        <xsl:variable name="identifier" select="key('identifier', $id, $identifier-doc)"/>
        <!-- dersom status er deleted eller md5 har endret seg, boolean for å oppdatere modified-->
        <xsl:variable name="isDifferent"
            select="$identifier/@status = 'deleted' or $identifier/@md5 != $md5"/>       
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
            <!-- Gå igjennom alle gamle identifers og oppdater disse-->
            <xsl:apply-templates select="$identifier-doc" mode="update-identifiers"/>
            <!-- Gå igjennom alle oai elementer (input fil) og opprett de som ikke finnes fra før-->
            <xsl:apply-templates/>
        </identifiers>
    </xsl:template>
    
    <xsl:template match="*" priority="1.0">
        <xsl:apply-templates/>
    </xsl:template>

    <!--Håndtering av records som ikke er tilstede.
        Legg til deleted status-->      
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