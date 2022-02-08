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
        <xsl:for-each select="//tei:list[not(parent::tei:p[@decls])]">
            <div class="comparison-result">
                <h3>
                    <xsl:apply-templates select="//tei:head[
                        not(ancestor::tei:p[@decls]) and 
                        not(parent::tei:table)]"/>
                </h3>
                <ul>
                    <xsl:apply-templates select="//tei:item[
                        not(ancestor::tei:p[@decls])]"/>
                </ul> 
            </div>            
        </xsl:for-each>    
    </xsl:template>    
    
    <xsl:template match="tei:head[
        not(ancestor::tei:p[@decls]) and 
        not(parent::tei:table)]">
        <legend><xsl:apply-templates/></legend>
    </xsl:template>
    
    <xsl:template match="tei:item[not(ancestor::tei:p[@decls])]">   
        <xsl:for-each select="./tei:title">
            <h6><xsl:apply-templates/></h6>
        </xsl:for-each>
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
    <xsl:template match="tei:figure">
        <xsl:apply-templates/>   
    </xsl:template>
    
    <xsl:template match="tei:graphic">
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
    </xsl:template>
    
    <xsl:template match="tei:title">
        
    </xsl:template>
    
    <xsl:template match="tei:ref[parent::tei:head]">
        <span>
            <a title="{.}" target="_blank">
                <xsl:attribute name="href">
                    <xsl:value-of select="concat(
                        'https://iiif.acdh.oeaw.ac.at/bruckner-kopisten/', 
                        replace(@target, '.jpg', '/full/full/0/default.jpg'))"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
            </a>
        </span>        
    </xsl:template>

</xsl:transform>	

