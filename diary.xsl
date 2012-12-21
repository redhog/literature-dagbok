<xsl:stylesheet
 version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:output method="html" encoding="ISO8859-1"/>

 <xsl:template match="/C[@title]" name="root" priority="1">
  <Html>
   <Head>
    <Title><xsl:value-of select="@title"/></Title>
   </Head>
   <Body>
    <P>
     <H1>Contents</H1>
     <xsl:call-template name="contents"/>
    </P>
    <Hr/>
    <xsl:call-template name="chapter"/>
    <Hr/>
    <P>
     <H1>Footnotes</H1>
     <xsl:for-each select="descendant::F">
      <xsl:element name="A">
       <xsl:attribute name="Name">footnote.<xsl:value-of select="generate-id()"/></xsl:attribute>
       <P>
        <xsl:apply-templates/>
       </P>
      </xsl:element>
     </xsl:for-each>
    </P>
    <P>
     <H1>Comments</H1>
     <xsl:for-each select="descendant::Comment">
      <xsl:element name="A">
       <xsl:attribute name="Name">comment.<xsl:value-of select="generate-id()"/></xsl:attribute>
       <P>
        <xsl:apply-templates select="child::P[position()=1]/node()"/>
       </P>
      </xsl:element>
     </xsl:for-each>
     <xsl:for-each select="descendant::Paus[child::node()]">
      <xsl:element name="A">
       <xsl:attribute name="Name">comment.<xsl:value-of select="generate-id()"/></xsl:attribute>
       <P>
        <xsl:apply-templates/>
       </P>
      </xsl:element>
     </xsl:for-each>
    </P>
    <P>
     <H1>Explanations</H1>
     <xsl:for-each select="descendant::Expl">
      <xsl:element name="A">
       <xsl:attribute name="Name">explanation.<xsl:value-of select="generate-id()"/></xsl:attribute>
       <P>
	<H2><xsl:apply-templates select="child::node()[position()!=1]"/></H2>
        <xsl:apply-templates select="child::P[position()=1]/node()"/>
       </P>
      </xsl:element>
     </xsl:for-each>
    </P>
   </Body>
  </Html>
 </xsl:template>

 <xsl:template name="contents" priority="0.5">
  <xsl:choose>
   <xsl:when test="self::C[@title or @date]">
    <Li>
     <xsl:element name="A">
      <xsl:attribute name="Target">doc</xsl:attribute>
      <xsl:attribute name="Href">#chapter.<xsl:value-of select="generate-id()"/></xsl:attribute>
      <xsl:if test="@title">
       <xsl:value-of select="@title"/>
      </xsl:if>
      <xsl:if test="@date">
       [<xsl:value-of select="@date"/>]
      </xsl:if>
     </xsl:element>
    </Li>
    <Ul>
     <xsl:for-each select="child::*">
      <xsl:call-template name="contents"/>
     </xsl:for-each>
    </Ul>
   </xsl:when>
   <xsl:when test="self::Include">
    <xsl:for-each select="document(@ref)">
     <xsl:call-template name="contents"/>
    </xsl:for-each>
   </xsl:when>
   <xsl:otherwise>
    <xsl:for-each select="child::*">
     <xsl:call-template name="contents"/>
    </xsl:for-each>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="P" name="paragraph" priority="0.5">
  <xsl:call-template name="chapter"/>
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

 <xsl:template match="C" name="chapter" priority="0.5">
  <xsl:element name="A">
   <xsl:attribute name="Name">chapter.<xsl:value-of select="generate-id()"/></xsl:attribute>
   <P>
    <xsl:if test="@title or @date">
     <xsl:element name="H{count(ancestor::C[@title or @date]) + 1}">
      <xsl:if test="@title">
       <xsl:value-of select="@title"/>
      </xsl:if>
      <xsl:if test="@date">
       [<xsl:value-of select="@date"/>]
      </xsl:if>
     </xsl:element>
    </xsl:if>
    <xsl:choose>
     <xsl:when test="@author">
      <Blockquote>
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
      </Blockquote>
     </xsl:when>
     <xsl:otherwise>
      <xsl:apply-templates/>
     </xsl:otherwise>
    </xsl:choose>
   </P>
  </xsl:element>
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
  <xsl:apply-templates select="document(@ref)"/>
 </xsl:template>

</xsl:stylesheet>
