<?xml version="1.0" encoding="UTF-8"?>
<!--sparql spørringer for å få ut eksempler til mapping, tar først en spørring etter alle subklasser av bibo dokument,
        og gjør så en sparql construct spørring (fra marcus elasticsearch mapping, litt omskrevet.) på hver klasse
         Begynner med et lite antall per type for å ha noe å teste mappingen på. 
         Denne spørringen er i utgangspunktet skreddersydd for marcus sin datamodell 
         (http://marcus.uib.no/ontology/ubbont.owl) og det er tenkt at uthenting av data fra eget system lages uavhengig av denne xsl-fil-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:flub="http://data.ub.uib.no/ns/function-library/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    exclude-result-prefixes="xs"
    version="2.0">
            
    <!--Tar på messages som er kjøres ut for debugging av kode.-->
    <xsl:param name="debug" as="xs:boolean" select="true()"/>
    <!--Antall objekter som hentes ad gangen i sparql spørring.-->
    <xsl:param name="limit" select="100"/>
    <!-- boolean, bestemmer om en skal gjenta spørringen for hele datasettet eller om en kun skal kjøre en testkjøring. -->
    <xsl:param name="test-run" as="xs:boolean" select="false()"/>
    <!-- sparql endpoint som spørringene kjøres mot-->
    <xsl:param name="sparql-endpoint" select="'http://sparql.ub.uib.no/sparql/sparql?query='"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:include href="lib/types.xsl"/>
    <!--Inneholder liste over typer som ikke skal høstes-->
    <xsl:variable name="blacklist" select="'http://data.ub.uib.no/ontology/Album','http://data.ub.uib.no/ontology/Seal','http://data.ub.uib.no/ontology/Page'" as="xs:string*"/>

    <!--Sparql spørring som henter ut alle typer i modellen som er etterkommere av bibo:Document--> 
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
   
    <xsl:variable name="sparql-output-suffix" select="'&amp;output=xml'"/>
    
    <!-- get sparql spørring etter typer--> 
    <xsl:variable name="types" select="document(concat($sparql-endpoint,encode-for-uri($class-sparql-query),$sparql-output-suffix))"/>   
    
    <!-- main template match som kjører type spørring fra sparql endpoint, kaller så named template getDocummentsFromSparqlQuery-->
    <xsl:template match="/">
        <results>
            <!-- gå igjennom alle typer som ikke er i blacklist og kjør sparql spørring etter dokumenter for hver type-->
            <xsl:for-each
                select="
                    $types/descendant::*:binding[@name = 'class' and not(some $x in $blacklist
                        satisfies $x = */.)]">
                <xsl:call-template name="getDocumentsFromSparqlQuery">
                    <xsl:with-param name="class" select="*/."/>
                    <xsl:with-param name="limit" select="$limit"/>
                    <xsl:with-param name="max-documents-per-type"
                        select="
                            if ($test-run) then
                                2
                            else
                                ()"
                    />
                </xsl:call-template>
            </xsl:for-each>
        </results>
    </xsl:template>
    
    <xsl:template name="getDocumentsFromSparqlQuery">          
        <xsl:param name="offset" select="0" as="xs:integer"/>
        <xsl:param name="limit" select="200" as="xs:integer"/>
        <!--Har satt en retry limit, for å gjenta forsøk på spørring dersom den ikke returnerer noe.
        -->
        <xsl:param name="retry" select="0"/>
        <!-- resultatet fra første spørring som henter klasser brukes i denne spørringen-->
        <xsl:param name="class"/>
        <!-- brukes sammen med $test-run for å gå ut av spørringene tidlig-->
        <xsl:param name="max-documents-per-type" as="xs:integer?"/>
        
        <!--sparql spørring, oppdateres her dersom noe data skal inn-->
        <xsl:variable name="document-query">
            <!-- namespace prefix-->
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
            <!-- construct fields-->
            CONSTRUCT { ?sR a ?classLabel . 
            ?sR dct:identifier ?identifier . 
            ?sR rdfs:label ?label .
            ?sR dct:isPartOf ?collection .
            ?sR dct:description ?description .
            ?sR foaf:maker ?maker . 
            ?sR dct:spatial ?spatial.
            ?sR dct:created ?created.
            ?sR  dct:subject ?topic.
            ?sR  dct:relation ?relation.
            ?sR  ubbont:hasThumbnail ?thumb.
            ?sR ubbont:invertedName ?invMaker.
            ?sR ubbont:collectionTitle ?colLabel.
            ?sR dct:alternative ?alternative.
            } 
            WHERE {
            { GRAPH  &lt;urn:x-arq:UnionGraph> 
            {   {
            SELECT ?s {?s a &lt;<xsl:value-of select="$class"/>>.
            FILTER  EXISTS{?s  ubbont:hasThumbnail ?thumbN.
            ?s dct:identifier ?id.}
            
            } LIMIT <xsl:value-of select="$limit"/> OFFSET <xsl:value-of select="$offset"/>}
            OPTIONAL { ?s  dct:identifier ?identifier }
            {?s  ubbont:hasThumbnail ?thumbnail.}
            <!--Skriv om thumbnail til https://-->
            BIND (REPLACE(str(?thumbnail),"http://data.ub.","https://marcus.","i") AS ?thumb)
            OPTIONAL { ?s  dct:created ?created0 } 
            OPTIONAL { ?s  dct:title ?label } 
            OPTIONAL { ?s  rdfs:label ?label } 
            OPTIONAL { ?s  dct:spatial/&lt;http://www.w3.org/2004/02/skos/core#prefLabel> ?spatial } 
            OPTIONAL { ?s  dct:relation/foaf:name ?relation } 
            OPTIONAL { ?s  dct:subject/ &lt;http://www.w3.org/2004/02/skos/core#prefLabel> ?topic }
            OPTIONAL { ?s  dct:description ?description } 
            OPTIONAL { ?s  &lt;http://www.w3.org/2004/02/skos/core#prefLabel> ?label } 
            OPTIONAL { ?s  foaf:maker/ubbont:invertedName ?invName } 
            OPTIONAL { ?s  foaf:maker/foaf:name ?maker. }             
            OPTIONAL { ?s  dct:isPartOf/rdfs:label ?collection0}
            OPTIONAL { ?s  dct:isPartOf/dct:title ?collection1}
            OPTIONAL { bind (COALESCE(?collection0,?collection1) AS ?collection) }
            OPTIONAL {  
            ?s  foaf:maker/foaf:firstName ?firstNameMaker. 
            ?s  foaf:maker/foaf:familyName ?familyNameMaker.
            }
            OPTIONAL {?s dct:alternative ?alternative .}
            <!-- top collection name start, for construct ?sR ?colLabel1-->
            OPTIONAL {?s (dct:isPartOf)* ?topCollection.
            NOT EXISTS {?topCollection dct:isPartOf ?part}}
            OPTIONAL {?topCollection rdfs:label ?colLabel0.}
            OPTIONAL {?topCollection dct:title ?colLabel1.}
            BIND (
            COALESCE(?colLabel0,?colLabel1)
            as ?colLabel)
            <!-- end-->
           <!-- binding names for inverse name in facets section-->
           BIND (IF(bound(?familyNameMaker) &amp;&amp; bound(?firstNameMaker),
           CONCAT(?familyNameMaker,", ",?firstNameMaker),
           coalesce(?invName,?maker))
           AS ?invMaker)
            <!-- binding variables for result variables-->
            BIND (str(?created0) 
            AS ?created)
            BIND (iri(replace(str(?s), "data.ub.uib.no", "marcus.uib.no")) 
            AS ?sR ) }
            }                 GRAPH ubbont:ubbont { &lt;<xsl:value-of select="$class"/>> rdfs:label ?classLabel . FILTER (langMatches(lang(?classLabel),"")) } 
            }         
        </xsl:variable>
        
        <xsl:variable name="result" select="document(concat($sparql-endpoint,encode-for-uri(replace($document-query,'(\s)\s+','$1')),$sparql-output-suffix))" as="node()?"/>
        
        <xsl:if test="$debug">
        <xsl:message>start of <xsl:value-of select="$class"/> offset: <xsl:value-of select="$offset"/></xsl:message>
        </xsl:if>
        <xsl:variable name="retry-times" select="5"/>
        <xsl:choose>
            <!--prøv på nytt ved feil-->
            <xsl:when test="not($result/descendant-or-self::rdf:RDF) and $retry &lt; $retry-times">
                <xsl:call-template name="getDocumentsFromSparqlQuery">
                    <xsl:with-param name="class" select="$class"/>
                    <xsl:with-param name="offset" select="$offset"/>
                    <xsl:with-param name="limit" select="$limit"/>
                    <xsl:with-param name="max-documents-per-type" select="$max-documents-per-type"/>
                    <xsl:with-param name="retry" select="$retry + 1"/>
                </xsl:call-template>
            </xsl:when>
            <!--terminer etter  $retry-times forsøk-->
            <xsl:when test="not($result/descendant-or-self::rdf:RDF)">
                <xsl:message terminate="yes">sparql endpoint returnerte ikke resultat.
                    Avslutter.</xsl:message>
            </xsl:when>
            <!--håndter tom klasse-->
            <xsl:when test="not($result/descendant-or-self::rdf:RDF/*) and $offset = 0">
                <xsl:message><xsl:text>Klasse </xsl:text><xsl:value-of select="."/>
                    <xsl:text> har ingen objekt å mappe.</xsl:text></xsl:message>
            </xsl:when>
            <!--ved ingen flere treff avslutt named templatae-->
            <xsl:when test="not($result/descendant-or-self::rdf:RDF/*)"/>
            <!--ta med resultat fra første spørring, og gjenta spørring-->
            <xsl:otherwise>
                <xsl:variable name="count-description"
                    select="count($result/descendant-or-self::rdf:RDF/*)"/>
                <xsl:sequence select="$result"/>
                <xsl:if
                    test="
                        $max-documents-per-type &lt; $limit + $offset
                        or
                        (not(string(($max-documents-per-type)))
                        and not($count-description &lt; $limit))">
                    <xsl:call-template name="getDocumentsFromSparqlQuery">
                        <xsl:with-param name="offset" select="$offset + $limit"/>
                        <xsl:with-param name="limit" select="$limit"/>
                        <xsl:with-param name="class" select="$class"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>            
    </xsl:template>
        
</xsl:stylesheet>