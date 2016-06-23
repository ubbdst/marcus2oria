<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rng="http://relaxng.org/ns/structure/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
    xmlns:flub="http://data.ub.uib.no/ns/function-library"
    exclude-result-prefixes="xs rng a flub"
    version="2.0">
    <xsl:key name="define-from-name" match="rng:define" use="@name"/>
    
    <xsl:variable name="indent"><xsl:text>     </xsl:text></xsl:variable>
    <xsl:variable name="newline">
    <xsl:text>
</xsl:text>        
    </xsl:variable>
    
    <xsl:template match ="/">
        <xsl:value-of select="$newline"/><xsl:element name="xsl:stylesheet">
            <xsl:namespace name="xsl" select="'http://www.w3.org/1999/XSL/Transform'"/>
            <xsl:namespace name="xs" select="'http://www.w3.org/2001/XMLSchema'"/>
            <xsl:attribute name="version" select="2.0"/>
            <xsl:attribute name="exclude-result-prefixes" select="'xs'"/>
            <xsl:value-of select="$newline"/>
            <xsl:value-of select="$indent"/>
            <xsl:comment>Automatically generated xsl library with templates for creating the different pnx sections based on PNX.rng <xsl:value-of select="current-date()"/></xsl:comment>
            
       <xsl:value-of select="$newline,$newline"/>
        
    <xsl:for-each select="//rng:element[@name='metadata']/*:element[@name='recordContainer']/rng:ref">
        <xsl:apply-templates select="key('define-from-name',@name)" mode="template"/>
    </xsl:for-each>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="*" mode="template">
        <xsl:if test="a:documentation">
           <xsl:value-of select="$indent"/><xsl:comment><xsl:value-of select="$indent"/><xsl:value-of select="a:documentation"/></xsl:comment>
        <xsl:value-of select="$newline"/>
        </xsl:if>       
        <xsl:value-of select="$newline"/>
        <xsl:value-of select="$indent"/>
        <xsl:variable name="rng:element" select="(rng:element,rng:optional/rng:element)[1]"/>
        <xsl:element name="xsl:template">
            <xsl:attribute name="name" select="$rng:element/@name"/>
          
            <xsl:value-of select="$newline"/>
            <xsl:apply-templates select="$rng:element/*" mode="parameters"/>
            <xsl:value-of select="$indent,$indent"/>
            <xsl:element name="{$rng:element/@name}">
            <xsl:apply-templates select="$rng:element/*"  mode="createTemplateBody"/>
                <xsl:value-of select="$indent"/>
            </xsl:element>
            <xsl:value-of select="$newline"/>
            
            </xsl:element>
        <xsl:value-of select="$newline"/>
        
    </xsl:template>
    
    
    <xsl:template match="text()" mode="parameters createTemplateBody"></xsl:template>
    <xsl:template match="rng:element" mode="parameters">
       <xsl:value-of select="$indent,$indent"/> <xsl:element name="xsl:param">
            <xsl:attribute name="name" select="@name"/>
            <xsl:attribute name="as" select="flub:getRestrictionsFromRNGElement(self::node())"/>   
        </xsl:element>
        <xsl:value-of select="$newline"/>        
    </xsl:template>
    
    <xsl:template match="rng:element" mode="createTemplateBody">
        <xsl:variable name="variable-name" select="concat('$',@name,'[string(.)]')"/>
        <xsl:value-of select="$newline"/>
        <xsl:value-of select="$indent,$indent"/>
        
        <xsl:if test="preceding-sibling::a:documentation">
            <xsl:comment><xsl:value-of select="preceding-sibling::a:documentation"/></xsl:comment>
            <xsl:value-of select="$indent,$indent"/>
            <xsl:value-of select="$newline"/>
            <xsl:value-of select="$indent,$indent"/>
        </xsl:if>
        <xsl:element name="xsl:for-each">
            <xsl:attribute name="select" select="$variable-name"/>
            <xsl:value-of select="$newline"/>
            <xsl:value-of select="$indent,$indent,$indent"/>
            <xsl:element name="{@name}">
                <xsl:value-of select="$newline"/>
                <xsl:value-of select="$indent,$indent,$indent,$indent"/>
                <xsl:element name="xsl:value-of">
                    <xsl:attribute name="select" select="'.'"/>                    
                </xsl:element>
                <xsl:value-of select="$newline"/>
                <xsl:value-of select="$indent,$indent,$indent"/>
            </xsl:element>
            <xsl:value-of select="$newline"/>
            <xsl:value-of select="$indent,$indent"/>
            
        </xsl:element>
        <xsl:value-of select="$newline"/>
        <xsl:value-of select="$indent"/>
    </xsl:template>
    
    
    
    <xsl:function name="flub:getRestrictionsFromRNGElement">
        <xsl:param name="element" as="node()"/>
        <xsl:variable name="datatype" select="'xs:string'"></xsl:variable>
        <xsl:variable name="parent-name" select="$element/parent::node()/name()"/>
        <xsl:choose>
            <xsl:when test="$parent-name='optional'">
                <xsl:value-of select="concat($datatype,'?')"/>
            </xsl:when>
            <xsl:when test="$parent-name='zeroOrMore'">
                <xsl:value-of select="concat($datatype,'*')"/>
            </xsl:when>
            <xsl:when test="$parent-name='oneOrMore'">
                <xsl:value-of select="concat($datatype,'+')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$datatype"/>
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:function>
</xsl:stylesheet>