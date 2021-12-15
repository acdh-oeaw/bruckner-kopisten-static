<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:foo="foo.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:dc="http://purl.org/dc/terms/" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:sparql="http://www.w3.org/2005/sparql-results#" xmlns:my="http://test.org/" exclude-result-prefixes="#all" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget tei-ref.</h1>
            <p>Contact person: daniel.stoxreiter@oeaw.ac.at</p>
            <p>Applied with apply-templates in html:body.</p>
            <p>The template "tei-ref" can handle the tei/xml tag ref.</p> 
            <p>The template verifies if attributes like type and target are available.</p>
            <p>If a type attribute is found the template verifies if the value is either URI, URL, GND or VIAF.</p>
            <p>If a corresponding value is found the ref value will be used as URL and create a html link.</p>
            <p>If a target attribute is found the ref value will be used as URL and create a html link if the value starts with http or www.</p>
        </desc>    
    </doc>
    
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="@type='URI' or @type='URL' or @type='GND' or @type='VIAF'">                
                <a target="_blank">
                    <xsl:attribute name="href">
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>          
                </a>               
            </xsl:when>
            <xsl:when test="starts-with(@target,'http') or starts-with(@target,'www')">                
                <a target="_blank">
                    <xsl:attribute name="href">
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>                                
                </a>               
            </xsl:when>
            <xsl:when test="@corresp">
                <xsl:variable name="cp" select="tokenize(@target, '/')"/>
                <xsl:variable name="cp-clean" select="                    
                    replace(
                        replace(
                            replace(
                                replace(
                                    replace(
                                        replace(
                                            replace(
                                                translate($cp[last()] ,' ', '-') 
                                                ,'.xml', '.html')
                                            , ',', '')
                                        ,'ß', 'ss')
                                    , '[éè]', 'e')
                                , 'ä', 'a')
                            , 'ö', 'o')
                        , 'ü', 'u')                      
                    "/>
                <a>
                    <xsl:choose>
                        <xsl:when test="contains($cp-clean,'Kopist')">
                            <xsl:variable name="kopist" select="data(translate($cp-clean,'.', ''))"/>
                            <xsl:variable name="kopist3" select="data(replace($kopist,'html', '.html'))"/>
                            <xsl:attribute name="href">
                                <xsl:value-of select="translate($kopist3, '&#xA0;', '-') => lower-case()"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="href">
                                <xsl:value-of select="lower-case($cp-clean)"/>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:otherwise>
                    </xsl:choose>                                 
                </a>
                <xsl:if test="following-sibling::tei:ref and ancestor::tei:table">
                    <xsl:text> / </xsl:text>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@type='noteAnchor'">        
                <small>
                    <a id="{@xml:id}" style="vertical-align:super;">
                        <xsl:attribute name="href">
                            <xsl:value-of select="@target"/>
                        </xsl:attribute>
                        <xsl:apply-templates/>                                
                    </a>
                </small>         
            </xsl:when>
            <xsl:when test="@type='table'">    
                <xsl:variable name="tg" select="tokenize(@target, '/')"/>
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="replace($tg[last()], '.xml', '.html')"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>                                
                </a>               
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>