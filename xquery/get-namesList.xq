xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace session="http://exist-db.org/xquery/session";
declare namespace util="http://exist-db.org/xquery/util";
<table type="people" xmlns="http://www.tei-c.org/ns/1.0" >
<head>Unidentified People Listing</head>
<row rend="label">
 <cell n="name">Name</cell>
 <cell n="name">Number of Mentions</cell>
</row>
{
for $unidentified in doc('/db/map/unidentifiedMap.xml')/tei:div/tei:ab
let $dates := $unidentified/tei:date
let $count := count($dates)
let $venue := count($dates[@n='V'])
let $nah:= count($dates[@type='nah'])
let $name := $unidentified/tei:persName
order by $name
return
<row> <cell n="name"><ref target="{$name/@ref}">{$name}</ref></cell> 
<cell n="count"><seg type="count">{$count}</seg>
 {if($venue gt 0) then <seg type="venue">{$venue}</seg> else()}
{if($nah gt 0) then <seg type="nah">{$nah}</seg> else()}
</cell>
</row>
}
</table>
           
