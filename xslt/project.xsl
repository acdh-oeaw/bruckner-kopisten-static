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
    <xsl:import href="partials/tei-ref.xsl"/>

    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type='sub'][1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" 
                        select="$doc_title"></xsl:with-param>
                </xsl:call-template>
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
                        <div id="navBarLetters" class="container"
                            style="margin-top:4em !important;">
                            <ul class="nav nav-tabs justify-content-end" 
                                id="dropdown-lang">                                
                                <li class="nav-item">                                    
                                    <a title="Deutsch" 
                                        href="#lang-de" 
                                        data-toggle="tab" 
                                        class="nav-link btn btn-round active">
                                        DE
                                    </a>
                                </li>
                                <li class="nav-item">                                    
                                    <a title="English" 
                                        href="#lang-en" 
                                        data-toggle="tab" 
                                        class="nav-link btn btn-round">
                                        EN
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="tab-content container">
                            <div class="tab-pane active" 
                                id="lang-de">
                                <div class="card" 
                                    style="margin-top:0;">
                                    <div class="card-header">
                                        <h1>
                                            <xsl:value-of select="//tei:head[ancestor::tei:div[@xml:lang='de']]"/>
                                        </h1>
                                    </div>
                                    <div class="card-body">                                
                                        <xsl:apply-templates select="//tei:div[@xml:lang='de']"/>
                                    </div>
                                    <xsl:if test="//tei:note">
                                        <div class="card-footer">
                                            <ul>
                                                <xsl:for-each select="//tei:note[ancestor::tei:div[@xml:lang='de']]">
                                                    <li>
                                                        <a href="#{replace(@xml:id, 'footnote', 'footnote-ref')}">
                                                            <span style="margin-right:.2em;vertical-align:super;">
                                                                <small><xsl:value-of select="@n"/></small>
                                                            </span>  
                                                        </a>            
                                                        <span class="note" 
                                                            id="{@xml:id}">
                                                            <xsl:apply-templates/>
                                                        </span>      
                                                    </li>
                                                </xsl:for-each>
                                            </ul>                                    
                                        </div>
                                    </xsl:if>                            
                                </div>
                            </div>
                            <div class="tab-pane fade" 
                                id="lang-en">
                                <div class="card" 
                                    style="margin-top:0;">
                                    <div class="card-header">
                                        <xsl:choose>
                                            <xsl:when test="//tei:head[ancestor::tei:div[@xml:lang='eng']]">
                                                <h1>
                                                    <xsl:value-of select="//tei:head[ancestor::tei:div[@xml:lang='eng']]"/>
                                                </h1>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <h1>Introduction</h1>
                                            </xsl:otherwise>
                                        </xsl:choose>                                
                                    </div>
                                    <div class="card-body">
                                        <xsl:apply-templates select="//tei:div[@xml:lang='eng']"/>
                                    </div>
                                    <xsl:if test="//tei:note">
                                        <div class="card-footer">
                                            <ul>
                                                <xsl:for-each select="//tei:note[ancestor::tei:div[@xml:lang='eng']]">
                                                    <li>
                                                        <a href="#{replace(@xml:id, 'footnote', 'footnote-ref')}">
                                                            <span style="margin-right:.2em;vertical-align:super;">
                                                                <small><xsl:value-of select="@n"/></small>
                                                            </span>  
                                                        </a>            
                                                        <span class="note" id="{@xml:id}">
                                                            <xsl:apply-templates/>
                                                        </span>      
                                                    </li>
                                                </xsl:for-each>
                                            </ul>                                    
                                        </div>
                                    </xsl:if>                            
                                </div>
                            </div>
                        </div>
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <ol><xsl:apply-templates/></ol>
    </xsl:template>
    <xsl:template match="tei:item">
        <li style="list-style:decimal;">
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="tei:p">
        <p id="{generate-id()}">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:div[@xml:lang='de']">
        <div id="{generate-id()}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:div[@xml:lang='eng']">
        <div id="{generate-id()}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    <xsl:template match="tei:head">

    </xsl:template>
    <xsl:template match="tei:hi">
        <span style="font-style:{@rend};">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:note">
        
    </xsl:template>
  
</xsl:stylesheet>