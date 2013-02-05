<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ms="urn:schemas-microsoft-com:xslt"
  xmlns:ap="http://xml.apache.org/xalan"
  xmlns:ex="http://exslt.org/common"
  extension-element-prefixes="ex"
  >

  <xsl:output indent="yes" method="xml" />

  <!-- GLOBAL PARAMETERS -->
  <xsl:param name="defaultFormat" select="yyy-mm-dd" />
  <xsl:param name="defaultCentury" select="20" />
  <xsl:param name="defaultYear" select="10" />
  <xsl:param name="defaultMonth" select="01" />
  <xsl:param name="defaultDate" select="01" />
  <xsl:variable name="DateTokens" >
    <DateTokens>
      <Token name="short-year"          length="2"  >yy</Token>
      <Token name="long-year"           length="4"  >yyy</Token>
      <Token name="short-numeric-month" length="-1" >m</Token>
      <Token name="long-numeric-month"  length="2"  >mm</Token>
      <Token name="short-month-name"    length="3"  >mmm</Token>
      <Token name="long-month-name"     length="-1" >mmmm</Token>
      <Token name="short-date"          length="-1" >d</Token>
      <Token name="long-date"           length="2"  >dd</Token>
      <Token name="short-day-of-week"   length="3"  >ww</Token>
      <Token name="long-day-of-week"    length="-1" >www</Token>
    </DateTokens>
  </xsl:variable>


  <!-- DATE MATH -->
  <xsl:template name="CalculateDayOfWeek">
    <xsl:param name="formatString" />
    <xsl:param name="dateString" />
    <xsl:variable name="dateValues">
      <xsl:call-template name="ParseDate">
        <xsl:with-param name="formatString" select="$formatString" />
        <xsl:with-param name="dateTimeString" select="$dateString" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="function-available('ms:node-set')">
        <xsl:call-template name="_CalculateDayOfWeek">
          <xsl:with-param name="date" select="ms:node-set($dateValues)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="function-available('ex:node-set')">
        <xsl:call-template name="_CalculateDayOfWeek">
          <xsl:with-param name="date" select="ex:node-set($dateValues)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="function-available('ap:node-set')">
        <xsl:call-template name="_CalculateDayOfWeek">
          <xsl:with-param name="date" select="ap:node-set($dateValues)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="_CalculateDayOfWeek">
          <xsl:with-param name="date" select="$dateValues" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CalculateTotalDaysSinceEpoch">
    <xsl:param name="formatString" />
    <xsl:param name="dateString" />
    <xsl:variable name="dateValues">
      <xsl:call-template name="ParseDate">
        <xsl:with-param name="formatString" select="$formatString" />
        <xsl:with-param name="dateTimeString" select="$dateString" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="function-available('ms:node-set')">
        <xsl:call-template name="_CalculateTotalDaysSinceEpoch">
          <xsl:with-param name="dateTime" select="ms:node-set($dateValues)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="function-available('ex:node-set')">
        <xsl:call-template name="_CalculateTotalDaysSinceEpoch">
          <xsl:with-param name="dateTime" select="ex:node-set($dateValues)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="function-available('ap:node-set')">
        <xsl:call-template name="_CalculateTotalDaysSinceEpoch">
          <xsl:with-param name="dateTime" select="ap:node-set($dateValues)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="_CalculateTotalDaysSinceEpoch">
          <xsl:with-param name="dateTime" select="$dateValues" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CalculateTotalSecondsSinceEpoch">
    <xsl:param name="formatString" />
    <xsl:param name="dateString" />
    <xsl:variable name="dateValues">
      <xsl:call-template name="ParseDate">
        <xsl:with-param name="formatString" select="$formatString" />
        <xsl:with-param name="dateTimeString" select="$dateString" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="function-available('ms:node-set')">
        <xsl:call-template name="_CalculateTotalSecondsSinceEpoch">
          <xsl:with-param name="date" select="ms:node-set($dateValues)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="function-available('ex:node-set')">
        <xsl:call-template name="_CalculateTotalSecondsSinceEpoch">
          <xsl:with-param name="date" select="ex:node-set($dateValues)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="function-available('ap:node-set')">
        <xsl:call-template name="_CalculateTotalSecondsSinceEpoch">
          <xsl:with-param name="date" select="ap:node-set($dateValues)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="_CalculateTotalSecondsSinceEpoch">
          <xsl:with-param name="date" select="$dateValues" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CalculateDayOfYear">
    <xsl:param name="formatString" />
    <xsl:param name="dateString" />
    <xsl:variable name="dateValues">
      <xsl:call-template name="ParseDate">
        <xsl:with-param name="formatString" select="$formatString" />
        <xsl:with-param name="dateTimeString" select="$dateString" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="function-available('ms:node-set')">
        <xsl:call-template name="_CalculateDayOfYear">
          <xsl:with-param name="date" select="ms:node-set($dateValues)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="function-available('ex:node-set')">
        <xsl:call-template name="_CalculateDayOfYear">
          <xsl:with-param name="date" select="ex:node-set($dateValues)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="function-available('ap:node-set')">
        <xsl:call-template name="_CalculateDayOfYear">
          <xsl:with-param name="date" select="ap:node-set($dateValues)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="_CalculateDayOfYear">
          <xsl:with-param name="date" select="$dateValues" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CalculateIsLeapYear">
    <xsl:param name="year" />
    <xsl:variable name="isDivBy4" select="$year mod 4" />
    <xsl:variable name="isCentury" select="$year mod 100" />
    <xsl:variable name="is400Century" select="$year mod 400" />
    <xsl:choose>
      <xsl:when test="$is400Century = 0">1</xsl:when>
      <xsl:when test="$isCentury = 0">0</xsl:when>
      <xsl:when test="$isDivBy4 = 0">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="_CalculateDayOfWeek">
    <xsl:param name="date" />
    <xsl:variable name="daysSinceEpoch">
      <xsl:call-template name="_CalculateTotalDaysSinceEpoch">
        <xsl:with-param name="dateTime" select="$date" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="($daysSinceEpoch mod 7) + 1"/>
  </xsl:template>

  <xsl:template name="_CalculateTotalDaysSinceEpoch">
    <xsl:param name="dateTime" />
    <xsl:variable name="year">
      <xsl:choose>
        <xsl:when test="$dateTime//DateValue[@name='year']">
          <xsl:value-of select="number($dateTime//DateValue[@name='year']/text())"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="number(concat($defaultCentury,$defaultYear))"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="dayOfYear">
      <xsl:call-template name="_CalculateDayOfYear">
        <xsl:with-param name="dateTime" select="$dateTime" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="leapYears" select="floor(($year - 1) div 4) - floor(($year - 1) div 100) + floor(($year - 1) div 400)" />
    <xsl:value-of select="(($year) * 365) + $dayOfYear + $leapYears - 1"/>
  </xsl:template>

  <xsl:template name="_CalculateTotalSecondsSinceEpoch">
    <xsl:param name="dateTime" />
    <xsl:variable name="daysSinceEpoch" >
      <xsl:call-template name="_CalculateTotalDaysSinceEpoch">
        <xsl:with-param name="dateTime" select="$dateTime" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="$daysSinceEpoch * 24 * 60 * 60"/>
  </xsl:template>

  <xsl:template name="_CalculateDayOfYear">
    <xsl:param name="dateTime" />
    <xsl:variable name="month">
      <xsl:choose>
        <xsl:when test="$dateTime//DateValue[@name='month']">
          <xsl:value-of select="$dateTime//DateValue[@name='month']/text()"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$defaultMonth"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="date">
      <xsl:choose>
        <xsl:when test="$dateTime//DateValue[@name='date']">
          <xsl:value-of select="$dateTime//DateValue[@name='date']/text()"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$defaultDate"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="monthDays">
      <xsl:choose>
        <xsl:when test="$month = '01'">0</xsl:when>
        <xsl:when test="$month = '02'">31</xsl:when>
        <xsl:when test="$month = '03'">59</xsl:when>
        <xsl:when test="$month = '04'">90</xsl:when>
        <xsl:when test="$month = '05'">120</xsl:when>
        <xsl:when test="$month = '06'">151</xsl:when>
        <xsl:when test="$month = '07'">181</xsl:when>
        <xsl:when test="$month = '08'">212</xsl:when>
        <xsl:when test="$month = '09'">243</xsl:when>
        <xsl:when test="$month = '10'">273</xsl:when>
        <xsl:when test="$month = '11'">304</xsl:when>
        <xsl:when test="$month = '12'">334</xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="leapYear" >
      <xsl:call-template name="CalculateIsLeapYear">
        <xsl:with-param name="year" select="$dateTime//DateValue[@name='year']/text()" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="extraDay">
      <xsl:choose>
        <xsl:when test="$month > 2">
          <xsl:value-of select="$leapYear" />
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="$monthDays + $date + $extraDay" />
  </xsl:template>



  <!-- DATE FORMATTING TEMPLATES -->
  <xsl:template name="FormatDate">
    <xsl:param name="inputFormatString" select="$defaultFormat" />
    <xsl:param name="outputFormatString" select="$defaultFormat" />
    <xsl:param name="dateTimeString" />
    <xsl:variable name="dateValues">
      <xsl:call-template name="ParseDate">
        <xsl:with-param name="formatString" select="$inputFormatString" />
        <xsl:with-param name="dateTimeString" select="$dateTimeString" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="outputFormat">
      <xsl:call-template name="ParseFormat">
        <xsl:with-param name="format" select="$outputFormatString" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="function-available('ms:node-set')">
        <xsl:call-template name="_FormatDateOutput">
          <xsl:with-param name="format" select="ms:node-set($outputFormat)" />
          <xsl:with-param name="date" select="ms:node-set($dateValues)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="function-available('ex:node-set')">
        <xsl:call-template name="_FormatDateOutput">
          <xsl:with-param name="format" select="ex:node-set($outputFormat)" />
          <xsl:with-param name="date" select="ex:node-set($dateValues)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="function-available('ap:node-set')">
        <xsl:call-template name="_FormatDateOutput">
          <xsl:with-param name="format" select="ap:node-set($outputFormat)" />
          <xsl:with-param name="date" select="ap:node-set($dateValues)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="_FormatDateOutput">
          <xsl:with-param name="format" select="$outputFormat" />
          <xsl:with-param name="date" select="$dateValues" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="_FormatDateOutput">
    <xsl:param name="format" />
    <xsl:param name="date" />
    <xsl:for-each select="$format//Token | $format//Delimiter">
      <xsl:sort select="number(@index)" data-type="number" order="ascending" />
      <xsl:choose>
        <xsl:when test="name() = 'Delimiter'">
          <xsl:value-of select="./text()"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates mode="_FormatDateValues" select="." >
            <xsl:with-param name="date" select="$date" />
          </xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="_FormatDateValues" match="Token[@token='yy']">
    <xsl:param name="date" />
    <xsl:choose>
      <xsl:when test="$date//DateValue[@name='year']">
        <xsl:value-of select="substring($date//DateValue[@name='year']/text(), 3, 2)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$defaultYear"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template mode="_FormatDateValues" match="Token[@token='yyy']">
    <xsl:param name="date" />
    <xsl:choose>
      <xsl:when test="$date//DateValue[@name='year']">
        <xsl:value-of select="$date//DateValue[@name='year']/text()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$defaultCentury"/>
        <xsl:value-of select="$defaultYear"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template mode="_FormatDateValues" match="Token[@token='m']">
    <xsl:param name="date" />
    <xsl:choose>
      <xsl:when test="$date//DateValue[@name='month']">
        <xsl:value-of select="number($date//DateValue[@name='month']/text())"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="number($defaultMonth)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template mode="_FormatDateValues" match="Token[@token='mm']">
    <xsl:param name="date" />
    <xsl:choose>
      <xsl:when test="$date//DateValue[@name='month']">
        <xsl:if test="string-length($date//DateValue[@name='month']/text()) &lt; 2">0</xsl:if>
        <xsl:value-of select="$date//DateValue[@name='month']/text()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="string-length($defaultMonth) &lt; 2">0</xsl:if>
        <xsl:value-of select="$defaultMonth"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template mode="_FormatDateValues" match="Token[@token='mmm']">
    <xsl:param name="date" />
    <xsl:choose>
      <xsl:when test="$date//DateValue[@name='month']">
        <xsl:call-template name="MonthShortString">
          <xsl:with-param name="value" select="$date//DateValue[@name='month']/text()" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="MonthShortString">
          <xsl:with-param name="value" select="$defaultMonth" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template mode="_FormatDateValues" match="Token[@token='mmmm']">
    <xsl:param name="date" />
    <xsl:choose>
      <xsl:when test="$date//DateValue[@name='month']">
        <xsl:call-template name="MonthLongString">
          <xsl:with-param name="value" select="$date//DateValue[@name='month']/text()" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="MonthLongString">
          <xsl:with-param name="value" select="$defaultMonth" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template mode="_FormatDateValues" match="Token[@token='d']">
    <xsl:param name="date" />
    <xsl:choose>
      <xsl:when test="$date//DateValue[@name='date']">
        <xsl:value-of select="number($date//DateValue[@name='date']/text())"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="number($defaultDate)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template mode="_FormatDateValues" match="Token[@token='dd']">
    <xsl:param name="date" />
    <xsl:choose>
      <xsl:when test="$date//DateValue[@name='date']">
        <xsl:if test="string-length($date//DateValue[@name='date']/text()) &lt; 2">0</xsl:if>
        <xsl:value-of select="$date//DateValue[@name='date']/text()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="string-length($defaultDate) &lt; 2">0</xsl:if>
        <xsl:value-of select="$defaultDate"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template mode="_FormatDateValues" match="Token[@token='ww']">
    <xsl:param name="date" />
    <xsl:choose>
      <xsl:when test="$date//DateValue[@name='dayofweek']">
        <xsl:call-template name="WeekDayShortName">
          <xsl:with-param name="value" select="$date//DateValue[@name='dayofweek']/text()" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="dayofweek">
          <xsl:call-template name="_CalculateDayOfWeek">
            <xsl:with-param name="date" select="$date" />
          </xsl:call-template>
        </xsl:variable>
        <xsl:call-template name="WeekDayShortName">
          <xsl:with-param name="value" select="$dayofweek" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template mode="_FormatDateValues" match="Token[@token='www']">
    <xsl:param name="date" />
    <xsl:choose>
      <xsl:when test="$date//DateValue[@name='dayofweek']">
        <xsl:call-template name="WeekDayLongName">
          <xsl:with-param name="value" select="$date//DateValue[@name='dayofweek']/text()" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="dayofweek">
          <xsl:call-template name="_CalculateDayOfWeek">
            <xsl:with-param name="date" select="$date" />
          </xsl:call-template>
        </xsl:variable>
        <xsl:call-template name="WeekDayLongName">
          <xsl:with-param name="value" select="$dayofweek" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



  <!-- DATE PARSING TEMPLATES -->
  <xsl:template name="ParseDate">
    <xsl:param name="dateTimeString" />
    <xsl:param name="formatString" />
    <xsl:variable name="format">
      <xsl:call-template name="ParseFormat">
        <xsl:with-param name="format" select="$formatString" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="dateValues">
      <xsl:choose>
        <xsl:when test="function-available('ms:node-set')">
          <xsl:call-template name="_GetDateValues">
            <xsl:with-param name="date" select="$dateTimeString" />
            <xsl:with-param name="format" select="ms:node-set($format)"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="function-available('ex:node-set')">
          <xsl:call-template name="_GetDateValues">
            <xsl:with-param name="date" select="$dateTimeString" />
            <xsl:with-param name="format" select="ex:node-set($format)"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="function-available('ap:node-set')">
          <xsl:call-template name="_GetDateValues">
            <xsl:with-param name="date" select="$dateTimeString" />
            <xsl:with-param name="format" select="ap:node-set($format)"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="_GetDateValues">
            <xsl:with-param name="date" select="$dateTimeString" />
            <xsl:with-param name="format" select="$format"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <Date>
      <xsl:choose>
        <xsl:when test="function-available('ms:node-set')">
          <xsl:apply-templates mode="_NormalizeDateValues" select="ms:node-set($dateValues)//DateValue" />
        </xsl:when>
        <xsl:when test="function-available('ex:node-set')">
          <xsl:apply-templates mode="_NormalizeDateValues" select="ex:node-set($dateValues)//DateValue" />
        </xsl:when>
        <xsl:when test="function-available('ap:node-set')">
          <xsl:apply-templates mode="_NormalizeDateValues" select="ap:node-set($dateValues)//DateValue" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates mode="_NormalizeDateValues" select="$dateValues//DateValue" />
        </xsl:otherwise>
      </xsl:choose>
    </Date>
  </xsl:template>

  <xsl:template mode="_NormalizeDateValues" match="DateValue[@token='yy']">
    <xsl:if test="number(./text()) = NaN">
      <xsl:message terminate="yes">
        Invalid short year value '<xsl:value-of select="./text()"/>'
      </xsl:message>
    </xsl:if>
    <DateValue name="year">
      <xsl:value-of select="$defaultCentury"/>
      <xsl:value-of select="./text()"/>
    </DateValue>
  </xsl:template>
  <xsl:template mode="_NormalizeDateValues" match="DateValue[@token='yyy']">
    <xsl:if test="number(./text()) = NaN">
      <xsl:message terminate="yes">
        Invalid long year value '<xsl:value-of select="./text()"/>'
      </xsl:message>
    </xsl:if>
    <DateValue name="year">
      <xsl:value-of select="./text()"/>
    </DateValue>
  </xsl:template>
  <xsl:template mode="_NormalizeDateValues" match="DateValue[@token='m']">
    <xsl:if test="number(./text()) = NaN or number(./text()) &gt; 12 or number(./text()) &lt; 1">
      <xsl:message terminate="yes">
        Invalid month value '<xsl:value-of select="./text()"/>'
      </xsl:message>
    </xsl:if>
    <DateValue name="month">
      <xsl:if test="string-length(./text()) &lt; 2">0</xsl:if>
      <xsl:value-of select="./text()"/>
    </DateValue>
  </xsl:template>
  <xsl:template mode="_NormalizeDateValues" match="DateValue[@token='mm']">
    <xsl:if test="number(./text()) = NaN or number(./text()) &gt; 12 or number(./text()) &lt; 1">
      <xsl:message terminate="yes">
        Invalid month value '<xsl:value-of select="./text()"/>'
      </xsl:message>
    </xsl:if>
    <DateValue name="month">
      <xsl:value-of select="./text()"/>
    </DateValue>
  </xsl:template>
  <xsl:template mode="_NormalizeDateValues" match="DateValue[@token='mmm']">
    <xsl:variable name="value">
      <xsl:call-template name="MonthFromShortName">
        <xsl:with-param name="value" select="string(./text())" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="string-length($value) = 0 or number($value) = NaN">
      <xsl:message terminate="yes">
        Invalid month name '<xsl:value-of select="./text()"/>'
      </xsl:message>
    </xsl:if>
    <DateValue name="month">
      <xsl:value-of select="$value" />
    </DateValue>
  </xsl:template>
  <xsl:template mode="_NormalizeDateValues" match="DateValue[@token='mmmm']">
    <xsl:variable name="value">
      <xsl:call-template name="MonthFromLongName">
        <xsl:with-param name="value" select="string(./text())" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="string-length($value) = 0 or number($value) = NaN">
      <xsl:message terminate="yes">
        Invalid month name '<xsl:value-of select="./text()"/>'
      </xsl:message>
    </xsl:if>
    <DateValue name="month">
      <xsl:value-of select="$value" />
    </DateValue>
  </xsl:template>
  <xsl:template mode="_NormalizeDateValues" match="DateValue[@token='d']">
    <xsl:if test="number(./text()) = NaN or number(./text()) &gt; 31 or number(./text()) &lt; 1">
      <xsl:message terminate="yes">
        Invalid date value '<xsl:value-of select="./text()"/>'
      </xsl:message>
    </xsl:if>
    <DateValue name="date">
      <xsl:value-of select="./text()"/>
    </DateValue>
  </xsl:template>
  <xsl:template mode="_NormalizeDateValues" match="DateValue[@token='dd']">
    <xsl:if test="number(./text()) = NaN or number(./text()) &gt; 31 or number(./text()) &lt; 1">
      <xsl:message terminate="yes">
        Invalid date value '<xsl:value-of select="./text()"/>'
      </xsl:message>
    </xsl:if>
    <DateValue name="date">
      <xsl:if test="string-length(./text()) &lt; 2">0</xsl:if>
      <xsl:value-of select="./text()"/>
    </DateValue>
  </xsl:template>
  <xsl:template mode="_NormalizeDateValues" match="DateValue[@token='ww']">
    <xsl:variable name="value">
      <xsl:call-template name="WeekDayFromShortName">
        <xsl:with-param name="value" select="string(./text())" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="string-length($value) = 0 or number($value) = NaN">
      <xsl:message terminate="yes">
        Invalid weekday name '<xsl:value-of select="./text()"/>'
      </xsl:message>
    </xsl:if>
    <DateValue name="weekday">
      <xsl:value-of select="$value" />
    </DateValue>
  </xsl:template>
  <xsl:template mode="_NormalizeDateValues" match="DateValue[@token='www']">
    <xsl:variable name="value">
      <xsl:call-template name="WeekDayFromLongName">
        <xsl:with-param name="value" select="string(./text())" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="string-length($value) = 0 or number($value) = NaN">
      <xsl:message terminate="yes">
        Invalid weekday name '<xsl:value-of select="./text()"/>'
      </xsl:message>
    </xsl:if>
    <DateValue name="weekday">
      <xsl:value-of select="$value" />
    </DateValue>
  </xsl:template>

  <xsl:template name="_GetDateValues">
    <xsl:param name="format" />
    <xsl:param name="date" />

    <xsl:choose>
      <xsl:when test="function-available('ms:node-set')">
        <xsl:call-template name="_GetDateValue">
          <xsl:with-param name="formatToken" select="ms:node-set($format)//Token[1]"/>
          <xsl:with-param name="delimiter" select="ms:node-set($format)//*[position() = 2][name() = 'Delimiter']" />
          <xsl:with-param name="dateSubString" select="$date" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="function-available('ex:node-set')">
        <xsl:call-template name="_GetDateValue">
          <xsl:with-param name="formatToken" select="ex:node-set($format)//Token[1]"/>
          <xsl:with-param name="delimiter" select="ex:node-set($format)//*[position() = 2][name() = 'Delimiter']" />
          <xsl:with-param name="dateSubString" select="$date" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="function-available('ap:node-set')">
        <xsl:call-template name="_GetDateValue">
          <xsl:with-param name="formatToken" select="ap:node-set($format)//Token[1]"/>
          <xsl:with-param name="delimiter" select="ap:node-set($format)//*[position() = 2][name() = 'Delimiter']" />
          <xsl:with-param name="dateSubString" select="$date" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="_GetDateValue">
          <xsl:with-param name="formatToken" select="$format//Token[1]"/>
          <xsl:with-param name="delimiter" select="$format//*[position() = 2][name() = 'Delimiter']" />
          <xsl:with-param name="dateSubString" select="$date" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="_GetDateValue">
    <xsl:param name="formatToken" />
    <xsl:param name="delimiter" />
    <xsl:param name="dateSubString" />
    <xsl:param name="startingIndex" select="0" />

    <xsl:variable name="value">
      <xsl:choose>
        <xsl:when test="$delimiter" >
          <xsl:value-of select="substring-before($dateSubString, $delimiter/text())" />
        </xsl:when>
        <xsl:when test="number($formatToken/@length) &gt; 0" >
          <xsl:value-of select="substring($dateSubString, 1, number($formatToken/@length))" />
        </xsl:when>
        <xsl:when test="not($formatToken/following-sibling::*[1])">
          <xsl:value-of select="$dateSubString"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:if test="string-length($value) = 0">
      <xsl:message terminate="yes">
        Could not parse token value '<xsl:value-of select="$formatToken/@token" />' from date '<xsl:value-of select="$dateSubString" />'
      </xsl:message>
    </xsl:if>

    <DateValue>
      <xsl:attribute name="name">
        <xsl:value-of select="$formatToken/@name" />
      </xsl:attribute>
      <xsl:attribute name="token">
        <xsl:value-of select="$formatToken/@token" />
      </xsl:attribute>
      <xsl:attribute name="index">
        <xsl:value-of select="$startingIndex" />
      </xsl:attribute>
      <xsl:value-of select="$value" />
    </DateValue>

    <xsl:if test="$formatToken/following-sibling::Token[1]" >
      <xsl:variable name="nextDateSubString">
        <xsl:choose>
          <xsl:when test="$delimiter">
            <xsl:value-of select="substring-after($dateSubString, $delimiter/text())" />
          </xsl:when>
          <xsl:when test="number($formatToken/@length) &gt; 0">
            <xsl:value-of select="substring($dateSubString, number($formatToken/@length) + 1, string-length($dateSubString))" />
          </xsl:when>
        </xsl:choose>
      </xsl:variable>
      <xsl:call-template name="_GetDateValue">
        <xsl:with-param name="formatToken" select="$formatToken/following-sibling::Token[1]" />
        <xsl:with-param name="delimiter" select="$delimiter/following-sibling::*[position() = 2][name() = 'Delimiter']" />
        <xsl:with-param name="dateSubString" select="$nextDateSubString" />
        <xsl:with-param name="startingIndex" select="$startingIndex + string-length($value) + string-length($delimiter/text())" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>



  <!-- DATE VALUE TEMPLATES -->
  <xsl:template name="MonthShortString">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = '01'">Jan</xsl:when>
      <xsl:when test="$value = '02'">Feb</xsl:when>
      <xsl:when test="$value = '03'">Mar</xsl:when>
      <xsl:when test="$value = '04'">Apr</xsl:when>
      <xsl:when test="$value = '05'">May</xsl:when>
      <xsl:when test="$value = '06'">Jun</xsl:when>
      <xsl:when test="$value = '07'">Jul</xsl:when>
      <xsl:when test="$value = '08'">Aug</xsl:when>
      <xsl:when test="$value = '09'">Sep</xsl:when>
      <xsl:when test="$value = '10'">Oct</xsl:when>
      <xsl:when test="$value = '11'">Nov</xsl:when>
      <xsl:when test="$value = '12'">Dec</xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="MonthLongString">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = '01'">January</xsl:when>
      <xsl:when test="$value = '02'">February</xsl:when>
      <xsl:when test="$value = '03'">March</xsl:when>
      <xsl:when test="$value = '04'">April</xsl:when>
      <xsl:when test="$value = '05'">May</xsl:when>
      <xsl:when test="$value = '06'">June</xsl:when>
      <xsl:when test="$value = '07'">July</xsl:when>
      <xsl:when test="$value = '08'">August</xsl:when>
      <xsl:when test="$value = '09'">September</xsl:when>
      <xsl:when test="$value = '10'">October</xsl:when>
      <xsl:when test="$value = '11'">November</xsl:when>
      <xsl:when test="$value = '12'">December</xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="MonthFromShortName">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 'Jan'">01</xsl:when>
      <xsl:when test="$value = 'Feb'">02</xsl:when>
      <xsl:when test="$value = 'Mar'">03</xsl:when>
      <xsl:when test="$value = 'Apr'">04</xsl:when>
      <xsl:when test="$value = 'May'">05</xsl:when>
      <xsl:when test="$value = 'Jun'">06</xsl:when>
      <xsl:when test="$value = 'Jul'">07</xsl:when>
      <xsl:when test="$value = 'Aug'">08</xsl:when>
      <xsl:when test="$value = 'Sep'">09</xsl:when>
      <xsl:when test="$value = 'Oct'">10</xsl:when>
      <xsl:when test="$value = 'Nov'">11</xsl:when>
      <xsl:when test="$value = 'Dec'">12</xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="MonthFromLongName">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 'January'">01</xsl:when>
      <xsl:when test="$value = 'February'">02</xsl:when>
      <xsl:when test="$value = 'March'">03</xsl:when>
      <xsl:when test="$value = 'April'">04</xsl:when>
      <xsl:when test="$value = 'May'">05</xsl:when>
      <xsl:when test="$value = 'June'">06</xsl:when>
      <xsl:when test="$value = 'July'">07</xsl:when>
      <xsl:when test="$value = 'August'">08</xsl:when>
      <xsl:when test="$value = 'Sepember'">09</xsl:when>
      <xsl:when test="$value = 'October'">10</xsl:when>
      <xsl:when test="$value = 'November'">11</xsl:when>
      <xsl:when test="$value = 'December'">12</xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="WeekDayFromLongName">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 'Sunday'">01</xsl:when>
      <xsl:when test="$value = 'Monday'">02</xsl:when>
      <xsl:when test="$value = 'Tuesday'">03</xsl:when>
      <xsl:when test="$value = 'Wednesday'">04</xsl:when>
      <xsl:when test="$value = 'Thursday'">05</xsl:when>
      <xsl:when test="$value = 'Friday'">06</xsl:when>
      <xsl:when test="$value = 'Saturday'">07</xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="WeekDayFromShortName">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = 'Sun'">01</xsl:when>
      <xsl:when test="$value = 'Mon'">02</xsl:when>
      <xsl:when test="$value = 'Tue'">03</xsl:when>
      <xsl:when test="$value = 'Wed'">04</xsl:when>
      <xsl:when test="$value = 'Thu'">05</xsl:when>
      <xsl:when test="$value = 'Fri'">06</xsl:when>
      <xsl:when test="$value = 'Sat'">07</xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="WeekDayLongName">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = '1'">Sunday</xsl:when>
      <xsl:when test="$value = '2'">Monday</xsl:when>
      <xsl:when test="$value = '3'">Tuesday</xsl:when>
      <xsl:when test="$value = '4'">Wednesday</xsl:when>
      <xsl:when test="$value = '5'">Thursday</xsl:when>
      <xsl:when test="$value = '6'">Friday</xsl:when>
      <xsl:when test="$value = '7'">Saturday</xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="WeekDayShortName">
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$value = '1'">Sun</xsl:when>
      <xsl:when test="$value = '2'">Mon</xsl:when>
      <xsl:when test="$value = '3'">Tue</xsl:when>
      <xsl:when test="$value = '4'">Wed</xsl:when>
      <xsl:when test="$value = '5'">Thu</xsl:when>
      <xsl:when test="$value = '6'">Fri</xsl:when>
      <xsl:when test="$value = '7'">Sat</xsl:when>
    </xsl:choose>
  </xsl:template>



  <!-- FORMAT TEMPLATES -->
  <xsl:template name="ParseFormat">
    <xsl:param name="format" />
    <xsl:variable name="dateTokens">
      <DateTokens>
        <xsl:choose>
          <xsl:when test="function-available('ms:node-set')">
            <xsl:for-each select="ms:node-set($DateTokens)//Token" >
              <xsl:call-template name="_FormatToken">
                <xsl:with-param name="format" select="$format" />
                <xsl:with-param name="token" select="." />
                <xsl:with-param name="name" select="./@name" />
              </xsl:call-template>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="function-available('ex:node-set')">
            <xsl:for-each select="ex:node-set($DateTokens)//Token" >
              <xsl:call-template name="_FormatToken">
                <xsl:with-param name="format" select="$format" />
                <xsl:with-param name="token" select="." />
                <xsl:with-param name="name" select="./@name" />
              </xsl:call-template>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="function-available('ap:node-set')">
            <xsl:for-each select="ap:node-set($DateTokens)//Token" >
              <xsl:call-template name="_FormatToken">
                <xsl:with-param name="format" select="$format" />
                <xsl:with-param name="token" select="." />
                <xsl:with-param name="name" select="./@name" />
              </xsl:call-template>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:for-each select="$DateTokens//Token" >
              <xsl:call-template name="_FormatToken">
                <xsl:with-param name="format" select="$format" />
                <xsl:with-param name="token" select="." />
                <xsl:with-param name="name" select="./@name" />
              </xsl:call-template>
            </xsl:for-each>
          </xsl:otherwise>
        </xsl:choose>
      </DateTokens>
    </xsl:variable>
    <xsl:variable name="intermedFormat">
      <xsl:choose>
        <xsl:when test="function-available('ms:node-set')">
          <xsl:for-each select="ms:node-set($dateTokens)//Token">
            <xsl:sort select="number(@index)" data-type="number" order="ascending" />
            <xsl:copy-of select="." />
          </xsl:for-each>
        </xsl:when>
        <xsl:when test="function-available('ex:node-set')">
          <xsl:for-each select="ex:node-set($dateTokens)//Token">
            <xsl:sort select="number(@index)" data-type="number" order="ascending" />
            <xsl:copy-of select="." />
          </xsl:for-each>
        </xsl:when>
        <xsl:when test="function-available('ap:node-set')">
          <xsl:for-each select="ap:node-set($dateTokens)//Token">
            <xsl:sort select="number(@index)" data-type="number" order="ascending" />
            <xsl:copy-of select="." />
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:for-each select="$dateTokens//Token">
            <xsl:sort select="number(@index)" data-type="number" order="ascending" />
            <xsl:copy-of select="." />
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <DateFormat>
      <xsl:choose>
        <xsl:when test="function-available('ms:node-set')">
          <xsl:for-each select="ms:node-set($intermedFormat)//Token">
            <xsl:call-template name="_ParseDelimiters">
              <xsl:with-param name="current" select="." />
              <xsl:with-param name="format" select="$format" />
            </xsl:call-template>
          </xsl:for-each>
        </xsl:when>
        <xsl:when test="function-available('ex:node-set')">
          <xsl:for-each select="ex:node-set($intermedFormat)//Token">
            <xsl:sort select="number(./@index)"/>
            <xsl:call-template name="_ParseDelimiters">
              <xsl:with-param name="current" select="." />
              <xsl:with-param name="format" select="$format" />
            </xsl:call-template>
          </xsl:for-each>
        </xsl:when>
        <xsl:when test="function-available('ap:node-set')">
          <xsl:for-each select="ap:node-set($intermedFormat)//Token">
            <xsl:sort select="number(./@index)"/>
            <xsl:call-template name="_ParseDelimiters">
              <xsl:with-param name="current" select="." />
              <xsl:with-param name="format" select="$format" />
            </xsl:call-template>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:for-each select="$intermedFormat//Token">
            <xsl:sort select="number(./@index)"/>
            <xsl:call-template name="_ParseDelimiters">
              <xsl:with-param name="current" select="." />
              <xsl:with-param name="format" select="$format" />
            </xsl:call-template>
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
    </DateFormat>
  </xsl:template>

  <xsl:template name="_FormatToken" >
    <xsl:param name="format" />
    <xsl:param name="token" />
    <xsl:param name="name" />
    <xsl:variable name="long" select="concat($token, substring($token, 1, 1))" />
    <xsl:if test="contains($format, $token) and not(contains($format, $long))" >
      <Token>
        <xsl:attribute name="name">
          <xsl:value-of select="$name" />
        </xsl:attribute>
        <xsl:attribute name="token">
          <xsl:value-of select="$token" />
        </xsl:attribute>
        <xsl:attribute name="length">
          <xsl:value-of select="$token/@length"/>
        </xsl:attribute>
        <xsl:attribute name="index">
          <xsl:value-of select="string-length(substring-before($format, $token)) + 1" />
        </xsl:attribute>
      </Token>
    </xsl:if>
  </xsl:template>

  <xsl:template name="_ParseDelimiters">
    <xsl:param name="current" />
    <xsl:param name="format" />

    <xsl:variable name="delimiterStart" select="number($current/@index) + string-length($current/@token)" />
    <xsl:variable name="delimiterLength" select="number(following-sibling::*[1]/@index) - $delimiterStart" />

    <!-- Write the token element -->
    <xsl:copy-of select="$current" />

    <!-- Write the delimiter element -->
    <xsl:if test="$delimiterStart &lt;= string-length($format) and $delimiterLength > 0">
      <Delimiter>
        <xsl:attribute name="index">
          <xsl:value-of select="$delimiterStart" />
        </xsl:attribute>
        <xsl:value-of select="substring($format, $delimiterStart, $delimiterLength)"/>
      </Delimiter>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
