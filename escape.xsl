<xsl:stylesheet
 version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:ext="http://exslt.org/common"
 exclude-result-prefixes="ext">

  <xsl:template match="*" mode="escape">
    <xsl:text>&lt;</xsl:text>
      <xsl:value-of select="name()" />
      <xsl:apply-templates mode="escape" select="@*" />
    <xsl:text>&gt;</xsl:text>
    <xsl:apply-templates mode="escape" />
    <xsl:text>&lt;/</xsl:text>
      <xsl:value-of select="name()" />
    <xsl:text>&gt;</xsl:text>
  </xsl:template>

  <xsl:template match="@*" mode="escape">
    <xsl:text> </xsl:text>
    <xsl:value-of select="name()" />
    <xsl:text>="</xsl:text>
      <xsl:value-of select="." />
    <xsl:text>"</xsl:text>
  </xsl:template>

</xsl:stylesheet>
