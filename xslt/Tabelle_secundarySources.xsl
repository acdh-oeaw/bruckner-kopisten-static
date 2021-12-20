<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:rng="http://relaxng.org/ns/structure/1.0"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:teix="http://www.tei-c.org/ns/Examples"
    xmlns:html="http://www.w3.org/1999/xhtml" xmlns:m="http://www.w3.org/1998/Math/MathML"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="#all" version="2.0">
    <xsl:output encoding="UTF-8" indent="yes"/>
    
    
    <xsl:template match="node() | @*" mode="inFile">
        <xsl:copy>
            <xsl:apply-templates mode="inFile" select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="t:TEI" exclude-result-prefixes="#all">
        <xsl:variable name="Person"
            select="collection('../data/editions?select=*.xml;recurse=yes')/t:TEI/t:text/t:body/t:div"/>
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title xmlns:xi="http://www.w3.org/2001/XInclude" level="m">Die Wiener Kopisten der Werke Anton Bruckners</title>
                        <title type="sub" level="a">Tabelle 2 – Kopisten der Sekundärquellen</title>
                        <author xmlns:xi="http://www.w3.org/2001/XInclude">
                            <name>Paul Hawkshaw</name>
                            <name>Clemens Gubsch</name>
                        </author>
                        <respStmt xmlns:xi="http://www.w3.org/2001/XInclude">
                            <resp>Automatische Konvertierung nach TEI P5</resp>
                            <name xml:id="cg">Clemens Gubsch</name>
                        </respStmt>
                        <respStmt xmlns:xi="http://www.w3.org/2001/XInclude">
                            <resp>Dokumentvorbereitung, Korrektur und weiterführendes Markup</resp>
                            <name corresp="#cg">Clemens Gubsch</name>
                        </respStmt>
                    </titleStmt>
                    <editionStmt>
                        <edition>
                            <date>2020-11-01</date>
                        </edition>
                    </editionStmt>
                    <publicationStmt>
                        <publisher xmlns:xi="http://www.w3.org/2001/XInclude">XXX Project Name
                            XXX</publisher>
                        <idno xmlns:xi="http://www.w3.org/2001/XInclude" type="BrucknerKopisten"/>
                    </publicationStmt>
                    <sourceDesc xmlns:xi="http://www.w3.org/2001/XInclude">
                        <p>Erstellt unter Berücksichtigung des bisherigen Forschungsstandes.</p>
                    </sourceDesc>
                </fileDesc>
                <profileDesc xmlns:xi="http://www.w3.org/2001/XInclude">
                    <textClass>
                        <keywords>
                            <term>Table</term>
                        </keywords>
                    </textClass>
                </profileDesc>
                <revisionDesc>
                    <listChange>
                        <change who="#cg" status="created">Erstellt und geprüft</change>
                    </listChange>
                </revisionDesc>
            </teiHeader>
            <text>
                <body>
                    <div>
                        <list>
                            <head xml:lang="de">Tabelle 2 – Kopisten der Sekundärquellen</head>
                            <head xml:lang="eng">Table 2 – Copyists of Secundary Sources</head>
                            <xsl:for-each select="$Person">
                                <xsl:if test="./t:listPerson/t:person/t:index/t:term[1] = 'Sekundärquellen'">
                                    <xsl:variable name="cp-cleaning1" select="                    
                                        replace(
                                            replace(
                                                replace(
                                                    replace(
                                                        replace(
                                                            replace(
                                                                translate(./t:listPerson/t:person/t:persName[@type = 'main'][last()] ,' ', '-') 
                                                            , ',', '')
                                                            ,'ß', 'ss')
                                                        , '[éè]', 'e')
                                                    , 'ä', 'a')
                                                , 'ö', 'o')
                                            , 'ü', 'u')                      
                                        "/>
                                    <xsl:variable name="cp-cleaning2" select="data(translate($cp-cleaning1,'.', ''))"/>
                                    <xsl:variable name="cp-clean" select="translate($cp-cleaning2, '&#xA0;', '-') => lower-case()"/>
                                    <xsl:element name="item">
                                        <xsl:element name="ref">
                                            <xsl:attribute name="corresp">
                                                <xsl:value-of select="@xml:id"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="target">
                                                <xsl:value-of
                                                    select="concat('data/editions/', $cp-clean, '.xml')"/>
                                            </xsl:attribute>
                                            <xsl:copy-of select="./t:listPerson/t:person/t:persName[@type = 'main']"/>
                                        </xsl:element>
                                    </xsl:element>
                                </xsl:if>
                            </xsl:for-each>
                        </list>
                    </div>
                </body>
            </text>
        </TEI>
    </xsl:template>
</xsl:stylesheet>
