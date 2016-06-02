<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <!-- sparql spørringer for å få ut eksempler til mapping, tar først en spørring etter alle subklasser av bibo dokument, og gjør en sparql construct spørring (fra marcus elasticsearch mapping, litt omskrevet.) på hver klasse
         Begynner med et lite antall per type for å ha noe å teste mappingen på.
         @todo bruke offset og rekursjon per klasse, inntil rdf:RDF ikke har noen rdf:Description returnert?
         @todo ignorer noen klasser som ikke skal med, som feks page
         @todo ta inn igjen type som streng, er med i ES.
    -->
    <xsl:output method="xml" indent="yes"/>
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
        <xsl:for-each select="$types/descendant::*:binding[@name='class']">
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
                SELECT ?s {?s a &lt;<xsl:value-of select="*/."/>>.
                } LIMIT 3}
                OPTIONAL { ?s  &lt;http://purl.org/dc/terms/identifier> ?identifier }
                OPTIONAL { ?s  &lt;http://purl.org/dc/terms/created> ?created0 } 
                OPTIONAL { ?s  &lt;http://purl.org/dc/terms/title> ?label } 
                OPTIONAL { ?s  &lt;http://www.w3.org/2000/01/rdf-schema#label> ?label } 
                OPTIONAL { ?s  &lt;http://purl.org/dc/terms/spatial>/&lt;http://www.w3.org/2004/02/skos/core#prefLabel> ?spatial } 
                OPTIONAL { ?s  &lt;http://purl.org/dc/terms/relation>/&lt;http://xmlns.com/foaf/0.1/name> ?relation } 
                OPTIONAL { ?s  &lt;http://purl.org/dc/terms/subject>/ &lt;http://www.w3.org/2004/02/skos/core#prefLabel> ?topic }
                OPTIONAL { ?s  &lt;http://purl.org/dc/terms/description> ?description } 
                OPTIONAL { ?s  &lt;http://www.w3.org/2004/02/skos/core#prefLabel> ?label } 
                OPTIONAL { ?s  &lt;http://xmlns.com/foaf/0.1/maker>/&lt;http://data.ub.uib.no/ontology/invertedName> ?maker } 
                OPTIONAL { ?s  &lt;http://purl.org/dc/terms/isPartOf>/&lt;http://www.w3.org/2000/01/rdf-schema#label> ?collection}
                OPTIONAL { ?s  &lt;http://data.ub.uib.no/ontology/hasThumbnail> ?thumb } 
                BIND (str(?created0) AS ?created)
                BIND (iri(replace(str(?s), "data.ub.uib.no", "marcus.uib.no")) AS ?sR ) } 
                }
                }
            </xsl:variable>
            
            <xsl:sequence select="document(concat($sparql-endpoint,encode-for-uri($document-without-image),$sparql-output-suffix))"/>      
        </xsl:for-each>
        </results>
    </xsl:template>
</xsl:stylesheet>