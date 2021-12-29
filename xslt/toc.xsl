<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:import href="partials/tei-geo.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title" select="'Inhaltsverzeichnis'"/>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
            </head>
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">
                        <div class="card" style="margin-bottom:-3em;padding:0!important;">
                            <div class="card-footer" style="padding:0!important;">
                                <xsl:call-template name="add_map_container"/>
                            </div>
                        </div>                        
                        <div class="card">
                            <div class="card-header">
                                <h1>Kopisten Gesamt</h1>
                            </div>
                            <div class="card-body">                                
                                <table class="table table-striped display" id="tocTable" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Titel</th>
                                            <th scope="col">Quelle</th>
                                            <th scope="col">Zuordnung</th>
                                            <th scope="col">Ort</th>
                                            <th scope="col">Details</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select="collection('../data/editions')//tei:TEI">
                                            <xsl:variable name="full_path">
                                                <xsl:value-of select="document-uri(/)"/>
                                            </xsl:variable>
                                            <tr>
                                                <td>                               
                                                    <xsl:value-of select=".//tei:title[@type='main'][1]/text()"/>
                                                </td>
                                                <td>
                                                    <xsl:if test=".//tei:index/tei:term/text()">
                                                        <xsl:value-of select=".//tei:index/tei:term[@xml:lang='de']/text()"/> | 
                                                        <xsl:value-of select=".//tei:index/tei:term[@xml:lang='eng']/text()"/>    
                                                    </xsl:if>                                                    
                                                </td>
                                                <td>
                                                    <xsl:if test=".//tei:affiliation/text()">
                                                        <xsl:value-of select=".//tei:affiliation[@xml:lang='de']/text()"/> | 
                                                        <xsl:value-of select=".//tei:affiliation[@xml:lang='eng']/text()"/>   
                                                    </xsl:if>                                                    
                                                </td>
                                                <td>                                                    
                                                    <xsl:if test=".//tei:listPlace">
                                                        <xsl:variable name="latLong" select="tokenize(.//tei:listPlace/tei:place/tei:location/tei:geo/text(), ' ')"/>
                                                        <xsl:variable name="lat" select="$latLong[1]"/>
                                                        <xsl:variable name="long" select="$latLong[2]"/>
                                                        <xsl:variable name="place" select=".//tei:listPlace/tei:place/tei:placeName/text()"/>
                                                        <xsl:attribute name="lat">
                                                            <xsl:value-of select="$lat"/>
                                                        </xsl:attribute>
                                                        <xsl:attribute name="long">
                                                            <xsl:value-of select="$long"/>
                                                        </xsl:attribute>
                                                        <xsl:attribute name="subtitle">
                                                            <xsl:value-of select="$place"/>
                                                        </xsl:attribute>
                                                        <xsl:attribute name="class">
                                                            <xsl:text>map-coordinates</xsl:text>
                                                        </xsl:attribute>
                                                        <xsl:value-of select="$place"/> 
                                                    </xsl:if>                                                    
                                                </td>
                                                <td>                                        
                                                    <a>
                                                        <xsl:attribute name="href">                                                
                                                            <xsl:value-of select="replace(tokenize($full_path, '/')[last()], '.xml', '.html')"/>
                                                        </xsl:attribute>
                                                        <xsl:attribute name="title">                                                
                                                            <xsl:value-of select="replace(tokenize($full_path, '/')[last()], '.xml', '.html')"/>
                                                        </xsl:attribute>
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-in-right" viewBox="0 0 16 16">
                                                            <path fill-rule="evenodd" d="M6 3.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 0-1 0v2A1.5 1.5 0 0 0 6.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-8A1.5 1.5 0 0 0 5 3.5v2a.5.5 0 0 0 1 0v-2z"/>
                                                            <path fill-rule="evenodd" d="M11.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H1.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
                                                        </svg>
                                                    </a>
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <xsl:call-template name="html_footer"/>
                    <script src="js/one_leaflet_refactored.js"/>
                    <script>
                        $(document).ready(function () {
                            leafletDatatable('tocTable')
                        }); 
                        $(document).ready(function () {
                            createDataTable('tocTable')
                        });                                               
                    </script>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="tei:div//tei:head">
        <h2 id="{generate-id()}"><xsl:apply-templates/></h2>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p id="{generate-id()}"><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <ul id="{generate-id()}"><xsl:apply-templates/></ul>
    </xsl:template>
    
    <xsl:template match="tei:item">
        <li id="{generate-id()}"><xsl:apply-templates/></li>
    </xsl:template>
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="starts-with(data(@target), 'http')">
                <a>
                    <xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>