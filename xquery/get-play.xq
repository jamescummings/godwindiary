xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
let $biblID := lower-case(request:get-parameter("id", "macb01"))
let $bibl := collection('/db/authors')//tei:bibl[@xml:id=$biblID][1]
let $person := $bibl/ancestor::tei:person
let $appearancesInDiary :=
    for $diaryYear in collection('/db/diary')//tei:TEI
    let $date := $diaryYear//tei:idno[1]
    order by $date
return <ab n="{$date}" xmlns="http://www.tei-c.org/ns/1.0"> {for $workAppearance in $diaryYear//tei:ref[contains(lower-case(@target), $biblID)]
    let $appearanceDate := $workAppearance/preceding::tei:date[1][@when]
    order by $appearanceDate/@when
    return $appearanceDate
} </ab>
return
<div xmlns="http://www.tei-c.org/ns/1.0">
<ab type="appearancesInDiary" xmlns="http://www.tei-c.org/ns/1.0">
{$appearancesInDiary}
</ab>
{$person}
{$bibl}
</div>
