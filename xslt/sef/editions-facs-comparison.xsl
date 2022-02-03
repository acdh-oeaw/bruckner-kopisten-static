<xsl:transform
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ixsl="http://saxonica.com/ns/interactiveXSLT"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:da="http://declarative.amsterdam/saxonjs"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    extension-element-prefixes="ixsl"
    expand-text="yes"
    version="3.0">
    
    <xsl:import href="../partials/add_modal-metadata.xsl"/>
    
    <xsl:template match="/">
        <xsl:for-each select="//tei:list">
            <div class="comparison-result">
                <legend>
                    <xsl:apply-templates select="//tei:head[parent::tei:list]"/>
                </legend>
                <ul>
                    <xsl:apply-templates select="//tei:item"/>
                </ul> 
            </div>            
        </xsl:for-each>    
        <xsl:call-template name="modal-metadata"/>
    </xsl:template>    
    
    <xsl:template match="tei:head[parent::tei:list]">
        <h3><xsl:value-of select="text()"/></h3>
        <xsl:for-each select="./tei:ref">
            <a href="#" data-toggle="modal" data-target="#img-modal">
                <xsl:value-of select="text()"/>
            </a>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="tei:item">   
        <li>
            <h6>
                <xsl:value-of select="./tei:title[@xml:lang='de']"/>
                | 
                <xsl:value-of select="./tei:title[@xml:lang='eng']"/>
            </h6>
            <xsl:apply-templates select="//tei:figure"/>
        </li>
    </xsl:template>
    
    <xsl:template match="tei:figure">
        <xsl:for-each select="./tei:graphic">
            <xsl:variable name="source" select="data(tokenize(@url, '/'))"/>
            <div class="img-notes">
                <img class="tei-xml-images">
                    <xsl:attribute name="src">
                        <xsl:value-of select="concat(
                            'https://iiif.acdh.oeaw.ac.at/bruckner-kopisten/', 
                            replace($source[last()], '.png', '/full/full/0/default.jpg'))"/>
                    </xsl:attribute>
                </img>
            </div>
        </xsl:for-each>        
    </xsl:template>
    
    <xsl:template match="tei:ref[parent::tei:head[@xml:lang='de']]">
        <div class="img-notes">
            <h3><xsl:apply-templates/></h3>
            <img class="tei-xml-images" title="{.}">
                <xsl:attribute name="src">
                    <xsl:value-of select="concat(
                        'https://iiif.acdh.oeaw.ac.at/bruckner-kopisten/', 
                        replace(@target, '.jpg', '/full/full/0/default.jpg'))"/>
                </xsl:attribute>
            </img>            
        </div>
    </xsl:template>

</xsl:transform>	

