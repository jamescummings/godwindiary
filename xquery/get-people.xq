xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
<listPerson xmlns="http://www.tei-c.org/ns/1.0">
{let $personID := upper-case(request:get-parameter("id", "SHE01"))
let $allpeople := collection('/db/people')
for $eachPerson in tokenize($personID, "\|")
let $person := $allpeople/tei:person[@xml:id = $eachPerson][1]
let $personContent:= $person/*
let $id := $person/@xml:id
let $sex := $person/@sex
return 
<person>{$id} {$sex}
{$personContent}
</person>
}
</listPerson>

