<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <body>
                <table border="1">
                    <tr bgcolor="#CCCCCC">
                        <td align="center"><strong>N</strong></td>
                        <td align="center"><strong>Titles</strong></td>
                    </tr>
                    <xsl:for-each select=".//section//title">
                        <tr bgcolor="#F5F5F5">
                            <td><xsl:number format="1.1.1" level="multiple" count="section"/></td>
                            <td>
                                <a href = "#{@id}">
                                    <xsl:value-of select="."/>
                                </a>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>

                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>


    <xsl:template match="section">
        <section>
            <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </section>
    </xsl:template>


    <xsl:template match="title">
        <h2>
            <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </h2>
    </xsl:template>


    <xsl:template match="para">
        <p>
            <xsl:choose>
                <xsl:when test="orderedlist">
                    <xsl:apply-templates select="orderedlist"/>
                </xsl:when>
                <xsl:when test="itemizedlist">
                    <xsl:apply-templates select="itemizedlist"/>
                </xsl:when>
                <xsl:when test="keycap">
                    <xsl:value-of select="substring-before(.,keycap)"/>
                    <xsl:apply-templates select="keycap"/>
                    <xsl:value-of select="substring-after(.,keycap)"/>
                </xsl:when>
                <xsl:when test="emphasis">
                    <xsl:value-of select="substring-before(.,emphasis)"/>
                    <xsl:apply-templates select="emphasis"/>
                    <xsl:value-of select="substring-after(.,emphasis)"/>
                </xsl:when>
                <xsl:when test="link">
                    <xsl:value-of select="substring-before(.,link)"/>
                    <xsl:apply-templates select="link"/>
                    <xsl:value-of select="substring-after(.,link)"/>
                </xsl:when>
                <xsl:when test="ulink">
                    <xsl:value-of select="substring-before(.,ulink)"/>
                    <xsl:apply-templates select="ulink"/>
                    <xsl:value-of select="substring-after(.,ulink)"/>
                </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
            </xsl:choose>
        </p>
    </xsl:template>



    <xsl:template match="orderedlist">
        <xsl:apply-templates select="para"/>
        <ol>
            <xsl:apply-templates select="listitem"/>
        </ol>
    </xsl:template>

    <xsl:template match="orderedlist" mode="nested">
        <xsl:apply-templates select="para"/>
        <ol>
            <xsl:apply-templates select="listitem"/>
        </ol>
    </xsl:template>


    <xsl:template match="listitem">
        <li>
            <xsl:apply-templates select="para"/>
        </li>
        <xsl:apply-templates select="itemizedlist" mode="nested"/>
        <xsl:apply-templates select="orderedlist" mode="nested"/>
    </xsl:template>


    <xsl:template match="itemizedlist">
        <xsl:apply-templates select="para"/>
        <ul>
            <xsl:apply-templates select="listitem"/>
        </ul>
    </xsl:template>

    <xsl:template match="itemizedlist" mode="nested">
        <xsl:apply-templates select="para"/>
        <ul>
            <xsl:apply-templates select="listitem"/>
        </ul>
    </xsl:template>


    <xsl:template match="keycap">
        <strong>
            <xsl:choose>
                <xsl:when test="emphasis">
                    <xsl:apply-templates select="emphasis"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </strong>
    </xsl:template>


    <xsl:template match="emphasis">
        <em>
            <xsl:value-of select="."/>
        </em>
    </xsl:template>


    <xsl:template match="link">
        <a href = "#{.//@linkend}">
            <xsl:choose>
                <xsl:when test="keycap">
                    <xsl:apply-templates select="keycap"/>
                    <xsl:value-of select="substring-after(substring-before(.,emphasis),keycap)"/>
                    <xsl:apply-templates select="emphasis"/>
                </xsl:when>

                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </a>
    </xsl:template>


    <xsl:template match="ulink">
        <a href = "{.//@url}">
            <xsl:value-of select="."/>
        </a>
    </xsl:template>

</xsl:stylesheet>