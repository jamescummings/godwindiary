xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $people := collection('/db/people/')
return
<table type="people" xmlns="http://www.tei-c.org/ns/1.0">
<head>People Listing</head>
<row rend="label">
 <cell n="name">Name</cell>
 <cell n="birth">Birth Date</cell>
 <cell n="death">Death Date</cell>
 <cell n="sex">Gender</cell>
 <cell n="count">Number of Mentions</cell>
<cell n="occupation">Occupation</cell>
</row>
{
for $person in $people/tei:person[not(@xml:id='AAA')][not(@xml:id='AAA01')]
let $id := data(upper-case($person/@xml:id))
let $dates := $person//tei:ab[@type="appearancesInDiary"]//tei:date
let $count := count($dates)
let $venue := count($dates[@n='venue'])
let $nah:= count($dates[@type='nah'])
let $name := $person/tei:persName
let $sex := data($person/@sex)
order by if($name/tei:surname[1]/text()) then $name/tei:surname[1] else $name/tei:forename[1],  $name/tei:forename[1], $name/tei:addName[1], $name/tei:roleName[1]
return
<row>
 <cell n="name"><ref target="{concat('/people/', $id, '.html')}">{$name}</ref></cell>
 <cell n="birth">{$person/tei:birth}</cell>
 <cell n="death">{$person/tei:death}</cell>
<cell n="sex">{if($sex='1') then 'Male' else if($sex='2') then 'Female' else if($sex='0') then 'Unknown' else if ($sex='9') then 'n/a' else 'Unknown'}</cell>
<cell n="count"><seg type="count">{$count}</seg>
 {if($venue gt 0) then <seg type="venue">{$venue}</seg> else()}
{if($nah gt 0) then <seg type="nah">{$nah}</seg> else()}
</cell>
 <cell n="occupation">{$person/tei:occupation}</cell>
</row>
}
</table>
