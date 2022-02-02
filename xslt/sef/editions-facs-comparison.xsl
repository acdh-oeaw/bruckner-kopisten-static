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
    
    <xsl:template match="/">
        <xsl:for-each select="//tei:list">
            <ul><xsl:apply-templates/></ul>
        </xsl:for-each>                        
    </xsl:template>    
    
    <xsl:template match="tei:item">   
        <li>
            <h6>
                <xsl:value-of select="
                    ./tei:title[@xml:lang='de']"/>
                | 
                <xsl:value-of select="./tei:title[@xml:lang='eng']"/>
            </h6>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
    <xsl:template match="tei:figure">
        <xsl:param name="iiif-ext" select="'full/full/0/default.jpg'"/>     
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

</xsl:transform>	

