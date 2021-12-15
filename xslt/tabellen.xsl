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
    <xsl:import href="partials/tei-table.xsl"/>
    
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type='main'][1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="datatable-base"/>
                <style>

                </style>
            </head>            
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">                        
                        <xsl:apply-templates select=".//tei:body"/>                 
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
            <script>
                $(document).ready(function () {
                    createDataTable('tabellen-table')
                });
            </script>            
        </html>
    </xsl:template>

    <xsl:template match="tei:div">
        <div class="row">
            <xsl:apply-templates>
                <xsl:with-param name="table-id" select="'tabellen-table'"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>   
    
    <xsl:template match="tei:list">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h2>
                        <xsl:value-of select="./tei:head[@xml:lang='de']"/>
                        <br/>
                        <xsl:value-of select="./tei:head[@xml:lang='eng']"/>
                    </h2>  
                </div>
                <div class="card-body">
                    <ul><xsl:apply-templates select="//tei:item"/></ul>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="tei:head">
   
    </xsl:template>
    <xsl:template match="tei:item">   
        <li style="margin:1em;">
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="tei:persName">
        <xsl:apply-templates/>    
    </xsl:template>
    
</xsl:stylesheet>