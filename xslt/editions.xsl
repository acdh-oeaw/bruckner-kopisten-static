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
        <div class="row kopisten-content" id="{@xml:id}">
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
                        <xsl:choose>
                            <xsl:when test="contains(./tei:persName[@type='main'], 'Anonymus')">
                                <h3><span class="text"><xsl:value-of select="concat(./tei:persName[@type='main'], ' (', ./tei:persName[@type='main']/@subtype, ')')"/></span></h3>
                            </xsl:when>
                            <xsl:otherwise>
                                <h3><span class="text"><xsl:value-of select="./tei:persName[@type='main']"/></span></h3>
                            </xsl:otherwise>
                        </xsl:choose>                        
                    </div>
                    <div class="card-body">
                        <table class="table">
                            <xsl:for-each select="child::*[not(self::tei:persName or self::tei:index or self::tei:idno)]">
                                <xsl:choose>
                                    <xsl:when test="@xml:lang = 'de' or not(@xml:lang)">
                                        <tr>
                                            <th><strong>
                                                <xsl:if test="name() = 'residence'">
                                                    <span class="text"><xsl:text>Residenz</xsl:text></span>
                                                </xsl:if>
                                                <xsl:if test="name() = 'affiliation'">
                                                    <span class="text"><xsl:text>Zuordnung zu</xsl:text></span>
                                                </xsl:if>
                                                <xsl:if test="name() = 'floruit'">
                                                    <span class="text"><xsl:text>Normdaten</xsl:text></span>
                                                </xsl:if>
                                            </strong></th>
                                            <td><span class="text"><xsl:apply-templates/></span></td>
                                        </tr>
                                    </xsl:when>
                                    <xsl:when test="@xml:lang = 'en'">
                                        
                                    </xsl:when>                                    
                                </xsl:choose>                                    
                            </xsl:for-each>
                        </table>
                    </div>
                    <div class="card-footer">
                        <xsl:for-each select="./tei:index/tei:term">
                            <span class="badge text-light text" style="margin-right:.2em;">
                                <xsl:apply-templates/>
                            </span>
                        </xsl:for-each>
                    </div>
                </div>
            </div>
            <div class="col-md-8">
                <div id="navBarLetters" style="margin-top:.8em !important;">
                    <ul class="nav nav-tabs" id="dropdown-lang">                                
                        <li class="nav-item">                                    
                            <a title="Deutsch" href="#lang-de" data-toggle="tab" class="nav-link btn btn-round active">
                                Deutsch
                            </a>
                        </li>
                        <xsl:if test="//tei:p[parent::tei:div][@xml:lang='eng']/text()">
                        <li class="nav-item">                                    
                            <a title="English" href="#lang-en" data-toggle="tab" class="nav-link btn btn-round">
                                English
                            </a>
                        </li>
                        </xsl:if>
                    </ul>
                </div>
                <div class="tab-content">
                    <xsl:if test="//tei:p[parent::tei:div][@xml:lang='de']/text()">
                        <div class="tab-pane active" id="lang-de">
                            <div class="card" style="margin-top:0;">
                                <div class="card-header">
                                    <h3>Beschreibung</h3>
                                </div>
                                <div class="card-body">
                                    <xsl:for-each select="//tei:p[@decls='desc'][parent::tei:div][@xml:lang='de']">
                                        <span class="text">
                                            <xsl:apply-templates/>
                                        </span>
                                    </xsl:for-each>                                
                                </div>
                                <div class="card-footer">
                                    <ul>
                                        <xsl:for-each select="//tei:note[parent::tei:p[@xml:lang='de']]">
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
                            </div>            
                        </div>
                    </xsl:if>   
                    <xsl:if test="//tei:p[parent::tei:div][@xml:lang='eng']/text()">
                        <div class="tab-pane fade" id="lang-en">
                            <div class="card" style="margin-top:0;">
                                <div class="card-header">
                                    <h3>Description</h3>
                                </div>
                                <div class="card-body">
                                    <xsl:for-each select="//tei:p[parent::tei:div][@xml:lang='eng']">
                                        <span class="text">
                                            <xsl:apply-templates/>
                                        </span>
                                    </xsl:for-each>                                
                                </div>
                                <div class="card-footer">
                                    <ul>
                                        <xsl:for-each select="//tei:note[parent::tei:p[@xml:lang='eng']]">
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
                            </div>            
                        </div>
                    </xsl:if>
                </div> 
            </div>
        </xsl:for-each>            
        
    </xsl:template>
    <xsl:template match="tei:p">
        
    </xsl:template>
    <xsl:template match="tei:note">
        
    </xsl:template>
    <xsl:template match="tei:list">
        <xsl:choose>
            <xsl:when test="parent::tei:p">
                <ul style="margin-top:.5em;"><xsl:apply-templates/></ul>
            </xsl:when>
            <xsl:otherwise>
                <div class="col-md-12">
                    <div class="card" style="margin-top:-.5em;border-top:none!important;">
                        <div class="card-header">
                            <h5><xsl:value-of select="./tei:head[@xml:lang='de']"/> | <xsl:value-of select="./tei:head[@xml:lang='eng']"/></h5>  
                        </div>
                        <div class="card-footer">
                            <ul><xsl:apply-templates select="//tei:item"/></ul>
                        </div>
                    </div>
                </div>
            </xsl:otherwise>
        </xsl:choose>                
    </xsl:template>
    <xsl:template match="tei:head">
   
    </xsl:template>
    <xsl:template match="tei:hi">
        <xsl:choose>
            <xsl:when test="@rend='sup'">
                <span style="vertical-align:super;"><small><xsl:apply-templates/></small></span>
            </xsl:when>
            <xsl:otherwise>
                <span><xsl:apply-templates/></span>
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:template>
    <xsl:template match="tei:item">   
        <xsl:choose>
            <xsl:when test="ancestor::tei:p">
                <li style="list-style: decimal;">
                    <xsl:apply-templates/>
                </li>
            </xsl:when>
            <xsl:otherwise>
                <li style="margin:2em;">
                    <h6><xsl:value-of select="./tei:title[@xml:lang='de']"/> | <xsl:value-of select="./tei:title[@xml:lang='eng']"/></h6>
                    <xsl:apply-templates/>
                </li>
            </xsl:otherwise>
        </xsl:choose>        
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