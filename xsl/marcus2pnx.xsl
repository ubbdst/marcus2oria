<?xml version="1.0" encoding="UTF-8"?>
<!-- Stilark som står for mapping fra sparql resultatet fra getDocuments.xsl for marcus
     Lager et OAI resultat med PNX-mapping, hvor en bruker named templates generert fra relaxNG skjema for PNX -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dct="http://purl.org/dc/terms/"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:flub="http://data.ub.uib.no/ns/function-library/"
    xmlns:ubbont="http://data.ub.uib.no/ontology/"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns="http://www.openarchives.org/OAI/2.0/"
    exclude-result-prefixes="ubbont xs flub foaf rdfs dct rdf"
    
    version="2.0">
    
    <xsl:strip-space elements="*"/>    
    <xsl:param name="debug" as="xs:boolean" select="false()"/>
    <!-- bibliotek som global parameter for å velge tilhørighet til andre bibliotek-->
    <xsl:param name="library" select="'1120109'"  as="xs:string"/>
    <!--instusjonsnavn i Oria-->
    <xsl:param name="institution" select="'UBB'"  as="xs:string"/>
    <!--bruke scopenavn som avtales med bibsys-->
    <xsl:param name="searchscope" select="'UBB_MARCUS'"  as="xs:string"/>    
    <!--bruke scopenavn som avtales med bibsys-->
    <xsl:param name="scope" select="'UBB_MARCUS'"  as="xs:string"/>
    <!--overstyrer denne inn i oria-->
    <xsl:param name="publisher" as="xs:string" select="'Universitetsbiblioteket i Bergen'"/>
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:include href="lib/pnx.xsl"/>
    <xsl:include href="lib/types.xsl"/>
    <xsl:include href="lib/subfields.xsl"/>
    
    <xsl:variable name="sourceid" select="'UBB-MARCUS'"/>
    <xsl:variable name="source-repository" select="'Marcus'"/>
    
    <!-- tar inn OAI toppelement og listrecord på main template -->
    <xsl:template match="/">        
        <OAI-PMH xmlns="http://www.openarchives.org/OAI/2.0/">
            <ListRecords>
                <xsl:apply-templates/>                
            </ListRecords>
        </OAI-PMH>
    </xsl:template>
    
    <!-- håndtering av hvert enkelt resultat (dokument) fra sparql spørringen-->
    <xsl:template match="rdf:Description">
        <xsl:variable name="identifier" select="dct:identifier"/>        
        <xsl:variable name="sourcerecordid" select="concat(rdf:type,'/',$identifier)"/>
        <xsl:variable name="recordid" select="concat($sourceid,'/',$sourcerecordid)"/>
        <record>
        <header>
            <!--?? kanskje bruke nytt felt ubbont:uuid her? noen dubletter av dct:identifier.-->           
            <identifier><xsl:value-of select="$recordid"/></identifier>
        </header>
        <metadata>           
          
            <recordContainer xmlns="">
             <!-- create control section-->
            <xsl:call-template name="control">                
                <xsl:with-param name="recordid" select="$recordid"/>
                <xsl:with-param name="sourceformat" select="'PNX'"/>
                <xsl:with-param name="sourceid" select="$sourceid"/>
                <xsl:with-param name="sourcerecordid" select="$sourcerecordid"/>
                <xsl:with-param name="sourcesystem" select="$source-repository"/>                                
            </xsl:call-template>
            <!-- variables for display section-->
            <xsl:variable name="display_maker" select="string-join(foaf:maker,'; ')"/>
            <xsl:variable name="creation_date" select="tokenize(dct:created[1],'-')[1]"/>
                <!-- tar med distinct values siden man har labels for steder også i subject, slik at en ikke får dubletter på feks bergen.-->
            <xsl:variable name="subjects" select="distinct-values(dct:subject,dct:spatial)"/>
            <xsl:variable name="display_subject" select="string-join($subjects,'; ')"/>
            <xsl:variable name="main_title" select="(rdfs:label[string(.)][1],'[Uten tittel]')[1]"/>
                <xsl:if test="$debug and not(dct:isPartOf) and not(ubbont:collectionTitle)">
                <xsl:message><xsl:value-of select="$recordid"/> uten ispartof</xsl:message>
            </xsl:if>
                <xsl:if test="$debug and (count(dct:created) &gt; 1)">
                    <xsl:message><xsl:value-of select="$recordid"/> <xsl:value-of select="dct:created"/> er mer enn en verdi</xsl:message>
                </xsl:if>
            <!-- create display section-->
            <xsl:call-template name="display">                
                <!-- ?? http://knowledge.exlibrisgroup.com/Primo/Product_Documentation/Technical_Guide/Mapping_to_the_Normalized_Record/Adding_%24%249ONLINE_to_Library_Level_Availability#ww1157297-->
                <xsl:with-param name="availlibrary" select="'$$9ONLINE'"/>
                <xsl:with-param name="creationdate" select="$creation_date"/>
                <xsl:with-param name="creator" select="$display_maker"/>
                <xsl:with-param name="description" select="dct:description,dct:alternative"/>
                <!--@todo ta inn physdesc, dct:extent i spørring? og ta concat?
                <xsl:with-param name="format"/>-->
                <xsl:with-param name="identifier" select="$identifier"/>
                <!--?? Flere top collections? bruke top collection her? se winterton http://search.library.northwestern.edu/primo_library/libweb/action/display.do?tabs=detailsTab&showPnx=true&ct=display&fn=search&doc=01NWU_WTON37&indx=4&recIds=01NWU_WTON37&recIdxs=3&elementId=&renderMode=poppedOut&displayMode=full&http://search.library.northwestern.edu:80/primo_library/libweb/action/expand.do?gathStatTab=true&dscnt=0&mode=Basic&vid=NULV&rfnGrp=1&tab=default_tab&dstmp=1465498593567&frbg=&rfnGrpCounter=1&frbrVersion=2&tb=t&fctV=images&srt=rank&fctN=facet_rtype&dum=true&vl(freeText0)=winterton&fromTabHeaderButtonPopout=true -->
                <xsl:with-param name="ispartof" select="dct:isPartOf,ubbont:collectionTitle"/>
                <!--?? er dette riktig bruk av subfield for å få ut Universitetsbiblioteket i Bergen?--> 
                <xsl:with-param name="publisher" select="$publisher"/>
                <xsl:with-param name="source" select="$source-repository"/>
                <xsl:with-param name="subject" select="$display_subject"/>
                <xsl:with-param name="title" select="$main_title"/>
                <xsl:with-param name="type" select="flub:getPrimoTypeFromRdfTypeLabel(rdf:type[1])"/>                               
            </xsl:call-template>
            
            <!-- variables for facets-->
            <xsl:variable name="rsrctype" select="flub:getRsrcTypeFromRdfTypeLabel(rdf:type[1])"/>
           
            <!-- create facets section-->
            <xsl:call-template name="facets">
                <!-- ta inn overordnet samling? i.e billedsamling, eller alle undersamlinger??
                -->
                <xsl:with-param name="collection" select="ubbont:collectionTitle"/>
                <!--?? normaliser creationdate i etter regler i dokumentasjon?-->
                <xsl:with-param name="creationdate" select="$creation_date"/>
                <!--@todo tror dct:contributor er med i ontology, men ikke særlig i bruk, tar bare med skapere-->
                <!-- Har satt inn to forsøk på inverted name (concat lastname,firstname, så property inverted name,
                hvis ikke brukes foaf:name som ikke er invertert. Tar vekk [1] bak invertedName siden denne kan ha flere?-->
                <xsl:with-param name="creatorcontrib" select="ubbont:invertedName"/>
                <xsl:with-param name="rsrctype" select="$rsrctype"/>
                <xsl:with-param name="prefilter" select="$rsrctype"/>
                <xsl:with-param name="toplevel" select="('online_resources','available')"/>                
                <xsl:with-param name="topic" select="$subjects"/>
                <xsl:with-param name="library" select="flub:setSubfield('L',$library)"/>
            </xsl:call-template>          
           
            <xsl:call-template name="search">
                <!-- @todo finne ut om vi har skos:altLabel også på dokument, eller flere titler enn en, lage sparql mapping addtitle,alttitle-->
                <!--@todo? ta inn datorange og lage flere felt som xs:gYear*-->                
                <xsl:with-param name="creationdate" select="$creation_date"/>
                <xsl:with-param name="creatorcontrib" select="foaf:maker"/>
                <xsl:with-param name="description" select="dct:description,dct:alternative"/>                
                <!--@todo enddate startdate date range må inn i sparql spørring-->
                <!--@todo legg inn publisher på general og i sparql spørring<xsl:with-param name="general"/>-->
                <xsl:with-param name="recordid" select="$recordid"/>                
                <xsl:with-param name="rsrctype" select="$rsrctype"/>
                <xsl:with-param name="sourceid" select="$sourceid"/>
                <xsl:with-param name="subject" select="$subjects"/>
                <xsl:with-param name="title" select="$main_title"/>
                <xsl:with-param name="addtitle" select="ubbont:collectionTitle"/>
                <xsl:with-param name="scope" select="$scope"/>
                <xsl:with-param name="searchscope" select="$searchscope"/>
            </xsl:call-template>
            
            <xsl:call-template name="delivery">
                <xsl:with-param name="institution" select="$institution"/>
                <xsl:with-param name="delcategory" select="'Online Resource'"/>                
            </xsl:call-template>
            
            <xsl:call-template name="links">
                <xsl:with-param name="thumbnail" select="flub:setSubfield('U',ubbont:hasThumbnail[1])"/>
                <xsl:with-param name="linktorsrc" select="flub:subfieldSetDisplayAndUrl('Lenke til Marcus',@rdf:about)"/>
            </xsl:call-template>
            
            <xsl:call-template name="sort">
                <xsl:with-param name="author" select="foaf:maker[1]"/>
                <xsl:with-param name="title" select="$main_title"/>
                <xsl:with-param name="creationdate" select="$creation_date[1]"/>
            </xsl:call-template>
          
                <xsl:call-template name="ranking">
                <xsl:with-param name="booster1" select="'1'"/>
            </xsl:call-template>
                
                <!-- @todo kan mappe noe inn her i adddata, avventer og ser
            <xsl:call-template name="addata">
                
            </xsl:call-template>
            -->             
            </recordContainer>
        </metadata>
        </record>
    </xsl:template>    
</xsl:stylesheet>