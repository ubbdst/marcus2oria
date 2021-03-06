<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
     
        <OAI-PMH xmlns="http://www.openarchives.org/OAI/2.0/">
            <ListRecords>
                <xsl:apply-templates select="*:identifiers/*:identifier[@status='deleted']"/>
            </ListRecords>
        </OAI-PMH>
        
    </xsl:template>
    
    <xsl:template match="*:identifier[@status='deleted']">
        <record>
            <header status="deleted">
                <identifier><xsl:value-of select="@id"/></identifier>
                <datestamp><xsl:value-of select="@modified"/></datestamp>
            </header>
        </record>
    </xsl:template>
</xsl:stylesheet>