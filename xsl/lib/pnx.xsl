<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2">
     <!--Automatically generated xsl library with templates for creating the different pnx sections based on PNX.rng 2016-06-08+02:00-->
 
     <!--     In some cases, the system will take only one of the following fields: 
            *All fields of the Control section.-->

     <xsl:template name="control">
           <xsl:param name="sourceid" as="xs:string"/>
           <xsl:param name="originalsourceid" as="xs:string?"/>
           <xsl:param name="sourcerecordid" as="xs:string"/>
           <xsl:param name="addsrcrecordid" as="xs:string?"/>
           <xsl:param name="recordid" as="xs:string"/>
           <xsl:param name="sourcetype" as="xs:string?"/>
           <xsl:param name="sourceformat" as="xs:string"/>
           <xsl:param name="sourcesystem" as="xs:string"/>

           <!--The source ID identifies the source repository in Primo. Every
                    source repository has a configuration file in which the sourceid and other
                    information about the source repository are recorded.-->           
           <xsl:for-each select="$sourceid[string(.)]">
                 <sourceid>
                       <xsl:value-of select="."/>
                 </sourceid>
           </xsl:for-each>
     
           <!--This ID identifies the source repository in the source system. This
                    is not necessarily the same as the source repository's identifier in Primo—for
                    example, USM01.-->           
           <xsl:for-each select="$originalsourceid[string(.)]">
                 <originalsourceid>
                       <xsl:value-of select="."/>
                 </originalsourceid>
           </xsl:for-each>
     
           <!--The source ID identifies the source repository in Primo. Every
                    source repository has a configuration file in which the sourceid and other
                    information about the source repository are recorded. This ID identifies the record in the source repository (such as an
                    ALEPH system number supplied in MARC21 tag 001). This ID must be unique and
                    persistent within the source repository. It is derived from the OAI
                    header.-->           
           <xsl:for-each select="$sourcerecordid[string(.)]">
                 <sourcerecordid>
                       <xsl:value-of select="."/>
                 </sourcerecordid>
           </xsl:for-each>
     
           <!--This ID identifies an additional ID of the source
                    record.-->           
           <xsl:for-each select="$addsrcrecordid[string(.)]">
                 <addsrcrecordid>
                       <xsl:value-of select="."/>
                 </addsrcrecordid>
           </xsl:for-each>
     
           <!--The source ID identifies the source repository in Primo. Every
                    source repository has a configuration file in which the sourceid and other
                    information about the source repository are recorded. This ID identifies the record in the source repository (such as an
                    ALEPH system number supplied in MARC21 tag 001). This ID must be unique and
                    persistent within the source repository. It is derived from the OAI
                    header. The record ID is a unique identifier of the record in the Primo
                    repository. The sourceid and sourcerecordid are concatenated to create the
                    recordid (for example, ALEPH system number + tag 001).-->           
           <xsl:for-each select="$recordid[string(.)]">
                 <recordid>
                       <xsl:value-of select="."/>
                 </recordid>
           </xsl:for-each>
     
           <!--Source type—not in use.-->           
           <xsl:for-each select="$sourcetype[string(.)]">
                 <sourcetype>
                       <xsl:value-of select="."/>
                 </sourcetype>
           </xsl:for-each>
     
           <!--The source ID identifies the source repository in Primo. Every
                    source repository has a configuration file in which the sourceid and other
                    information about the source repository are recorded. This ID identifies the record in the source repository (such as an
                    ALEPH system number supplied in MARC21 tag 001). This ID must be unique and
                    persistent within the source repository. It is derived from the OAI
                    header. The record ID is a unique identifier of the record in the Primo
                    repository. The sourceid and sourcerecordid are concatenated to create the
                    recordid (for example, ALEPH system number + tag 001). The source format identifies the original format of the source
                    record (such as MARC21, Dublin Core, and MAB2).-->           
           <xsl:for-each select="$sourceformat[string(.)]">
                 <sourceformat>
                       <xsl:value-of select="."/>
                 </sourceformat>
           </xsl:for-each>
     
           <!--The source ID identifies the source repository in Primo. Every
                    source repository has a configuration file in which the sourceid and other
                    information about the source repository are recorded. This ID identifies the record in the source repository (such as an
                    ALEPH system number supplied in MARC21 tag 001). This ID must be unique and
                    persistent within the source repository. It is derived from the OAI
                    header. The record ID is a unique identifier of the record in the Primo
                    repository. The sourceid and sourcerecordid are concatenated to create the
                    recordid (for example, ALEPH system number + tag 001). The source format identifies the original format of the source
                    record (such as MARC21, Dublin Core, and MAB2). The source system identifies the system used by the source
                    repository (such as ALEPH, ADAM, MetaLib, SFX, and Digitool).-->           
           <xsl:for-each select="$sourcesystem[string(.)]">
                 <sourcesystem>
                       <xsl:value-of select="."/>
                 </sourcesystem>
           </xsl:for-each>
     </xsl:template>

     <xsl:template name="display">
           <xsl:param name="availinstitution" as="xs:string?"/>
           <xsl:param name="availlibrary" as="xs:string?"/>
           <xsl:param name="availpnx" as="xs:string?"/>
           <xsl:param name="contributor" as="xs:string?"/>
           <xsl:param name="coverage" as="xs:string?"/>
           <xsl:param name="creationdate" as="xs:string?"/>
           <xsl:param name="creator" as="xs:string?"/>
           <xsl:param name="description" as="xs:string?"/>
           <xsl:param name="crsinfo" as="xs:string?"/>
           <xsl:param name="edition" as="xs:string?"/>
           <xsl:param name="format" as="xs:string?"/>
           <xsl:param name="identifier" as="xs:string?"/>
           <xsl:param name="ispartof" as="xs:string?"/>
           <xsl:param name="language" as="xs:string?"/>
           <xsl:param name="oa" as="xs:string?"/>
           <xsl:param name="publisher" as="xs:string?"/>
           <xsl:param name="relation" as="xs:string?"/>
           <xsl:param name="rights" as="xs:string?"/>
           <xsl:param name="source" as="xs:string?"/>
           <xsl:param name="subject" as="xs:string?"/>
           <xsl:param name="title" as="xs:string?"/>
           <xsl:param name="type" as="xs:string?"/>
           <xsl:param name="unititle" as="xs:string?"/>
           <xsl:param name="userrank" as="xs:string?"/>
           <xsl:param name="userreview" as="xs:string?"/>
           <xsl:param name="vertitle" as="xs:string?"/>

           <xsl:for-each select="$availinstitution[string(.)]">
                 <availinstitution>
                       <xsl:value-of select="."/>
                 </availinstitution>
           </xsl:for-each>
     
           <!--The library-level availability status, which includes availability
                    information per Primo library or sub-location, in addition to location
                    information. The field is structured with subfields as follows: *$$I —
                    institution code (required) *$$L — library code (required) *$$1 — sub-location
                    *$$2 — call number *$$S — availability status (available, unavailable,
                    check_holdings) (required) *$$3 — number of items *$$4 — number of unavailable
                    items *$$5 — multi-volume flag: Y/N *$$6 — number of loans (for ranking
                    purposes) *$$9 — indicates that the location represents online material. For
                    more information, refer to Adding $$9ONLINE to Library Level Availability. *$$X
                    — source institution code (required for OvP) *$$Y — source library code
                    (required for OvP) *$$Z — source sublocation code (not required for
                    OvP)-->           
           <xsl:for-each select="$availlibrary[string(.)]">
                 <availlibrary>
                       <xsl:value-of select="."/>
                 </availlibrary>
           </xsl:for-each>
     
           <!--The availability PNX. Calculated by Primo from all availinstitution
                    fields in the Display section, using the following logic: Primo takes all
                    availinstitution fields and merges the availability status from $$S as follows:
                    *If one of the statuses is check_holdings or available, Primo sets availpnx to
                    available. *If the above condition does not exist, Primo sets availpnx to
                    unavailable. This field is used in the UI when filtering by
                    availability.-->           
           <xsl:for-each select="$availpnx[string(.)]">
                 <availpnx>
                       <xsl:value-of select="."/>
                 </availpnx>
           </xsl:for-each>
     
           <!--The contributor is an entity that is responsible for making a
                    contribution to the content of the resource. Multiple occurrences are
                    concatenated with a semicolon. Example of source data: *MARC21: 700/710/711
                    fields, stripping subfield $$d, and stripping from subfield $$t to the end. It
                    is possible to reverse the author's last and first name by using a special
                    routine (for example, Stephans, Mary to Mary Stephans). *The display form of the
                    contributor also serves as a hyperlink to search for additional records. It is
                    important that all the strings in the display also be added to the
                    creatorcontrib field in the Search section.-->           
           <xsl:for-each select="$contributor[string(.)]">
                 <contributor>
                       <xsl:value-of select="."/>
                 </contributor>
           </xsl:for-each>
     
           <!--The extent or scope of the content of the
                    resource.-->           
           <xsl:for-each select="$coverage[string(.)]">
                 <coverage>
                       <xsl:value-of select="."/>
                 </coverage>
           </xsl:for-each>
     
           <!--The date or year when the resource was created or the year when the
                    resource was published or manufactured. Multiple occurrences are concatenated
                    with a semicolon. Example of source data: *MARC21: 008/07-10; 260
                    $$c.-->           
           <xsl:for-each select="$creationdate[string(.)]">
                 <creationdate>
                       <xsl:value-of select="."/>
                 </creationdate>
           </xsl:for-each>
     
           <!--The content creator is an entity that is responsible for creating
                    the content of the resource. Multiple occurrences are concatenated with a
                    semicolon. An example of source data: *MARC21: 245 subfields $$c OR if 245 $$c
                    is not present, 1XX, stripping subfield $$d, and stripping from subfield $$t to
                    the end. It is possible to reverse the author's last and first name (for
                    example, Stephans, Mary to Mary Stephans) by using a special routine. *The
                    display form of the creator also serves as a hyperlink to search for additional
                    records. It is important that all the strings in the display also be added to
                    the creatorcontrib field in the Search section.-->           
           <xsl:for-each select="$creator[string(.)]">
                 <creator>
                       <xsl:value-of select="."/>
                 </creator>
           </xsl:for-each>
     
           <!--The description is any information that describes the content of
                    the resource. This can be an abstract, contents notes, summary, and so forth.
                    Multiple occurrences are not concatenated. Example of source data: *MARC21: 502,
                    505, 520 fields.-->           
           <xsl:for-each select="$description[string(.)]">
                 <description>
                       <xsl:value-of select="."/>
                 </description>
           </xsl:for-each>
     
           <!--Course reserve information.-->           
           <xsl:for-each select="$crsinfo[string(.)]">
                 <crsinfo>
                       <xsl:value-of select="."/>
                 </crsinfo>
           </xsl:for-each>
     
           <!--The edition of the resource. This is one of the fields of the PNX
                    record that is not derived from Dublin Core. The edition field is a key element
                    in grouping bibliographic records. Example of source data: *MARC21: 250 $a and
                    $b.-->           
           <xsl:for-each select="$edition[string(.)]">
                 <edition>
                       <xsl:value-of select="."/>
                 </edition>
           </xsl:for-each>
     
           <!--The physical format—physical description, extent, or digital
                    manifestation of the resource. Multiple occurrences are concatenated with a
                    semicolon. Example of source data: *MARC21: 300 and 340 fields. Can also be
                    created from the control data in the leader and 008, 006
                    fields.-->           
           <xsl:for-each select="$format[string(.)]">
                 <format>
                       <xsl:value-of select="."/>
                 </format>
           </xsl:for-each>
     
           <!--Any unique identifier of the record. Dublin Core defines this as an
                    unambiguous reference to the resource within a given context. In the context of
                    the PNX record, this is intended to be used for standard identifiers like ISBN
                    and ISSN. Multiple occurrences are concatenated with a semicolon. Examples of
                    source data (MARC21): *020 $$a: prefix the value with ISBN. *022 $$a: prefix the
                    value with ISSN.-->           
           <xsl:for-each select="$identifier[string(.)]">
                 <identifier>
                       <xsl:value-of select="."/>
                 </identifier>
           </xsl:for-each>
     
           <!--The resource from which this resource is derived (for example, in
                    an article from a journal - the journal is the source). Multiple occurrences are
                    not concatenated. This type of relationship has been added as a specific
                    relationship so it can be displayed as part of the brief results display.
                    Example of source data: *MARC21: 773.-->           
           <xsl:for-each select="$ispartof[string(.)]">
                 <ispartof>
                       <xsl:value-of select="."/>
                 </ispartof>
           </xsl:for-each>
     
           <!--The language of the resource. The language is stored in coded form
                    (ISO 639-2) and is translated in the UI. Multiple occurrences are concatenated
                    with a semicolon. If the language is not in ISO 639-2 form, the normalization
                    process attempts to convert it to this form. If this is not possible, the
                    language is unknown (using the und code). Example of source data: *MARC21:
                    008/35-37; if blank, use 041 subfield $$a.-->           
           <xsl:for-each select="$language[string(.)]">
                 <language>
                       <xsl:value-of select="."/>
                 </language>
           </xsl:for-each>
     
           <!--Intended for use by Primo Central to indicate whether a record is
                    open access or not.-->           
           <xsl:for-each select="$oa[string(.)]">
                 <oa>
                       <xsl:value-of select="."/>
                 </oa>
           </xsl:for-each>
     
           <!--An entity that is responsible for making the resource available.
                    Multiple occurrences are concatenated with a semicolon. Example of source data:
                    *MARC21: 260 subfields $a and $b.-->           
           <xsl:for-each select="$publisher[string(.)]">
                 <publisher>
                       <xsl:value-of select="."/>
                 </publisher>
           </xsl:for-each>
     
           <!--A reference to a related resource. Multiple occurrences are not
                    concatenated. Example of source data: *MARC21: 440, 830, 760-787 except for
                    773.-->           
           <xsl:for-each select="$relation[string(.)]">
                 <relation>
                       <xsl:value-of select="."/>
                 </relation>
           </xsl:for-each>
     
           <!--Information about the rights of the resource.-->           
           <xsl:for-each select="$rights[string(.)]">
                 <rights>
                       <xsl:value-of select="."/>
                 </rights>
           </xsl:for-each>
     
           <!--The source repository from which the record was
                    derived.-->           
           <xsl:for-each select="$source[string(.)]">
                 <source>
                       <xsl:value-of select="."/>
                 </source>
           </xsl:for-each>
     
           <!--The topic of the resource’s content. Multiple occurrences are
                    concatenated with a semicolon. Example of source data: *MARC21: 6XX fields *The
                    display form of the subject also serves as a hyperlink to search for additional
                    records. It is important that all the strings in the display also be added to
                    the search index.-->           
           <xsl:for-each select="$subject[string(.)]">
                 <subject>
                       <xsl:value-of select="."/>
                 </subject>
           </xsl:for-each>
     
           <!--The name that is given to a resource. The title can be created from
                    a number of fields and subfields from the source record. Multiple occurrences
                    are not concatenated. Example of source data: *MARC21: 245 subfields $$a and
                    $$b.-->           
           <xsl:for-each select="$title[string(.)]">
                 <title>
                       <xsl:value-of select="."/>
                 </title>
           </xsl:for-each>
     
           <!--The resource type that represents the main format of the record or
                    the type, based on a master list of main record types. It is recommended to
                    include only a minimum number of types (~10). Primo sites are able to modify
                    this list so that it is suited to the content of its repository and its users.
                    The type is used to determine which icon displays next to the record in the
                    brief and full results list. Every record must have a single type field. The
                    default resource type list includes book, journal, article, text_resource
                    (includes text resources that cannot be identified as a book, journal, or
                    article), image, video, audio, map, score, and other (includes records that
                    cannot be classified as any other resource type). Example of source data:
                    *MARC21: Mapping based on the leader position 6 and the 007 and 008
                    fields.-->           
           <xsl:for-each select="$type[string(.)]">
                 <type>
                       <xsl:value-of select="."/>
                 </type>
           </xsl:for-each>
     
           <!--The uniform title will be displayed with the title of the resource
                    when the merged FRBR record is displayed. Example of source data: *MARC21: 240
                    subfields a, d,m,n, p, r, s-->           
           <xsl:for-each select="$unititle[string(.)]">
                 <unititle>
                       <xsl:value-of select="."/>
                 </unititle>
           </xsl:for-each>
     
           <!--A rank or score that is assigned by the end user for the
                    resource.-->           
           <xsl:for-each select="$userrank[string(.)]">
                 <userrank>
                       <xsl:value-of select="."/>
                 </userrank>
           </xsl:for-each>
     
           <!--The user review, which is added by the end user.-->           
           <xsl:for-each select="$userreview[string(.)]">
                 <userreview>
                       <xsl:value-of select="."/>
                 </userreview>
           </xsl:for-each>
     
           <!--The vernacular title is used when the record contains both a
                    transliterated title and a title in the vernacular (as in the MARC format).
                    Example of source data: *MARC21: 880 with subfield 6 =245 and subfields a and
                    b.-->           
           <xsl:for-each select="$vertitle[string(.)]">
                 <vertitle>
                       <xsl:value-of select="."/>
                 </vertitle>
           </xsl:for-each>
     </xsl:template>

     <xsl:template name="facet">
           <xsl:param name="classificationlcc" as="xs:string*"/>
           <xsl:param name="classificationddc" as="xs:string*"/>
           <xsl:param name="classificationudc" as="xs:string*"/>
           <xsl:param name="classificationrvk" as="xs:string*"/>
           <xsl:param name="collection" as="xs:string*"/>
           <xsl:param name="creationdate" as="xs:string*"/>
           <xsl:param name="creatorcontrib" as="xs:string*"/>
           <xsl:param name="crsdept" as="xs:string*"/>
           <xsl:param name="crsid" as="xs:string*"/>
           <xsl:param name="crsinstrc" as="xs:string*"/>
           <xsl:param name="crsname" as="xs:string*"/>
           <xsl:param name="filesize" as="xs:string*"/>
           <xsl:param name="format" as="xs:string*"/>
           <xsl:param name="genre" as="xs:string*"/>
           <xsl:param name="jtitle" as="xs:string*"/>
           <xsl:param name="language" as="xs:string*"/>
           <xsl:param name="library" as="xs:string*"/>
           <xsl:param name="prefilter" as="xs:string*"/>
           <xsl:param name="related" as="xs:string*"/>
           <xsl:param name="rsrctype" as="xs:string*"/>
           <xsl:param name="topic" as="xs:string*"/>
           <xsl:param name="pnxdate" as="xs:string*"/>
           <xsl:param name="toplevel" as="xs:string*"/>

           <!--Classification (LCC/DDC/UDC/RVK). The classification facet can
                        be used to create a subject browse list based on the main subject classes of
                        the classification scheme. The classification code is translated into a
                        description in the enrichment phase. The field is updated by the system. -->           
           <xsl:for-each select="$classificationlcc[string(.)]">
                 <classificationlcc>
                       <xsl:value-of select="."/>
                 </classificationlcc>
           </xsl:for-each>
     
           <!--Classification (LCC/DDC/UDC/RVK). The classification facet can
                        be used to create a subject browse list based on the main subject classes of
                        the classification scheme. The classification code is translated into a
                        description in the enrichment phase. The field is updated by the system. -->           
           <xsl:for-each select="$classificationddc[string(.)]">
                 <classificationddc>
                       <xsl:value-of select="."/>
                 </classificationddc>
           </xsl:for-each>
     
           <!--Classification (LCC/DDC/UDC/RVK). The classification facet can
                        be used to create a subject browse list based on the main subject classes of
                        the classification scheme. The classification code is translated into a
                        description in the enrichment phase. The field is updated by the system. -->           
           <xsl:for-each select="$classificationudc[string(.)]">
                 <classificationudc>
                       <xsl:value-of select="."/>
                 </classificationudc>
           </xsl:for-each>
     
           <!--Classification (LCC/DDC/UDC/RVK). The classification facet can
                        be used to create a subject browse list based on the main subject classes of
                        the classification scheme. The classification code is translated into a
                        description in the enrichment phase. The field is updated by the system. -->           
           <xsl:for-each select="$classificationrvk[string(.)]">
                 <classificationrvk>
                       <xsl:value-of select="."/>
                 </classificationrvk>
           </xsl:for-each>
     
           <!--The collection (physical, digital, electronic, or logical) to
                        which the resource belongs. The collection facet is a code that is
                        translated in the UI. Examples of source data: *MARC21: 852 $b
                        $c.-->           
           <xsl:for-each select="$collection[string(.)]">
                 <collection>
                       <xsl:value-of select="."/>
                 </collection>
           </xsl:for-each>
     
           <!--The creation date normalized to four digits. BCE dates are
                        preceded by a minus sign. If the creation date cannot be normalized, the
                        field will not be created. Examples of source data: *MARC21: 008/07-10; 260
                        $$c. The Creation Date facet is created dynamically based on the results
                        set. Note that it is created from all results, not just the top 200 results
                        as done for dynamic facets. The system creates this facet as follows: 1
                        During normalization, creation dates are normalized as follows for each PNX
                        record: * Dates before 1899 are normalized as their century. For example,
                        1826 is normalized to 1800. *Dates between 1900 and 1949 are normalized by
                        decade. For example, 1945 is normalized to 1940. *Dates after 1950 are not
                        changed. 2 During a search, the system counts the number of different
                        creation dates found in the search results and split the dates into five
                        groups. For example, if the following 10 dates were found during a search:
                        1994, 1996, 1998, 2000, 2001, 2002, 2004, 2006, 2007, and 2008 The system
                        will display the following facets groups and the total number of records for
                        each group: Before 1998 (500) 1998 To 2001 (300) 2001 To 2004 (250) 2004 To
                        2007 (1,020) After 2007 (8234) *If the system finds less than five dates
                        during a search, the Creation Date facet will not be
                        displayed.-->           
           <xsl:for-each select="$creationdate[string(.)]">
                 <creationdate>
                       <xsl:value-of select="."/>
                 </creationdate>
           </xsl:for-each>
     
           <!--Creator/Contributor. This facet attempts to normalize personal
                        names so that the field contains the last name and the first letter of first
                        name (since this is common in many databases). Example of source data:
                        *MARC21: 100/110/111 and 700/710/711 fields. If the author is a person, the
                        field contains the last name and the first letter of each of the first
                        names: *The second and third characters of the tag are 00. *The first
                        indicator is 1 (for example, 1001). *Use subfield $$a only. *The first name
                        is each word after the comma. If the author is a conference, the field
                        contains only the conference name, and not particulars on time or place:
                        *The second and third characters of the tag are 11 (for example, 711). *Use
                        subfield $$a only. In all other cases, the entire field is
                        used.-->           
           <xsl:for-each select="$creatorcontrib[string(.)]">
                 <creatorcontrib>
                       <xsl:value-of select="."/>
                 </creatorcontrib>
           </xsl:for-each>
     
           <!--The course department.-->           
           <xsl:for-each select="$crsdept[string(.)]">
                 <crsdept>
                       <xsl:value-of select="."/>
                 </crsdept>
           </xsl:for-each>
     
           <!--The course ID.-->           
           <xsl:for-each select="$crsid[string(.)]">
                 <crsid>
                       <xsl:value-of select="."/>
                 </crsid>
           </xsl:for-each>
     
           <!--The course instructor.-->           
           <xsl:for-each select="$crsinstrc[string(.)]">
                 <crsinstrc>
                       <xsl:value-of select="."/>
                 </crsinstrc>
           </xsl:for-each>
     
           <!--The course name.-->           
           <xsl:for-each select="$crsname[string(.)]">
                 <crsname>
                       <xsl:value-of select="."/>
                 </crsname>
           </xsl:for-each>
     
           <!--The size of the file for digital objects.-->           
           <xsl:for-each select="$filesize[string(.)]">
                 <filesize>
                       <xsl:value-of select="."/>
                 </filesize>
           </xsl:for-each>
     
           <!--Physical format. The physical format or file type. Examples of
                        source data: *MARC21: Can be based on the 007 control
                        field.-->           
           <xsl:for-each select="$format[string(.)]">
                 <format>
                       <xsl:value-of select="."/>
                 </format>
           </xsl:for-each>
     
           <!--The genre of the resource. Examples of source data: *MARC21:
                        655 and subfield v from all 6XX.-->           
           <xsl:for-each select="$genre[string(.)]">
                 <genre>
                       <xsl:value-of select="."/>
                 </genre>
           </xsl:for-each>
     
           <!--The journal title. This facet can be used in PNX records that
                        represent articles. Sample source data: MARC21: 773 $$t-->           
           <xsl:for-each select="$jtitle[string(.)]">
                 <jtitle>
                       <xsl:value-of select="."/>
                 </jtitle>
           </xsl:for-each>
     
           <!--The language of the resource. The language is stored in coded
                        form (ISO 639-2) and translated in the UI. If the language is not coded, the
                        normalization process attempts to convert it to coded form. If this is not
                        possible, a language facet is not created. Examples of source data: *MARC21:
                        008/35-37; if blank, use 041 subfield $$a.-->           
           <xsl:for-each select="$language[string(.)]">
                 <language>
                       <xsl:value-of select="."/>
                 </language>
           </xsl:for-each>
     
           <!--The facet for physical libraries, which can be used instead of
                        or in addition to the collection facet. The Library facet has a special
                        feature intended for multi-institution sites. It allows you to configure the
                        facet so that it is split between libraries that belong to the user's
                        institution and libraries that belong to all other institutions. In addition
                        to the number of hits and alphabetical sort, the library facet allows the
                        following sort options: *By user institution and then by size *By user
                        institution and then alphanumerically *By user institution only If any of
                        the sort options are selected, two 'Library' facets will display. The first
                        includes libraries that belong to the user's institution, and the second
                        includes all libraries from other institutions.-->           
           <xsl:for-each select="$library[string(.)]">
                 <library>
                       <xsl:value-of select="."/>
                 </library>
           </xsl:for-each>
     
           <!--The search pre-filter that is available in the Primo UI and
                        must be mapped as a facet. The default list of pre-filters is based on the
                        Resource Type field in the display: *Book -> Books (books) *Journal ->
                        Journals (journals) *Article -> Articles (articles) *Text Resource -> Books
                        (books) *Image -> Images (images) *Video -> Audio-Video (audio-video) *Audio
                        -> Audio-Video (audio-video) *Maps -> Maps (maps) *Score -> Scores
                        (scores)-->           
           <xsl:for-each select="$prefilter[string(.)]">
                 <prefilter>
                       <xsl:value-of select="."/>
                 </prefilter>
           </xsl:for-each>
     
           <!--Related records—not in use.-->           
           <xsl:for-each select="$related[string(.)]">
                 <related>
                       <xsl:value-of select="."/>
                 </related>
           </xsl:for-each>
     
           <!--The nature or genre of the resource. This field is based on the
                        rsrctype field in the Display section: *Book -> books *Journal -> journals
                        *Article -> articles *Text Resource -> text resources *Image -> images
                        *Audio -> media *Video -> media *Score -> scores *Map -> maps *Other ->
                        others-->           
           <xsl:for-each select="$rsrctype[string(.)]">
                 <rsrctype>
                       <xsl:value-of select="."/>
                 </rsrctype>
           </xsl:for-each>
     
           <!--Enables the display of topics (subjects) on three levels. Every
                        level is separate by a hyphen with a 3-byte Unicode representation. In the
                        UI, only three levels are used. Examples of source data: *MARC21: 6XX (all
                        fields which begin with the digit 6) fields: First facet level (topic 1) is
                        all data up to the first occurrence of subfield $$v, x, y, or z. Each
                        subfield division (v, x, y, or z) constitutes the next level. The string is
                        truncated after three levels. toplevel The facet that displays on top of the
                        results set, which is shown only in the Primo UI. The top-level facet
                        includes the following values: *Online Resources—assigned if the delivery
                        category is Online Resource. *Available in library—assigned if the
                        availability_pnx field from the Display section is available. *Multiple
                        top-level facet values may be assigned to a single PNX
                        record.-->           
           <xsl:for-each select="$topic[string(.)]">
                 <topic>
                       <xsl:value-of select="."/>
                 </topic>
           </xsl:for-each>
     
           <!--Ikke funnet i primo
                        dokumentasjon.-->           
           <xsl:for-each select="$pnxdate[string(.)]">
                 <pnxdate>
                       <xsl:value-of select="."/>
                 </pnxdate>
           </xsl:for-each>
     
           <!-- The facet that displays on top of the results set, which is
                        shown only in the Primo UI. The top-level facet includes the following
                        values: *Online Resources—assigned if the delivery category is Online
                        Resource. *Available in library—assigned if the availability_pnx field from
                        the Display section is available. *Multiple top-level facet values may be
                        assigned to a single PNX record.>-->           
           <xsl:for-each select="$toplevel[string(.)]">
                 <toplevel>
                       <xsl:value-of select="."/>
                 </toplevel>
           </xsl:for-each>
     </xsl:template>

     <xsl:template name="search">
           <xsl:param name="addsrcrecordid" as="xs:string*"/>
           <xsl:param name="addtitle" as="xs:string*"/>
           <xsl:param name="alttitle" as="xs:string*"/>
           <xsl:param name="creationdate" as="xs:string*"/>
           <xsl:param name="creatorcontrib" as="xs:string*"/>
           <xsl:param name="crsdept" as="xs:string*"/>
           <xsl:param name="crsid" as="xs:string*"/>
           <xsl:param name="crsinstrc" as="xs:string*"/>
           <xsl:param name="crsname" as="xs:string*"/>
           <xsl:param name="description" as="xs:string*"/>
           <xsl:param name="enddate" as="xs:string*"/>
           <xsl:param name="frbrid" as="xs:string*"/>
           <xsl:param name="fulltext" as="xs:string*"/>
           <xsl:param name="general" as="xs:string*"/>
           <xsl:param name="isbn" as="xs:string*"/>
           <xsl:param name="issn" as="xs:string*"/>
           <xsl:param name="matchid" as="xs:string*"/>
           <xsl:param name="orcidid" as="xs:string*"/>
           <xsl:param name="pnxtype" as="xs:string*"/>
           <xsl:param name="recordid" as="xs:string*"/>
           <xsl:param name="recordtype" as="xs:string*"/>
           <xsl:param name="ressearscope" as="xs:string*"/>
           <xsl:param name="rsrctype" as="xs:string*"/>
           <xsl:param name="scope" as="xs:string*"/>
           <xsl:param name="searchscope" as="xs:string*"/>
           <xsl:param name="sourceid" as="xs:string*"/>
           <xsl:param name="startdate" as="xs:string*"/>
           <xsl:param name="subject" as="xs:string*"/>
           <xsl:param name="syndetics_fulltext" as="xs:string*"/>
           <xsl:param name="syndetics_toc" as="xs:string*"/>
           <xsl:param name="title" as="xs:string*"/>
           <xsl:param name="toc" as="xs:string*"/>
           <xsl:param name="usertag" as="xs:string*"/>

           <!--The index that is created from the additional source record ID from
                    the Control section.-->           
           <xsl:for-each select="$addsrcrecordid[string(.)]">
                 <addsrcrecordid>
                       <xsl:value-of select="."/>
                 </addsrcrecordid>
           </xsl:for-each>
     
           <!--This field contains additional titles that are related to the
                    record. Examples of MARC21 source data: 440 subfield $$a 830 subfield
                    $$a-->           
           <xsl:for-each select="$addtitle[string(.)]">
                 <addtitle>
                       <xsl:value-of select="."/>
                 </addtitle>
           </xsl:for-each>
     
           <!--The alternative titles. Examples of MARC21 source data: MARC21:
                    130, 210, 240, 246-->           
           <xsl:for-each select="$alttitle[string(.)]">
                 <alttitle>
                       <xsl:value-of select="."/>
                 </alttitle>
           </xsl:for-each>
     
           <!--This field contains the publication date, which is the year when
                    either the resource was created or the resource was published or manufactured.
                    Valid years are one to four digits (0 - 9). For example: 1, 75, 910, and 2016.
                    BCE dates are preceded by a minus sign. For example: -5. Multiple occurrences of
                    this field are possible. The creation dates are used during searches and when
                    refining dates with the date slider. The following notes apply to the date
                    slider: The initial date ranges that display in the date slider are based on the
                    ranges in the creation date facet (see facets section), not the dates from this
                    field. Out of the box, the Creation Date facet ranges are hidden. If you want to
                    display the facet ranges, change display:none to display:block in the following
                    line of your local CSS file: .EXLFacetContainer ol li.EXLHiddenFacetCreationDate
                    {display:none;}-->           
           <xsl:for-each select="$creationdate[string(.)]">
                 <creationdate>
                       <xsl:value-of select="."/>
                 </creationdate>
           </xsl:for-each>
     
           <!--The normalized form of authors created for the facets. Examples of
                    MARC21 source data: MARC21:1XX and 700/710/711 fields.-->           
           <xsl:for-each select="$creatorcontrib[string(.)]">
                 <creatorcontrib>
                       <xsl:value-of select="."/>
                 </creatorcontrib>
           </xsl:for-each>
     
           <!--The course department.-->           
           <xsl:for-each select="$crsdept[string(.)]">
                 <crsdept>
                       <xsl:value-of select="."/>
                 </crsdept>
           </xsl:for-each>
     
           <!--The course ID.-->           
           <xsl:for-each select="$crsid[string(.)]">
                 <crsid>
                       <xsl:value-of select="."/>
                 </crsid>
           </xsl:for-each>
     
           <!--The course instructor.-->           
           <xsl:for-each select="$crsinstrc[string(.)]">
                 <crsinstrc>
                       <xsl:value-of select="."/>
                 </crsinstrc>
           </xsl:for-each>
     
           <!--The course name.-->           
           <xsl:for-each select="$crsname[string(.)]">
                 <crsname>
                       <xsl:value-of select="."/>
                 </crsname>
           </xsl:for-each>
     
           <!--Description of the content of the resource. This includes abstract,
                    contents notes, summary, and so forth. Examples of MARC21 source data: MARC21:
                    502, 505, 520 fields.-->           
           <xsl:for-each select="$description[string(.)]">
                 <description>
                       <xsl:value-of select="."/>
                 </description>
           </xsl:for-each>
     
           <!--Contains the end date in date ranges. For more information, see the
                    Configuring Date Ranges section in the Primo Back Office
                    Guide.-->           
           <xsl:for-each select="$enddate[string(.)]">
                 <enddate>
                       <xsl:value-of select="."/>
                 </enddate>
           </xsl:for-each>
     
           <!--The ID assigned to records following the FRBRization process. The
                    field is updated by the system.-->           
           <xsl:for-each select="$frbrid[string(.)]">
                 <frbrid>
                       <xsl:value-of select="."/>
                 </frbrid>
           </xsl:for-each>
     
           <!--Words from the full-text that were added in the enrichment
                    phase.-->           
           <xsl:for-each select="$fulltext[string(.)]">
                 <fulltext>
                       <xsl:value-of select="."/>
                 </fulltext>
           </xsl:for-each>
     
           <!--A general index for fields that have not yet been added to any of
                    the specific indexes and should be. For example, publisher.-->           
           <xsl:for-each select="$general[string(.)]">
                 <general>
                       <xsl:value-of select="."/>
                 </general>
           </xsl:for-each>
     
           <!--The ISBN of the item. Example of MARC21 source data:
                    MARC21:020.-->           
           <xsl:for-each select="$isbn[string(.)]">
                 <isbn>
                       <xsl:value-of select="."/>
                 </isbn>
           </xsl:for-each>
     
           <!--The ISSN of the item. Example of source data: MARC21:
                    022.-->           
           <xsl:for-each select="$issn[string(.)]">
                 <issn>
                       <xsl:value-of select="."/>
                 </issn>
           </xsl:for-each>
     
           <!--The ID assigned to records following the duplicate detection
                    process. The field is updated by the system.-->           
           <xsl:for-each select="$matchid[string(.)]">
                 <matchid>
                       <xsl:value-of select="."/>
                 </matchid>
           </xsl:for-each>
     
           <!--The ORCID ID.-->           
           <xsl:for-each select="$orcidid[string(.)]">
                 <orcidid>
                       <xsl:value-of select="."/>
                 </orcidid>
           </xsl:for-each>
     
           <!--An internal Primo index that defines the type of PNX record. The
                    field is updated by the system.-->           
           <xsl:for-each select="$pnxtype[string(.)]">
                 <pnxtype>
                       <xsl:value-of select="."/>
                 </pnxtype>
           </xsl:for-each>
     
           <!--The recordid field from the Control section, which is used to
                    locate a specific record. This is an internal Primo index.-->           
           <xsl:for-each select="$recordid[string(.)]">
                 <recordid>
                       <xsl:value-of select="."/>
                 </recordid>
           </xsl:for-each>
     
           <!--Record type—not in use.-->           
           <xsl:for-each select="$recordtype[string(.)]">
                 <recordtype>
                       <xsl:value-of select="."/>
                 </recordtype>
           </xsl:for-each>
     
           <!--The restricted search scope, used to limit discovery of certain PNX
                    records to specific user groups. In order to limit discovery, the records should
                    be assigned a denied search scope. Access is enabled based on the denied search
                    scopes defined in a Back Office table. Access can be enabled based on
                    institution, on-off campus, and user group. This field is copied to the scope
                    field for indexing by the search engine.-->           
           <xsl:for-each select="$ressearscope[string(.)]">
                 <ressearscope>
                       <xsl:value-of select="."/>
                 </ressearscope>
           </xsl:for-each>
     
           <!--The type field from the Display section.-->           
           <xsl:for-each select="$rsrctype[string(.)]">
                 <rsrctype>
                       <xsl:value-of select="."/>
                 </rsrctype>
           </xsl:for-each>
     
           <!--Used in creating search scopes and denied search scopes. The values
                    from the search scope and restricted search scope fields above should be copied
                    to the scope field.-->           
           <xsl:for-each select="$scope[string(.)]">
                 <scope>
                       <xsl:value-of select="."/>
                 </scope>
           </xsl:for-each>
     
           <!--Used to create search scopes values for use in Primo views. This
                    field is copied to the scope field for indexing by the search
                    engine.-->           
           <xsl:for-each select="$searchscope[string(.)]">
                 <searchscope>
                       <xsl:value-of select="."/>
                 </searchscope>
           </xsl:for-each>
     
           <!--Based on the sourceid field from the Control section. It may be
                    required to filter out certain records and is an internal Primo
                    index.-->           
           <xsl:for-each select="$sourceid[string(.)]">
                 <sourceid>
                       <xsl:value-of select="."/>
                 </sourceid>
           </xsl:for-each>
     
           <!--Contains the start date in date ranges. For more information, see
                    the Configuring Date Ranges section in the Primo Back Office
                    Guide.-->           
           <xsl:for-each select="$startdate[string(.)]">
                 <startdate>
                       <xsl:value-of select="."/>
                 </startdate>
           </xsl:for-each>
     
           <!--The topic of the content of the resource. Example of source data:
                    MARC21: 6XX fields.-->           
           <xsl:for-each select="$subject[string(.)]">
                 <subject>
                       <xsl:value-of select="."/>
                 </subject>
           </xsl:for-each>
     
           <!--Used for abstracts and other data loaded from Syndetics. This field
                    is updated by the system.-->           
           <xsl:for-each select="$syndetics_fulltext[string(.)]">
                 <syndetics_fulltext>
                       <xsl:value-of select="."/>
                 </syndetics_fulltext>
           </xsl:for-each>
     
           <!--Used for table of contents data loaded from Syndetics. This field
                    is updated by the system.-->           
           <xsl:for-each select="$syndetics_toc[string(.)]">
                 <syndetics_toc>
                       <xsl:value-of select="."/>
                 </syndetics_toc>
           </xsl:for-each>
     
           <!--The main title. Examples of source data: MARC21: 245 subfields $$a
                    and $$b.-->           
           <xsl:for-each select="$title[string(.)]">
                 <title>
                       <xsl:value-of select="."/>
                 </title>
           </xsl:for-each>
     
           <!--This field contains words from the table of
                    contents.-->           
           <xsl:for-each select="$toc[string(.)]">
                 <toc>
                       <xsl:value-of select="."/>
                 </toc>
           </xsl:for-each>
     
           <!--This field contains end-user tags. This field is updated by the
                    system.-->           
           <xsl:for-each select="$usertag[string(.)]">
                 <usertag>
                       <xsl:value-of select="."/>
                 </usertag>
           </xsl:for-each>
     </xsl:template>

     <xsl:template name="delivery">
           <xsl:param name="delcategory" as="xs:string"/>
           <xsl:param name="fulltext" as="xs:string*"/>
           <xsl:param name="institution" as="xs:string*"/>
           <xsl:param name="resdelscope" as="xs:string*"/>

           <!--The delivery resource categories for which delivery may function
                    differently. The following are supported categories: *Physical Item – all
                    physical items except for microforms. *Microform *SFX Resources *Online
                    Resources *MetaLib Resource—records from the MetaLib Knowledgebase *Remote
                    Search Resources—records retrieved via MetaLib. This field is required. A record
                    that does not have a delivery category will fail and display the following error
                    message in the back office: Invalid content was found starting with element
                    'ranking'. One of '{"":delivery}' is expected. If you define another category in
                    this field, delivery related functionality will not be available for this
                    record. This means that there will be no availability status or GetIt
                    tabs.-->           
           <xsl:for-each select="$delcategory[string(.)]">
                 <delcategory>
                       <xsl:value-of select="."/>
                 </delcategory>
           </xsl:for-each>
     
           <!--Indicates that there is online full-text for the resource, which is
                    used for remote search resources.-->           
           <xsl:for-each select="$fulltext[string(.)]">
                 <fulltext>
                       <xsl:value-of select="."/>
                 </fulltext>
           </xsl:for-each>
     
           <!--The institution to which the resource belongs.-->           
           <xsl:for-each select="$institution[string(.)]">
                 <institution>
                       <xsl:value-of select="."/>
                 </institution>
           </xsl:for-each>
     
           <xsl:for-each select="$resdelscope[string(.)]">
                 <resdelscope>
                       <xsl:value-of select="."/>
                 </resdelscope>
           </xsl:for-each>
     </xsl:template>

     <xsl:template name="links">
           <xsl:param name="additionallinks" as="xs:string*"/>
           <xsl:param name="backlink" as="xs:string*"/>
           <xsl:param name="linktoabstract" as="xs:string*"/>
           <xsl:param name="linktoextract" as="xs:string*"/>
           <xsl:param name="linktofindingaid" as="xs:string*"/>
           <xsl:param name="linktoholdings" as="xs:string*"/>
           <xsl:param name="linktoprice" as="xs:string*"/>
           <xsl:param name="linktorequest" as="xs:string*"/>
           <xsl:param name="linktoreview" as="xs:string*"/>
           <xsl:param name="linktorsrc" as="xs:string*"/>
           <xsl:param name="linktotoc" as="xs:string*"/>
           <xsl:param name="linktouc" as="xs:string*"/>
           <xsl:param name="openurl" as="xs:string*"/>
           <xsl:param name="openurlfullt" as="xs:string*"/>
           <xsl:param name="openurlservice" as="xs:string*"/>
           <xsl:param name="thumbnail" as="xs:string*"/>

           <!--Additional links that are relevant to the
                    resource.-->           
           <xsl:for-each select="$additionallinks[string(.)]">
                 <additionallinks>
                       <xsl:value-of select="."/>
                 </additionallinks>
           </xsl:for-each>
     
           <!--A link back to the original record in the source
                    repository.-->           
           <xsl:for-each select="$backlink[string(.)]">
                 <backlink>
                       <xsl:value-of select="."/>
                 </backlink>
           </xsl:for-each>
     
           <!--A link to the item's abstract.-->           
           <xsl:for-each select="$linktoabstract[string(.)]">
                 <linktoabstract>
                       <xsl:value-of select="."/>
                 </linktoabstract>
           </xsl:for-each>
     
           <!--A link to an extract or first chapter of the
                    item.-->           
           <xsl:for-each select="$linktoextract[string(.)]">
                 <linktoextract>
                       <xsl:value-of select="."/>
                 </linktoextract>
           </xsl:for-each>
     
           <!--A link to a finding aid.-->           
           <xsl:for-each select="$linktofindingaid[string(.)]">
                 <linktofindingaid>
                       <xsl:value-of select="."/>
                 </linktofindingaid>
           </xsl:for-each>
     
           <!--A link to the holdings display and request options in the source
                    system. For multi-institution sites, the following links can be used:
                    *linktoholdings_avail—A link to the holdings display and request options in the
                    source system if the item is available in the user's institution.
                    *linktoholdings_unavail—A link to the holdings display and request options in
                    the source system if the item is unavailable in the user's institution.
                    *linktoholdings_notexist—A link to the holdings display and request options in
                    the source system if the item does not exist in the user's
                    institution.-->           
           <xsl:for-each select="$linktoholdings[string(.)]">
                 <linktoholdings>
                       <xsl:value-of select="."/>
                 </linktoholdings>
           </xsl:for-each>
     
           <!--A link to the item's price.-->           
           <xsl:for-each select="$linktoprice[string(.)]">
                 <linktoprice>
                       <xsl:value-of select="."/>
                 </linktoprice>
           </xsl:for-each>
     
           <!--A link to a form or page on which a user can place a
                    request.-->           
           <xsl:for-each select="$linktorequest[string(.)]">
                 <linktorequest>
                       <xsl:value-of select="."/>
                 </linktorequest>
           </xsl:for-each>
     
           <!--A link to the item's review.-->           
           <xsl:for-each select="$linktoreview[string(.)]">
                 <linktoreview>
                       <xsl:value-of select="."/>
                 </linktoreview>
           </xsl:for-each>
     
           <!--A link to the resource itself (for example, to the full-text or
                    image).-->           
           <xsl:for-each select="$linktorsrc[string(.)]">
                 <linktorsrc>
                       <xsl:value-of select="."/>
                 </linktorsrc>
           </xsl:for-each>
     
           <!--A link to the item's table of contents.-->           
           <xsl:for-each select="$linktotoc[string(.)]">
                 <linktotoc>
                       <xsl:value-of select="."/>
                 </linktotoc>
           </xsl:for-each>
     
           <!--A link to a Union Catalog (such as WorldCat).-->           
           <xsl:for-each select="$linktouc[string(.)]">
                 <linktouc>
                       <xsl:value-of select="."/>
                 </linktouc>
           </xsl:for-each>
     
           <!--This URL can be created by Primo for the metadata in the
                    PNX.-->           
           <xsl:for-each select="$openurl[string(.)]">
                 <openurl>
                       <xsl:value-of select="."/>
                 </openurl>
           </xsl:for-each>
     
           <!--An open URL that is limited to the full-text
                    service.-->           
           <xsl:for-each select="$openurlfullt[string(.)]">
                 <openurlfullt>
                       <xsl:value-of select="."/>
                 </openurlfullt>
           </xsl:for-each>
     
           <!--An open URL that is limited to a specific service other then the
                    full-text service.-->           
           <xsl:for-each select="$openurlservice[string(.)]">
                 <openurlservice>
                       <xsl:value-of select="."/>
                 </openurlservice>
           </xsl:for-each>
     
           <!--A link to the item's thumbnail.-->           
           <xsl:for-each select="$thumbnail[string(.)]">
                 <thumbnail>
                       <xsl:value-of select="."/>
                 </thumbnail>
           </xsl:for-each>
     </xsl:template>

     <xsl:template name="sort">
           <xsl:param name="author" as="xs:string?"/>
           <xsl:param name="creationdate" as="xs:string?"/>
           <xsl:param name="popularity" as="xs:string?"/>
           <xsl:param name="title" as="xs:string?"/>

           <!--The author of the record. Only one author field should be created.
                    Sample source data: MARC21: 100 $$a-->           
           <xsl:for-each select="$author[string(.)]">
                 <author>
                       <xsl:value-of select="."/>
                 </author>
           </xsl:for-each>
     
           <!--Should be normalized to four digits. Example of source data:
                    *MARC21: 008/07-10; 260 $$c.-->           
           <xsl:for-each select="$creationdate[string(.)]">
                 <creationdate>
                       <xsl:value-of select="."/>
                 </creationdate>
           </xsl:for-each>
     
           <!--Based on the number of times the following types of clicks occur in
                    Primo: e-Shelf, Full display, and GetIt!.-->           
           <xsl:for-each select="$popularity[string(.)]">
                 <popularity>
                       <xsl:value-of select="."/>
                 </popularity>
           </xsl:for-each>
     
           <!--The title of the record. Only one title field should be
                    added.-->           
           <xsl:for-each select="$title[string(.)]">
                 <title>
                       <xsl:value-of select="."/>
                 </title>
           </xsl:for-each>
     </xsl:template>

     <xsl:template name="addata">
           <xsl:param name="orcidid" as="xs:string*"/>
           <xsl:param name="aulast" as="xs:string*"/>
           <xsl:param name="aufirst" as="xs:string*"/>
           <xsl:param name="auinit" as="xs:string*"/>
           <xsl:param name="auinit1" as="xs:string*"/>
           <xsl:param name="auinitm" as="xs:string*"/>
           <xsl:param name="ausuffix" as="xs:string*"/>
           <xsl:param name="au" as="xs:string*"/>
           <xsl:param name="aucorp" as="xs:string*"/>
           <xsl:param name="addau" as="xs:string*"/>
           <xsl:param name="seriesau" as="xs:string*"/>
           <xsl:param name="btitle" as="xs:string*"/>
           <xsl:param name="atitle" as="xs:string*"/>
           <xsl:param name="jtitle" as="xs:string*"/>
           <xsl:param name="stitle" as="xs:string*"/>
           <xsl:param name="addtitle" as="xs:string*"/>
           <xsl:param name="seriestitle" as="xs:string*"/>
           <xsl:param name="date" as="xs:string*"/>
           <xsl:param name="risdate" as="xs:string*"/>
           <xsl:param name="adddate" as="xs:string*"/>
           <xsl:param name="volume" as="xs:string*"/>
           <xsl:param name="issue" as="xs:string*"/>
           <xsl:param name="part" as="xs:string*"/>
           <xsl:param name="ssn" as="xs:string*"/>
           <xsl:param name="quarter" as="xs:string*"/>
           <xsl:param name="spage" as="xs:string*"/>
           <xsl:param name="epage" as="xs:string*"/>
           <xsl:param name="pages" as="xs:string*"/>
           <xsl:param name="artnum" as="xs:string*"/>
           <xsl:param name="issn" as="xs:string*"/>
           <xsl:param name="eissn" as="xs:string*"/>
           <xsl:param name="isbn" as="xs:string*"/>
           <xsl:param name="eisbn" as="xs:string*"/>
           <xsl:param name="coden" as="xs:string*"/>
           <xsl:param name="sici" as="xs:string*"/>
           <xsl:param name="format" as="xs:string*"/>
           <xsl:param name="genre" as="xs:string*"/>
           <xsl:param name="ristype" as="xs:string*"/>
           <xsl:param name="notes" as="xs:string*"/>
           <xsl:param name="abstract" as="xs:string*"/>
           <xsl:param name="cop" as="xs:string*"/>
           <xsl:param name="pub" as="xs:string*"/>
           <xsl:param name="mis1" as="xs:string*"/>
           <xsl:param name="mis2" as="xs:string*"/>
           <xsl:param name="mis3" as="xs:string*"/>
           <xsl:param name="oclcid" as="xs:string*"/>
           <xsl:param name="doi" as="xs:string*"/>
           <xsl:param name="url" as="xs:string*"/>
           <xsl:param name="objectid" as="xs:string*"/>
           <xsl:param name="lccn" as="xs:string*"/>
           <xsl:param name="pmid" as="xs:string*"/>
           <xsl:param name="ericid" as="xs:string*"/>
           <xsl:param name="bibcode" as="xs:string*"/>
           <xsl:param name="hdlid" as="xs:string*"/>
           <xsl:param name="oai" as="xs:string*"/>
           <xsl:param name="co" as="xs:string*"/>
           <xsl:param name="cc" as="xs:string*"/>
           <xsl:param name="inst" as="xs:string*"/>
           <xsl:param name="advisor" as="xs:string*"/>
           <xsl:param name="degree" as="xs:string*"/>
           <xsl:param name="tpages" as="xs:string*"/>
           <xsl:param name="edition" as="xs:string*"/>
           <xsl:param name="bici" as="xs:string*"/>

           <!--orcidid-->           
           <xsl:for-each select="$orcidid[string(.)]">
                 <orcidid>
                       <xsl:value-of select="."/>
                 </orcidid>
           </xsl:for-each>
     
           <!--Author last name-->           
           <xsl:for-each select="$aulast[string(.)]">
                 <aulast>
                       <xsl:value-of select="."/>
                 </aulast>
           </xsl:for-each>
     
           <!--Author first name-->           
           <xsl:for-each select="$aufirst[string(.)]">
                 <aufirst>
                       <xsl:value-of select="."/>
                 </aufirst>
           </xsl:for-each>
     
           <!--Author initials-->           
           <xsl:for-each select="$auinit[string(.)]">
                 <auinit>
                       <xsl:value-of select="."/>
                 </auinit>
           </xsl:for-each>
     
           <!--Author first initial-->           
           <xsl:for-each select="$auinit1[string(.)]">
                 <auinit1>
                       <xsl:value-of select="."/>
                 </auinit1>
           </xsl:for-each>
     
           <!--Author middle initial-->           
           <xsl:for-each select="$auinitm[string(.)]">
                 <auinitm>
                       <xsl:value-of select="."/>
                 </auinitm>
           </xsl:for-each>
     
           <!--Author suffix-->           
           <xsl:for-each select="$ausuffix[string(.)]">
                 <ausuffix>
                       <xsl:value-of select="."/>
                 </ausuffix>
           </xsl:for-each>
     
           <!--Author-->           
           <xsl:for-each select="$au[string(.)]">
                 <au>
                       <xsl:value-of select="."/>
                 </au>
           </xsl:for-each>
     
           <!--Corporate author-->           
           <xsl:for-each select="$aucorp[string(.)]">
                 <aucorp>
                       <xsl:value-of select="."/>
                 </aucorp>
           </xsl:for-each>
     
           <!--Additional author-->           
           <xsl:for-each select="$addau[string(.)]">
                 <addau>
                       <xsl:value-of select="."/>
                 </addau>
           </xsl:for-each>
     
           <!--Series author-->           
           <xsl:for-each select="$seriesau[string(.)]">
                 <seriesau>
                       <xsl:value-of select="."/>
                 </seriesau>
           </xsl:for-each>
     
           <!--Book title-->           
           <xsl:for-each select="$btitle[string(.)]">
                 <btitle>
                       <xsl:value-of select="."/>
                 </btitle>
           </xsl:for-each>
     
           <!--Article title-->           
           <xsl:for-each select="$atitle[string(.)]">
                 <atitle>
                       <xsl:value-of select="."/>
                 </atitle>
           </xsl:for-each>
     
           <!--Journal title-->           
           <xsl:for-each select="$jtitle[string(.)]">
                 <jtitle>
                       <xsl:value-of select="."/>
                 </jtitle>
           </xsl:for-each>
     
           <!--Short title-->           
           <xsl:for-each select="$stitle[string(.)]">
                 <stitle>
                       <xsl:value-of select="."/>
                 </stitle>
           </xsl:for-each>
     
           <!--Additional title-->           
           <xsl:for-each select="$addtitle[string(.)]">
                 <addtitle>
                       <xsl:value-of select="."/>
                 </addtitle>
           </xsl:for-each>
     
           <!--Series title-->           
           <xsl:for-each select="$seriestitle[string(.)]">
                 <seriestitle>
                       <xsl:value-of select="."/>
                 </seriestitle>
           </xsl:for-each>
     
           <!--Date-->           
           <xsl:for-each select="$date[string(.)]">
                 <date>
                       <xsl:value-of select="."/>
                 </date>
           </xsl:for-each>
     
           <!--RISDate-->           
           <xsl:for-each select="$risdate[string(.)]">
                 <risdate>
                       <xsl:value-of select="."/>
                 </risdate>
           </xsl:for-each>
     
           <!--Additional Date-->           
           <xsl:for-each select="$adddate[string(.)]">
                 <adddate>
                       <xsl:value-of select="."/>
                 </adddate>
           </xsl:for-each>
     
           <!--Volume-->           
           <xsl:for-each select="$volume[string(.)]">
                 <volume>
                       <xsl:value-of select="."/>
                 </volume>
           </xsl:for-each>
     
           <!--Issue-->           
           <xsl:for-each select="$issue[string(.)]">
                 <issue>
                       <xsl:value-of select="."/>
                 </issue>
           </xsl:for-each>
     
           <!--Part-->           
           <xsl:for-each select="$part[string(.)]">
                 <part>
                       <xsl:value-of select="."/>
                 </part>
           </xsl:for-each>
     
           <!--Season-->           
           <xsl:for-each select="$ssn[string(.)]">
                 <ssn>
                       <xsl:value-of select="."/>
                 </ssn>
           </xsl:for-each>
     
           <!--Quarter-->           
           <xsl:for-each select="$quarter[string(.)]">
                 <quarter>
                       <xsl:value-of select="."/>
                 </quarter>
           </xsl:for-each>
     
           <!--Start page-->           
           <xsl:for-each select="$spage[string(.)]">
                 <spage>
                       <xsl:value-of select="."/>
                 </spage>
           </xsl:for-each>
     
           <!--End page-->           
           <xsl:for-each select="$epage[string(.)]">
                 <epage>
                       <xsl:value-of select="."/>
                 </epage>
           </xsl:for-each>
     
           <!--pages-->           
           <xsl:for-each select="$pages[string(.)]">
                 <pages>
                       <xsl:value-of select="."/>
                 </pages>
           </xsl:for-each>
     
           <!--Article number-->           
           <xsl:for-each select="$artnum[string(.)]">
                 <artnum>
                       <xsl:value-of select="."/>
                 </artnum>
           </xsl:for-each>
     
           <!--ISSN-->           
           <xsl:for-each select="$issn[string(.)]">
                 <issn>
                       <xsl:value-of select="."/>
                 </issn>
           </xsl:for-each>
     
           <!--EISSN-->           
           <xsl:for-each select="$eissn[string(.)]">
                 <eissn>
                       <xsl:value-of select="."/>
                 </eissn>
           </xsl:for-each>
     
           <!--ISBN-->           
           <xsl:for-each select="$isbn[string(.)]">
                 <isbn>
                       <xsl:value-of select="."/>
                 </isbn>
           </xsl:for-each>
     
           <!--EISBN-->           
           <xsl:for-each select="$eisbn[string(.)]">
                 <eisbn>
                       <xsl:value-of select="."/>
                 </eisbn>
           </xsl:for-each>
     
           <!--CODEN-->           
           <xsl:for-each select="$coden[string(.)]">
                 <coden>
                       <xsl:value-of select="."/>
                 </coden>
           </xsl:for-each>
     
           <!--SICI-->           
           <xsl:for-each select="$sici[string(.)]">
                 <sici>
                       <xsl:value-of select="."/>
                 </sici>
           </xsl:for-each>
     
           <!--Metadata format-->           
           <xsl:for-each select="$format[string(.)]">
                 <format>
                       <xsl:value-of select="."/>
                 </format>
           </xsl:for-each>
     
           <!--Genre-->           
           <xsl:for-each select="$genre[string(.)]">
                 <genre>
                       <xsl:value-of select="."/>
                 </genre>
           </xsl:for-each>
     
           <!--RISType-->           
           <xsl:for-each select="$ristype[string(.)]">
                 <ristype>
                       <xsl:value-of select="."/>
                 </ristype>
           </xsl:for-each>
     
           <!--Notes-->           
           <xsl:for-each select="$notes[string(.)]">
                 <notes>
                       <xsl:value-of select="."/>
                 </notes>
           </xsl:for-each>
     
           <!--Abstract-->           
           <xsl:for-each select="$abstract[string(.)]">
                 <abstract>
                       <xsl:value-of select="."/>
                 </abstract>
           </xsl:for-each>
     
           <!--finner ikke i primo documentation, co? country of
                    publication??-->           
           <xsl:for-each select="$cop[string(.)]">
                 <cop>
                       <xsl:value-of select="."/>
                 </cop>
           </xsl:for-each>
     
           <!--Publisher?-->           
           <xsl:for-each select="$pub[string(.)]">
                 <pub>
                       <xsl:value-of select="."/>
                 </pub>
           </xsl:for-each>
     
           <!--Miscellaneous1-->           
           <xsl:for-each select="$mis1[string(.)]">
                 <mis1>
                       <xsl:value-of select="."/>
                 </mis1>
           </xsl:for-each>
     
           <!--Miscellaneous2-->           
           <xsl:for-each select="$mis2[string(.)]">
                 <mis2>
                       <xsl:value-of select="."/>
                 </mis2>
           </xsl:for-each>
     
           <!--Miscellaneous3-->           
           <xsl:for-each select="$mis3[string(.)]">
                 <mis3>
                       <xsl:value-of select="."/>
                 </mis3>
           </xsl:for-each>
     
           <!--OCLC ID-->           
           <xsl:for-each select="$oclcid[string(.)]">
                 <oclcid>
                       <xsl:value-of select="."/>
                 </oclcid>
           </xsl:for-each>
     
           <!--DOI-->           
           <xsl:for-each select="$doi[string(.)]">
                 <doi>
                       <xsl:value-of select="."/>
                 </doi>
           </xsl:for-each>
     
           <!--URL-->           
           <xsl:for-each select="$url[string(.)]">
                 <url>
                       <xsl:value-of select="."/>
                 </url>
           </xsl:for-each>
     
           <!--Object ID-->           
           <xsl:for-each select="$objectid[string(.)]">
                 <objectid>
                       <xsl:value-of select="."/>
                 </objectid>
           </xsl:for-each>
     
           <!--finner ikke i
                    https://knowledge.exlibrisgroup.com/Primo/Product_Documentation/Technical_Guide/The_PNX_Record/The_Additional_Data_Section#ww1050167-->           
           <xsl:for-each select="$lccn[string(.)]">
                 <lccn>
                       <xsl:value-of select="."/>
                 </lccn>
           </xsl:for-each>
     
           <!--PMID-->           
           <xsl:for-each select="$pmid[string(.)]">
                 <pmid>
                       <xsl:value-of select="."/>
                 </pmid>
           </xsl:for-each>
     
           <!--finner ikke i dokumentasjon-->           
           <xsl:for-each select="$ericid[string(.)]">
                 <ericid>
                       <xsl:value-of select="."/>
                 </ericid>
           </xsl:for-each>
     
           <!--finner ikke i dokumentasjon-->           
           <xsl:for-each select="$bibcode[string(.)]">
                 <bibcode>
                       <xsl:value-of select="."/>
                 </bibcode>
           </xsl:for-each>
     
           <!--finner ikke i dokumentasjon-->           
           <xsl:for-each select="$hdlid[string(.)]">
                 <hdlid>
                       <xsl:value-of select="."/>
                 </hdlid>
           </xsl:for-each>
     
           <!--finner ikke i dokumentasjon-->           
           <xsl:for-each select="$oai[string(.)]">
                 <oai>
                       <xsl:value-of select="."/>
                 </oai>
           </xsl:for-each>
     
           <!--co – country of publication-->           
           <xsl:for-each select="$co[string(.)]">
                 <co>
                       <xsl:value-of select="."/>
                 </co>
           </xsl:for-each>
     
           <!--cc – country of publication code-->           
           <xsl:for-each select="$cc[string(.)]">
                 <cc>
                       <xsl:value-of select="."/>
                 </cc>
           </xsl:for-each>
     
           <!--inst – institution that issues dissertation-->           
           <xsl:for-each select="$inst[string(.)]">
                 <inst>
                       <xsl:value-of select="."/>
                 </inst>
           </xsl:for-each>
     
           <!--advisor – dissertation advisor-->           
           <xsl:for-each select="$advisor[string(.)]">
                 <advisor>
                       <xsl:value-of select="."/>
                 </advisor>
           </xsl:for-each>
     
           <!--degree – degree conferred for the dissertation-->           
           <xsl:for-each select="$degree[string(.)]">
                 <degree>
                       <xsl:value-of select="."/>
                 </degree>
           </xsl:for-each>
     
           <!--finner ikke i dokumentasjon-->           
           <xsl:for-each select="$tpages[string(.)]">
                 <tpages>
                       <xsl:value-of select="."/>
                 </tpages>
           </xsl:for-each>
     
           <!--finner ikke i dokumentasjon-->           
           <xsl:for-each select="$edition[string(.)]">
                 <edition>
                       <xsl:value-of select="."/>
                 </edition>
           </xsl:for-each>
     
           <!--finner ikke i dokumentasjon-->           
           <xsl:for-each select="$bici[string(.)]">
                 <bici>
                       <xsl:value-of select="."/>
                 </bici>
           </xsl:for-each>
     </xsl:template>

     <xsl:template name="ranking">
           <xsl:param name="booster1" as="xs:string?"/>
           <xsl:param name="booster2" as="xs:string?"/>
           <xsl:param name="pcg_type" as="xs:string?"/>

           <!--The amount of boost that is applied to a record. By default, no boost
                is given to a record. The amount of boost is determined by the following booster
                settings: *No boost – Assign a value of 1. *Negative boost – Assign a value greater
                than 0 and less than 1. Lower values provide less boost (such as .1). Note that 0 is
                not a valid setting. *Positive boost – Assign a value greater than 1. Higher values
                provide more boost.-->           
           <xsl:for-each select="$booster1[string(.)]">
                 <booster1>
                       <xsl:value-of select="."/>
                 </booster1>
           </xsl:for-each>
     
           <!--Not in use.-->           
           <xsl:for-each select="$booster2[string(.)]">
                 <booster2>
                       <xsl:value-of select="."/>
                 </booster2>
           </xsl:for-each>
     
           <!--Primo Central grouping type. This field is used in the selection of the
                preferred record in Primo Central FRBR groups.-->           
           <xsl:for-each select="$pcg_type[string(.)]">
                 <pcg_type>
                       <xsl:value-of select="."/>
                 </pcg_type>
           </xsl:for-each>
     </xsl:template>
</xsl:stylesheet>