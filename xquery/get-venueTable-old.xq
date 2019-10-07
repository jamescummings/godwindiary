xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $diary := collection('/db/diary/')
let $people:= collection('/db/people/') 
return
<table type="venues" xmlns="http://www.tei-c.org/ns/1.0">
<head>Venue Listing</head>
<row rend="label">
 <cell n="venue">Venue</cell>
 <cell n="count">Count</cell>
</row>
{
let $venues := $diary//tei:persName[.//tei:placeName/@type='venue'][@ref]/@ref
for $venue in distinct-values($venues)
let $nameID := substring-before(substring-after($venue, '/people/'), '.html')
let $count := count($venues[. = $venue])
return
<row>
<cell n="venue">{ 
for $eachID in tokenize($nameID, "\|")
let $person := $people//tei:person[@xml:id = $eachID][1]
let $persName := $person/tei:persName
return
<ref target="{concat('/people/', $eachID, '.html')}">{$persName}</ref>
}
</cell>
<cell>{$count}</cell>
</row>
}
</table>
