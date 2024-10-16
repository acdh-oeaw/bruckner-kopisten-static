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
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type='sub'][1]/text()"/>
        </xsl:variable>

        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml">
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
                <div class="hfeed site" 
                    id="page">
                    <xsl:call-template name="nav_bar"/>
                
                    <!--<div class="wrapper" 
                        id="wrapper-hero">
                        <!-\-<div class="wrapper" id="wrapper-hero-content" >
                            <div class="container hero-dark" id="wrapper-hero-inner" tabindex="-1">-\->
                                <div id="audenIndexCarousel" 
                                    class="carousel slide" 
                                    data-ride="carousel">
                                    <ol class="carousel-indicators">
                                        <li data-target="#audenIndexCarousel" 
                                            data-slide-to="0" class="active"></li>
                                        <li data-target="#audenIndexCarousel" 
                                            data-slide-to="1"></li>
                                        <li data-target="#audenIndexCarousel" 
                                            data-slide-to="2"></li>
                                    </ol>
                                    <div class="carousel-inner">
                                        <div class="carousel-item active">
                                            <img src="img/Kopistenanzeigen.jpg" 
                                                class="d-block w-100" 
                                                alt="..."/>
                                            <div class="carousel-caption d-none d-md-block" 
                                                style="background-image: linear-gradient(rgba(38.0, 35.3, 37.6, 0.5), rgba(38.0, 35.3, 37.6, 0.5));">
                                                <h1><xsl:value-of select="$project_title"/></h1>
                                                <h2><xsl:value-of select="$project_short_title"/></h2>
                                                <p>
                                                    Bruckner Kopisten 
                                                    <strong>
                                                        <xsl:value-of select="$project_short_title"/>
                                                    </strong>
                                                </p>
                                                <button class="btn btn-round">
                                                    <a href="01-introduction.html">Weiterlesen</a>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="carousel-item">
                                            <img src="img/datenbank.jpg" 
                                                class="d-block w-100" 
                                                alt="..."/>
                                            <div class="carousel-caption d-none d-md-block" 
                                                style="background-image: linear-gradient(rgba(38.0, 35.3, 37.6, 0.5), rgba(38.0, 35.3, 37.6, 0.5));">
                                                <h1>Gesamtbestand aller Kopisten</h1>
                                                <!-\-<p>Some representative placeholder content for the second slide.</p>-\->
                                                <button class="btn btn-round">
                                                    <a href="toc.html">Weiterlesen</a>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="carousel-item">
                                            <img src="img/projekt.jpg" 
                                                class="d-block w-100" 
                                                alt="..."/>
                                            <div class="carousel-caption d-none d-md-block" 
                                                style="background-image: linear-gradient(rgba(38.0, 35.3, 37.6, 0.5), rgba(38.0, 35.3, 37.6, 0.5));">
                                                <h1>Über das Projekt</h1>
                                                <!-\-<h2>Example Subtitle Slide 2</h2>
                                                <h5>Second slide label</h5>
                                                <p>Some representative placeholder content for the second slide.</p>-\->
                                                <button class="btn btn-round">
                                                    <a href="about.html">Weiterlesen</a>
                                                </button>
                                            </div>
                                        </div>                                        
                                    </div>
                                </div>
                            <!-\-</div>
                        </div>-\->                        
                    </div>-->
                    <div class="container-fluid mb-0"
                         style="margin-top:4em;">
                        <xsl:variable name="about" 
                            select="doc('../data/meta/about.xml')//tei:TEI"/>
                        <div class="row">
                            <div class="col-md-7" 
                                style="margin: 0 auto;">
                                <h1 class="text-center mb-4 small-caps fw-399">
                                    <xsl:value-of select="//tei:body/tei:head"/>
                                </h1>
                                <xsl:for-each select="//tei:body/tei:p">
                                    <xsl:choose>
                                        <xsl:when test="position() = 1">
                                            <p id="about-position-{position()}" 
                                               class="p-index">
                                                <xsl:apply-templates/>
                                            </p>                                            
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <p class="fade about-text-hidden p-index" 
                                               id="about-text-{position()}" 
                                               >
                                                <xsl:apply-templates/>
                                            </p>
                                        </xsl:otherwise>
                                    </xsl:choose>                                    
                                </xsl:for-each> 
                                <p class="d-flex justify-content-end" style="margin-right: 2rem;">
                                    <a id="show-text" style="cursor:pointer;color:#ab1923;">
                                        mehr anzeigen
                                    </a>
                                </p>
                                <script type="text/javascript">
                                    $('#show-text').click(function () {
                                        if ($('.about-text-hidden').hasClass('fade') == true) {
                                            $('.about-text-hidden').removeClass('fade')
                                            .addClass('active');
                                            $(this).html('weniger anzeigen');
                                        } else {
                                            $('.about-text-hidden').removeClass('active')
                                            .addClass('fade');
                                            $(this).html('mehr anzeigen');
                                        }  
                                    });
                                </script>
                            </div>                          
                        </div>
                    </div>
                    <div class="container col-7" 
                        style="margin:1em auto 3em auto;">
                        <div class="row">
                            <div class="col-md-12">
                                <a href="toc.html" 
                                    class="index-link">  
                                    <div class="card index-card">
                                        <div class="card-body picture-box" 
                                            style="padding:0;">
                                            <img src="img/Kopistenanzeigen.jpg" 
                                                class="d-block w-100" 
                                                alt="..."/>
                                        </div>
                                        <div class="card-header">                                            
                                            <h5 class="fw-399">
                                                Gesamtbestand aller Kopisten
                                            </h5>                                            
                                        </div>
                                    </div>                                    
                                </a>
                            </div>
                            <div class="col-md-4">
                                <a href="Tabelle_1.html" 
                                    class="index-link">                                   
                                    <div class="card index-card">
                                        <div class="card-body picture-box" 
                                            style="padding:0;">
                                            <img src="img/Thumbnail_Primärquellen.jpg" 
                                                class="d-block w-100" alt="..."/>
                                        </div>
                                        <div class="card-header">                                            
                                            <h5 class="fw-399">
                                                Kopisten der Primärquellen
                                            </h5>                                            
                                        </div>
                                    </div>                                     
                                </a>                                    
                            </div>
                            <div class="col-md-4">
                                <a href="Tabelle_2.html" 
                                    class="index-link">                                                     
                                    <div class="card index-card">
                                        <div class="card-body picture-box" 
                                            style="padding:0;">
                                            <img src="img/Sekundärquellen_Thumbnail.jpg" 
                                                class="d-block w-100" 
                                                alt="..."/>
                                        </div>
                                        <div class="card-header">                                            
                                            <h5 class="fw-399">
                                                Kopisten der Sekundärquellen
                                            </h5>                                            
                                        </div>
                                    </div>                                 
                                </a>
                            </div>
                            <div class="col-md-4">
                                <a href="Tabelle_3.html" 
                                    class="index-link">  
                                    <div class="card index-card">
                                        <div class="card-body picture-box" 
                                            style="padding:0;">
                                            <img src="img/Landkarte.jpg" 
                                                class="d-block w-100" 
                                                alt="..."/>
                                        </div>
                                        <div class="card-header">                                            
                                            <h5 class="fw-399">
                                                Kopisten der Werke Bruckners außerhalb Wiens
                                            </h5>                                            
                                        </div>
                                    </div>                                    
                                </a>
                            </div>
                            <div class="col-md-4">
                                <a href="Tabelle_4.html" 
                                    class="index-link">  
                                    <div class="card index-card">
                                        <div class="card-body picture-box" 
                                            style="padding:0;">
                                            <img src="img/Chronologie_Thumbnail.jpg" 
                                                class="d-block w-100" 
                                                alt="..."/>
                                        </div>
                                        <div class="card-header">                                            
                                            <h5 class="fw-399">
                                                Zeitraum der Kopiertätigkeit der Kopisten zu Bruckners Lebzeiten
                                            </h5>                                            
                                        </div>
                                    </div>                                    
                                </a>
                            </div>                            
                            <div class="col-md-4">
                                <a href="search.html" 
                                    class="index-link">  
                                    <div class="card index-card">
                                        <div class="card-body picture-box" 
                                            style="padding:0;">
                                            <img src="img/Wien.jpg" 
                                                class="d-block w-100" 
                                                alt="..."/>
                                        </div>
                                        <div class="card-header">                                            
                                            <h5 class="fw-399">
                                                Suche
                                            </h5>                                            
                                        </div>
                                    </div>                                    
                                </a>
                            </div>
                            <div class="col-md-4">
                                <a href="kopist-comparison.html" 
                                    class="index-link">  
                                    <div class="card index-card">
                                        <div class="card-body picture-box" 
                                            style="padding:0;">
                                            <img src="img/datenbank.jpg" 
                                                class="d-block w-100" 
                                                alt="..."/>
                                        </div>
                                        <div class="card-header">                                            
                                            <h5 class="fw-399">
                                                Handschriftenvergleich
                                            </h5>                                            
                                        </div>
                                    </div>                                    
                                </a>
                            </div>
                        </div>
                    </div>
                    <xsl:call-template name="html_footer"/>
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
                    <xsl:attribute name="href">                        
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>