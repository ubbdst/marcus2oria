<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:flub="http://data.ub.uib.no/ns/function-library/"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="2.0">
    
    <xsl:key name="primo-type-from-marcus" match="@primo-type" use="parent::marcus-label/text()"/>
    <xsl:variable name="types-table" as="node()">
        <types>
            <marcus-label primo-type="book">Manuskript</marcus-label>
            <marcus-label primo-type="text_resource">Brev</marcus-label>
            <!-- mer en samling enn dokument, ignorer? <marcus-label primo-type="">Album</marcus-label>-->
            <marcus-label primo-type="book">Bok</marcus-label>
            <marcus-label primo-type="book">Forhandlingsprotokoll</marcus-label>
            <marcus-label primo-type="book">Kassebok</marcus-label>
            <marcus-label primo-type="text_resource">Diplom</marcus-label>
            <marcus-label primo-type="text_resource">Kontrakt</marcus-label>
            <marcus-label primo-type="book">Dagbok</marcus-label>
            <marcus-label primo-type="book">Dokument</marcus-label>
            <marcus-label primo-type="image">Tegning</marcus-label>
            <marcus-label primo-type="book">Fragment</marcus-label>
            <marcus-label primo-type="image">Grafikk</marcus-label>
            <marcus-label primo-type="book">Reisedagbok</marcus-label>
            <marcus-label primo-type="text_resource">Oppmålingsdokument</marcus-label>
            <marcus-label primo-type="map">Kart</marcus-label>
            <marcus-label primo-type="text_resource">Notat</marcus-label>
            <marcus-label primo-type="image">Fotografi</marcus-label>
            <marcus-label primo-type="image">Postkort</marcus-label>
            <marcus-label primo-type="image">Plakat</marcus-label>
            <marcus-label primo-type="book">Bønnebok</marcus-label>
            <marcus-label primo-type="book">Protokoll</marcus-label>
            <marcus-label primo-type="text_resource">Kvittering</marcus-label>
            <marcus-label primo-type="text_resource">Salgsskjøte</marcus-label>
            <marcus-label primo-type="text_resource">Tale</marcus-label>
            <marcus-label primo-type="text_resource">Telegram</marcus-label>
            <marcus-label primo-type="text_resource">Transkripsjon</marcus-label>
            <!-- <marcus-label primo-type="">Side</marcus-label>
            <marcus-label primo-type="">Segl</marcus-label>-->            
        </types>
    </xsl:variable>
    
    <xsl:function name="flub:getPrimoTypeFromRdfTypeLabel">
        <xsl:param name="rdfTypeLabel"/>
        <xsl:variable name="oria-type" select="key('primo-type-from-marcus',$rdfTypeLabel,$types-table)"/>
        <xsl:if test="not($oria-type)">
            <xsl:message terminate="yes">flub:getPrimoTypeFromRdfTypeLabel(): <xsl:value-of select="$rdfTypeLabel"/> er ikke mappet</xsl:message>
        </xsl:if>
        <xsl:value-of select="$oria-type"/>
       </xsl:function>
    
</xsl:stylesheet>