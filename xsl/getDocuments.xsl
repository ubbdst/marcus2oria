<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:flub="http://data.ub.uib.no/ns/function-library/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    exclude-result-prefixes="xs"
    version="2.0">
    <!-- sparql spørringer for å få ut eksempler til mapping, tar først en spørring etter alle subklasser av bibo dokument, og gjør en sparql construct spørring (fra marcus elasticsearch mapping, litt omskrevet.) på hver klasse
         Begynner med et lite antall per type for å ha noe å teste mappingen på.
         Bruker saxon:discard-document som er tilgjengelig i Saxon 9.1-B, men ikke nyere HE versjoner av Saxon. Kan også bruke PE og EE.
         -->
    <xsl:output method="xml" indent="yes"/>
    <xsl:include href="lib/types.xsl"/>
    <xsl:variable name="blacklist" select="'http://data.ub.uib.no/ontology/Album','http://data.ub.uib.no/ontology/Seal','http://data.ub.uib.no/ontology/Page'" as="xs:string*"/>
    <xsl:variable name="class-sparql-query">
        PREFIX bibo: &lt;http://purl.org/ontology/bibo/>
        PREFIX rdf: &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#>
        prefix owl: &lt;http://www.w3.org/2002/07/owl#>
        prefix rdfs: &lt;http://www.w3.org/2000/01/rdf-schema#>
                    
                    SELECT DISTINCT ?class 
                    WHERE {
                    GRAPH ?g {
                    <!-- mulig at owl:Class også skulle vært med her, men for nå finnes det ingen underklasser av bibo:Document som er owl:Class-->
                    ?class a rdfs:Class.                    
                    ?class (rdfs:subClassOf)* bibo:Document.
                    }
                    }                    
    </xsl:variable>
    
    <xsl:variable name="sparql-endpoint" select="'http://sparql.ub.uib.no/sparql/sparql?query='"/>
    <xsl:variable name="sparql-output-suffix" select="'&amp;output=xml'"/>
    
    <xsl:variable name="types" select="document(concat($sparql-endpoint,encode-for-uri($class-sparql-query),$sparql-output-suffix))"/>   
    
    <xsl:template match="/"> 
       
        <results>
            <xsl:for-each select="$types/descendant::*:binding[@name='class' and not(some $x in $blacklist satisfies $x =*/.)]">
            <xsl:call-template name="getDocumentsFromSparqlQuery">
                <xsl:with-param name="class" select="*/."/>
                <xsl:with-param name="limit" select="2"/>
                <xsl:with-param name="max-documents-per-type" select="2"/>
                            </xsl:call-template>
        </xsl:for-each>
        </results>
    </xsl:template>

    <xsl:template name="getDocumentsFromSparqlQuery">
        <xsl:param name="offset" select="0" as="xs:integer"/>
        <xsl:param name="limit" select="200" as="xs:integer"/>
        <xsl:param name="class"/>
        <xsl:param name="max-documents-per-type" as="xs:integer?"/>
        <xsl:variable name="document-without-image">
            PREFIX rdf:&lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
            PREFIX rdfs: &lt;http://www.w3.org/2000/01/rdf-schema#> 
            PREFIX xsd:&lt;http://www.w3.org/2001/XMLSchema#> 
            PREFIX foaf: &lt;http://xmlns.com/foaf/0.1/>
            PREFIX owl:&lt;http://www.w3.org/2002/07/owl#> 
            PREFIX skos: &lt;http://www.w3.org/2004/02/skos/core#> 
            PREFIX dct: &lt;http://purl.org/dc/terms/> 
            PREFIX bibo:&lt;http://purl.org/ontology/bibo/> 
            PREFIX geo: &lt;http://www.w3.org/2003/01/geo/wgs84_pos#> 
            PREFIX ubbont: &lt;http://data.ub.uib.no/ontology/> 
            CONSTRUCT { ?sR a ?classLabel . ?sR 
            &lt;http://purl.org/dc/terms/identifier> ?identifier . 
            ?sR &lt;http://www.w3.org/2000/01/rdf-schema#label> ?label .
            ?sR &lt;http://purl.org/dc/terms/isPartOf> ?collection .
            ?sR &lt;http://purl.org/dc/terms/description> ?description .
            ?sR &lt;http://xmlns.com/foaf/0.1/maker> ?maker . 
            ?sR &lt;http://purl.org/dc/terms/spatial> ?spatial.
            ?sR &lt;http://purl.org/dc/terms/created> ?created.
            ?sR  &lt;http://purl.org/dc/terms/subject> ?topic.
            ?sR  &lt;http://purl.org/dc/terms/relation> ?relation.
            ?sR  &lt;http://data.ub.uib.no/ontology/hasThumbnail> ?thumb.
            } 
            WHERE {
            { GRAPH  &lt;urn:x-arq:UnionGraph> 
            {   {
            SELECT ?s {?s a &lt;<xsl:value-of select="$class"/>>.
            FILTER  EXISTS{?s  &lt;http://data.ub.uib.no/ontology/hasThumbnail> ?thumbN.
            ?s dct:identifier ?id.}
            
            } LIMIT <xsl:value-of select="$limit"/> OFFSET <xsl:value-of select="$offset"/>}
            OPTIONAL { ?s  &lt;http://purl.org/dc/terms/identifier> ?identifier }
            {?s  &lt;http://data.ub.uib.no/ontology/hasThumbnail> ?thumbnail.}
            <!--Skriv om thumbnail til https://-->
            BIND (REPLACE(str(?thumbnail),"http://data.ub.","https://marcus.","i") AS ?thumb)
            OPTIONAL { ?s  &lt;http://purl.org/dc/terms/created> ?created0 } 
            OPTIONAL { ?s  &lt;http://purl.org/dc/terms/title> ?label } 
            OPTIONAL { ?s  &lt;http://www.w3.org/2000/01/rdf-schema#label> ?label } 
            OPTIONAL { ?s  &lt;http://purl.org/dc/terms/spatial>/&lt;http://www.w3.org/2004/02/skos/core#prefLabel> ?spatial } 
            OPTIONAL { ?s  &lt;http://purl.org/dc/terms/relation>/&lt;http://xmlns.com/foaf/0.1/name> ?relation } 
            OPTIONAL { ?s  &lt;http://purl.org/dc/terms/subject>/ &lt;http://www.w3.org/2004/02/skos/core#prefLabel> ?topic }
            OPTIONAL { ?s  &lt;http://purl.org/dc/terms/description> ?description } 
            OPTIONAL { ?s  &lt;http://www.w3.org/2004/02/skos/core#prefLabel> ?label } 
            OPTIONAL { ?s  &lt;http://xmlns.com/foaf/0.1/maker>/&lt;http://data.ub.uib.no/ontology/invertedName> ?maker } 
            OPTIONAL { ?s  &lt;http://xmlns.com/foaf/0.1/maker>/&lt;http://xmlns.com/foaf/0.1/name> ?maker. }             
            OPTIONAL { ?s  &lt;http://purl.org/dc/terms/isPartOf>/&lt;http://www.w3.org/2000/01/rdf-schema#label> ?collection}
            BIND (str(?created0) AS ?created)
            BIND (iri(replace(str(?s), "data.ub.uib.no", "marcus.uib.no")) AS ?sR ) }
            }                 GRAPH ubbont:ubbont { &lt;<xsl:value-of select="$class"/>> rdfs:label ?classLabel . FILTER (langMatches(lang(?classLabel),"")) } 
            }         
        </xsl:variable>
        <xsl:variable name="result" select="document(concat($sparql-endpoint,encode-for-uri($document-without-image),$sparql-output-suffix))" as="node()"/>
         <xsl:choose>
            <xsl:when test="not($result/descendant-or-self::rdf:RDF)">
                <xsl:message terminate="yes">sparql endpoint returnerte ikke resultat. Avslutter.</xsl:message>
            </xsl:when>
            <xsl:when test="not($result/descendant-or-self::rdf:RDF/*) and $offset = 0">
                <xsl:message>Klasse <xsl:value-of select="."/> har ingen objekt å mappe.</xsl:message>
            </xsl:when>
            <xsl:when test="not($result/descendant-or-self::rdf:RDF/*)"></xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="$result"/>       
                <xsl:if test="$max-documents-per-type >$limit+$offset or not($max-documents-per-type)">
                    <xsl:call-template name="getDocumentsFromSparqlQuery">
                        <xsl:with-param name="offset" select="$offset+$limit"/>
                        <xsl:with-param name="class" select="$class"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>            
    </xsl:template>
        
</xsl:stylesheet>