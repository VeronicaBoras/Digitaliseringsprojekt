<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema" 
   xmlns:tei="http://www.tei-c.org/ns/1.0"
   version="2.0"
   exclude-result-prefixes="xs tei">
   
   <xsl:output method="html" encoding="UTF-8"/>
   
   <!-- Huvudmall som matchar <TEI> och bygger HTML-strukturen -->
   <xsl:template match="tei:TEI">
      <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;&#xa;</xsl:text>
      <html lang="en" xml:lang="en">
         <head>
            <title>
               <xsl:value-of select="//tei:titleStmt/tei:title"/>
            </title>
            <link rel="stylesheet"
               href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
               integrity="sha384-..." crossorigin="anonymous"/>
            <link rel="stylesheet" href="assets/css/main.css"/>
            <link rel="stylesheet" href="assets/css/desktop.css"/>
         </head>
         <body>
            <header>
               <h1>
                  <xsl:apply-templates select="//tei:titleStmt/tei:title"/>
               </h1>
            </header>
            
            <nav id="sitenav">
               <a href="index.html">Home</a> |
               <a href="diplomatic.html">Diplomatic Transcription</a> |
               <a href="reading.html">Reading Text</a> |
               <a href="toplayer.html">Top Layer</a>
            </nav>
            
            <main id="manuscript">
               <div class="container">
                  <!-- Bildkolumn -->
                  <div class="row">
                     <div class="col-sm">
                        <article id="collection">
                           <xsl:for-each select="//tei:surface">
                              <img class="thumbnail">
                                 <xsl:attribute name="src">
                                    <xsl:value-of select="tei:figure/tei:graphic[2]/@url"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="title">
                                    <xsl:value-of select="tei:figure/tei:label"/>
                                 </xsl:attribute>
                                 <xsl:attribute name="alt">
                                    <xsl:value-of select="tei:figure/tei:figDesc"/>
                                 </xsl:attribute>
                              </img>
                           </xsl:for-each>
                        </article>
                     </div>
                     
                     <!-- Textkolumn -->
                     <div class="col-sm">
                        <article id="text">
                           <xsl:apply-templates select="//tei:text/tei:body"/>
                        </article>
                     </div>
                  </div>
                  
                  <div class="row">
                     <div class="col-sm">
                        <article id="details">
                           <p><strong>Author:</strong><br/>
                              <xsl:apply-templates select="//tei:titleStmt/tei:author"/>
                           </p>
                           <p><strong>Transcription by:</strong><br/>
                              <xsl:apply-templates select="//tei:titleStmt/tei:principal"/>
                           </p>
                        </article>
                     </div>
                  </div>
               </div>
            </main>
            
            <footer>
               <div class="row" id="footer">
                  <div class="col-sm copyright">
                     <div class="copyright_logos">
                        <a href="https://creativecommons.org/licenses/by/4.0/legalcode">
                           <img src="assets/img/logos/cc.svg" class="copyright_logo"
                              alt="Creative Commons License"/>
                           <img src="assets/img/logos/by.svg" class="copyright_logo"
                              alt="Attribution 4.0 International"/>
                        </a>
                     </div>
                  </div>
               </div>
            </footer>
            
            <!-- JS-filer -->
            <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"></script>
         </body>
      </html>
   </xsl:template>
   
   <!-- 🧾 Mallar för att visa <body> och dess innehåll -->
   <xsl:template match="tei:body">
      <section class="tei-body">
         <xsl:apply-templates/>
      </section>
   </xsl:template>
   
   <xsl:template match="tei:div">
      <div class="tei-div">
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   
   <xsl:template match="tei:p">
      <p>
         <xsl:apply-templates/>
      </p>
   </xsl:template>
   
   <!-- 🔗 Gör TEI <ref> till klickbara länkar -->
   <xsl:template match="tei:ref">
      <a>
         <xsl:attribute name="href">
            <xsl:value-of select="@target"/>
         </xsl:attribute>
         <xsl:apply-templates/>
      </a>
   </xsl:template>
   
</xsl:stylesheet>