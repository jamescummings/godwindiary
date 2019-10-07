xquery version "1.0";

(: standard eXist namespaces :)
declare namespace fn="http://www.w3.org/2003/05/xpath-functions";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace session="http://exist-db.org/xquery/session";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";

(: TEI namespace :)
declare namespace tei="http://www.tei-c.org/ns/1.0";

(: enable the query optimizer :)
declare option exist:serialize "indent=yes method=xhtml media-type=text/xml omit-xml-declaration=no";
declare option exist:optimize "enable=yes";


declare function local:start() as element()
{
        <body>
	  <p>Please browse the list of places and statuses, or put
        the name you want to search for in the box and press Go. Use
        Lexicon transliteration.</p>
	</body>
};

let $pageContent :=
   <div>
<table>
    <row type="headers"><cell>Year</cell><cell>Count of persName elements</cell><cell># without @key</cell></row>
{for $diary-year in collection('/db/diary')/tei:TEI
let $idno := $diary-year//tei:idno
let $count := count($diary-year//tei:persName)
let $countNoKey := count($diary-year//tei:persName[not(@ref)])
return
<row>
<cell>{$idno/text()}</cell>
<cell>{$count}</cell>
<cell>{$countNoKey}</cell>
</row>
}</table>
 
</div> 

return
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader>
    <fileDesc>
      <titleStmt>
        <title>Some Random Chart (just testing!) </title>
      </titleStmt>
      <publicationStmt>
        <p>Publication information</p>        
      </publicationStmt>
      <sourceDesc>
        <p>Information about the source</p>
      </sourceDesc>
    </fileDesc>
  </teiHeader>
  <text>
    <body>
{$pageContent}
</body>
  </text>
</TEI>