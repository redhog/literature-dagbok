<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ms="urn:schemas-microsoft-com:xslt"
  xmlns:ap="http://xml.apache.org/xalan"
  xmlns:ex="http://exslt.org/common"
  extension-element-prefixes="ex"
  >

  <xsl:output indent="yes" method="xml" />

  <xsl:include href ="DateFormatting.xslt" />

  <!--  
  BEGIN TEST TEMPLATES
  -->

  <xsl:template match="/">
    <Results>
      <Support>
        <Supports name="ms:node-set">
          <xsl:value-of select="function-available('ms:node-set')"/>
        </Supports>
        <Supports name="ap:nodeset">
          <xsl:value-of select="function-available('ap:nodeset')"/>
        </Supports>
        <Supports name="ex:node-set">
          <xsl:value-of select="function-available('ex:node-set')"/>
        </Supports>
        <Supports name="abc">
          <xsl:value-of select="function-available('abc')"/>
        </Supports>
      </Support>
      <xsl:apply-templates select="//Test" />
    </Results>
  </xsl:template>

  <xsl:template match="//Test[@name='ParseFormat']">
    <Test>
      <Input>
        <xsl:copy-of select="." />
      </Input>
      <Result>
        <xsl:call-template name="ParseFormat">
          <xsl:with-param name="format" select="." />
        </xsl:call-template>
      </Result>
    </Test>
  </xsl:template>

  <xsl:template match="//Test[@name='ParseDate']">
    <Test>
      <Input>
        <xsl:copy-of select="." />
      </Input>
      <Result>
        <xsl:call-template name="ParseDate">
          <xsl:with-param name="formatString" select="./@format" />
          <xsl:with-param name="dateTimeString" select="string(./text())" />
        </xsl:call-template>
      </Result>
    </Test>
  </xsl:template>

  <xsl:template match="//Test[@name='FormatDate']">
    <xsl:variable name="result">
        <xsl:call-template name="FormatDate">
          <xsl:with-param name="inputFormatString" select="./@inputformat" />
          <xsl:with-param name="outputFormatString" select="./@outputformat" />
          <xsl:with-param name="dateTimeString" select="string(./text())" />
        </xsl:call-template>
    </xsl:variable>
    <Test>
      <xsl:attribute name="result">
        <xsl:choose>
          <xsl:when test="$result != ./@expectedResult">Failed</xsl:when>
          <xsl:when test="$result = ./@expectedResult">Passed</xsl:when>
          <xsl:otherwise>No idea...</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <Input>
        <xsl:copy-of select="." />
      </Input>
      <Result>
        <xsl:value-of select="$result"/>
      </Result>
    </Test>

  </xsl:template>

  <xsl:template match="//Test[@name='DaysSinceEpoch']">
    <xsl:variable name="result">
      <xsl:call-template name="CalculateTotalDaysSinceEpoch">
        <xsl:with-param name="formatString" select="@format" />
        <xsl:with-param name="dateString" select="./text()" />
      </xsl:call-template>
    </xsl:variable>
    <Test>
      <xsl:attribute name="result">
        <xsl:choose>
          <xsl:when test="$result != ./@expectedResult">Failed</xsl:when>
          <xsl:when test="$result = ./@expectedResult">Passed</xsl:when>
          <xsl:otherwise>No idea...</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <Input>
        <xsl:copy-of select="." />
      </Input>
      <Result>
        <xsl:value-of select="$result"/>
      </Result>
    </Test>
  </xsl:template>

  <xsl:template match="//Test[@name='DayOfWeek']">
    <xsl:variable name="result">
      <xsl:call-template name="CalculateDayOfWeek">
        <xsl:with-param name="formatString" select="@format" />
        <xsl:with-param name="dateString" select="./text()" />
      </xsl:call-template>
    </xsl:variable>
    <Test>
      <xsl:attribute name="result">
        <xsl:choose>
          <xsl:when test="$result != ./@expectedResult">Failed</xsl:when>
          <xsl:when test="$result = ./@expectedResult">Passed</xsl:when>
          <xsl:otherwise>No idea...</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <Input>
        <xsl:copy-of select="." />
      </Input>
      <Result>
        <xsl:value-of select="$result"/>
      </Result>
    </Test>
  </xsl:template>

</xsl:stylesheet>