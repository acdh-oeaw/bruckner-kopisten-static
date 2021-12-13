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
                        <div class="card">
                            <!--<div class="card-header">
                                <h1><xsl:value-of select="$doc_title"/></h1>
                            </div>-->
                            <div class="card-body">                                
                                <xsl:apply-templates select=".//tei:body"/>
                            </div>
                        </div>                       
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
            <script>
                $(document).ready(function () {
                    $('#editions-table').DataTable({
                        "language": {
                            "url": "https://cdn.datatables.net/plug-ins/1.10.19/i18n/German.json"
                        },
                        dom: 'fpBirtp',
                        buttons:['copy', 'excel', 'pdf'],
                        "lengthMenu":[25, 50, 75, 100, "All"],
                        responsive: true,
                        orderCellsTop: true,
                        "pageLength": 25,
                        keepConditions: true
                    });
                });
            </script>            
        </html>
    </xsl:template>

    <xsl:template match="tei:div">
        <div id="{@xml:id}"><xsl:apply-templates/></div>
    </xsl:template>
    <xsl:template match="tei:listPerson">
        <div class="row">
            <xsl:for-each select="./tei:person">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            <h3><xsl:value-of select="./tei:persName"/></h3>
                        </div>
                        <div class="card-body">
                            <dl>
                                <xsl:for-each select="child::*[not(self::tei:persName or self::tei:index)]">
                                    <dt><strong><xsl:value-of select="name()"/></strong></dt>
                                    <dd><xsl:apply-templates/></dd>
                                </xsl:for-each>
                            </dl>
                        </div>
                        <div class="card-footer">
                            <xsl:for-each select="./tei:index/tei:term">
                                <span class="badge bg-primary text-light" style="margin-right:.2em;">
                                    <xsl:apply-templates/>
                                </span>
                            </xsl:for-each>
                        </div>
                    </div>
                </div>
            </xsl:for-each>            
        </div>
    </xsl:template>
    <xsl:template match="tei:p">
        <p class="card-body">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:list">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <xsl:apply-templates select="//tei:head"/>
                    </div>
                    <div class="card-footer">
                        <ul><xsl:apply-templates select="//tei:item"/></ul>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="tei:head">
        <xsl:if test="@xml:lang='de'">
            <h3><xsl:apply-templates/></h3>
        </xsl:if>        
    </xsl:template>
    <xsl:template match="tei:item">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    <xsl:template match="tei:title">
        <xsl:if test="@xml:lang='de'">
            <h5><xsl:apply-templates/></h5>
        </xsl:if>       
    </xsl:template>
    <xsl:template match="tei:figure">
        <xsl:param name="iiif-ext" select="'full/full/0/default.jpg'"/>     
        <xsl:for-each select="./tei:graphic">
            <img class="tei-xml-images">
                <xsl:attribute name="src">
                    <xsl:value-of select="concat(@url , $iiif-ext)"/>
                </xsl:attribute>
            </img>
        </xsl:for-each>        
    </xsl:template>    
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    
</xsl:stylesheet>