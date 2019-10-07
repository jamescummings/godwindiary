xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
<listPerson xmlns="http://www.tei-c.org/ns/1.0">
{let $personID := lower-case(request:get-parameter("id", "she01"))
for $eachPerson in tokenize($personID, "\|")
let $file := concat('/db/authors/', $eachPerson, '.xml')
let $person := doc($file)
let $appearancesInDiary := 
for $IDs in $person/tei:person/tei:note[@type='works']/tei:listBibl/bibl/@xml:id
let $thisID := data($IDs)
order by $IDs/parent::tei:bibl/@type
return
<ab type="workAppearances" n="{$thisID}">{
    for $workAppearance in collection('/db/diary')//tei:ref[contains(@target, $thisID)]
    let $appearanceDate := $workAppearance/preceding::tei:date[1]
    order by $appearanceDate/@when
    return $appearanceDate
}
</ab>
let $personContent:= $person/tei:person/*
let $id := $person/tei:person/@xml:id
let $sex := $person/tei:person/@sex
return 
<person>{$id} {$sex}
{$personContent}
{$appearancesInDiary}
</person>
}
</listPerson>
