declare namespace tei="http://www.tei-c.org/ns/1.0";
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
    <div xml:id="chart_div"> </div>
   <div>
<table rend="gv_barchart">
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

   
 </body>
  </text>
</TEI>
