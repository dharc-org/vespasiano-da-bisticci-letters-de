<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" 
    xmlns:skos='http://www.w3.org/2004/02/skos/core#'
    xmlns:owl="http://www.w3.org/2002/07/owl#"
    xmlns:bio="http://purl.org/vocab/bio/0.1/"
    xmlns:biro="http://purl.org/spar/biro/"
    xmlns:c4o="http://purl.org/spar/c4o/"
    xmlns:cito="http://purl.org/spar/cito/"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:deo="http://purl.org/spar/deo/"
    xmlns:doco="http://purl.org/spar/doco/"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:frbr="http://purl.org/vocab/frbr/core#"
    xmlns:fabio="http://purl.org/spar/fabio/"
    xmlns:hico="http://purl.org/emmedi/hico/"
    xmlns:po="http://www.essepuntato.it/2008/12/pattern#"
    xmlns:prism="http://prismstandard.org/namespaces/basic/2.0/"
    xmlns:pro="http://purl.org/spar/pro/"
    xmlns:prov="http://www.w3.org/ns/prov#"
    xmlns:san="http://dati.san.beniculturali.it/SAN/"
    xmlns:schema="http://schema.org/"
    xmlns:ti="http://www.ontologydesignpatterns.org/cp/owl/timeinterval.owl#"
    xmlns:tvc="http://www.ontologydesignpatterns.org/cp/owl/timeindexedsituation.owl#"
    xmlns:vdb="http://vespasianodabisticciletters.unibo.it/"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" encoding="utf-8" indent="yes"/>
    
    <xsl:function name="vdb:clean">
        <xsl:param name="string"/>
        <xsl:variable name="AllowedSymbols" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789äàèéìòù- '"/>
        <xsl:value-of select="lower-case(translate(translate(normalize-space(translate($string, translate($string, $AllowedSymbols, ''),'')), ' ', '-'), 'äàèéìòù', 'aaeeiou'))"/>
    </xsl:function>
    
    <!-- PARAMETERS -->
    <!-- Ontologies -->
    <!-- base -->
    <xsl:param name="vdb">http://vespasianodabisticciletters.unibo.it/</xsl:param>
    <!-- Local authorities -->
    <xsl:param name="people"/>
    <xsl:param name="biblio"/>
    <!-- current editor -->
    <xsl:param name="editor">tomasi</xsl:param>
    
    <xsl:template match="/">      
        <xsl:result-document href="vdbRdf.rdf">
            <rdf:RDF xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" 
                xmlns:skos='http://www.w3.org/2004/02/skos/core#'
                xmlns:owl="http://www.w3.org/2002/07/owl#"
                xmlns:bio="http://purl.org/vocab/bio/0.1/"
                xmlns:biro="http://purl.org/spar/biro/"
                xmlns:c4o="http://purl.org/spar/c4o/"
                xmlns:cito="http://purl.org/spar/cito/"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:dcterms="http://purl.org/dc/terms/"
                xmlns:deo="http://purl.org/spar/deo/"
                xmlns:doco="http://purl.org/spar/doco/"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:frbr="http://purl.org/vocab/frbr/core#"
                xmlns:fabio="http://purl.org/spar/fabio/"
                xmlns:hico="http://purl.org/emmedi/hico/"
                xmlns:po="http://www.essepuntato.it/2008/12/pattern#"
                xmlns:prism="http://prismstandard.org/namespaces/basic/2.0/"
                xmlns:pro="http://purl.org/spar/pro/"
                xmlns:prov="http://www.w3.org/ns/prov#"
                xmlns:san="http://dati.san.beniculturali.it/SAN/"
                xmlns:schema="http://schema.org/"
                xmlns:ti="http://www.ontologydesignpatterns.org/cp/owl/timeinterval.owl#"
                xmlns:tvc="http://www.ontologydesignpatterns.org/cp/owl/timeindexedsituation.owl#"
                xmlns:vdb="http://vespasianodabisticciletters.unibo.it/"> 
                
                <!-- CURRENT EDITION FRBR HIERARCHY -->
                <frbr:WorkCollection rdf:about="{concat($vdb, $editor, '-letters')}">
                    <rdfs:label xml:lang="it">Lettere di Vespasiano da Bisticci, edite da Francesca Tomasi</rdfs:label>
                    <rdfs:label xml:lang="en">Vespasiano da Bisticci's Letters, published by Francesca Tomasi</rdfs:label>
                    <dcterms:description xml:lang="it">Edizione delle Lettere di Vespasiano da Bisticci, copista fiorentino vissuto nell'arco del XV secolo</dcterms:description>
                    <dcterms:description xml:lang="en">Edition of Vespasiano da Bisticci's letters, a Florentine copyst lived in XV century</dcterms:description>
                    <frbr:realization>
                        <frbr:ExpressionCollection rdf:about="http://dx.doi.org/10.6092/unibo/vespasianodabisticciletters">
                            <rdfs:label xml:lang="it">Testo delle Lettere di Vespasiano da Bisticci, edite da Francesca Tomasi</rdfs:label>
                            <rdfs:label xml:lang="en">Text of Vespasiano da Bisticci's Letters, published by Francesca Tomasi</rdfs:label>
                            <dcterms:description xml:lang="it">Testo dell'Edizione delle Lettere di Vespasiano da Bisticci, copista fiorentino vissuto nell'arco del XV secolo</dcterms:description>
                            <dcterms:description xml:lang="en">Text of the Edition of Vespasiano da Bisticci's letters, a Florentine copyst lived in XV century</dcterms:description>
                            <dcterms:identifier>doi:10.6092/unibo/vespasianodabisticciletters</dcterms:identifier>
                            <dcterms:rights rdf:resource="https://creativecommons.org/licenses/by-nc-nd/3.0/deed.it"/>
                            <dcterms:identifier>ISBN:9788898010110</dcterms:identifier>
                            <xsl:for-each select="collection('letters?select=*.html;recurse=yes')/div">
                                <frbr:part rdf:resource="{concat($vdb, $editor, '-', @id, '-expr')}"/>
                            </xsl:for-each>
                            <frbr:embodiment>
                                <fabio:WebManifestation rdf:about="{concat($vdb, $editor, '-letters-digital-edition')}">
                                    <rdfs:label xml:lang="it">Edizione digitale delle Lettere di Vespasiano da Bisticci, edite da Francesca Tomasi</rdfs:label>
                                    <rdfs:label xml:lang="en">Digital Edition of Vespasiano da Bisticci's Letters, published by Francesca Tomasi</rdfs:label>
                                    <dcterms:description xml:lang="it">Edizione digitale delle Lettere di Vespasiano da Bisticci, copista fiorentino vissuto nell'arco del XV secolo, edite da Francesca Tomasi</dcterms:description>
                                    <dcterms:description xml:lang="en">Digital edition of Vespasiano da Bisticci's letters, a Florentine copyst lived in XV century, published by Francesca Tomasi</dcterms:description>
                                    <xsl:for-each select="collection('letters?select=*.html;recurse=yes')/div">
                                        <frbr:part rdf:resource="{concat($vdb, $editor, @id, '-digital-edition')}"/>
                                    </xsl:for-each>
                                    <frbr:exemplar>
                                        <frbr:Item rdf:about="{$vdb}">
                                            <rdfs:label xml:lang="it">Edizione digitale online delle Lettere di Vespasiano da Bisticci, edite da Francesca Tomasi</rdfs:label>
                                            <rdfs:label xml:lang="en">Online digital ddition of Vespasiano da Bisticci's Letters, published by Francesca Tomasi</rdfs:label>
                                            <dcterms:description xml:lang="it">Edizione digitale online delle Lettere di Vespasiano da Bisticci, copista fiorentino vissuto nell'arco del XV secolo, edite da Francesca Tomasi</dcterms:description>
                                            <dcterms:description xml:lang="en">Online digital edition of Vespasiano da Bisticci's letters, a Florentine copyst lived in XV century, published by Francesca Tomasi</dcterms:description>
                                            <xsl:for-each select="collection('letters?select=*.html;recurse=yes')/div">
                                                <xsl:variable name="html" select="ul/ul[@class='visualization']/li[contains(., 'trans')]/@href"/>
                                                <frbr:part rdf:resource="{concat($vdb, 'letters/', $html)}"/>
                                            </xsl:for-each>
                                        </frbr:Item>
                                    </frbr:exemplar>
                                </fabio:WebManifestation>
                            </frbr:embodiment>
                        </frbr:ExpressionCollection>
                    </frbr:realization>
                    <xsl:for-each select="collection('letters?select=*.html;recurse=yes')/div">
                        <xsl:variable name="id" select="@id"/>
                        <xsl:variable name="html" select="substring-before(ul/ul[@class='visualization']/li[contains(., 'trans')]/@href, '.html')"/>
                        <xsl:variable name="title" select="article/h1"/>
                        <frbr:part>
                            <frbr:Work rdf:about="{concat($vdb, $editor, '-', @id)}">
                                <rdfs:label xml:lang="it">Lettera "<xsl:value-of select="article/h1"/>"</rdfs:label>
                                <rdfs:label xml:lang="en">Letter "<xsl:value-of select="article/h1"/>"</rdfs:label>
                                <dcterms:description xml:lang="it">Lettera "<xsl:value-of select="article/h1"/>", edita da Francesca Tomasi</dcterms:description>
                                <dcterms:description xml:lang="en">Letter "<xsl:value-of select="article/h1"/>", published by Francesca Tomasi</dcterms:description>
                                <schema:about rdf:resource="{concat($vdb, @id, '-expr')}"/>
                                <frbr:partOf rdf:resource="{concat($vdb, $editor,'-letters')}"/>
                                <frbr:realization>
                                    <fabio:Letter rdf:about="{concat($vdb, $editor, '-', @id, '-expr')}">
                                        <rdfs:label xml:lang="it">Testo della lettera "<xsl:value-of select="article/h1"/>"</rdfs:label>
                                        <rdfs:label xml:lang="en">Content of the letter "<xsl:value-of select="article/h1"/>"</rdfs:label>
                                        <dcterms:description xml:lang="it">Testo della lettera "<xsl:value-of select="article/h1"/>", edita da Francesca Tomasi</dcterms:description>
                                        <dcterms:description xml:lang="en">Content of the letter "<xsl:value-of select="article/h1"/>", published by Francesca Tomasi</dcterms:description>
                                        <schema:about rdf:resource="{concat($vdb, @id, '-expr')}"/>
                                        <frbr:partOf rdf:resource="http://dx.doi.org/10.6092/unibo/vespasianodabisticciletters"/>
                                        <frbr:embodiment>
                                            <!-- html transcription -->
                                            <fabio:WebManifestation rdf:about="{concat($vdb, $editor, '-', @id, '-digital-edition')}">
                                                <rdfs:label xml:lang="it">Manifestazione sul web della lettera "<xsl:value-of select="article/h1"/>"</rdfs:label>
                                                <rdfs:label xml:lang="en">Web manifestation of the letter "<xsl:value-of select="article/h1"/>"</rdfs:label>
                                                <dcterms:description xml:lang="it">Edizione digitale della lettera "<xsl:value-of select="article/h1"/>", edita da Francesca Tomasi</dcterms:description>
                                                <dcterms:description xml:lang="en">Web representation of the letter "<xsl:value-of select="article/h1"/>", published by Francesca Tomasi</dcterms:description>
                                                <frbr:partOf rdf:resource="{concat($vdb, $editor,'-letters-digital-edition')}"/>
                                                <frbr:exemplar>
                                                    <frbr:Item rdf:about="{concat($vdb, 'letters/', $html)}">
                                                        <rdfs:label><xsl:value-of select="substring-before($html, '.')"/></rdfs:label>
                                                        <dcterms:identifier><xsl:value-of select="$html"/></dcterms:identifier>
                                                        <frbr:partOf rdf:resource="{$vdb}"/>
                                                        <rdfs:label xml:lang="it"><xsl:value-of select="article/h1"/></rdfs:label>
                                                        <rdfs:label xml:lang="en"><xsl:value-of select="article/h1"/></rdfs:label>
                                                        <dcterms:description xml:lang="it">Edizione digitale online della lettera "<xsl:value-of select="article/h1"/>", edita da Francesca Tomasi</dcterms:description>
                                                        <dcterms:description xml:lang="en">Online digital edition of the letter "<xsl:value-of select="article/h1"/>", published by Francesca Tomasi</dcterms:description>
                                                        <dcterms:source rdf:resource="{concat($vdb, ul/ul[@class='provenance']/li[@class='Identifier']/@href)}"/>
                                                    </frbr:Item>
                                                </frbr:exemplar>
                                            </fabio:WebManifestation>
                                        </frbr:embodiment>
                                        <!-- PREVIOUS EDITIONS | ul[@class='metadata']/ul[@class='editions'] -->
                                        <xsl:if test="ul/ul[@class='editions']/li">
                                            <xsl:for-each select="ul/ul[@class='editions']/li[@class='Edition']">
                                                <cito:citesAsAuthority>
                                                    <fabio:PrintObject rdf:about="{concat($vdb, @href, '-', $id, '-print')}">
                                                        <rdfs:label xml:lang="it"><xsl:value-of select="."/></rdfs:label>
                                                        <rdfs:label xml:lang="en"><xsl:value-of select="."/></rdfs:label>
                                                        <dcterms:description xml:lang="it">Edizione digitale della lettera "<xsl:value-of select="$title"/>", edita da <xsl:value-of select="substring-before(.,',')"/></dcterms:description>
                                                        <dcterms:description xml:lang="en">Web representation of the letter "<xsl:value-of select="$title"/>", published by <xsl:value-of select="substring-before(.,',')"/></dcterms:description>
                                                        <prism:pageRange><xsl:value-of select="span[@class='citedRange']"/></prism:pageRange>
                                                        <frbr:partOf rdf:resource="{concat($vdb, @href, 'ition')}"/>
                                                    </fabio:PrintObject>
                                                </cito:citesAsAuthority>
                                            </xsl:for-each>
                                        </xsl:if>
                                    </fabio:Letter>
                                </frbr:realization>
                            </frbr:Work>
                        </frbr:part>
                    </xsl:for-each>
                </frbr:WorkCollection>
                
                <!-- VDB's LETTERS FRBR HIERARCHY -->
                <!-- TODO xsl:for-each if more than one image/html item is provided -->
                <frbr:WorkCollection rdf:about="{concat($vdb, 'vdb-letters')}">
                    <rdfs:label xml:lang="it">Lettere di Vespasiano da Bisticci</rdfs:label>
                    <rdfs:label xml:lang="en">Vespasiano da Bisticci's Letters</rdfs:label>
                    <dcterms:description xml:lang="it">Lettere di Vespasiano da Bisticci, copista fiorentino vissuto nell'arco del XV secolo</dcterms:description>
                    <dcterms:description xml:lang="en">Vespasiano da Bisticci's letters, a Florentine copyst lived in XV century</dcterms:description>
                    <xsl:for-each select="collection('letters?select=*.html;recurse=yes')/div">
                        <xsl:variable name="id" select="@id"/>
                        <xsl:variable name="title" select="article/h1"/>
                        <frbr:part>
                            <frbr:Work rdf:about="{concat($vdb, @id)}">
                                <rdfs:label xml:lang="it"><xsl:value-of select="article/h1"/></rdfs:label>
                                <rdfs:label xml:lang="en"><xsl:value-of select="article/h1"/></rdfs:label>
                                <dcterms:description xml:lang="it">Lettera "<xsl:value-of select="article/h1"/>", parte della raccolta di lettere di Vespasiano da Bisticci</dcterms:description>
                                <dcterms:description xml:lang="en">Letter "<xsl:value-of select="article/h1"/>", part of the Vespasiano da Bisticci's Letters collection</dcterms:description>
                                <fabio:hasPortrayal rdf:resource="{concat($vdb, ul/ul[@class='provenance']/li[@class='Identifier']/@href)}"/>
                                <frbr:realization>
                                    <fabio:Letter rdf:about="{concat($vdb, @id, '-expr')}">
                                        <rdfs:label xml:lang="it"><xsl:value-of select="article/h1"/></rdfs:label>
                                        <rdfs:label xml:lang="en"><xsl:value-of select="article/h1"/></rdfs:label>
                                        <dcterms:description xml:lang="it">Testo della lettera "<xsl:value-of select="article/h1"/>", parte della raccolta di lettere di Vespasiano da Bisticci</dcterms:description>
                                        <dcterms:description xml:lang="en">Content of the letter "<xsl:value-of select="article/h1"/>", part of the Vespasiano da Bisticci's Letters collection</dcterms:description>
                                        <!-- CURRENT EDITION -->
                                        <schema:subjectOf rdf:resource="{concat($vdb, $editor, '-', @id)}"/>
                                        <schema:subjectOf rdf:resource="{concat($vdb, $editor, '-', @id, '-expr')}"/>
                                        <!-- OTHER EDITIONS | ul[@class='metadata']/ul[@class='editions'] -->
                                        <xsl:if test="ul/ul[@class='editions']/li">
                                            <xsl:for-each select="ul/ul[@class='editions']/li[@class='Edition']">
                                                <schema:subjectOf rdf:resource="{concat($vdb, @href, '-', $id)}"/>
                                                <schema:subjectOf rdf:resource="{concat($vdb, @href, '-', $id, '-expr')}"/>
                                            </xsl:for-each>
                                        </xsl:if>
                                        
                                        <!-- digitizations -->
                                        <xsl:for-each select="ul/ul[@class='visualization']/li[contains(., 'facs')]">
                                            <frbr:embodiment>
                                                <fabio:DigitalManifestation rdf:about="{concat($vdb, $id, '-digital-image')}">
                                                    <rdfs:label xml:lang="it"><xsl:value-of select="$title"/></rdfs:label>
                                                    <rdfs:label xml:lang="en"><xsl:value-of select="$title"/></rdfs:label>
                                                    <dcterms:description xml:lang="it">Manifestazione digitale della lettera "<xsl:value-of select="$title"/>", parte della raccolta di lettere di Vespasiano da Bisticci</dcterms:description>
                                                    <dcterms:description xml:lang="en">Digital manifestation of the letter "<xsl:value-of select="$title"/>", part of the Vespasiano da Bisticci's Letters collection</dcterms:description>
                                                    <!-- digital image -->
                                                    <frbr:exemplar>
                                                        <frbr:Item rdf:about="{concat($vdb, @href)}">
                                                            <rdfs:label xml:lang="it"><xsl:value-of select="$title"/></rdfs:label>
                                                            <rdfs:label xml:lang="en"><xsl:value-of select="$title"/></rdfs:label>
                                                            <dcterms:description xml:lang="it">Immagine digitale della lettera "<xsl:value-of select="$title"/>", parte della raccolta di lettere di Vespasiano da Bisticci</dcterms:description>
                                                            <dcterms:description xml:lang="en">Digital image of the letter "<xsl:value-of select="$title"/>", part of the Vespasiano da Bisticci's Letters collection</dcterms:description>
                                                        </frbr:Item>
                                                    </frbr:exemplar>
                                                </fabio:DigitalManifestation>
                                            </frbr:embodiment>
                                        </xsl:for-each>
                                        
                                        <!-- the analog letter -->
                                        <frbr:embodiment>
                                            <fabio:AnalogManifestation rdf:about="{concat($vdb, @id, '-analog')}">
                                                <rdf:type rdf:resource="http://purl.org/spar/fabio/AnalogManifestation"/>
                                                <rdfs:label xml:lang="it"><xsl:value-of select="article/h1"/></rdfs:label>
                                                <rdfs:label xml:lang="en"><xsl:value-of select="article/h1"/></rdfs:label>
                                                <dcterms:description xml:lang="it">Manifestazione analogica della lettera "<xsl:value-of select="article/h1"/>", parte della raccolta di lettere di Vespasiano da Bisticci</dcterms:description>
                                                <dcterms:description xml:lang="en">Analog manifestation of the letter "<xsl:value-of select="article/h1"/>", part of the Vespasiano da Bisticci's Letters collection</dcterms:description>
                                                <!-- original letter -->
                                                <frbr:exemplar>
                                                    <frbr:Item rdf:about="{concat($vdb, ul/ul[@class='provenance']/li[@class='Identifier']/@href)}">
                                                        <rdfs:label xml:lang="it"><xsl:value-of select="article/h1"/></rdfs:label>
                                                        <rdfs:label xml:lang="en"><xsl:value-of select="article/h1"/></rdfs:label>
                                                        <dcterms:description xml:lang="it">Esemplare originale della lettera "<xsl:value-of select="article/h1"/>", parte della raccolta di lettere di Vespasiano da Bisticci</dcterms:description>
                                                        <dcterms:description xml:lang="en">Original exemplar of the letter "<xsl:value-of select="article/h1"/>", part of the Vespasiano da Bisticci's Letters collection</dcterms:description>
                                                        <pro:isRelatedToRoleInTime rdf:resource="{concat($vdb, vdb:clean(ul/ul/li[@class='Sender']/span/@href),  '-sender-', @id, '-', ul/ul/li/span[@class='TimeInterval']/@href)}"/>
                                                        <pro:isRelatedToRoleInTime rdf:resource="{concat($vdb, vdb:clean(ul/ul/li[@class='Addressee']/span/@href),  '-addressee-', @id)}"/>
                                                        <pro:isRelatedToRoleInTime rdf:resource="{concat($vdb, vdb:clean(ul/ul[@class='provenance']/li[@title='Repository']/span[@class='Organization']/@href),  '-repository-', @id)}"/>
                                                        <dcterms:identifier><xsl:value-of select="ul/ul[@class='provenance']/li[@class='Identifier']"/></dcterms:identifier> 
                                                        <frbr:partOf rdf:resource="{concat($vdb, ul/ul[@class='provenance']/li[@class='Identifier']/@data-partOf)}"/>
                                                        <xsl:for-each select="ul/ul[@class='visualization']/li[contains(., 'facs')]">
                                                            <foaf:depiction rdf:resource="{concat($vdb, @href)}"/>
                                                        </xsl:for-each>
                                                    </frbr:Item>
                                                </frbr:exemplar>
                                            </fabio:AnalogManifestation>
                                        </frbr:embodiment>
                                    </fabio:Letter>
                                </frbr:realization>
                            </frbr:Work>
                        </frbr:part>
                    </xsl:for-each>
                </frbr:WorkCollection>
                
                <!-- see other templates for the text -->
                <xsl:for-each select="collection('letters?select=*.html;recurse=yes')">
                    <xsl:apply-templates select="node()|@*"/>
                </xsl:for-each>
            
                <!-- PEOPLE: authority file -->
                <xsl:for-each select="doc('people.html')/table/tbody/tr">
                    <foaf:Person rdf:about="{concat($vdb, vdb:clean(@id))}">
                        <rdf:type rdf:resource="http://xmlns.com/foaf/0.1/Person"/>
                        <rdfs:label xml:lang="it"><xsl:value-of select="td[2]"/></rdfs:label>
                        <rdfs:label xml:lang="en"><xsl:value-of select="td[2]"/></rdfs:label>
                        <dcterms:description xml:lang="it"><xsl:value-of select="td[2]"/></dcterms:description>
                        <dcterms:description xml:lang="en"><xsl:value-of select="td[2]"/></dcterms:description>
                        <xsl:if test="td[2]/span[@class='date birth-date']">
                            <bio:birth>
                                <bio:Birth rdf:about="{concat($vdb, vdb:clean(@id), '-birth')}">
                                    <rdfs:label xml:lang="it">Nascita di <xsl:value-of select="td[2]"/></rdfs:label>
                                    <rdfs:label xml:lang="en"><xsl:value-of select="td[2]"/>'s birth</rdfs:label>
                                    <dcterms:description xml:lang="it">Nascita di <xsl:value-of select="td[2]"/></dcterms:description>
                                    <dcterms:description xml:lang="en"><xsl:value-of select="td[2]"/>'s birth</dcterms:description>
                                    <dc:date><xsl:value-of select="td[2]/span[@class='date birth-date']"/></dc:date>
                                </bio:Birth>
                            </bio:birth>
                        </xsl:if>
                        <xsl:if test="td[2]/span[@class='date death-date']">
                            <bio:death>
                                <bio:Death rdf:about="{concat($vdb, vdb:clean(@id), '-death')}">
                                    <rdfs:label xml:lang="it">Morte di <xsl:value-of select="td[2]"/></rdfs:label>
                                    <rdfs:label xml:lang="en"><xsl:value-of select="td[2]"/>'s death</rdfs:label>
                                    <dcterms:description xml:lang="it">Morte di <xsl:value-of select="td[2]"/></dcterms:description>
                                    <dcterms:description xml:lang="en"><xsl:value-of select="td[2]"/>'s desth</dcterms:description>
                                    <dc:date><xsl:value-of select="td[2]/span[@class='date death-date']"/></dc:date>
                                </bio:Death>
                            </bio:death>
                        </xsl:if>
                        <xsl:if test="string-length(td[3]) > 0">
                            <xsl:for-each select="td[3]/a/@href">
                                <owl:sameAs rdf:resource="{.}"/>
                            </xsl:for-each>
                        </xsl:if>
                    </foaf:Person>
                </xsl:for-each>
            
                <!-- BIBLIOGRAPHY: authority file -->
                <!-- TODO pages -->
                <xsl:for-each select="doc('biblio.html')/div/span">
                    <frbr:Work rdf:about="{concat($vdb, @id)}">
                        <xsl:variable name="ref" select="@id"/>
                        <xsl:variable name="date" select="span[@class='date']"/>
                        <xsl:variable name="place" select="span[@class='place']"/>
                        <rdfs:label xml:lang="it">
                            <xsl:choose>
                                <xsl:when test="span[@class='author']">"<xsl:value-of>
                                        <xsl:for-each select="span[@class='author']">
                                            <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                        </xsl:for-each>
                                        <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                    </xsl:value-of>"</xsl:when>
                                <xsl:otherwise>"<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                            </xsl:choose>
                        </rdfs:label>
                        <rdfs:label xml:lang="en">
                            <xsl:choose>
                                <xsl:when test="span[@class='author']">"<xsl:value-of>
                                        <xsl:for-each select="span[@class='author']">
                                            <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                        </xsl:for-each>
                                        <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                    </xsl:value-of>"</xsl:when>
                                <xsl:otherwise>"<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                            </xsl:choose>
                        </rdfs:label>
                        <dcterms:description xml:lang="it">
                            <xsl:choose>
                                <xsl:when test="span[@class='author']">"<xsl:value-of>
                                        <xsl:for-each select="span[@class='author']">
                                            <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                        </xsl:for-each>
                                        <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                    </xsl:value-of>"</xsl:when>
                                <xsl:otherwise>"<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                            </xsl:choose>
                        </dcterms:description>
                        <dcterms:description xml:lang="en">
                            <xsl:choose>
                                <xsl:when test="span[@class='author']">"<xsl:value-of>
                                        <xsl:for-each select="span[@class='author']">
                                            <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                        </xsl:for-each>
                                        <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                    </xsl:value-of>"</xsl:when>
                                <xsl:otherwise>"<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                            </xsl:choose>
                        </dcterms:description>
                        <xsl:if test="span[@class='author']">
                            <xsl:for-each select="span[@class='author']">
                                <dcterms:creator>
                                    <rdf:Description rdf:about="{concat($vdb, @href)}">
                                        <rdfs:label xml:lang="it"><xsl:value-of select="."/></rdfs:label>
                                        <rdfs:label xml:lang="en"><xsl:value-of select="."/></rdfs:label>
                                        <dcterms:description xml:lang="it"><xsl:value-of select="."/></dcterms:description>
                                        <dcterms:description xml:lang="en"><xsl:value-of select="."/></dcterms:description>
                                    </rdf:Description>
                                </dcterms:creator>
                            </xsl:for-each>
                        </xsl:if>
                        <dcterms:title><xsl:value-of select="span[@class='title']"/></dcterms:title>
                        <frbr:realization>
                            <xsl:variable name="pub-uri">
                                <xsl:choose>
                                    <xsl:when test="span[@class='publisher']/@href">
                                        <xsl:value-of select="span[@class='publisher']/@href"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="vdb:clean(span[@class='publisher'])"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <xsl:choose>
                                <xsl:when test="@class='book'">
                                    <xsl:variable name="vol">
                                        <xsl:if test="span[@class='volume']">
                                            <xsl:value-of select="concat('-', span[@class='volume'])"/>
                                        </xsl:if>
                                    </xsl:variable>
                                    <fabio:Book rdf:about="{concat($vdb, @id, $vol, '-expr')}">
                                        <rdf:type rdf:resource="http://purl.org/spar/fabio/Book"/>
                                        <rdfs:label xml:lang="it">
                                            <xsl:choose>
                                                <xsl:when test="span[@class='author']">Testo "<xsl:value-of>
                                                    <xsl:for-each select="span[@class='author']">
                                                            <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                        </xsl:for-each>
                                                        <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                    </xsl:value-of>"</xsl:when>
                                                <xsl:otherwise>Testo "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                            </xsl:choose>
                                        </rdfs:label>
                                        <rdfs:label xml:lang="en">
                                            <xsl:choose>
                                                <xsl:when test="span[@class='author']">Text "<xsl:value-of>
                                                        <xsl:for-each select="span[@class='author']">
                                                            <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                        </xsl:for-each>
                                                        <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                    </xsl:value-of>"</xsl:when>
                                                <xsl:otherwise>Text "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                            </xsl:choose>
                                        </rdfs:label>
                                        <dcterms:description xml:lang="it">
                                            <xsl:choose>
                                                <xsl:when test="span[@class='author']">Testo "<xsl:value-of>
                                                        <xsl:for-each select="span[@class='author']">
                                                            <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                        </xsl:for-each>
                                                        <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                    </xsl:value-of>"</xsl:when>
                                                <xsl:otherwise>Text "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                            </xsl:choose>
                                        </dcterms:description>
                                        <dcterms:description xml:lang="en">
                                            <xsl:choose>
                                                <xsl:when test="span[@class='author']">Testo "<xsl:value-of>
                                                        <xsl:for-each select="span[@class='author']">
                                                            <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                        </xsl:for-each>
                                                        <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                    </xsl:value-of>"</xsl:when>
                                                <xsl:otherwise>Testo "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                            </xsl:choose>
                                        </dcterms:description>
                                        <fabio:hasPublicationYear><xsl:value-of select="span[@class='date']"/></fabio:hasPublicationYear>
                                        <dcterms:bibliographicCitation><xsl:value-of select="normalize-space(.)"/></dcterms:bibliographicCitation>
                                        <xsl:if test="span[@class='volume']">
                                            <prism:volume><xsl:value-of select="span[@class='volume']"/></prism:volume>
                                        </xsl:if>
                                        <frbr:embodiment>
                                            <fabio:PrintObject rdf:about="{concat($vdb, @id, 'ition')}">
                                                <rdfs:label xml:lang="it">
                                                    <xsl:choose>
                                                        <xsl:when test="span[@class='author']">Edizione "<xsl:value-of>
                                                                <xsl:for-each select="span[@class='author']">
                                                                    <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                                </xsl:for-each>
                                                                <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                            </xsl:value-of>"</xsl:when>
                                                        <xsl:otherwise>Edizione "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                                    </xsl:choose>
                                                </rdfs:label>
                                                <rdfs:label xml:lang="en">
                                                    <xsl:choose>
                                                        <xsl:when test="span[@class='author']">Edition "<xsl:value-of>
                                                                <xsl:for-each select="span[@class='author']">
                                                                    <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                                </xsl:for-each>
                                                                <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                            </xsl:value-of>"</xsl:when>
                                                        <xsl:otherwise>Edition "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                                    </xsl:choose>
                                                </rdfs:label>
                                                <dcterms:description xml:lang="it">
                                                    <xsl:choose>
                                                        <xsl:when test="span[@class='author']">Edizione "<xsl:value-of>
                                                                <xsl:for-each select="span[@class='author']">
                                                                    <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                                </xsl:for-each>
                                                                <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                            </xsl:value-of>"</xsl:when>
                                                        <xsl:otherwise>Edizione "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                                    </xsl:choose>
                                                </dcterms:description>
                                                <dcterms:description xml:lang="en">
                                                    <xsl:choose>
                                                        <xsl:when test="span[@class='author']">Edition "<xsl:value-of>
                                                                <xsl:for-each select="span[@class='author']">
                                                                    <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                                </xsl:for-each>
                                                                <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                            </xsl:value-of>"</xsl:when>
                                                        <xsl:otherwise>Edition "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                                    </xsl:choose>
                                                </dcterms:description>
                                                
                                                <!-- publisher, place, date -->
                                                <xsl:if test="span[@class='publisher']">
                                                    <pro:isRelatedToRoleInTime>
                                                        <pro:RoleInTime rdf:about="{concat($vdb, @id, '-', $pub-uri, '-publisher-', span[@class='date'])}">
                                                            <rdfs:label xml:lang="it">Edizione di <xsl:value-of select="span[@class='publisher']"/></rdfs:label>
                                                            <rdfs:label xml:lang="en">Publisher <xsl:value-of select="span[@class='publisher']"/></rdfs:label>
                                                            <dcterms:description xml:lang="it">Edizione di <xsl:value-of select="span[@class='publisher']"/></dcterms:description>
                                                            <dcterms:description xml:lang="en">Publisher <xsl:value-of select="span[@class='publisher']"/></dcterms:description>
                                                            <pro:withRole>
                                                                <pro:Role rdf:about="{concat($vdb, 'publisher')}">
                                                                    <rdfs:label xml:lang="it">editore</rdfs:label>
                                                                    <rdfs:label xml:lang="en">publisher</rdfs:label>
                                                                </pro:Role>
                                                            </pro:withRole>
                                                            <pro:isHeldBy>
                                                                <foaf:Organization rdf:about="{concat($vdb, $pub-uri)}">
                                                                    <rdfs:label xml:lang="it"><xsl:value-of select="span[@class='publisher']"/></rdfs:label>
                                                                </foaf:Organization>
                                                            </pro:isHeldBy>
                                                            <tvc:atTime>
                                                                <ti:TimeInterval rdf:about="{concat($vdb, span[@class='date'])}">
                                                                    <rdfs:label xml:lang="it"><xsl:value-of select="span[@class='date']"/></rdfs:label>
                                                                    <rdfs:label xml:lang="en"><xsl:value-of select="span[@class='date']"/></rdfs:label>
                                                                </ti:TimeInterval>
                                                            </tvc:atTime>
                                                            <xsl:if test="span[@class='place']">
                                                                <bio:place>
                                                                    <bio:Place rdf:about="{concat($vdb, span[@class='place']/@href)}">
                                                                        <rdfs:label xml:lang="it"><xsl:value-of select="span[@class='place']"/></rdfs:label>
                                                                    </bio:Place>
                                                                </bio:place>
                                                            </xsl:if>
                                                            <pro:relatesTo rdf:resource="{concat($vdb, @id, 'ition')}"/>
                                                        </pro:RoleInTime>
                                                    </pro:isRelatedToRoleInTime>
                                                </xsl:if>
                                                <xsl:if test="span[@class='editor']">
                                                    <xsl:for-each select="span[@class='editor']">
                                                        <pro:isRelatedToRoleInTime>
                                                            <pro:RoleInTime rdf:about="{concat($vdb, $ref, '-', @href,  '-editor-', $date)}">
                                                                <rdfs:label xml:lang="it">Edizione a cura di <xsl:value-of select="."/></rdfs:label>
                                                                <rdfs:label xml:lang="en">Ed. by <xsl:value-of select="."/></rdfs:label>
                                                                <dcterms:description xml:lang="it">Edizione a cura di <xsl:value-of select="."/></dcterms:description>
                                                                <dcterms:description xml:lang="en">Ed. by <xsl:value-of select="."/></dcterms:description>
                                                                <pro:withRole>
                                                                    <pro:Role rdf:about="{concat($vdb, 'editor')}">
                                                                        <rdfs:label xml:lang="it">curatore</rdfs:label>
                                                                        <rdfs:label xml:lang="en">editor</rdfs:label>
                                                                    </pro:Role>
                                                                </pro:withRole>
                                                                <pro:isHeldBy rdf:resource="{concat($vdb, vdb:clean(.))}"/>
                                                                <tvc:atTime>
                                                                    <ti:TimeInterval rdf:about="{concat($vdb, $date)}">
                                                                        <rdfs:label xml:lang="it"><xsl:value-of select="$date"/></rdfs:label>
                                                                        <rdfs:label xml:lang="en"><xsl:value-of select="$date"/></rdfs:label>
                                                                    </ti:TimeInterval>
                                                                </tvc:atTime>
                                                                <xsl:if test="$place">
                                                                    <bio:place>
                                                                        <bio:Place rdf:about="{concat($vdb, $place/@href)}">
                                                                            <rdfs:label xml:lang="it"><xsl:value-of select="$place"/></rdfs:label>
                                                                        </bio:Place>
                                                                    </bio:place>
                                                                </xsl:if>
                                                                <pro:relatesTo rdf:resource="{concat($vdb, $ref, 'ition')}"/>
                                                            </pro:RoleInTime>
                                                        </pro:isRelatedToRoleInTime>
                                                    </xsl:for-each>    
                                                </xsl:if>
                                                <frbr:exemplar>
                                                    <frbr:Item rdf:about="{concat($vdb, @id, 'ition-item')}">
                                                        <rdfs:label xml:lang="it">
                                                            <xsl:choose>
                                                                <xsl:when test="span[@class='author']">Edizione "<xsl:value-of>
                                                                    <xsl:for-each select="span[@class='author']">
                                                                        <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                                    </xsl:for-each>
                                                                    <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                                </xsl:value-of>"</xsl:when>
                                                                <xsl:otherwise>Edizione "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                                            </xsl:choose>
                                                        </rdfs:label>
                                                        <rdfs:label xml:lang="en">
                                                            <xsl:choose>
                                                                <xsl:when test="span[@class='author']">Edition "<xsl:value-of>
                                                                    <xsl:for-each select="span[@class='author']">
                                                                        <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                                    </xsl:for-each>
                                                                    <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                                </xsl:value-of>"</xsl:when>
                                                                <xsl:otherwise>Edition "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                                            </xsl:choose>
                                                        </rdfs:label>
                                                        <dcterms:description xml:lang="it">
                                                            <xsl:choose>
                                                                <xsl:when test="span[@class='author']">Edizione "<xsl:value-of>
                                                                    <xsl:for-each select="span[@class='author']">
                                                                        <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                                    </xsl:for-each>
                                                                    <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                                </xsl:value-of>"</xsl:when>
                                                                <xsl:otherwise>Edizione "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                                            </xsl:choose>
                                                        </dcterms:description>
                                                        <dcterms:description xml:lang="en">
                                                            <xsl:choose>
                                                                <xsl:when test="span[@class='author']">Edition "<xsl:value-of>
                                                                    <xsl:for-each select="span[@class='author']">
                                                                        <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                                    </xsl:for-each>
                                                                    <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                                </xsl:value-of>"</xsl:when>
                                                                <xsl:otherwise>Edition "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                                            </xsl:choose>
                                                        </dcterms:description>
                                                    </frbr:Item>
                                                </frbr:exemplar>
                                            </fabio:PrintObject>
                                        </frbr:embodiment>
                                    </fabio:Book>
                                </xsl:when>
                                <xsl:when test="@class='article'">
                                    <fabio:Article rdf:about="{concat($vdb, @id, '-expr')}">
                                        <rdf:type rdf:resource="http://purl.org/spar/fabio/Article"/>
                                        <rdfs:label xml:lang="it">
                                            <xsl:choose>
                                                <xsl:when test="span[@class='author']">Testo "<xsl:value-of>
                                                        <xsl:for-each select="span[@class='author']">
                                                            <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                        </xsl:for-each>
                                                        <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                    </xsl:value-of>"</xsl:when>
                                                <xsl:otherwise>Testo "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                            </xsl:choose>
                                        </rdfs:label>
                                        <rdfs:label xml:lang="en">
                                            <xsl:choose>
                                                <xsl:when test="span[@class='author']">Text "<xsl:value-of>
                                                        <xsl:for-each select="span[@class='author']">
                                                            <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                        </xsl:for-each>
                                                        <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                    </xsl:value-of>"</xsl:when>
                                                <xsl:otherwise>Text "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                            </xsl:choose>
                                        </rdfs:label>
                                        <dcterms:description xml:lang="it">
                                            <xsl:choose>
                                                <xsl:when test="span[@class='author']">Testo "<xsl:value-of>
                                                        <xsl:for-each select="span[@class='author']">
                                                            <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                        </xsl:for-each>
                                                        <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                    </xsl:value-of>"</xsl:when>
                                                <xsl:otherwise>Text "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                            </xsl:choose>
                                        </dcterms:description>
                                        <dcterms:description xml:lang="en">
                                            <xsl:choose>
                                                <xsl:when test="span[@class='author']">Text "<xsl:value-of>
                                                        <xsl:for-each select="span[@class='author']">
                                                            <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                        </xsl:for-each>
                                                        <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                    </xsl:value-of>"</xsl:when>
                                                <xsl:otherwise>Text "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                            </xsl:choose>
                                        </dcterms:description>
                                        <fabio:hasPublicationYear><xsl:value-of select="span[@class='date']"/></fabio:hasPublicationYear>
                                        <dcterms:bibliographicCitation><xsl:value-of select="normalize-space(.)"/></dcterms:bibliographicCitation>
                                        <frbr:embodiment>
                                            <frbr:Manifestation rdf:about="{concat($vdb, @id, 'ition')}">
                                                <xsl:if test="span[@class='publisher']">
                                                    <pro:isRelatedToRoleInTime>
                                                        <pro:RoleInTime rdf:about="{concat($vdb, @id,  '-', $pub-uri, '-publisher-', span[@class='date'])}">
                                                            <rdfs:label xml:lang="it"><xsl:value-of select="span[@class='series']"/>, edizione di <xsl:value-of select="span[@class='publisher']"/></rdfs:label>
                                                            <rdfs:label xml:lang="en"><xsl:value-of select="span[@class='series']"/>, publisher <xsl:value-of select="span[@class='publisher']"/></rdfs:label>
                                                            <dcterms:description xml:lang="it"><xsl:value-of select="span[@class='series']"/>, edizione di <xsl:value-of select="span[@class='publisher']"/></dcterms:description>
                                                            <dcterms:description xml:lang="en"><xsl:value-of select="span[@class='series']"/>, publisher <xsl:value-of select="span[@class='publisher']"/></dcterms:description>
                                                            <pro:withRole>
                                                                <pro:Role rdf:about="{concat($vdb, 'publisher')}">
                                                                    <rdfs:label xml:lang="it">editore</rdfs:label>
                                                                    <rdfs:label xml:lang="en">publisher</rdfs:label>
                                                                </pro:Role>
                                                            </pro:withRole>
                                                            <pro:isHeldBy rdf:resource="{concat($vdb, $pub-uri)}"/>
                                                            <tvc:atTime>
                                                                <ti:TimeInterval rdf:about="{concat($vdb, span[@class='date'])}">
                                                                    <rdfs:label xml:lang="it"><xsl:value-of select="span[@class='date']"/></rdfs:label>
                                                                    <rdfs:label xml:lang="en"><xsl:value-of select="span[@class='date']"/></rdfs:label>
                                                                </ti:TimeInterval>
                                                            </tvc:atTime>
                                                            <xsl:if test="span[@class='place']">
                                                                <bio:place>
                                                                    <bio:Place rdf:about="{concat($vdb, span[@class='place']/@href)}">
                                                                        <rdfs:label xml:lang="it"><xsl:value-of select="span[@class='place']"/></rdfs:label>
                                                                    </bio:Place>
                                                                </bio:place>
                                                            </xsl:if>
                                                            <pro:relatesTo rdf:resource="{concat($vdb, @id, 'ition')}"/>
                                                        </pro:RoleInTime>
                                                    </pro:isRelatedToRoleInTime>
                                                </xsl:if>
                                            </frbr:Manifestation>
                                        </frbr:embodiment>
                                        <xsl:choose>
                                            <xsl:when test="span[@class='volume']">
                                                <frbr:partOf>
                                                    <frbr:JournalVolume rdf:about="{concat($vdb, span[@class='series']/@href, '-', vdb:clean(span[@class='volume']), '-expr')}">
                                                        <rdfs:label xml:lang="it"><xsl:value-of select="concat(span[@class='series'], ', volume ', span[@class='volume'])"/></rdfs:label>
                                                        <rdfs:label xml:lang="en"><xsl:value-of select="concat(span[@class='series'], ', volume ', span[@class='volume'])"/></rdfs:label>
                                                        <dcterms:description xml:lang="it">"<xsl:value-of select="concat(span[@class='series'], ', volume ', span[@class='volume'])"/>"</dcterms:description>
                                                        <dcterms:description xml:lang="en">"<xsl:value-of select="concat(span[@class='series'], ', volume ', span[@class='volume'])"/>"</dcterms:description>
                                                        <xsl:if test="span[@class='volume']"><prism:volume><xsl:value-of select="span[@class='volume']"/></prism:volume></xsl:if>
                                                        <dcterms:issued><xsl:value-of select="span[@class='date']"/></dcterms:issued>
                                                        <frbr:partOf>
                                                            <fabio:Journal rdf:about="{concat($vdb, span[@class='series']/@href, '-expr')}">
                                                                <rdfs:label xml:lang="it">Rivista <xsl:value-of select="span[@class='series']"/></rdfs:label>
                                                                <rdfs:label xml:lang="en">Journal <xsl:value-of select="span[@class='series']"/></rdfs:label>
                                                                <dcterms:description xml:lang="it">Rivista "<xsl:value-of select="span[@class='series']"/></dcterms:description>
                                                                <dcterms:description xml:lang="en">Journal <xsl:value-of select="span[@class='series']"/></dcterms:description>
                                                                <xsl:if test="span[@class='editor']">
                                                                    <xsl:for-each select="span[@class='editor']">
                                                                        <pro:isRelatedToRoleInTime>
                                                                            <pro:RoleInTime rdf:about="{concat($vdb, $ref, '-', @href, '-editor-', $date)}">
                                                                                <rdfs:label xml:lang="it">Edizione a cura di <xsl:value-of select="."/></rdfs:label>
                                                                                <rdfs:label xml:lang="en">Ed. by <xsl:value-of select="."/></rdfs:label>
                                                                                <dcterms:description xml:lang="it">Edizione a cura di <xsl:value-of select="."/></dcterms:description>
                                                                                <dcterms:description xml:lang="en">Ed. by <xsl:value-of select="."/></dcterms:description>
                                                                                <pro:withRole>
                                                                                    <pro:Role rdf:about="{concat($vdb, 'editor')}">
                                                                                        <rdfs:label xml:lang="it">curatore</rdfs:label>
                                                                                        <rdfs:label xml:lang="en">editor</rdfs:label>
                                                                                    </pro:Role>
                                                                                </pro:withRole>
                                                                                <pro:isHeldBy rdf:resource="{concat($vdb, vdb:clean(.))}"/>
                                                                                <tvc:atTime>
                                                                                    <ti:TimeInterval rdf:about="{concat($vdb, $date)}">
                                                                                        <rdfs:label xml:lang="it"><xsl:value-of select="$date"/></rdfs:label>
                                                                                        <rdfs:label xml:lang="en"><xsl:value-of select="$date"/></rdfs:label>
                                                                                    </ti:TimeInterval>
                                                                                </tvc:atTime>
                                                                                <xsl:if test="$place">
                                                                                    <bio:place>
                                                                                        <bio:Place rdf:about="{concat($vdb, $place/@href)}">
                                                                                            <rdfs:label xml:lang="it"><xsl:value-of select="$place"/></rdfs:label>
                                                                                        </bio:Place>
                                                                                    </bio:place>
                                                                                </xsl:if>
                                                                                <pro:relatesTo rdf:resource="{concat($vdb, $ref, 'ition')}"/>
                                                                            </pro:RoleInTime>
                                                                        </pro:isRelatedToRoleInTime>
                                                                    </xsl:for-each>    
                                                                </xsl:if>
                                                            </fabio:Journal>
                                                        </frbr:partOf>
                                                    </frbr:JournalVolume>
                                                </frbr:partOf>
                                            </xsl:when>
                                            <xsl:when test="not(span[@class='volume'])">
                                                <frbr:partOf>
                                                    <fabio:Journal rdf:about="{concat($vdb, span[@class='series']/@href, '-expr')}">
                                                        <rdfs:label xml:lang="it">Testo "<xsl:value-of select="span[@class='series']"/>"</rdfs:label>
                                                        <rdfs:label xml:lang="en">Text of "<xsl:value-of select="span[@class='series']"/>"</rdfs:label>
                                                        <dcterms:description xml:lang="it">Testo "<xsl:value-of select="span[@class='series']"/>"</dcterms:description>
                                                        <dcterms:description xml:lang="en">Text of "<xsl:value-of select="span[@class='series']"/>"</dcterms:description>
                                                        <xsl:if test="span[@class='editor']">
                                                            <xsl:for-each select="span[@class='editor']">
                                                                <pro:isRelatedToRoleInTime>
                                                                    <pro:RoleInTime rdf:about="{concat($vdb, $ref, '-', @href,  '-editor-', $date)}">
                                                                        <rdfs:label xml:lang="it">Edizione a cura di <xsl:value-of select="."/></rdfs:label>
                                                                        <rdfs:label xml:lang="en">Ed. by <xsl:value-of select="."/></rdfs:label>
                                                                        <dcterms:description xml:lang="it">Edizione a cura di <xsl:value-of select="."/></dcterms:description>
                                                                        <dcterms:description xml:lang="en">Ed. by <xsl:value-of select="."/></dcterms:description>
                                                                        <pro:withRole>
                                                                            <pro:Role rdf:about="{concat($vdb, 'editor')}">
                                                                                <rdfs:label xml:lang="it">curatore</rdfs:label>
                                                                                <rdfs:label xml:lang="en">editor</rdfs:label>
                                                                            </pro:Role>
                                                                        </pro:withRole>
                                                                        <pro:isHeldBy rdf:resource="{concat($vdb, vdb:clean(.))}"/>
                                                                        <tvc:atTime>
                                                                            <ti:TimeInterval rdf:about="{concat($vdb, $date)}">
                                                                                <rdfs:label xml:lang="it"><xsl:value-of select="$date"/></rdfs:label>
                                                                                <rdfs:label xml:lang="en"><xsl:value-of select="$date"/></rdfs:label>
                                                                            </ti:TimeInterval>
                                                                        </tvc:atTime>
                                                                        <xsl:if test="$place">
                                                                            <bio:place>
                                                                                <bio:Place rdf:about="{concat($vdb, $place/@href)}">
                                                                                    <rdfs:label xml:lang="it"><xsl:value-of select="$place"/></rdfs:label>
                                                                                </bio:Place>
                                                                            </bio:place>
                                                                        </xsl:if>
                                                                        <pro:relatesTo rdf:resource="{concat($vdb, $ref, 'ition')}"/>
                                                                    </pro:RoleInTime>
                                                                </pro:isRelatedToRoleInTime>
                                                            </xsl:for-each>    
                                                        </xsl:if>
                                                    </fabio:Journal>
                                                </frbr:partOf>
                                            </xsl:when>
                                        </xsl:choose>
                                    </fabio:Article>
                                </xsl:when>
                                <xsl:when test="@class='bookset'">
                                    <fabio:Book rdf:about="{concat($vdb, @id, '-expr')}">
                                        <rdf:type rdf:resource="http://purl.org/spar/fabio/Book"/>
                                        <rdfs:label xml:lang="it">
                                            <xsl:choose>
                                                <xsl:when test="span[@class='author']">Testo "<xsl:value-of>
                                                        <xsl:for-each select="span[@class='author']">
                                                            <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                        </xsl:for-each>
                                                        <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                    </xsl:value-of>"</xsl:when>
                                                <xsl:otherwise>Testo "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                            </xsl:choose>
                                        </rdfs:label>
                                        <rdfs:label xml:lang="en">
                                            <xsl:choose>
                                                <xsl:when test="span[@class='author']">Text "<xsl:value-of>
                                                        <xsl:for-each select="span[@class='author']">
                                                            <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                        </xsl:for-each>
                                                        <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                    </xsl:value-of>"</xsl:when>
                                                <xsl:otherwise>Text "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                            </xsl:choose>
                                        </rdfs:label>
                                        <dcterms:description xml:lang="it">
                                            <xsl:choose>
                                                <xsl:when test="span[@class='author']">Testo "<xsl:value-of>
                                                        <xsl:for-each select="span[@class='author']">
                                                            <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                        </xsl:for-each>
                                                        <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                    </xsl:value-of>"</xsl:when>
                                                <xsl:otherwise>Text "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                            </xsl:choose>
                                        </dcterms:description>
                                        <dcterms:description xml:lang="en">
                                            <xsl:choose>
                                                <xsl:when test="span[@class='author']">Text "<xsl:value-of>
                                                        <xsl:for-each select="span[@class='author']">
                                                            <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                        </xsl:for-each>
                                                        <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                    </xsl:value-of>"</xsl:when>
                                                <xsl:otherwise>Text "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                            </xsl:choose>
                                        </dcterms:description>
                                        <fabio:hasPublicationYear><xsl:value-of select="span[@class='date']"/></fabio:hasPublicationYear>
                                        <dcterms:bibliographicCitation><xsl:value-of select="normalize-space(.)"/></dcterms:bibliographicCitation>
                                        <xsl:if test="span[@class='volume']"><prism:volume><xsl:value-of select="span[@class='volume']"/></prism:volume></xsl:if>
                                        <frbr:partOf>
                                            <fabio:BookSet rdf:about="{concat($vdb, span[@class='series']/@href, '-expr')}">
                                                <rdfs:label xml:lang="it"><xsl:value-of select="concat(span[@class='series'], ', ', span[@class='date'])"/></rdfs:label>
                                                <rdfs:label xml:lang="en"><xsl:value-of select="concat(span[@class='series'], ', ', span[@class='date'])"/></rdfs:label>
                                                <dcterms:description xml:lang="it"><xsl:value-of select="concat(span[@class='series'], ', ', span[@class='date'])"/></dcterms:description>
                                                <dcterms:description xml:lang="en"><xsl:value-of select="concat(span[@class='series'], ', ', span[@class='date'])"/></dcterms:description>
                                                <fabio:hasPublicationYear><xsl:value-of select="span[@class='date']"/></fabio:hasPublicationYear>
                                                <xsl:if test="span[@class='place']">
                                                    <dcterms:coverage rdf:resource="{concat($vdb, vdb:clean(span[@class='place']))}"/>
                                                </xsl:if>
                                                <xsl:if test="span[@class='archiv-coll']">
                                                    <dcterms:identifier rdf:resource="{concat($vdb, vdb:clean(span[@class='archiv-coll']))}"/>
                                                </xsl:if>
                                                <frbr:embodiment>
                                                    <frbr:Manifestation rdf:about="{concat($vdb, vdb:clean(span[@class='title']), '-manif')}">
                                                        <rdfs:label xml:lang="it">Edizione <xsl:value-of select="concat(span[@class='series'], ', ', span[@class='date'])"/></rdfs:label>
                                                        <rdfs:label xml:lang="en">Edition <xsl:value-of select="concat(span[@class='series'], ', ', span[@class='date'])"/></rdfs:label>
                                                        <dcterms:description xml:lang="it">Edizione <xsl:value-of select="concat(span[@class='series'], ', ', span[@class='date'])"/></dcterms:description>
                                                        <dcterms:description xml:lang="en">Edition <xsl:value-of select="concat(span[@class='series'], ', ', span[@class='date'])"/></dcterms:description>
                                                        <fabio:hasPublicationYear><xsl:value-of select="span[@class='date']"/></fabio:hasPublicationYear>
                                                        <xsl:if test="span[@class='publisher']">
                                                            <pro:isRelatedToRoleInTime>
                                                                <pro:RoleInTime rdf:about="{concat($vdb, @id, '-', $pub-uri, '-publisher-', span[@class='date'])}">
                                                                    <rdfs:label xml:lang="it">Edizione di <xsl:value-of select="span[@class='publisher']"/></rdfs:label>
                                                                    <rdfs:label xml:lang="en">Publisher <xsl:value-of select="span[@class='publisher']"/></rdfs:label>
                                                                    <dcterms:description xml:lang="it">Edizione di <xsl:value-of select="span[@class='publisher']"/></dcterms:description>
                                                                    <dcterms:description xml:lang="en">Publisher <xsl:value-of select="span[@class='publisher']"/></dcterms:description>
                                                                    <pro:withRole>
                                                                        <pro:Role rdf:about="{concat($vdb, 'publisher')}">
                                                                            <rdfs:label xml:lang="it">editore</rdfs:label>
                                                                            <rdfs:label xml:lang="en">publisher</rdfs:label>
                                                                        </pro:Role>
                                                                    </pro:withRole>
                                                                    <pro:isHeldBy rdf:resource="{concat($vdb, $pub-uri)}"/>
                                                                    <tvc:atTime>
                                                                        <ti:TimeInterval rdf:about="{concat($vdb, span[@class='date'])}">
                                                                            <rdfs:label xml:lang="it"><xsl:value-of select="span[@class='date']"/></rdfs:label>
                                                                            <rdfs:label xml:lang="en"><xsl:value-of select="span[@class='date']"/></rdfs:label>
                                                                        </ti:TimeInterval>
                                                                    </tvc:atTime>
                                                                    <xsl:if test="span[@class='place']">
                                                                        <bio:place>
                                                                            <bio:Place rdf:about="{concat($vdb, span[@class='place']/@href)}">
                                                                                <rdfs:label xml:lang="it"><xsl:value-of select="span[@class='place']"/></rdfs:label>
                                                                            </bio:Place>
                                                                        </bio:place>
                                                                    </xsl:if>
                                                                    <pro:relatesTo rdf:resource="{concat($vdb, @id, 'ition')}"/>
                                                                </pro:RoleInTime>
                                                            </pro:isRelatedToRoleInTime>
                                                        </xsl:if>
                                                        <xsl:if test="span[@class='editor']">
                                                            <xsl:for-each select="span[@class='editor']">
                                                                <pro:isRelatedToRoleInTime>
                                                                    <pro:RoleInTime rdf:about="{concat($vdb, $ref, '-', @href,  '-editor-', $date)}">
                                                                        <rdfs:label xml:lang="it">Edizione a cura di <xsl:value-of select="."/></rdfs:label>
                                                                        <rdfs:label xml:lang="en">Ed. by <xsl:value-of select="."/></rdfs:label>
                                                                        <dcterms:description xml:lang="it">Edizione a cura di <xsl:value-of select="."/></dcterms:description>
                                                                        <dcterms:description xml:lang="en">Ed. by <xsl:value-of select="."/></dcterms:description>
                                                                        <pro:withRole>
                                                                            <pro:Role rdf:about="{concat($vdb, 'editor')}">
                                                                                <rdfs:label xml:lang="it">curatore</rdfs:label>
                                                                                <rdfs:label xml:lang="en">editor</rdfs:label>
                                                                            </pro:Role>
                                                                        </pro:withRole>
                                                                        <pro:isHeldBy rdf:resource="{concat($vdb, vdb:clean(.))}"/>
                                                                        <tvc:atTime>
                                                                            <ti:TimeInterval rdf:about="{concat($vdb, $date)}">
                                                                                <rdfs:label xml:lang="it"><xsl:value-of select="$date"/></rdfs:label>
                                                                                <rdfs:label xml:lang="en"><xsl:value-of select="$date"/></rdfs:label>
                                                                            </ti:TimeInterval>
                                                                        </tvc:atTime>
                                                                        <xsl:if test="$place">
                                                                            <bio:place>
                                                                                <bio:Place rdf:about="{concat($vdb, $place/@href)}">
                                                                                    <rdfs:label xml:lang="it"><xsl:value-of select="$place"/></rdfs:label>
                                                                                </bio:Place>
                                                                            </bio:place>
                                                                        </xsl:if>
                                                                        <pro:relatesTo rdf:resource="{concat($vdb, $ref, 'ition')}"/>
                                                                    </pro:RoleInTime>
                                                                </pro:isRelatedToRoleInTime>
                                                            </xsl:for-each>    
                                                        </xsl:if>
                                                    </frbr:Manifestation>
                                                </frbr:embodiment>
                                            </fabio:BookSet>
                                        </frbr:partOf>
                                        <frbr:embodiment>
                                            <frbr:Manifestation rdf:about="{concat($vdb, @id, 'ition')}">
                                                <rdfs:label xml:lang="it">
                                                    <xsl:choose>
                                                        <xsl:when test="span[@class='author']">"<xsl:value-of>
                                                            <xsl:for-each select="span[@class='author']">
                                                                <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                            </xsl:for-each>
                                                            <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                        </xsl:value-of>"</xsl:when>
                                                        <xsl:otherwise>"<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                                    </xsl:choose>
                                                </rdfs:label>
                                                <rdfs:label xml:lang="en">
                                                    <xsl:choose>
                                                        <xsl:when test="span[@class='author']">"<xsl:value-of>
                                                            <xsl:for-each select="span[@class='author']">
                                                                <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                            </xsl:for-each>
                                                            <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                        </xsl:value-of>"</xsl:when>
                                                        <xsl:otherwise>"<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                                    </xsl:choose>
                                                </rdfs:label>
                                                <dcterms:description xml:lang="it">
                                                    <xsl:choose>
                                                        <xsl:when test="span[@class='author']">"<xsl:value-of>
                                                            <xsl:for-each select="span[@class='author']">
                                                                <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                            </xsl:for-each>
                                                            <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                        </xsl:value-of>"</xsl:when>
                                                        <xsl:otherwise>"<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                                    </xsl:choose>
                                                </dcterms:description>
                                                <dcterms:description xml:lang="en">
                                                    <xsl:choose>
                                                        <xsl:when test="span[@class='author']">"<xsl:value-of>
                                                            <xsl:for-each select="span[@class='author']">
                                                                <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                            </xsl:for-each>
                                                            <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                        </xsl:value-of>"</xsl:when>
                                                        <xsl:otherwise>"<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                                    </xsl:choose>
                                                </dcterms:description>
                                            </frbr:Manifestation>
                                        </frbr:embodiment>
                                    </fabio:Book>
                                </xsl:when>
                                <xsl:when test="@class='chapter'">
                                    <fabio:BookChapter rdf:about="{concat($vdb, @id, '-expr')}">
                                        <rdf:type rdf:resource="http://purl.org/spar/fabio/BookChapter"/>
                                        <rdfs:label xml:lang="it">
                                            <xsl:choose>
                                                <xsl:when test="span[@class='author']">Testo "<xsl:value-of>
                                                    <xsl:for-each select="span[@class='author']">
                                                        <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                    </xsl:for-each>
                                                    <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                </xsl:value-of>"</xsl:when>
                                                <xsl:otherwise>Testo "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                            </xsl:choose>
                                        </rdfs:label>
                                        <rdfs:label xml:lang="en">
                                            <xsl:choose>
                                                <xsl:when test="span[@class='author']">Text "<xsl:value-of>
                                                    <xsl:for-each select="span[@class='author']">
                                                        <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                    </xsl:for-each>
                                                    <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                </xsl:value-of>"</xsl:when>
                                                <xsl:otherwise>Text "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                            </xsl:choose>
                                        </rdfs:label>
                                        <dcterms:description xml:lang="it">
                                            <xsl:choose>
                                                <xsl:when test="span[@class='author']">Testo "<xsl:value-of>
                                                    <xsl:for-each select="span[@class='author']">
                                                        <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                    </xsl:for-each>
                                                    <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                </xsl:value-of>"</xsl:when>
                                                <xsl:otherwise>Text "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                            </xsl:choose>
                                        </dcterms:description>
                                        <dcterms:description xml:lang="en">
                                            <xsl:choose>
                                                <xsl:when test="span[@class='author']">Text "<xsl:value-of>
                                                    <xsl:for-each select="span[@class='author']">
                                                        <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                    </xsl:for-each>
                                                    <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                </xsl:value-of>"</xsl:when>
                                                <xsl:otherwise>Text "<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                            </xsl:choose>
                                        </dcterms:description>
                                        <fabio:hasPublicationYear><xsl:value-of select="span[@class='date']"/></fabio:hasPublicationYear>
                                        <dcterms:bibliographicCitation><xsl:value-of select="normalize-space(.)"/></dcterms:bibliographicCitation>
                                        <xsl:if test="span[@class='volume']"><prism:volume><xsl:value-of select="span[@class='volume']"/></prism:volume></xsl:if>
                                        <frbr:embodiment>
                                            <frbr:Manifestation rdf:about="{concat($vdb, @id, 'ition')}">
                                                <rdfs:label xml:lang="it">
                                                    <xsl:choose>
                                                        <xsl:when test="span[@class='author']">"<xsl:value-of>
                                                            <xsl:for-each select="span[@class='author']">
                                                                <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                            </xsl:for-each>
                                                            <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                        </xsl:value-of>"</xsl:when>
                                                        <xsl:otherwise>"<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                                    </xsl:choose>
                                                </rdfs:label>
                                                <rdfs:label xml:lang="en">
                                                    <xsl:choose>
                                                        <xsl:when test="span[@class='author']">"<xsl:value-of>
                                                            <xsl:for-each select="span[@class='author']">
                                                                <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                            </xsl:for-each>
                                                            <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                        </xsl:value-of>"</xsl:when>
                                                        <xsl:otherwise>"<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                                    </xsl:choose>
                                                </rdfs:label>
                                                <dcterms:description xml:lang="it">
                                                    <xsl:choose>
                                                        <xsl:when test="span[@class='author']">"<xsl:value-of>
                                                            <xsl:for-each select="span[@class='author']">
                                                                <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                            </xsl:for-each>
                                                            <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                        </xsl:value-of>"</xsl:when>
                                                        <xsl:otherwise>"<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                                    </xsl:choose>
                                                </dcterms:description>
                                                <dcterms:description xml:lang="en">
                                                    <xsl:choose>
                                                        <xsl:when test="span[@class='author']">"<xsl:value-of>
                                                            <xsl:for-each select="span[@class='author']">
                                                                <xsl:value-of select="concat(., ',')"></xsl:value-of>
                                                            </xsl:for-each>
                                                            <xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>
                                                        </xsl:value-of>"</xsl:when>
                                                        <xsl:otherwise>"<xsl:value-of select="concat(span[@class='title'], ', ', span[@class='date'])"/>"</xsl:otherwise>
                                                    </xsl:choose>
                                                </dcterms:description>
                                            </frbr:Manifestation>
                                        </frbr:embodiment>
                                        <frbr:partOf>
                                            <fabio:Book rdf:about="{concat($vdb, span[@class='series']/@href, '-expr')}">
                                                <rdfs:label xml:lang="it"><xsl:value-of select="concat(span[@class='series'], ', ', span[@class='date'])"/></rdfs:label>
                                                <rdfs:label xml:lang="en"><xsl:value-of select="concat(span[@class='series'], ', ', span[@class='date'])"/></rdfs:label>
                                                <dcterms:description xml:lang="it"><xsl:value-of select="concat(span[@class='series'], ', ', span[@class='date'])"/></dcterms:description>
                                                <dcterms:description xml:lang="en"><xsl:value-of select="concat(span[@class='series'], ', ', span[@class='date'])"/></dcterms:description>
                                                <fabio:hasPublicationYear><xsl:value-of select="span[@class='date']"/></fabio:hasPublicationYear>
                                                <frbr:embodiment>
                                                    <frbr:Manifestation rdf:about="{concat($vdb, span[@class='series']/@href, '-manif')}">
                                                        <rdfs:label xml:lang="it">Edizione <xsl:value-of select="concat(span[@class='series'], ', ', span[@class='date'])"/></rdfs:label>
                                                        <rdfs:label xml:lang="en">Edition <xsl:value-of select="concat(span[@class='series'], ', ', span[@class='date'])"/></rdfs:label>
                                                        <dcterms:description xml:lang="it">Edizione <xsl:value-of select="concat(span[@class='series'], ', ', span[@class='date'])"/></dcterms:description>
                                                        <dcterms:description xml:lang="en">Edition <xsl:value-of select="concat(span[@class='series'], ', ', span[@class='date'])"/></dcterms:description>
                                                        <fabio:hasPublicationYear><xsl:value-of select="span[@class='date']"/></fabio:hasPublicationYear>
                                                        <xsl:if test="span[@class='place']">
                                                            <dcterms:coverage rdf:resource="{concat($vdb, vdb:clean(span[@class='place']))}"/>
                                                        </xsl:if>
                                                        <fabio:hasPublicationYear><xsl:value-of select="span[@class='date']"/></fabio:hasPublicationYear>
                                                        <xsl:if test="span[@class='publisher']">
                                                            <pro:isRelatedToRoleInTime>
                                                                <pro:RoleInTime rdf:about="{concat($vdb, @id, '-', $pub-uri, '-publisher-', span[@class='date'])}">
                                                                    <rdfs:label xml:lang="it">Edizione di <xsl:value-of select="span[@class='publisher']"/></rdfs:label>
                                                                    <rdfs:label xml:lang="en">Publisher <xsl:value-of select="span[@class='publisher']"/></rdfs:label>
                                                                    <dcterms:description xml:lang="it">Edizione di <xsl:value-of select="span[@class='publisher']"/></dcterms:description>
                                                                    <dcterms:description xml:lang="en">Publisher <xsl:value-of select="span[@class='publisher']"/></dcterms:description>
                                                                    <pro:withRole>
                                                                        <pro:Role rdf:about="{concat($vdb, 'publisher')}">
                                                                            <rdfs:label xml:lang="it">editore</rdfs:label>
                                                                            <rdfs:label xml:lang="en">publisher</rdfs:label>
                                                                        </pro:Role>
                                                                    </pro:withRole>
                                                                    <pro:isHeldBy rdf:resource="{concat($vdb, $pub-uri)}"/>
                                                                    <tvc:atTime>
                                                                        <ti:TimeInterval rdf:about="{concat($vdb, span[@class='date'])}">
                                                                            <rdfs:label xml:lang="it"><xsl:value-of select="span[@class='date']"/></rdfs:label>
                                                                            <rdfs:label xml:lang="en"><xsl:value-of select="span[@class='date']"/></rdfs:label>
                                                                        </ti:TimeInterval>
                                                                    </tvc:atTime>
                                                                    <xsl:if test="span[@class='place']">
                                                                        <bio:place>
                                                                            <bio:Place rdf:about="{concat($vdb, span[@class='place']/@href)}">
                                                                                <rdfs:label xml:lang="it"><xsl:value-of select="span[@class='place']"/></rdfs:label>
                                                                            </bio:Place>
                                                                        </bio:place>
                                                                    </xsl:if>
                                                                    <pro:relatesTo rdf:resource="{concat($vdb, @id, 'ition')}"/>
                                                                </pro:RoleInTime>
                                                            </pro:isRelatedToRoleInTime>
                                                        </xsl:if>
                                                        <xsl:if test="span[@class='editor']">
                                                            <xsl:for-each select="span[@class='editor']">
                                                                <pro:isRelatedToRoleInTime>
                                                                    <pro:RoleInTime rdf:about="{concat($vdb, $ref, '-', @href,  '-editor-', $date)}">
                                                                        <rdfs:label xml:lang="it">Edizione a cura di <xsl:value-of select="."/></rdfs:label>
                                                                        <rdfs:label xml:lang="en">Ed. by <xsl:value-of select="."/></rdfs:label>
                                                                        <dcterms:description xml:lang="it">Edizione a cura di <xsl:value-of select="."/></dcterms:description>
                                                                        <dcterms:description xml:lang="en">Ed. by <xsl:value-of select="."/></dcterms:description>
                                                                        <pro:withRole>
                                                                            <pro:Role rdf:about="{concat($vdb, 'editor')}">
                                                                                <rdfs:label xml:lang="it">curatore</rdfs:label>
                                                                                <rdfs:label xml:lang="en">editor</rdfs:label>
                                                                            </pro:Role>
                                                                        </pro:withRole>
                                                                        <pro:isHeldBy rdf:resource="{concat($vdb, vdb:clean(.))}"/>
                                                                        <tvc:atTime>
                                                                            <ti:TimeInterval rdf:about="{concat($vdb, $date)}">
                                                                                <rdfs:label xml:lang="it"><xsl:value-of select="$date"/></rdfs:label>
                                                                                <rdfs:label xml:lang="en"><xsl:value-of select="$date"/></rdfs:label>
                                                                            </ti:TimeInterval>
                                                                        </tvc:atTime>
                                                                        <xsl:if test="$place">
                                                                            <bio:place>
                                                                                <bio:Place rdf:about="{concat($vdb, $place/@href)}">
                                                                                    <rdfs:label xml:lang="it"><xsl:value-of select="$place"/></rdfs:label>
                                                                                </bio:Place>
                                                                            </bio:place>
                                                                        </xsl:if>
                                                                        <pro:relatesTo rdf:resource="{concat($vdb, $ref, 'ition')}"/>
                                                                    </pro:RoleInTime>
                                                                </pro:isRelatedToRoleInTime>
                                                            </xsl:for-each>    
                                                        </xsl:if>
                                                    </frbr:Manifestation>
                                                </frbr:embodiment>
                                            </fabio:Book>
                                        </frbr:partOf>
                                    </fabio:BookChapter>
                                </xsl:when>
                            </xsl:choose>    
                        </frbr:realization>
                    </frbr:Work>
                </xsl:for-each>
            
                <!-- LEXICON: authority file -->
                <xsl:for-each select="doc('lexicon.html')/table/tbody/tr">
                    <doco:TextChunk rdf:about="{concat($vdb, vdb:clean(@id))}">
                        <xsl:if test="string-length(td[3]) > 0">
                            <fabio:hasSubjectTerm>
                                <fabio:SubjectTerm rdf:about="{concat($vdb, vdb:clean(td[3]))}">
                                    <rdfs:label xml:lang="en"><xsl:value-of select="td[3]"/></rdfs:label>
                                </fabio:SubjectTerm>
                            </fabio:hasSubjectTerm>
                        </xsl:if>
                        <xsl:if test="td[4]/@href">
                            <dcterms:relation rdf:resource="{concat($vdb, td[4]/vdb:clean(@href))}"/>
                        </xsl:if>
                    </doco:TextChunk>
                </xsl:for-each>
            
                <!-- CODICES: authority file -->
                <xsl:for-each select="doc('codices.html')/table/tbody/tr">
                    <fabio:AnalogItem rdf:about="{concat($vdb, vdb:clean(@id))}">
                        <dcterms:description xml:lang="it"><xsl:value-of select="concat(td[2], ', ', td[3], '. ', td[5], ' ', td[6], '. ', td[7])"/></dcterms:description>
                        <xsl:if test="string-length(td[2]) > 0">
                            <rdfs:label xml:lang="it">Codice "<xsl:value-of select="td[2]"/>"</rdfs:label>
                            <dcterms:title><xsl:value-of select="td[2]"/></dcterms:title>
                        </xsl:if>
                        <xsl:if test="string-length(td[4]) > 0">
                            <fabio:isPortrayalOf>
                                <fabio:Work rdf:about="{concat($vdb, td[4]/@href)}">
                                    <rdfs:label xml:lang="it"><xsl:value-of select="td[4]"/></rdfs:label>
                                    <dcterms:title><xsl:value-of select="td[4]"/></dcterms:title>
                                    <xsl:if test="td[4]/@data-sameAs">
                                        <owl:sameAs rdf:resource="{td[4]/@data-sameAs}"/>
                                    </xsl:if>
                                    <xsl:if test="td[3]/@href">
                                        <dcterms:creator>
                                            <foaf:Person rdf:about="{concat($vdb, vdb:clean(td[3]/@href))}">
                                                <rdfs:label xml:lang="it"><xsl:value-of select="td[3]"/></rdfs:label>
                                                <xsl:if test="td[3]/@data-sameAs">
                                                    <owl:sameAs rdf:resource="{td[3]/@data-sameAs}"/>
                                                </xsl:if>
                                            </foaf:Person>
                                        </dcterms:creator>
                                    </xsl:if>
                                </fabio:Work>
                            </fabio:isPortrayalOf>
                        </xsl:if>
                        <xsl:if test="td[7]/@href">
                            <dcterms:identifier><xsl:value-of select="td[7]/@href"/></dcterms:identifier>
                        </xsl:if>
                        <xsl:if test="td[5]/@class">
                            <pro:isRelatedToRoleInTime>
                                <pro:RoleInTime rdf:about="{concat($vdb, td[6]/@href, '-', td[6]/@class, '-', vdb:clean(@id))}">
                                    <rdfs:label xml:lang="it">Codice "<xsl:value-of select="td[2]"/>". <xsl:value-of select="concat(td[5], ' ')"/> <xsl:value-of select="td[6]"/></rdfs:label>
                                    <rdfs:label xml:lang="en">Codex "<xsl:value-of select="td[2]"/>", <xsl:value-of select="concat(td[5]/@class, ' ')"/>: <xsl:value-of select="td[6]"/></rdfs:label>
                                    <dcterms:description xml:lang="it">Codice "<xsl:value-of select="td[2]"/>". <xsl:value-of select="concat(td[5], ' ')"/> <xsl:value-of select="td[6]"/></dcterms:description>
                                    <dcterms:description xml:lang="en">Codex "<xsl:value-of select="td[2]"/>", <xsl:value-of select="concat(td[5]/@class, ' ')"/>: <xsl:value-of select="td[6]"/></dcterms:description>
                                    <pro:withRole>
                                        <pro:Role rdf:about="{concat($vdb, td[6]/@class)}">
                                            <rdfs:label xml:lang="it">
                                                <xsl:choose>
                                                    <xsl:when test="td[6]/@class = 'customer'">committente</xsl:when>
                                                    <xsl:when test="td[6]/@class = 'provider'">fornitore</xsl:when>
                                                    <xsl:when test="td[6]/@class = 'owner'">possessore</xsl:when>
                                                </xsl:choose>
                                            </rdfs:label>
                                            <rdfs:label xml:lang="en"><xsl:value-of select="td[6]/@class"/></rdfs:label>
                                        </pro:Role>
                                    </pro:withRole>
                                    <pro:isHeldBy rdf:resource="{concat($vdb, vdb:clean(td[6]/@href))}"/>
                                    <pro:relatesTo rdf:resource="{concat($vdb, vdb:clean(@id))}"/>
                                    <prov:wasGeneratedBy>
                                        <hico:InterpretationAct rdf:about="{concat($vdb, vdb:clean(@id), '-commission-attribution')}">
                                            <rdfs:label xml:lang="it">Attribuzione della commissione del codice</rdfs:label>
                                            <rdfs:label xml:lang="en">Attribution of the commission of the codex</rdfs:label>
                                            <dcterms:description xml:lang="it">Attribuzione della commissione del codice "<xsl:value-of select="td[2]"/>"</dcterms:description>
                                            <dcterms:description xml:lang="en">Attribution of the commission of the codex "<xsl:value-of select="td[2]"/>"</dcterms:description>
                                            <hico:hasInterpretationType>
                                                <hico:InterpretationType rdf:about="{concat($vdb, 'role-attribution')}">
                                                    <rdfs:label xml:lang="it">Attribuzione di ruolo</rdfs:label>
                                                    <rdfs:label xml:lang="en">Attribution of role</rdfs:label>
                                                </hico:InterpretationType>
                                            </hico:hasInterpretationType>
                                            <hico:hasInterpretationCriterion>
                                                <hico:InterpretationCriterion rdf:about="{concat($vdb, 'philological-analysis')}">
                                                    <rdfs:label xml:lang="it">Analisi del testo</rdfs:label>
                                                    <rdfs:label xml:lang="en">Philological analysis</rdfs:label>
                                                </hico:InterpretationCriterion>
                                            </hico:hasInterpretationCriterion>
                                            <xsl:for-each select="td[8]/a">
                                                <cito:citesAsSource rdf:resource="{concat($vdb, 'letter-', ., '-expr')}"/>
                                                <hico:isExtractedFrom rdf:resource="{concat($vdb, $editor, '-letter-', ., '-expr')}"/>
                                            </xsl:for-each>
                                            <xsl:if test="td[7]/span[@class='Edition']">
                                                <xsl:for-each select="td[7]/span[@class='Edition']">
                                                    <cito:citesAsAuthority rdf:resource="{concat($vdb, @href)}"/>
                                                </xsl:for-each>
                                            </xsl:if>
                                            <prov:wasAssociatedWith rdf:resource="{concat($vdb, $editor)}"/>
                                        </hico:InterpretationAct>
                                    </prov:wasGeneratedBy>
                                </pro:RoleInTime>
                            </pro:isRelatedToRoleInTime>
                        </xsl:if>
                    </fabio:AnalogItem>
                </xsl:for-each>
            
                <!-- CITATIONS: authority file -->
                <xsl:for-each select="doc('citations.html')/table/tbody/tr">
                    <doco:TextChunk rdf:about="{concat($vdb, vdb:clean(@id))}">
                        <xsl:if test="td[4]/span[@class='content']">
                            <c4o:hasContent><xsl:value-of select="normalize-space(td[4]/span[@class='content'])"/></c4o:hasContent>
                        </xsl:if>
                        <xsl:if test="td[4]/span[@class='BibliographicReference']">
                            <dcterms:bibliographicCitation><xsl:value-of select="td[4]/span[@class='BibliographicReference']"/></dcterms:bibliographicCitation>
                        </xsl:if>
                        <frbr:partOf>
                            <frbr:Expression rdf:about="{concat($vdb, td[4]/@href, '-expr')}">
                                <frbr:realizationOf>
                                    <frbr:Work rdf:about="{concat($vdb, td[4]/@href)}">
                                        <xsl:if test="td[4]/@data-sameAs">
                                            <owl:sameAs rdf:resource="{td[4]/@data-sameAs}"/>
                                        </xsl:if>
                                        <xsl:if test="string-length(td[3]) > 0">
                                            <dcterms:creator>
                                                <foaf:Person rdf:about="{concat($vdb, td[3]/@href)}">
                                                    <rdfs:label xml:lang="it"><xsl:value-of select="td[3]"/></rdfs:label>
                                                    <xsl:if test="td[3]/@data-sameAs">
                                                        <owl:sameAs rdf:resource="{td[3]/@data-sameAs}"/>
                                                    </xsl:if>
                                                </foaf:Person>
                                            </dcterms:creator>
                                        </xsl:if>
                                    </frbr:Work>
                                </frbr:realizationOf>
                            </frbr:Expression>
                        </frbr:partOf>
                    </doco:TextChunk>
                </xsl:for-each>
            
                <!-- ARCHIVAL DESCRIPTION :authority file -->
                <xsl:for-each select="doc('descArchiv.html')/div/ul/li">
                <xsl:choose>
                    <xsl:when test="span[@class='Organization']">
                        <san:conservatore rdf:about="{concat($vdb, span[@class='Organization']/@id)}">
                            <rdfs:label xml:lang="it"><xsl:value-of select="span[@class='Organization']"/></rdfs:label>
                            <xsl:if test="span[@class='Organization']/@data-sameAs">
                                <xsl:choose>
                                    <xsl:when test="contains(span[@class='Organization']/@data-sameAs, ' ')">
                                        <owl:sameAs rdf:resource="{substring-before(span[@class='Organization']/@data-sameAs, ' ')}"/>
                                        <owl:sameAs rdf:resource="{substring-after(span[@class='Organization']/@data-sameAs, ' ')}"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <owl:sameAs rdf:resource="{span[@class='Organization']/@data-sameAs}"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:if>
                            <san:has_luogoConservatore>
                                <bio:Place rdf:about="{concat($vdb, span[@class='Place']/@href)}">
                                    <rdfs:label xml:lang="it"><xsl:value-of select="span[@class='Place']"/></rdfs:label>
                                    <xsl:if test="span[@class='Place']/@data-sameAs">
                                        <owl:sameAs rdf:resource="{span[@class='Place']/@data-sameAs}"/>
                                    </xsl:if>
                                </bio:Place>
                            </san:has_luogoConservatore>
                            <san:isConservatoreOf>
                                <san:complessoArchivistico rdf:about="{concat($vdb, span[@class='Fond']/@id)}">
                                    <rdfs:label xml:lang="it"><xsl:value-of select="concat(span[@class='Place'], ', ', span[@class='Organization'], ', ',  span[@class='Fond'])"/></rdfs:label>
                                    <xsl:if test="span[@class='Fond']/@data-sameAs">
                                        <owl:sameAs rdf:resource="{span[@class='Fond']/@data-sameAs}"/>
                                    </xsl:if>
                                </san:complessoArchivistico>
                            </san:isConservatoreOf>
                        </san:conservatore>
                    </xsl:when>
                    <xsl:when test="span[@class='Series'], span[@class='Row'], span[@class='Volume']">
                        <xsl:for-each select="span[@class='Series'], span[@class='Row'], span[@class='Volume']">
                            <fabio:ItemCollection rdf:about="{concat($vdb, @id)}">
                                <rdfs:label xml:lang="it"><xsl:value-of select="."/></rdfs:label>
                                <xsl:if test="@data-partOf">
                                    <frbr:partOf>
                                        <rdf:Description rdf:about="{concat($vdb, @data-partOf)}">
                                            <frbr:part rdf:resource="{concat($vdb, @id)}"/>
                                        </rdf:Description>
                                    </frbr:partOf>
                                </xsl:if>
                            </fabio:ItemCollection>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="span[@class='Manuscript'] | span[@class='Identifier']">
                        <xsl:for-each select="span[@class='Manuscript'] | span[@class='Identifier']">
                            <fabio:AnalogItem rdf:about="{concat($vdb, @id)}">
                                <rdfs:label xml:lang="it"><xsl:value-of select="."/></rdfs:label>
                                <xsl:if test="@data-partOf">
                                    <frbr:partOf>
                                        <rdf:Description rdf:about="{concat($vdb, @data-partOf)}">
                                            <frbr:part rdf:resource="{concat($vdb, @id)}"/>
                                        </rdf:Description>
                                    </frbr:partOf>
                                </xsl:if>
                            </fabio:AnalogItem>
                        </xsl:for-each>
                    </xsl:when>
                </xsl:choose>    
                </xsl:for-each>
            </rdf:RDF>
        </xsl:result-document>
    </xsl:template>
    
    <!--<rdfs:label xml:lang="it"></rdfs:label>
    <rdfs:label xml:lang="en"></rdfs:label>
    <dcterms:description xml:lang="it"></dcterms:description>
    <dcterms:description xml:lang="en"></dcterms:description>-->
    
    <xsl:template match="div">
        <xsl:variable name="id" select="@id"/>
        <xsl:variable name="html" select="ul/ul[@class='visualization']/li[contains(., 'trans')]/@href"/>
        <!-- ***** LETTER ***** -->
        <!-- ROLES | match ul[@class='metadata']/ul[@class='sending-info'] -->
        <!-- sender -->
        <pro:RoleInTime rdf:about="{concat($vdb, vdb:clean(ul/ul/li[@class='Sender']/span/@href),  '-sender-', @id, '-', ul/ul/li[@class='When']/span/@href)}">
            <rdfs:label xml:lang="it">Spedizione della lettera "<xsl:value-of select="article/h1"/>"</rdfs:label>
            <rdfs:label xml:lang="en">Sending of the letter "<xsl:value-of select="article/h1"/>"</rdfs:label>
            <dcterms:description xml:lang="it">La lettera "<xsl:value-of select="article/h1"/>", fu spedita da <xsl:value-of select="ul/ul/li[@class='Sender']/span"/> nel <xsl:value-of select="ul/ul/li[@class='When']/span/@href"/> da <xsl:value-of select="ul/ul/li[@class='From']/span"/></dcterms:description>
            <dcterms:description xml:lang="en">In <xsl:value-of select="ul/ul/li[@class='When']/span"/> the letter "<xsl:value-of select="article/h1"/>", was sent by <xsl:value-of select="ul/ul/li[@class='Sender']/span"/> from <xsl:value-of select="ul/ul/li[@class='From']/span"/></dcterms:description>
            <pro:withRole>
                <pro:Role rdf:about="{concat($vdb, 'sender')}">
                    <rdfs:label xml:lang="it">mittente</rdfs:label>
                    <rdfs:label xml:lang="en">sender</rdfs:label>
                </pro:Role>
            </pro:withRole>
            <pro:isHeldBy rdf:resource="{concat($vdb, vdb:clean(ul/ul/li[@class='Sender']/span/@href))}"/>
            <tvc:atTime>
                <ti:TimeInterval rdf:about="{concat($vdb, ul/ul/li[@class='When']/span/@href)}">
                    <rdfs:label xml:lang="it"><xsl:value-of select="ul/ul/li[@class='When']/span"/></rdfs:label>
                    <rdfs:label xml:lang="en"><xsl:value-of select="ul/ul/li[@class='When']/span"/></rdfs:label>
                </ti:TimeInterval>
            </tvc:atTime>
            <bio:place>
                <bio:Place rdf:about="{concat($vdb, vdb:clean(ul/ul/li[@class='From']/span/@href))}">
                    <rdfs:label xml:lang="it"><xsl:value-of select="ul/ul/li[@class='From']/span"/></rdfs:label>
                    <xsl:if test="ul/ul/li/span[@class='Place']/@data-sameAs">
                        <owl:sameAs rdf:resource="{ul/ul/li/span[@class='Place']/@data-sameAs}"/>
                    </xsl:if>
                </bio:Place>
            </bio:place>
            <pro:relatesTo rdf:resource="{concat($vdb, ul/ul[@class='provenance']/li[@class='Identifier']/@href)}"/>
            <prov:wasGeneratedBy>
                <hico:InterpretationAct rdf:about="{concat($vdb, @id, '-sender-attribution')}">
                    <rdfs:label xml:lang="it">Attribuzione del mittente della lettera "<xsl:value-of select="article/h1"/>"</rdfs:label>
                    <rdfs:label xml:lang="en">Attribution of the sender of the letter "<xsl:value-of select="article/h1"/>"</rdfs:label>
                    <dcterms:description xml:lang="it">Attribuzione del mittente della lettera "<xsl:value-of select="article/h1"/>"</dcterms:description>
                    <dcterms:description xml:lang="en">Attribution of the sender of the letter "<xsl:value-of select="article/h1"/>"</dcterms:description>
                    <hico:hasInterpretationType>
                        <hico:InterpretationType rdf:about="{concat($vdb, 'role-attribution')}">
                            <rdfs:label xml:lang="it">Attribuzione di ruolo</rdfs:label>
                            <rdfs:label xml:lang="en">Attribution of role</rdfs:label>
                        </hico:InterpretationType>
                    </hico:hasInterpretationType>
                    <hico:hasInterpretationCriterion>
                        <hico:InterpretationCriterion rdf:about="{concat($vdb, 'philological-analysis')}">
                            <rdfs:label xml:lang="it">Analisi del testo</rdfs:label>
                            <rdfs:label xml:lang="en">Philological analysis</rdfs:label>
                        </hico:InterpretationCriterion>
                    </hico:hasInterpretationCriterion>
                    <cito:citesAsSource rdf:resource="{concat($vdb, @id, '-expr')}"/>
                    <hico:isExtractedFrom rdf:resource="{concat($vdb, $editor, '-', @id, '-expr')}"/>
                    <prov:wasAssociatedWith rdf:resource="{concat($vdb, $editor)}"/>
                </hico:InterpretationAct>
            </prov:wasGeneratedBy>
        </pro:RoleInTime>
        <!-- addressee -->
        <pro:RoleInTime rdf:about="{concat($vdb, ul/ul/li[@class='Addressee']/span/@href,  '-addressee-', @id)}">
            <rdfs:label xml:lang="it">Ricezione della lettera "<xsl:value-of select="article/h1"/>"</rdfs:label>
            <rdfs:label xml:lang="en">Reception of the letter "<xsl:value-of select="article/h1"/>"</rdfs:label>
            <dcterms:description xml:lang="it"><xsl:value-of select="ul/ul/li[@class='Addressee']/span"/> fu il destinatario della lettera "<xsl:value-of select="article/h1"/>", spedita da <xsl:value-of select="ul/ul/li[@class='Sender']/span"/> nel <xsl:value-of select="ul/ul/li[@class='When']/span"/> da <xsl:value-of select="ul/ul/li[@class='From']/span"/></dcterms:description>
            <dcterms:description xml:lang="en"><xsl:value-of select="ul/ul/li[@class='Addressee']/span"/> was the addressee of the letter "<xsl:value-of select="article/h1"/>", sent in <xsl:value-of select="ul/ul/li[@class='When']/span"/> by <xsl:value-of select="ul/ul/li[@class='Sender']/span"/> from <xsl:value-of select="ul/ul/li[@class='From']/span"/></dcterms:description>
            <pro:withRole>
                <pro:Role rdf:about="{concat($vdb, 'addressee')}">
                    <rdfs:label xml:lang="it">destinatario</rdfs:label>
                    <rdfs:label xml:lang="en">addressee</rdfs:label>
                </pro:Role>
            </pro:withRole>
            <pro:isHeldBy rdf:resource="{concat($vdb, vdb:clean(ul/ul/li[@class='Addressee']/span/@href))}"/>
            <pro:relatesTo rdf:resource="{concat($vdb, ul/ul[@class='provenance']/li[@class='Identifier']/@href)}"/>
            <prov:wasGeneratedBy>
                <hico:InterpretationAct rdf:about="{concat($vdb, @id, '-addressee-attribution')}">
                    <rdfs:label xml:lang="it">Attribuzione del destinatario della lettera "<xsl:value-of select="article/h1"/>"</rdfs:label>
                    <rdfs:label xml:lang="en">Attribution of the addressee of the letter "<xsl:value-of select="article/h1"/>"</rdfs:label>
                    <dcterms:description xml:lang="it">Attribuzione del destinatario della lettera "<xsl:value-of select="article/h1"/>"</dcterms:description>
                    <dcterms:description xml:lang="en">Attribution of the addressee of the letter "<xsl:value-of select="article/h1"/>"</dcterms:description>
                    <hico:hasInterpretationType>
                        <hico:InterpretationType rdf:about="{concat($vdb, 'role-attribution')}">
                            <rdfs:label xml:lang="it">Attribuzione di ruolo</rdfs:label>
                            <rdfs:label xml:lang="en">Attribution of role</rdfs:label>
                        </hico:InterpretationType>
                    </hico:hasInterpretationType>
                    <hico:hasInterpretationCriterion>
                        <hico:InterpretationCriterion rdf:about="{concat($vdb, 'philological-analysis')}">
                            <rdfs:label xml:lang="it">Analisi del testo</rdfs:label>
                            <rdfs:label xml:lang="en">Philological analysis</rdfs:label>
                        </hico:InterpretationCriterion>
                    </hico:hasInterpretationCriterion>
                    <cito:citesAsSource rdf:resource="{concat($vdb, @id, '-expr')}"/>
                    <hico:isExtractedFrom rdf:resource="{concat($vdb, $editor, '-', @id, '-expr')}"/>
                    <prov:wasAssociatedWith rdf:resource="{concat($vdb, $editor)}"/>
                </hico:InterpretationAct>
            </prov:wasGeneratedBy>
        </pro:RoleInTime>
        <!-- repository | match ul[@class='metadata']/ul[@class='provenance'] -->
        <xsl:if test="ul/ul[@class='provenance']/li[@title='Repository']/span[@class='Organization']/@href">
            <pro:RoleInTime rdf:about="{concat($vdb, ul/ul[@class='provenance']/li[@title='Repository']/span[@class='Organization']/@href,  '-repository-', @id)}">
                <rdfs:label xml:lang="it">Provenienza della lettera "<xsl:value-of select="article/h1"/>"</rdfs:label>
                <rdfs:label xml:lang="en">Provenance of the letter "<xsl:value-of select="article/h1"/>"</rdfs:label>
                <dcterms:description xml:lang="it"><xsl:value-of select="ul/ul[@class='provenance']/li[@title='Repository']/span[@class='Organization']"/>, ente conservatore della lettera "<xsl:value-of select="article/h1"/>"</dcterms:description>
                <dcterms:description xml:lang="en"><xsl:value-of select="ul/ul[@class='provenance']/li[@title='Repository']/span[@class='Organization']"/>, curator of the letter "<xsl:value-of select="article/h1"/>"</dcterms:description>
                <pro:withRole>
                    <pro:Role rdf:about="{concat($vdb, 'repository')}">
                        <rdfs:label xml:lang="it">ente conservatore</rdfs:label>
                        <rdfs:label xml:lang="en">repository</rdfs:label>
                    </pro:Role>
                </pro:withRole>
                <pro:isHeldBy>
                    <foaf:Organization rdf:about="{concat($vdb, ul/ul[@class='provenance']/li[@title='Repository']/span[@class='Organization']/@href)}">
                        <rdfs:label xml:lang="it"><xsl:value-of select="ul/ul[@class='provenance']/li[@title='Repository']/span[@class='Organization']"/></rdfs:label>
                        <rdfs:label xml:lang="en"><xsl:value-of select="ul/ul[@class='provenance']/li[@title='Repository']/span[@class='Organization']"/></rdfs:label>
                        <xsl:if test="ul/ul[@class='provenance']/li[@title='Repository']/span[@class='Organization']/@data-sameAs">
                            <owl:sameAs rdf:resource="{ul/ul[@class='provenance']/li[@title='Repository']/span[@class='Organization']/@data-sameAs}"/>
                        </xsl:if>
                    </foaf:Organization>
                </pro:isHeldBy>
                <bio:place>
                    <bio:Place rdf:about="{concat($vdb, ul/ul[@class='provenance']/li[@title='Repository']/span[@class='Place']/@href)}">
                        <rdfs:label xml:lang="it"><xsl:value-of select="ul/ul[@class='provenance']/li[@title='Repository']/span[@class='Place']"/></rdfs:label>
                        <rdfs:label xml:lang="en"><xsl:value-of select="ul/ul[@class='provenance']/li[@title='Repository']/span[@class='Place']"/></rdfs:label>
                        <xsl:if test="ul/ul[@class='provenance']/li[@title='Repository']/span[@class='Place']/@data-sameAs">
                            <owl:sameAs rdf:resource="{ul/ul[@class='provenance']/li[@title='Repository']/span[@class='Place']/@data-sameAs}"/>
                        </xsl:if>
                    </bio:Place>
                </bio:place>
                <pro:relatesTo rdf:resource="{concat($vdb, ul/ul[@class='provenance']/li[@class='Identifier']/@href)}"/>
            </pro:RoleInTime>
        </xsl:if>
        <!-- ID ASSIGNMENT | match ul[@class='metadata']/ul[@class='provenance'] -->
        <!--<lettero:IdentifierAssignment rdf:about="{concat($vdb, vdb:clean(ul/ul[@class='provenance']/li[@title='Repository']/span[@class='Organization']/@title), '-id-', @id)}">
            <lettero:assigned>
                <lettero:Identifier rdf:about="{concat($vdb, vdb:clean(ul/ul[@class='provenance']/li[@class='Identifier']/@title))}">
                    <rdfs:label xml:lang="it"><xsl:value-of select="ul/ul[@class='provenance']/li[@class='Identifier']"/></rdfs:label>
                    <rdfs:label xml:lang="en"><xsl:value-of select="ul/ul[@class='provenance']/li[@class='Identifier']"/></rdfs:label>
                    <dcterms:description xml:lang="it">Collocazione: <xsl:value-of select="ul/ul[@class='provenance']/li[@class='Identifier']"/></dcterms:description>
                    <dcterms:description xml:lang="en">Archival collocation: <xsl:value-of select="ul/ul[@class='provenance']/li[@class='Identifier']"/></dcterms:description>
                </lettero:Identifier>
            </lettero:assigned>
            <lettero:assignedTo rdf:resource="{concat($vdb, @id, '-item')}"/>
            <lettero:assignedBy rdf:resource="{concat($vdb, vdb:clean(ul/ul[@class='provenance']/li[@title='Repository']/span[@class='Organization']/@title))}"/>
        </lettero:IdentifierAssignment>-->
        
        <!-- ***** EDITION OF THE LETTER ***** -->
        <fabio:Letter rdf:about="{concat($vdb, $editor, '-', @id, '-expr')}">
            <!-- title and parts of text -->
            <dcterms:title><xsl:value-of select="article/h1"/></dcterms:title>
            <xsl:for-each select="article/section">
                <xsl:variable name="class" select="@class"></xsl:variable>
                <frbr:part>
                    <doco:TextChunk rdf:about="{concat($vdb, $editor, '-', $id, '-', vdb:clean($class))}">
                        <dcterms:type rdf:resource="{concat($vdb, vdb:clean(@class))}"/>
                        <c4o:hasContent><xsl:value-of select="normalize-space(translate(., '&#10;', ''))"></xsl:value-of></c4o:hasContent>
                        <frbr:embodiment>
                            <fabio:WebManifestation rdf:about="{concat($vdb, $editor, '-', $id, '-', vdb:clean(@class), '-html')}">
                                <frbr:exemplar rdf:resource="{concat($vdb, 'letters/', $html, '#', @id)}"/>
                            </fabio:WebManifestation>
                        </frbr:embodiment>
                        <!-- NAMES -->
                        <!-- attested forms of names: people, places, dates -->
                        <xsl:for-each select="p/span[@class='Person'] | p/span/span[@class='Person'] | p/span[@class='Place'] | p/span/span[@class='Place'] | p/span[@class='TimeInterval'] | p/span/span[@class='TimeInterval']">
                            <po:contains>
                                <doco:TextChunk rdf:about="{concat($vdb, $editor, '-', $id, '-', vdb:clean($class), '-', vdb:clean(@href), '-attested-name-', generate-id(.))}">
                                    <rdfs:label xml:lang="it"><xsl:value-of select="."/></rdfs:label>
                                    <rdfs:label xml:lang="en"><xsl:value-of select="."/></rdfs:label>
                                    <dcterms:description xml:lang="it">Forma attestata del nome "<xsl:value-of select="."/>"</dcterms:description>
                                    <dcterms:description xml:lang="en">Attested form of name "<xsl:value-of select="."/>"</dcterms:description>
                                    <dcterms:type rdf:resource="{concat($vdb, 'attested-name')}"/>
                                    <c4o:hasContent><xsl:value-of select="normalize-space(.)"/></c4o:hasContent>
                                    <dcterms:references>
                                        <xsl:choose>
                                            <xsl:when test="contains(@class, 'Person')">
                                                <foaf:Person rdf:about="{concat($vdb, vdb:clean(@href))}">
                                                    <rdf:type rdf:resource="http://xmlns.com/foaf/0.1/Person"/>
                                                    <xsl:if test="@data-label">
                                                        <rdfs:label xml:lang="it"><xsl:value-of select="@data-label"/></rdfs:label>
                                                    </xsl:if>
                                                    <dcterms:isReferencedBy rdf:resource="{concat($vdb, $editor, '-', $id, '-', vdb:clean($class), '-', vdb:clean(@href), '-attested-name-', generate-id(.))}"/>
                                                </foaf:Person>
                                            </xsl:when>
                                            <xsl:when test="contains(@class, 'Place')">
                                                <bio:Place rdf:about="{concat($vdb, vdb:clean(@href))}">
                                                    <rdf:type rdf:resource="http://purl.org/vocab/bio/0.1/Place"/>
                                                    <dcterms:isReferencedBy rdf:resource="{concat($vdb, $editor, '-', $id, '-', vdb:clean($class), '-', vdb:clean(@href), '-attested-name-', generate-id(.))}"/>
                                                </bio:Place>
                                            </xsl:when>
                                            <xsl:when test="contains(@class, 'TimeInterval')">
                                                <ti:TimeInterval rdf:about="{concat($vdb, vdb:clean(@href))}">
                                                    <rdf:type rdf:resource="http://www.ontologydesignpatterns.org/cp/owl/timeinterval.owl#TimeInterval"/>
                                                    <dcterms:isReferencedBy rdf:resource="{concat($vdb, $editor, '-', $id, '-', vdb:clean($class), '-', vdb:clean(@href), '-attested-name-', generate-id(.))}"/>
                                                </ti:TimeInterval>
                                            </xsl:when>
                                        </xsl:choose>
                                    </dcterms:references>
                                    <dcterms:source rdf:resource="{concat($vdb, 'letters/', substring-after($id,'letter-'))}"/>
                                    <dcterms:creator rdf:resource="{concat($vdb, $editor)}"/>
                                </doco:TextChunk>
                            </po:contains>
                        </xsl:for-each>
                        <!-- NOTES -->
                        <xsl:for-each select="p/span[contains(@class, 'Note')] | p/span/span[contains(@class, 'Note')]">
                            <po:contains>
                                <doco:TextChunk rdf:about="{concat($vdb, $editor, '-', $id, '-', @id)}">
                                    <rdfs:label xml:lang="it">Nota filologica</rdfs:label>
                                    <rdfs:label xml:lang="en">Philological note</rdfs:label>
                                    <dcterms:type rdf:resource="{concat($vdb, 'philological-note')}"/>
                                    <dcterms:type rdf:resource="{concat($vdb, substring-after(@class, 'Note '))}"/>
                                    <c4o:hasContent><xsl:value-of select="normalize-space(.)"/></c4o:hasContent>
                                    <dcterms:description><xsl:value-of select="@data-description"/></dcterms:description>
                                    <dcterms:source rdf:resource="{concat($vdb, 'letters/', substring-after($id,'letter-'))}"/>
                                    <dcterms:creator rdf:resource="{concat($vdb, $editor)}"/>
                                </doco:TextChunk>
                            </po:contains>
                        </xsl:for-each>
                        <!-- LEXICON -->
                        <xsl:for-each select="p/span[contains(@class, 'lexicon')] | p/span/span[contains(@class, 'lexicon')]">
                            <po:contains>
                                <doco:TextChunk rdf:about="{concat($vdb, vdb:clean(@href))}">
                                    <rdfs:label xml:lang="it"><xsl:value-of select="."/></rdfs:label>
                                    <rdfs:label xml:lang="en"><xsl:value-of select="."/></rdfs:label>
                                    <dcterms:description xml:lang="it">Termine di lessico specifico "<xsl:value-of select="."/>"</dcterms:description>
                                    <dcterms:description xml:lang="en">Lexical form "<xsl:value-of select="."/>"</dcterms:description>
                                    <dcterms:type rdf:resource="{concat($vdb, 'lexical-form')}"/>
                                    <c4o:hasContent><xsl:value-of select="normalize-space(.)"/></c4o:hasContent>
                                    <dcterms:source rdf:resource="{concat($vdb, 'letters/', substring-after($id,'letter-'))}"/>
                                </doco:TextChunk>
                            </po:contains>
                        </xsl:for-each>
                        <!-- CODICES -->
                        <xsl:for-each select="p/span[contains(@class, 'Codex')] | p/span/span[contains(@class, 'Codex')]">
                            <po:contains>
                                <doco:TextChunk rdf:about="{concat($vdb, $editor, '-', $id, '-', vdb:clean($class), '-', vdb:clean(@href), '-attested-name-', generate-id(.))}">
                                    <rdfs:label xml:lang="it"><xsl:value-of select="."/></rdfs:label>
                                    <rdfs:label xml:lang="en"><xsl:value-of select="."/></rdfs:label>
                                    <dcterms:description xml:lang="it">Forma attestata del codice "<xsl:value-of select="."/>"</dcterms:description>
                                    <dcterms:description xml:lang="en">Attested reference of codex "<xsl:value-of select="."/>"</dcterms:description>
                                    <dcterms:references rdf:resource="{concat($vdb, vdb:clean(@href))}"/>
                                    <dcterms:source rdf:resource="{concat($vdb, 'letters/', substring-after($id,'letter-'))}"/>
                                </doco:TextChunk>
                            </po:contains>
                        </xsl:for-each>
                        <!-- CITATIONS -->
                        <xsl:for-each select="p/span[contains(@class, 'Quotation')] | p/span/span[contains(@class, 'Quotation')]">
                            <po:contains>
                                <doco:TextChunk rdf:about="{concat($vdb, $editor, '-', $id, '-', vdb:clean($class), '-', vdb:clean(@href))}">
                                    <c4o:hasContent><xsl:value-of select="normalize-space(.)"/></c4o:hasContent>
                                    <c4o:isRelevantTo rdf:resource="{concat($vdb, vdb:clean(@href))}"/>
                                    <dcterms:description xml:lang="it"><xsl:value-of select="@data-description"/></dcterms:description>
                                    <dcterms:source rdf:resource="{concat($vdb, 'letters/', substring-after($id,'letter-'))}"/>
                                </doco:TextChunk>
                            </po:contains>
                        </xsl:for-each>
                    </doco:TextChunk>
                </frbr:part>
            </xsl:for-each>
            <!-- editor's notes -->
            <xsl:for-each select="section[@class='Footnote']">
                <xsl:variable name="id-note" select="@href"/>
                <frbr:complement>
                    <doco:Footnote rdf:about="{concat($vdb, $editor, '-', $id, '-', @href)}"><!-- NEW -->
                        <dcterms:title><xsl:value-of select="h2"/></dcterms:title>
                        <c4o:hasContent><xsl:value-of select="normalize-space(translate(., '&#10;', ''))"></xsl:value-of></c4o:hasContent>
                        <!-- cited editions --> <!-- TODO with c4o -->
                        <xsl:if test="p/span[@class='Edition']">
                            <xsl:for-each select="p/span[@class='Edition']">
                                <po:contains>
                                    <deo:Reference rdf:about="{concat($vdb, $id-note, 'ref-to-', @href)}">
                                        <dcterms:references rdf:resource="{concat($vdb, @href)}"/>
                                    </deo:Reference>
                                </po:contains>
                            </xsl:for-each>
                        </xsl:if>
                    </doco:Footnote>
                </frbr:complement>
            </xsl:for-each>
        </fabio:Letter>
    </xsl:template>
    
    
</xsl:stylesheet>