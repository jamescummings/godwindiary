xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
let $personID := upper-case(request:get-parameter("id", "SHE01"))
let $diary := collection('/db/diary/')
let $eachPerson := $personID
let $file := concat('/db/people/', $eachPerson, '.xml')
let $person := doc($file)
let $thisID := $person/tei:person/@xml:id

(:for $eachPerson in tokenize($personID, "\|"):)
return
<list xmlns="http://www.tei-c.org/ns/1.0">
<head n="{$personID}">Acquaintances of {$personID}</head>
{
let $eachPerson := $personID
let $file := concat('/db/people/', $eachPerson, '.xml')
let $person := doc($file)
let $thisID := $person/tei:person/@xml:id
let $meetingPpl := $diary//tei:persName[contains(@ref, $thisID)]/parent::node()/tei:persName[@ref]
let $trimmedRef := $meetingPpl/substring-after(substring-before(@ref, '.html'), '/people/')
let $trimmedUpRef := for $x in $trimmedRef return tokenize(replace($x, "\|", ' '), ' ')

for $eachRef in distinct-values($trimmedUpRef)
let $count := count($trimmedUpRef[.=$eachRef])
where not($eachRef=$thisID)
order by $count descending
return 
<persName ref="{$eachRef}" n="{$count}"/>

}
</list>
