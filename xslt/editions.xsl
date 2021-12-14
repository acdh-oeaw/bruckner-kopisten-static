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
    <!--<xsl:import href="partials/osd-container.xsl"/>-->
    <!--<xsl:import href="partials/tei-facsimile.xsl"/>-->
    <xsl:import href="partials/tei-ref.xsl"/>
    <xsl:import href="partials/tei-table.xsl"/>
    <xsl:import href="partials/dataTable-base.xsl"/>
    
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
                    .container-fluid {
                        max-width: 100%;
                    }
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
                    createDataTable('editions-table')
                });
            </script>            
        </html>
    </xsl:template>

    <xsl:template match="tei:div">
        <div class="row" id="{@xml:id}">
            <xsl:apply-templates>
                <xsl:with-param name="table-id" select="'editions-table'"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>
    <xsl:template match="tei:listPerson">
        <xsl:for-each select="./tei:person">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h3><xsl:value-of select="./tei:persName[1]"/></h3>
                    </div>
                    <div class="card-body">
                        <table class="table">
                            <xsl:for-each select="child::*[not(self::tei:persName or self::tei:index)]">
                                <xsl:choose>
                                    <xsl:when test="@xml:lang = 'de'">
                                        <tr>
                                            <th><strong><xsl:value-of select="name()"/></strong></th>
                                            <td><xsl:apply-templates/></td>
                                        </tr>
                                    </xsl:when>
                                    <xsl:when test="@xml:lang = 'en'">
                                        
                                    </xsl:when>
                                    <xsl:when test="not(@xml:lang)">
                                        <tr>
                                            <th><strong><xsl:value-of select="name()"/></strong></th>
                                            <td><xsl:apply-templates/></td>
                                        </tr>
                                    </xsl:when>
                                </xsl:choose>                                    
                            </xsl:for-each>
                        </table>
                    </div>
                    <div class="card-footer">
                        <xsl:for-each select="./tei:index/tei:term[@xml:lang='de']">
                            <span class="badge text-light" style="margin-right:.2em;">
                                <xsl:apply-templates/>
                            </span>
                        </xsl:for-each>
                    </div>
                </div>
            </div>
        </xsl:for-each>            
        
    </xsl:template>
    <xsl:template match="tei:p">
        <div class="col-md-2">
            <div class="card">
                <div class="card-header">
                    <h3>Beschreibung</h3>
                </div>
                <div class="card-body">
                    <p>
                        <xsl:apply-templates/>
                    </p>
                </div>
            </div>            
        </div>        
    </xsl:template>
    <xsl:template match="tei:list">
        <div class="col-md-12">
            <div class="card" style="margin-top:-.5em;border-top:none!important;">
                <div class="card-header">
                    <h3><xsl:value-of select="./tei:head[@xml:lang='de']"/> | <xsl:value-of select="./tei:head[@xml:lang='eng']"/></h3>  
                </div>
                <div class="card-footer">
                    <ul><xsl:apply-templates select="//tei:item"/></ul>
                </div>
            </div>
        </div>        
    </xsl:template>
    <xsl:template match="tei:head">
   
    </xsl:template>
    <xsl:template match="tei:item">        
        <li style="margin:2em;">
            <h5><xsl:value-of select="./tei:title[@xml:lang='de']"/> | <xsl:value-of select="./tei:title[@xml:lang='eng']"/></h5>  
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="tei:title">
        
    </xsl:template>
    <xsl:template match="tei:figure">
        <xsl:param name="iiif-ext" select="'full/full/0/default.jpg'"/>     
        <xsl:for-each select="./tei:graphic">
            <xsl:variable name="source" select="data(tokenize(@url, '/'))"/>
            <div class="img-notes">
                <img class="tei-xml-images">
                    <xsl:attribute name="src">
                        <xsl:value-of select="concat('https://iiif.acdh.oeaw.ac.at/bruckner-kopisten/', replace($source[last()], '.png', '/full/full/0/default.jpg'))"/>
                    </xsl:attribute>
                </img>
            </div>
        </xsl:for-each>        
    </xsl:template>    
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    
</xsl:stylesheet>