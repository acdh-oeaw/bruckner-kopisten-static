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
    <xsl:template match="/">
        <xsl:variable name="doc_title" select="'Impressum'"/>
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
                        <div class="card">
                            <div class="card-header">
                                <h1><xsl:value-of select="$doc_title"/></h1>
                            </div>                            
                            <div class="card-body">
                                <div id="d6e130">
                                    
                                    
                                    <h2>Bildnachweise</h2>
                                    
                                    <p id="d6e138">
                                        Bildausschnitt <span style="font-style:italic;">Copist Hlawaczek</span>: Autographe
                                        Eintragung in Bruckners Taschenkalender, in: Akademischer Kalender
                                        der Österreichischen Hochschulen für das Studienjahr 1879.
                                        Aufbewahrungsort: Musiksammlung der Österreichischen
                                        Nationalbibliothek, Signatur: <a target="_blank" href="https://data.onb.ac.at/rec/AC14012099">Mus.Hs.3178/a/1</a>, fol. 13r.
                                        <br />
                                        Collage <span style="font-style:italic;">Sekundärquellen</span>: Zusammenstellung
                                        der Verfasser mit den Quellen A-SF20-41a, A-Wn Mus.Hs. 19717, A-Wn
                                        Mus.Hs. 33157 und A-Wn Mus.Hs. 41004.
                                        <br />
                                        Kartenausschnitt <span style="font-style:italic;">Oberösterreich</span> aus: Karte
                                        des Erzherzogthums Oesterreich ob und unter der Enns. Westlicher
                                        Theil. Entw. u. gez. v. Major Radefeld. 1849, in: Grosser Hand-Atlas
                                        über alle Theile der Erde in 170 Karten. Herausgegeben von J. Meyer.
                                        Hildburghausen Verlag des Bibliographischen Instituts 1860,
                                        Reproduktion von: Stanford University Libraries, David Rumsey Map
                                        Collection, Signatur: <a target="_blank" href="https://purl.stanford.edu/yv048gy3228">G1019 .M4 1860
                                            F</a>, S. 67
                                        <br />
                                        Kalenderblätter: Seiten aus Bruckners Taschenkalender, in:
                                        Fromme's Oesterreichischer Hochschulen-Kalender für Professoren und
                                        Studirende für das Schuljahr 1885/86. Aufbewahrungsort:
                                        Musiksammlung der Österreichischen Nationalbibliothek, Signatur:
                                        <a target="_blank" href="https://data.onb.ac.at/rec/AC14012108">Mus.Hs.3178/b/2</a>, fol. 528v und 531r.
                                        <br />
                                        Collage <span style="font-style:italic;">Kopisten-Annoncen</span>: Zusammenstellung
                                        der Verfasser anhand von Zeitungsausschnitten aus dem virtuellen
                                        Zeitungslesesaal der Österreichischen Nationalbibliothek: <a target="_blank" href="https://anno.onb.ac.at/">ANNO</a>.
                                        <br />
                                        Kartenausschnitt <span style="font-style:italic;">Wien</span> aus: Monumental-Plan
                                        der Haupt- und Residenzstadt Wien: Vom Arsenal bis zum Kahlenberg -
                                        von der Sternwarte bis zu den Kaisermühlen, verf. von Ladislaus
                                        Eugen Petrovits, Wien 1887. Reproduktion von: Wienbibliothek im
                                        Rathaus, Depot Rathaus, Signautr: <a target="_blank" href="https://resolver.obvsg.at/urn:nbn:at:AT-WBR-46343">k-19215</a>.
                                        <br />
                                        Werk-Datenbank (Karteikästen): Dreamstime LLC, 1616 Westgate
                                        Circle, Brentwood, TN 37027, United States.
                                        
                                    </p>
                                    
                                    <h2>Urheberrechtlicher Hinweis</h2>
                                    
                                    <p id="d6e214">Die durch die ÖAW auf diesen Seiten erstellten Inhalte und Werke unterliegen
                                        dem österreichischen Urheberrecht. Die Vervielfältigung, Bearbeitung,
                                        Verbreitung und jede Art der Verwertung außerhalb der Grenzen des
                                        Urheberrechtes bedürfen der schriftlichen Zustimmung des jeweiligen Autors
                                        bzw. Erstellers. Downloads und Kopien dieser Seite sind nur für den
                                        privaten, nicht kommerziellen Gebrauch gestattet. Soweit die Inhalte auf
                                        dieser Seite nicht vom Betreiber erstellt wurden, werden die Urheberrechte
                                        Dritter beachtet. Insbesondere werden Inhalte Dritter als solche
                                        gekennzeichnet. Die Bildrechte an den Digitalisaten (Farbabbildungen) von
                                        Musikhandschriften liegen bei den Eigentümern der originalen Quellen.</p>
                                    
                                </div>
                                <xsl:for-each select=".//div">
                                    <xsl:copy>
                                        <xsl:copy-of select="."/>
                                    </xsl:copy>
                                </xsl:for-each>     
                            </div>
                        </div>
                    </div>
                    
                    <xsl:call-template name="html_footer"/>
                    
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>