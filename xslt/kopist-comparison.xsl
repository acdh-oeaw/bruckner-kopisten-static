<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" 
    exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" 
        media-type="text/html" 
        method="xhtml" 
        version="1.0" 
        indent="yes" 
        omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <!--<xsl:import href="partials/osd-container.xsl"/>-->
    <!--<xsl:import href="partials/tei-facsimile.xsl"/>-->
    <xsl:import href="partials/tei-ref.xsl"/>
    
    <xsl:template match="/">        
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="'Kopisten-Vergleich'"/>
                </xsl:call-template>
                <script type="text/javascript" src="saxon-js/SaxonJS2.rt.js"></script>
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
                        
                        <xsl:variable name="col" select="collection('../data/editions')//tei:TEI"/>
                        
                        <div class="row">
                            <div class="col-md-5">
                                <div class="card">
                                    <div class="card-header">
                                        <select class="custom-select custom-select-sm" id="compare-kopist-one">
                                            <option selected="selected">Kopist 1 auswählen</option>
                                            <xsl:for-each select="$col//tei:titleStmt/tei:title[@level='a']">
                                                <xsl:variable name="cp-cleaning1" select="                    
                                                    replace(
                                                    replace(
                                                    replace(
                                                    replace(
                                                    replace(
                                                    replace(
                                                    translate(. ,' ', '-')
                                                    , ',', '')
                                                    ,'ß', 'ss')
                                                    , '[éè]', 'e')
                                                    , 'ä', 'a')
                                                    , 'ö', 'o')
                                                    , 'ü', 'u')                      
                                                    "/>
                                                <xsl:variable name="cp-cleaning2" select="data(translate($cp-cleaning1,'.', ''))"/>
                                                <xsl:variable name="cp-clean" select="translate($cp-cleaning2, '&#xA0;', '-') => lower-case()"/>
                                                <option value="{$cp-clean}">
                                                    <xsl:apply-templates/>
                                                </option>
                                            </xsl:for-each>
                                        </select>
                                    </div>
                                    <div class="card-body" id="compare-column-one">
                                        
                                    </div>
                                    <div class="card-footer">
                                        
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">        
                                <div class="text-center" style="margin-top: 4em;">
                                    <button class="button btn" onclick="loadComparison()">vergleichen</button>
                                </div>                                                                
                            </div>
                            <div class="col-md-5">
                                <div class="card">
                                    <div class="card-header">
                                        <select class="custom-select custom-select-sm" id="compare-kopist-two">
                                            <option selected="selected">Kopist 2 auswählen</option>
                                            <xsl:for-each select="$col//tei:titleStmt/tei:title[@level='a']">
                                                <xsl:variable name="cp-cleaning1" select="                    
                                                    replace(
                                                    replace(
                                                    replace(
                                                    replace(
                                                    replace(
                                                    replace(
                                                    translate(. ,' ', '-')
                                                    , ',', '')
                                                    ,'ß', 'ss')
                                                    , '[éè]', 'e')
                                                    , 'ä', 'a')
                                                    , 'ö', 'o')
                                                    , 'ü', 'u')                      
                                                    "/>
                                                <xsl:variable name="cp-cleaning2" select="data(translate($cp-cleaning1,'.', ''))"/>
                                                <xsl:variable name="cp-clean" select="translate($cp-cleaning2, '&#xA0;', '-') => lower-case()"/>
                                                <option value="{$cp-clean}">
                                                    <xsl:apply-templates/>
                                                </option>
                                            </xsl:for-each>
                                        </select>
                                    </div>
                                    <div class="card-body" id="compare-column-two">
                                        
                                    </div>
                                    <div class="card-footer">
                                        
                                    </div>
                                </div>
                            </div>                            
                        </div>
                    </div>                   
                    
                    <xsl:call-template name="html_footer"/>
                    <script type="text/javascript" src="js/saxon-js-comparison.js"></script>
                </div>
            </body>
            
                        
        </html>
    </xsl:template>
    
</xsl:stylesheet>