xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
let $eventType := request:get-parameter("type", "le")
let $coll := collection('/db/diary')/tei:TEI
return
<table type="eventListing" xmlns="http://www.tei-c.org/ns/1.0">
<head type="eventListing" subtype="{$eventType}">Event Listing</head>
<row n="label"><cell>Diary Date</cell><cell>Event Information</cell></row>
{for $event in $coll//tei:ref[@type='dEvent' or @type='dEntertainment'][starts-with(@target, concat('/events/', $eventType))]
let $date := $event/ancestor::tei:ab[@type='dDay']/tei:date[@when][1]
order by $date/@when
return
<row>
<cell>{$date}</cell>
<cell>{$event}</cell>
</row>
}
</table>
