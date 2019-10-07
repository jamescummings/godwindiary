xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
<table type="badDiaryEntries"  xmlns="http://www.tei-c.org/ns/1.0">
<head>Bad dDay Dates</head>
<row rend="label">
<cell>Year     </cell>
<cell>Previous Day</cell>
<cell>Diary Entry</cell>
</row>
{let $collection := collection('/db/diary/')//tei:TEI
for $badDiaryEntry in $collection//tei:ab[@type='dDay'][not(tei:date/@when)]
let $previousDate := $badDiaryEntry/preceding::tei:date[@when][1]
let $idno:= $badDiaryEntry/ancestor::tei:TEI//tei:idno[1]
return
<row>
<cell>{$idno}</cell>
<cell>{$previousDate}</cell>
<cell>{$badDiaryEntry}</cell>
</row>
}</table>
