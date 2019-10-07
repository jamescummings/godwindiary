xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
<div xmlns="http://www.tei-c.org/ns/1.0">
{
let $personID := request:get-parameter("id", "HSmith")
let $unidentifiedPeople := document('/db/map/unidentifiedMap.xml')
for $eachPerson in tokenize(normalize-space(lower-case($personID)), "\|")
for $unidentified in $unidentifiedPeople/tei:div/tei:ab[@type='unidentifiedPerson'][substring-before(substring-after(tei:persName/@ref, '/people/unidentified/'), '.html') = $eachPerson][1]
return $unidentified
}
</div>
