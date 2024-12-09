<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:template match="/">
        <xliff version="1.2"
               xmlns="urn:oasis:names:tc:xliff:document:1.2">
            <xsl:element name="file">
                <xsl:attribute name="source-language">en</xsl:attribute>
                <xsl:attribute name="target-language">en</xsl:attribute>
                <xsl:attribute name="datatype">plaintext</xsl:attribute>
                <body>                    
                    <xsl:for-each select="/infotexts/*">
                        
                        <xsl:element name="trans-unit">
                            <xsl:attribute name="id">
                                <xsl:value-of select="concat(name(.), '.gno', string(position()))"/>
                            </xsl:attribute>
                            
                            <xsl:element name="source">
                            </xsl:element>
                            <xsl:element name="target">
                                <xsl:value-of select="(.)"/>
                            </xsl:element>
                        </xsl:element>
                        
                    </xsl:for-each>
                    
                </body>
            </xsl:element>
        </xliff>
    </xsl:template>
    
</xsl:stylesheet>