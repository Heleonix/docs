<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
             xmlns:msb="http://schemas.microsoft.com/developer/msbuild/2003">
  <xsl:output method="text" indent="no"/>
  <xsl:strip-space elements="*"/>
  <xsl:param name="filename"/>
  <xsl:template match="/">---
uid: <xsl:value-of select="$filename"/>
---

# <xsl:value-of select="$filename"/>
<xsl:text>&#x0A;&#x0A;</xsl:text>
<xsl:value-of select="normalize-space(xs:schema/xs:element/xs:annotation/xs:documentation)"/>
<xsl:for-each select="xs:schema/xs:element/xs:complexType/xs:complexContent/xs:extension/xs:attribute">
#### <xsl:value-of select="@name"/>
<xsl:if test="@use = 'required'">
Required: `true`
</xsl:if>
<xsl:text>&#x0A;&#x0A;</xsl:text>
<xsl:value-of select="normalize-space(xs:annotation/xs:documentation)"/>
<xsl:text>&#x0A;</xsl:text>
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
