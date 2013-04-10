<xsl:stylesheet
 version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:ext="http://exslt.org/common"
 exclude-result-prefixes="ext">

 <xsl:import href="escape.xsl" />
 <xsl:import href="DateFormatting/DateFormatting.xslt" />

 <xsl:output method="xml" encoding="utf-8" indent="yes" />

 <xsl:template match="/C[@title]" name="root" priority="1">
  <rss version="2.0">
   <channel>
    <title><xsl:value-of select="@title"/> News</title>
    <link>http://redhog.org/__generated__/<xsl:value-of select="generate-id()"/></link>
    <language>en-us</language>
    <generator>Diary</generator>
    <description>Diary</description>
    <xsl:apply-templates mode="root" />
   </channel>
  </rss>
 </xsl:template>

 <xsl:template match="*" mode="root" priority="0">
  <xsl:apply-templates mode="root" />
 </xsl:template>

 <xsl:template match="C" name="chapter" mode="root" priority="1">
  <item>
    <title>
     <xsl:if test="@title">
      <xsl:value-of select="@title"/>
     </xsl:if>
     [<xsl:value-of select="@date"/>]
   </title>
   <link>http://redhog.org/__generated__/<xsl:value-of select="generate-id()"/></link>
   <description>
    <xsl:variable name="description">
     <xsl:call-template name="description" />
    </xsl:variable>
    <xsl:apply-templates mode="escape" select="ext:node-set($description)/*"/>
   </description>
   <xsl:if test="@date">
    <pubDate>
     <xsl:call-template name="FormatDate">
      <xsl:with-param name="inputFormatString" select="'mmm/dd/yyy'" />
      <xsl:with-param name="outputFormatString" select="'ww, dd mmm yyy'" />
      <xsl:with-param name="dateTimeString" select="'Jan/30/2010'" />
     </xsl:call-template> 00:00:00 GMT
    </pubDate>
   </xsl:if>
   <category>Personal/Dagbok/<xsl:value-of select="ancestor::C[@title]/@title" separator="/" /></category>
   <guid>http://redhog.org/__generated__/<xsl:value-of select="generate-id()"/></guid>
  </item>
 </xsl:template>

 <xsl:template name="description">
  <xsl:choose>
   <xsl:when test="@author">
    <blockquote>
     <xsl:element name="a">
      <xsl:attribute name="target">footnote</xsl:attribute>
      <xsl:attribute name="href"><xsl:value-of select="@author"/></xsl:attribute>
      ``
     </xsl:element>
     <xsl:apply-templates/>
     <xsl:element name="a">
      <xsl:attribute name="target">footnote</xsl:attribute>
      <xsl:attribute name="href"><xsl:value-of select="@author"/></xsl:attribute>
      ''
     </xsl:element>
    </blockquote>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>

  <xsl:if test="descendant::F">
   <div class="footnotes">
    <h1>Footnotes</h1>
    <xsl:for-each select="descendant::F">
     <xsl:element name="a">
      <xsl:attribute name="name">footnote.<xsl:value-of select="generate-id()"/></xsl:attribute>
      <div class="paragraph">
       <xsl:apply-templates/>
      </div>
     </xsl:element>
    </xsl:for-each>
   </div>
  </xsl:if>

  <xsl:if test="descendant::*[Comment or Paus[child::node()]]">
   <div class="comments">
    <h1>Comments</h1>
    <xsl:for-each select="descendant::Comment">
     <xsl:element name="a">
      <xsl:attribute name="name">comment.<xsl:value-of select="generate-id()"/></xsl:attribute>
      <div class="paragraph">
       <xsl:apply-templates select="child::P[position()=1]/node()"/>
      </div>
     </xsl:element>
    </xsl:for-each>

    <xsl:for-each select="descendant::Paus[child::node()]">
     <xsl:element name="a">
      <xsl:attribute name="name">comment.<xsl:value-of select="generate-id()"/></xsl:attribute>
      <div class="paragraph">
       <xsl:apply-templates/>
      </div>
     </xsl:element>
    </xsl:for-each>
   </div>
  </xsl:if>

  <xsl:if test="descendant::Expl">
   <div class="explanations">
    <h1>Explanations</h1>
    <xsl:for-each select="descendant::Expl">
     <xsl:element name="a">
      <xsl:attribute name="name">explanation.<xsl:value-of select="generate-id()"/></xsl:attribute>
      <div class="paragraph">
       <h2><xsl:apply-templates select="child::node()[position()!=1]"/></h2>
       <xsl:apply-templates select="child::P[position()=1]/node()"/>
      </div>
     </xsl:element>
    </xsl:for-each>
   </div>
  </xsl:if>
 </xsl:template>

 <xsl:template match="C">
  <div class="chapter">
   <h1>
    <xsl:if test="@title">
     <xsl:value-of select="@title"/>
    </xsl:if>
    <xsl:if test="@date">
    [<xsl:value-of select="@date"/>]
    </xsl:if>
   </h1>
   <xsl:apply-templates/>
  </div>
 </xsl:template>

 <xsl:template match="P" name="paragraph" priority="0.5">
  <div class="paragraph">
   <xsl:apply-templates />
  </div>
 </xsl:template>

 <xsl:template match="Quote" name="quote" priority="0.5">
  <xsl:choose>
   <xsl:when test="@author">
    <xsl:element name="A">
     <xsl:attribute name="Target">footnote</xsl:attribute>
     <xsl:attribute name="Href"><xsl:value-of select="@author"/></xsl:attribute>
     ``
    </xsl:element>
    <xsl:apply-templates/>
    <xsl:element name="A">
     <xsl:attribute name="Target">footnote</xsl:attribute>
     <xsl:attribute name="Href"><xsl:value-of select="@author"/></xsl:attribute>
     ''
    </xsl:element>
   </xsl:when>
   <xsl:otherwise>
    ``<xsl:apply-templates/>''
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="Blockquote" name="blockquote" priority="0.5">
  <xsl:choose>
   <xsl:when test="@author">
    <xsl:call-template name="chapter"/>
   </xsl:when>
   <xsl:otherwise>
    <Blockquote>
     ``<xsl:apply-templates/>''
    </Blockquote>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="F" name="footnote" priority="0.5">
  <xsl:element name="A">
   <xsl:attribute name="Target">footnote</xsl:attribute>
   <xsl:attribute name="Href">#footnote.<xsl:value-of select="generate-id()"/></xsl:attribute>
   <Sup>*</Sup>
  </xsl:element>
 </xsl:template>

 <xsl:template match="Comment" name="comment" priority="0.5">
  <xsl:element name="A">
   <xsl:attribute name="Target">footnote</xsl:attribute>
   <xsl:attribute name="Href">#comment.<xsl:value-of select="generate-id()"/></xsl:attribute>
   [[
  </xsl:element>
  <xsl:apply-templates select="child::node()[position()!=1]"/>
  <xsl:element name="A">
   <xsl:attribute name="Target">footnote</xsl:attribute>
   <xsl:attribute name="Href">#comment.<xsl:value-of select="generate-id()"/></xsl:attribute>
   ]]
  </xsl:element>
 </xsl:template>

 <xsl:template match="Paus" name="paus" priority="0.5">
  <xsl:choose>
   <xsl:when test="node()">
    <xsl:element name="A">
     <xsl:attribute name="Target">footnote</xsl:attribute>
     <xsl:attribute name="Href">#comment.<xsl:value-of select="generate-id()"/></xsl:attribute>
     (Paus)
    </xsl:element>
   </xsl:when>
   <xsl:otherwise>
    (Paus)
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="Expl" name="explanation" priority="0.5">
  <xsl:element name="A">
   <xsl:attribute name="Target">footnote</xsl:attribute>
   <xsl:attribute name="Href">#explanation.<xsl:value-of select="generate-id()"/></xsl:attribute>
   [
  </xsl:element>
  <xsl:apply-templates select="child::node()[position()!=1]"/>
  <xsl:element name="A">
   <xsl:attribute name="Target">footnote</xsl:attribute>
   <xsl:attribute name="Href">#explanation.<xsl:value-of select="generate-id()"/></xsl:attribute>
   ]
  </xsl:element>
 </xsl:template>

 <xsl:template match="List" name="list" priority="0.5">
  <Ul>
   <xsl:for-each select="child::P">
    <Li><xsl:apply-templates/></Li>
   </xsl:for-each>
  </Ul>
 </xsl:template>

 <xsl:template match="Conversation" name="conversation" priority="0.5">
  <Table border="0">
   <xsl:for-each select="child::P[@author]">
    <Tr>
     <Td valign="top"><xsl:value-of select="@author"/>:</Td>
     <Td valign="top"><xsl:apply-templates/></Td>
    </Tr>
   </xsl:for-each>
  </Table>
 </xsl:template>

 <xsl:template match="Do" name="action" priority="0.5">
  *<xsl:apply-templates/>*
 </xsl:template>

 <xsl:template match="Tag" name="tag" priority="0.5">
  <xsl:element name="{substring-before(@text, ' ')}">
   <xsl:apply-templates/>
  </xsl:element>
 </xsl:template>

 <xsl:template match="Em" name="emphasis" priority="0.5">
  <Em><xsl:apply-templates/></Em>
 </xsl:template>

 <xsl:template match="Tm" name="trademarked" priority="0.5">
  <xsl:apply-templates/>&lt;Tm&gt;
 </xsl:template>

 <xsl:template match="Namify" name="namify" priority="0.5">
  <U><xsl:apply-templates/></U>
 </xsl:template>

 <xsl:template match="Code" name="code" priority="0.5">
  <Pre><xsl:value-of select="child::node()"/></Pre>
 </xsl:template>

 <xsl:template match="Link" name="link" priority="0.5">
  <xsl:element name="A">
   <xsl:attribute name="Target">_top</xsl:attribute>
   <xsl:attribute name="Href"><xsl:value-of select="@ref"/></xsl:attribute>
   <xsl:apply-templates/>
  </xsl:element>
 </xsl:template>

 <xsl:template match="I" name="inclusion" priority="0.5">
  <xsl:variable name="name" select="@r"/>
  <xsl:apply-templates select="/descendant::*[@name=$name]"/>
 </xsl:template>

 <xsl:template match="Include" name="external-inclusion" priority="0.5">
  <xsl:apply-templates select="document(@ref)/*/*"/>
 </xsl:template>

 <xsl:template match="Include" mode="root">
  <xsl:apply-templates select="document(@ref)/*/*" mode="root" />
 </xsl:template>

</xsl:stylesheet>
