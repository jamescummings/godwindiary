xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $authors := collection('/db/authors/')
return
<table type="authors" xmlns="http://www.tei-c.org/ns/1.0">
<head>Dramatists in Godwin's Diary</head>
<row rend="label">
 <cell n="name">Name</cell>
 <cell n="birth">Birth Date</cell>
 <cell n="death">Death Date</cell>
<cell n="numWorks">Works</cell>
</row>
{
for $person in $authors/tei:person[not(lower-case(@xml:id)='aaa')][not(lower-case(@xml:id)='aaa01')]
let $id := data($person/@xml:id)
let $name := $person/tei:persName
let $numWorks := count($person/tei:note[@type='works']/tei:listBibl/bibl)
order by if($name/tei:surname[1]/text()) then $name/tei:surname[1] else $name/tei:forename[1],  $name/tei:forename[1], $name/tei:addName[1], $name/tei:roleName[1]
return
<row>
 <cell n="name"><ref target="{concat('/dramatists/', $id, '.html')}">{$name}</ref></cell>
 <cell n="birth">{$person/tei:birth}</cell>
 <cell n="death">{$person/tei:death}</cell>
 <cell n="works">{$numWorks}</cell>
</row>
}
</table>
