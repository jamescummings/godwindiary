xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
<listEvent xmlns="http://www.tei-c.org/ns/1.0">
{let $eventID := request:get-parameter("id", "le0001")
for $eachEvent in tokenize($eventID, "\|")
let $event := doc(concat('/db/events/', $eachEvent, '.xml'))/tei:event
return $event
}
</listEvent>
