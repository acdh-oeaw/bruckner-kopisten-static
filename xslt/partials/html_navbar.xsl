<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl tei xs" version="2.0">
    <xsl:template match="/" name="nav_bar">
        <div class="wrapper-fluid wrapper-navbar sticky-navbar" id="wrapper-navbar" >
            <a class="skip-link screen-reader-text sr-only" href="#content">Skip to content</a>
            <nav class="navbar navbar-expand-lg navbar-light" style="margin-right:0!important;">
                <div class="container">                    
                    <!-- Your site title as branding in the menu -->
                    <a href="http://www.bruckner-online.at" class="navbar-brand custom-logo-link" rel="home" itemprop="url"><img src="{$project_logo}" class="img-fluid" title="{$project_short_title}" alt="{$project_short_title}" itemprop="logo" /></a><!-- end custom logo -->
                    <a class="navbar-brand site-title-with-logo" rel="home" href="http://www.bruckner-online.at" title="{$project_short_title}" itemprop="url"><!--<xsl:value-of select="$project_short_title"/>--></a>
                    <span class="badge bg-light text-dark">BETA</span>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-end justify-content-bottom" id="navbarNavDropdown">
                        <!-- Your menu goes here -->
                        <ul id="main-menu" class="navbar-nav" style="margin-right:0!important;">
                            <li class="nav-item dropdown">
                                <a title="Papers" href="#" data-toggle="dropdown" class="nav-link dropdown-toggle">Projektbeschreibung <span class="caret"></span></a>
                                <ul class=" dropdown-menu" role="menu" style="width:16rem;">
                                    <!--<li class="nav-item dropdown-submenu">
                                        <a title="Über das Projekt" href="about.html" class="nav-link">Über das Projekt</a>
                                    </li>-->
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Über das Projekt" href="index.html" class="nav-link">Über das Projekt</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Einleitung" href="01-introduction.html" class="nav-link">Einleitung</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Benutzerhinweise und Anlage" href="02-userguide.html" class="nav-link">Benutzerhinweise und Anlage</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Methodik" href="03-methodology.html" class="nav-link">Methodik</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Nachtrag der Verfasser" href="04-authors_note.html" class="nav-link">Nachtrag der Verfasser</a>
                                    </li>
                                </ul>                                
                            </li>
                            <li class="nav-item dropdown">
                                <a title="Indexes" href="#" data-toggle="dropdown" class="nav-link dropdown-toggle">Katalogzugänge<span class="caret"></span></a>
                                <ul class=" dropdown-menu" role="menu" style="width:16rem;">
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Kopisten gesamt" href="toc.html" class="nav-link">Gesamtbestand aller Kopisten</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Kopisten nach Werk" href="toc.html" class="nav-link">Kopisten nach Werk</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Kopisten der Primärquellen" href="Tabelle_1.html" class="nav-link">Kopisten der Primärquellen</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Kopisten der Sekundärquellen" href="Tabelle_2.html" class="nav-link">Kopisten der Sekundärquellen</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Kopisten der Werke Bruckners außerhalb
                                            Wiens" href="Tabelle_3.html" class="nav-link">Kopisten der Werke Bruckners außerhalb
                                            Wiens</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Zeitraum der Kopiertätigkeit der Kopisten zu Bruckners Lebzeiten" 
                                           href="Tabelle_4.html" class="nav-link">Zeitraum der Kopiertätigkeit der Kopisten zu Bruckners Lebzeiten</a>
                                    </li>
                                </ul>                                
                            </li>                            
                            <li class="nav-item">
                                <a title="Datenbanksuche" href="search.html" class="nav-link">Suche</a>
                            </li>
                            <li class="nav-item">
                                <a title="Vergleich" href="kopist-comparison.html" class="nav-link">Handschriftenvergleich</a>
                            </li>   
                            <!--<li class="nav-item">
                                <a title="Bruckner Online" href="http://www.bruckner-online.at" class="nav-link">Bruckner-Online</a>
                            </li>-->
                        </ul>                        
                        <!--<form class="form-inline my-2 my-lg-0 navbar-search-form" method="get" action="search.html" role="search">
                            <input class="form-control navbar-search" id="s" name="q" type="text" placeholder="Search" value="" autocomplete="off" />
                            <button type="submit" class="navbar-search-icon">
                                <i data-feather="search"></i>
                            </button>
                        </form>-->
                    </div>
                    <!-- .collapse navbar-collapse -->                    
                </div>
                <!--<div id="k-functional-wrap">
                    <nav class="k-functional-navig">
                        <div class="menu-functional-container">
                            <ul id="menu-functional" class="pull-right">
                                <li class="list-inline">
                                    <a title="Kontakt" href="05-contact.html">Kontakt</a>
                                </li>
                                <li class="list-inline">
                                    <a title="Impressum" href="imprint.html">Impressum</a>
                                </li>
                            </ul>
                            
                        </div>
                    </nav>    
                </div>-->
                <!-- .container -->
            </nav>
            <!-- .site-navigation -->
        </div>
    </xsl:template>
</xsl:stylesheet>