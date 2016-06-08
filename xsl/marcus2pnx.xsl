<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dct="http://purl.org/dc/terms/"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:flub="http://data.ub.uib.no/ns/function-library/"
    xmlns:ubbont="http://data.ub.uib.no/ontology/"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    exclude-result-prefixes="ubbont xs flub foaf rdfs dct rdf"
    
    version="2.0">
    <xsl:strip-space elements="*"/>
    <xsl:param name="institution" select="'UBB'"/>
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:include href="lib/pnx.xsl"/>
    <xsl:include href="lib/types.xsl"/>
    
    <xsl:template match="/">
        <OAI-PMH>
            <ListRecords>
                <xsl:apply-templates/>
            </ListRecords>
        </OAI-PMH>
    </xsl:template>
    
    <xsl:template match="rdf:Description">
        <metadata>
            <xsl:variable name="sourceid" select="'UBB-MARCUS'"/>
            <!-- kanskje bruke nytt felt ubbont:uuid her? noen dubletter av dct:identifier.-->
            <xsl:variable name="identifier" select="dct:identifier"/>
            <xsl:variable name="source-repository" select="'Marcus'"/>
            <xsl:variable name="sourcerecordid" select="concat(rdf:type,'/',$identifier)"/>
            <xsl:variable name="recordid" select="concat($sourceid,'/',$sourcerecordid)"/>
            <xsl:call-template name="control">                
                <xsl:with-param name="recordid" select="$recordid"/>
                <xsl:with-param name="sourceformat" select="'PNX'"/>
                <xsl:with-param name="sourceid" select="$sourceid"/>
                <xsl:with-param name="sourcerecordid" select="$sourcerecordid"/>
                <xsl:with-param name="sourcesystem" select="$source-repository"/>                                
            </xsl:call-template>
            
            <xsl:variable name="display_maker" select="string-join(foaf:maker,';')"/>
            <xsl:variable name="creation_date" select="tokenize(dct:created,'-')[1]"/>
            <xsl:variable name="display_subject" select="string-join(dct:subject,';')"/>
            <xsl:variable name="main_title" select="(rdfs:label[1],'[Uten Tittel]')[1]"/>
            
            <xsl:call-template name="display">                
                <!-- ?? http://knowledge.exlibrisgroup.com/Primo/Product_Documentation/Technical_Guide/Mapping_to_the_Normalized_Record/Adding_%24%249ONLINE_to_Library_Level_Availability#ww1157297-->
                <xsl:with-param name="availlibrary" select="'$$9ONLINE'"/>
                <xsl:with-param name="creationdate" select="$creation_date"/>
                <xsl:with-param name="creator" select="$display_maker"/>
                <!--?? Multiple occurrences are not concatenated. Betyr dette at vi kan ha flere beskrivelsesfelt eller at man kun har en beskrivelse? står mange steder-->
                <xsl:with-param name="description" select="dct:description[1]"/>
                <!--@todo ta inn physdesc, dct:extent i spørring? og ta concat?
                <xsl:with-param name="format"/>-->
                <xsl:with-param name="identifier" select="$identifier"/>
                <xsl:with-param name="ispartof" select="dct:isPartOf[1]"/>
                <!--@todo legg til publisher i sparql spørring-->
                <xsl:with-param name="source" select="$source-repository"/>
                <xsl:with-param name="subject" select="$display_subject"/>
                <xsl:with-param name="title" select="$main_title"/>
                <xsl:with-param name="type" select="flub:getPrimoTypeFromRdfTypeLabel(rdf:type[1])"/>
                <xsl:with-param name="unititle" select="$main_title"/>                
            </xsl:call-template>
           
            <xsl:variable name="rsrctype" select="flub:getRsrcTypeFromRdfTypeLabel(rdf:type[1])"/>
           
            <xsl:call-template name="facet">
                <!--?? ta inn overordnet samling? i.e billedsamling, eller alle undersamlinger??
                <xsl:with-param name="collection"/>-->
                <xsl:with-param name="creationdate" select="$creation_date"/>
                <!--@todo tror dct:contributor er med i ontology, men ikke særlig i bruk, tar bare med skapere-->
                <!-- ?? kan navn taes inn slik de er, (fornavn etternavn) for å så normaliseres??-->
                <xsl:with-param name="creatorcontrib" select="foaf:maker"/>
                <xsl:with-param name="rsrctype" select="$rsrctype"/>
                <xsl:with-param name="toplevel" select="'Online Resources'"/>
            </xsl:call-template>
            
            <xsl:call-template name="search">
                <!-- @todo finne ut om vi har skos:altLabel også på dokument, eller flere titler enn en, lage sparql mapping addtitle,alttitle-->
                <!--@todo ta inn datorange og lage flere felt som xs:gYear*-->
                <xsl:with-param name="creationdate" select="$creation_date"/>
                <xsl:with-param name="creatorcontrib" select="foaf:maker"/>
                <xsl:with-param name="description" select="dct:description"/>
                <!--@todo enddate startdate date range må inn i sparql spørring-->
                <!--@todo legg inn publisher på general og i sparql spørring<xsl:with-param name="general"/>-->
                <xsl:with-param name="recordid" select="$recordid"/>
                <xsl:with-param name="rsrctype" select="$rsrctype"/>
                <xsl:with-param name="sourceid" select="$sourceid"/>
                <xsl:with-param name="subject" select="dct:subject"/>
                <xsl:with-param name="title" select="$main_title"/>
            </xsl:call-template>
            
            <xsl:call-template name="delivery">
                <xsl:with-param name="institution" select="$institution"/>
                <xsl:with-param name="delcategory" select="'Online Resources'"/>                
            </xsl:call-template>
            
            <xsl:call-template name="links">
                <xsl:with-param name="thumbnail" select="ubbont:hasThumbnail"/>
                <xsl:with-param name="linktorsrc" select="@rdf:about"/>
            </xsl:call-template>
            
            <xsl:call-template name="sort">
                <xsl:with-param name="author" select="foaf:maker[1]"/>
                <xsl:with-param name="title" select="rdf:label[1]"/>
                <xsl:with-param name="creationdate" select="$creation_date[1]"/>
            </xsl:call-template>
            <!-- @todo kan mappe noe inn her i adddata, avventer og ser
            <xsl:call-template name="addata">
                
            </xsl:call-template>
            -->
        </metadata>
    </xsl:template>
</xsl:stylesheet>