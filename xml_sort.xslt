<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/infotexts">
        <infotexts>
            <xsl:apply-templates>
                <xsl:sort select="name()"></xsl:sort>
            </xsl:apply-templates>
        </infotexts>
    </xsl:template>
    
</xsl:stylesheet>