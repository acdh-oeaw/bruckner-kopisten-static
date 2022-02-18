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
    <xsl:import href="partials/tei-ref.xsl"/>
    <xsl:import href="partials/dataTable-base.xsl"/>
    <xsl:import href="partials/leaflet-base.xsl"/>
    <xsl:import href="partials/tei-table.xsl"/>
    <xsl:import href="partials/tei-rs.xsl"/>
    <xsl:import href="partials/tei-geo.xsl"/>

    <xsl:template match="/">
        <xsl:variable name="start" as="xs:int">
            <xsl:choose>
                <xsl:when test="starts-with(.//tei:title[@type='sub'][1]/text(), 'Tabelle 4')">
                    <xsl:value-of select="3"/>
                </xsl:when>                
                <xsl:otherwise>
                    <xsl:value-of select="0"/>
                </xsl:otherwise>
            </xsl:choose>            
        </xsl:variable>
        <xsl:variable name="dt-script">
            <xsl:choose>
                <xsl:when test="starts-with(.//tei:title[@type='sub'][1]/text(), 'Tabelle 3')">
                    <xsl:value-of select="concat('leafletDatatable(`tabellen-table`);createDataTable(`tabellen-table`, 20, ' , $start, ');')"/>                        
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat('createDataTable(`tabellen-table`, 20, ' , $start, ');')"/>
                </xsl:otherwise>
            </xsl:choose>            
        </xsl:variable>
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type='sub'][1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="datatable-base"/>
                <xsl:call-template name="leaflet-base"/>
                <style>

                </style>
            </head>                  
            
            <body class="page" onload="{$dt-script}">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">
                        <xsl:if test="//tei:listPlace">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card" style="margin-bottom:-3em;padding:0!important;">
                                        <div class="card-footer" style="padding:0!important;">
                                            <xsl:call-template name="add_map_container"/>
                                        </div>
                                    </div>
                                </div>                                 
                            </div>                            
                        </xsl:if>                        
                        <xsl:apply-templates select=".//tei:body"/>                 
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
            <script src="js/one_leaflet_refactored.js"/>
            <xsl:choose>
                <xsl:when test="starts-with(.//tei:title[@type='sub'][1]/text(), 'Tabelle 4')">
                    <script type="text/javascript" src="js/dt-alphabet-filter-column3.js"></script>  
                </xsl:when>
                <xsl:otherwise>
                    <script type="text/javascript" src="js/dt-alphabet-filter.js"></script>  
                </xsl:otherwise>
            </xsl:choose>                      
        </html>
    </xsl:template>

    <xsl:template match="tei:div">        
        <xsl:apply-templates>
            <xsl:with-param name="table-id" select="'tabellen-table'"/>
        </xsl:apply-templates>        
    </xsl:template>   
    
    <xsl:template match="tei:list">
        <xsl:param name="table-id"/>
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h2>
                            <xsl:value-of select="./tei:head[@xml:lang='de']"/>                        
                        </h2>
                        <h3>                       
                            <xsl:value-of select="./tei:head[@xml:lang='eng']"/>
                        </h3> 
                    </div>
                    <div class="card-body">
                        <table class="table table-striped" id="{$table-id}">
                            <thead>
                                <tr>
                                    <th>
                                        Name
                                    </th>
                                    <th>
                                        Details
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:apply-templates select="//tei:item"/>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="tei:head">
   
    </xsl:template>
    <xsl:template match="tei:item">   
        <xsl:variable name="url" select="tokenize(./tei:ref/@target, '/')[last()]"/>
        <tr>
            <td><xsl:value-of select="."/></td>
            <td>
                <a href="{replace($url, '.xml', '.html')}" title="{./tei:ref/tei:persName}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-in-right" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M6 3.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 0-1 0v2A1.5 1.5 0 0 0 6.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-8A1.5 1.5 0 0 0 5 3.5v2a.5.5 0 0 0 1 0v-2z"/>
                        <path fill-rule="evenodd" d="M11.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H1.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
                    </svg>
                </a>
            </td>
        </tr>        
    </xsl:template>
    <xsl:template match="tei:persName">
        <xsl:apply-templates/>    
    </xsl:template>    
    
</xsl:stylesheet>