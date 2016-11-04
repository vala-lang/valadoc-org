<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings" xmlns:sphinx="foo">
  <xsl:param name="startid" />
  <xsl:output method="xml" indent="yes" version="1.0" encoding='UTF-8' />

  <xsl:template match="/">
    <sphinx:docset>
      <sphinx:schema>
        <sphinx:field name="ftsname"/>
        <sphinx:field name="shortname"/>
        <sphinx:attr name="name" type="string" />
        <sphinx:attr name="namelen" type="int" />
        <sphinx:attr name="shortnamelen" type="int" />
        <sphinx:attr name="typeorder" type="int" />
        <sphinx:attr name="shortdesc" type="string" />
        <sphinx:attr name="type" type="string" />
        <sphinx:attr name="path" type="string" />
        <sphinx:attr name="signature" type="string" />
      </sphinx:schema>

      <xsl:for-each select="package/node">
        <sphinx:document id="{number($startid)+position()}">
          <ftsname><xsl:apply-templates select="str:tokenize(@name, '.')"/></ftsname>
          <shortname><xsl:value-of select="str:tokenize(@name, '.')[last()]"/></shortname>

          <name><xsl:value-of select="@name"/></name>
          <namelen><xsl:value-of select="string-length(@name)"/></namelen>
          <shortnamelen><xsl:value-of select="string-length(str:tokenize(@name, '.')[last()])"/></shortnamelen>
          <typeorder>
            <xsl:if test="@type='CLASS' or @type='INTERFACE' or @type='ENUM' or @type='ERROR_DOMAIN'">1</xsl:if>
            <xsl:if test="@type='METHOD'">2</xsl:if>
            <xsl:if test="@type='PROPERTY'">3</xsl:if>
            <xsl:if test="@type='SIGNAL'">4</xsl:if>
            <xsl:if test="@type='STATIC_METHOD'">5</xsl:if>
            <xsl:if test="@type='DELEGATE'">6</xsl:if>
            <xsl:if test="@type='FIELD' or @type='CONSTANT' or @type='ENUM_VALUE' or @type='ERROR_CODE'">7</xsl:if>
            <xsl:if test="@type='NAMESPACE'">8</xsl:if>
            <xsl:if test="@type='CREATION_METHOD'">9</xsl:if>
          </typeorder>
          <shortdesc><xsl:value-of select="@shortdesc"/></shortdesc>
          <type><xsl:value-of select="@type"/></type>
          <path><xsl:value-of select="@path"/></path>
          <signature><xsl:value-of select="@signature"/></signature>
        </sphinx:document>
      </xsl:for-each>

    </sphinx:docset>
  </xsl:template>

  <xsl:template match="token">
    <xsl:value-of select="."/>
    <xsl:if test="position()!=last()">
      <xsl:text> . </xsl:text>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
