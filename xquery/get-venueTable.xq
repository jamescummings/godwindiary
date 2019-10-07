xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $people:= collection('/db/people/') 
return
<table type="venues" xmlns="http://www.tei-c.org/ns/1.0">
<head>Venue Listing</head>
<row rend="label">
 <cell n="venue">Venue</cell>
 <cell n="count">Number of Mentions</cell>
</row>
{

let $peopleAsVenues := $people//tei:person[.//tei:date/@n='venue']
for $person in $peopleAsVenues
let $dates := $person//tei:ab[@type="appearancesInDiary"]//tei:date
let $count := count($dates)
let $venue := count($dates[@n='venue'])
let $nah := count($dates[@type='nah'])
let $persName := $person//tei:persName[1]
let $renderedName := <ab type="renderedName">
{if($persName/tei:surname[text()]) then concat($persName/tei:surname/text(), ', ') else()}
{for $othernames in $persName/tei:*[not(name()='addName')][not(name()='surname')]
return concat(' ', $othernames)}
{if($persName/tei:addName[text()]) then 
for $eachAddName in $persName/tei:addName[text()]
return concat(' (',$eachAddName, ')')
 else()}
</ab>
return
<row>
<cell n="venue">{ 
<ref target="{concat('/people/', $person/@xml:id, '.html')}">{data($renderedName)}</ref>
}
</cell>
<cell><seg type="venueCount" rend="bold">{$venue}</seg> out of <seg type="count">{$count}</seg> 
{if ($nah gt 0) then <seg type="nah">{$nah}</seg> else()}</cell>
</row>
}
</table>
