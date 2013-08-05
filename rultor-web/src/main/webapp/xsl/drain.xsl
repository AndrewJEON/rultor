<?xml version="1.0"?>
<!--
 * Copyright (c) 2009-2013, rultor.com
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met: 1) Redistributions of source code must retain the above
 * copyright notice, this list of conditions and the following
 * disclaimer. 2) Redistributions in binary form must reproduce the above
 * copyright notice, this list of conditions and the following
 * disclaimer in the documentation and/or other materials provided
 * with the distribution. 3) Neither the name of the rultor.com nor
 * the names of its contributors may be used to endorse or promote
 * products derived from this software without specific prior written
 * permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
 * NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml" version="2.0" exclude-result-prefixes="xs">
    <xsl:output method="xml" omit-xml-declaration="yes"/>
    <xsl:include href="/xsl/layout.xsl"/>
    <xsl:include href="/xsl/snapshot.xsl"/>
    <xsl:template name="head">
        <title>
            <xsl:apply-templates select="/page/unit"/>
        </title>
    </xsl:template>
    <xsl:template name="content">
        <h2>
            <xsl:value-of select="/page/unit"/>
        </h2>
        <xsl:choose>
            <xsl:when test="/page/pulses/pulse">
                <xsl:if test="/page/since">
                    <div class="spacious">
                        <ul class="list-inline">
                            <li>
                                <xsl:text>Since </xsl:text>
                                <span class="timeago"><xsl:value-of select="/page/since"/></span>
                            </li>
                            <li>
                                <a title="back to start">
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="//links/link[@rel='latest']/@href"/>
                                    </xsl:attribute>
                                    <xsl:text>back to start</xsl:text>
                                </a>
                            </li>
                        </ul>
                    </div>
                </xsl:if>
                <xsl:apply-templates select="/page/pulses/pulse"/>
                <xsl:if test="//links/link[@rel='more']">
                    <p>
                        <xsl:text>See </xsl:text>
                        <a title="more">
                            <xsl:attribute name="href">
                                <xsl:value-of select="//links/link[@rel='more']/@href"/>
                            </xsl:attribute>
                            <xsl:text>more</xsl:text>
                        </a>
                        <xsl:text> pulses.</xsl:text>
                    </p>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:text>Drain is empty.</xsl:text>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="pulse">
        <div class="panel">
            <div class="panel-heading">
                <ul class="list-inline" style="margin:0;">
                    <li><xsl:value-of select="time"/></li>
                    <li>
                        <a title="stream">
                            <xsl:attribute name="href">
                                <xsl:value-of select="links/link[@rel='stream']/@href"/>
                            </xsl:attribute>
                            <i class="icon-chevron-sign-right"><xsl:comment>drain</xsl:comment></i>
                        </a>
                    </li>
                    <xsl:if test="xembly">
                        <li>
                            <i class="icon-wrench" style="cursor:pointer;" title="show xembly"
                                onclick="$(this).parent().parent().parent().parent().find('.xembly').toggle();"><xsl:comment>xembly</xsl:comment></i>
                        </li>
                    </xsl:if>
                    <xsl:if test="exceptions/exception">
                        <li>
                            <i class="icon-warning-sign text-danger" style="cursor:pointer;" title="show exceptions"
                                onclick="$(this).parent().parent().parent().parent().find('.exceptions').toggle();"><xsl:comment>exceptions</xsl:comment></i>
                        </li>
                    </xsl:if>
                </ul>
            </div>
            <xsl:if test="exceptions/exception">
                <ul class="list-unstyled exceptions" style="display:none; font-family: monospace;">
                    <xsl:apply-templates select="exceptions/exception"/>
                </ul>
            </xsl:if>
            <xsl:if test="xembly">
                <ul class="list-inline xembly" style="white-space: pre; display:none; font-family: monospace;">
                    <li>
                        <xsl:value-of select="xembly"/>
                    </li>
                </ul>
            </xsl:if>
            <xsl:apply-templates select="snapshot"/>
        </div>
    </xsl:template>
    <xsl:template match="exception">
        <li class="text-danger">
            <xsl:value-of select="class"/>
            <xsl:text>: </xsl:text>
            <xsl:value-of select="message"/>
        </li>
    </xsl:template>
</xsl:stylesheet>
