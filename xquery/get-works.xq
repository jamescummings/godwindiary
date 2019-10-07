xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
<listBibl xmlns="http://www.tei-c.org/ns/1.0">
{let $workID := lower-case(request:get-parameter("id", "delo01"))
for $eachWork in tokenize($workID, "\|")
let $work := document('/db/people/GOD00.xml')//tei:bibl[@xml:id=$eachWork][1]
let $appearancesInDiary :=
    for $diaryYear in collection('/db/diary')//tei:TEI 
    let $date := $diaryYear//tei:idno[1]
    order by $date
return <ab n="{$date}"> {for $workAppearance in $diaryYear//tei:ref[contains(lower-case(@target), $eachWork)]
    let $appearanceDate := $workAppearance/preceding::tei:date[1][@when]
    order by $appearanceDate/@when
    return $appearanceDate
}
</ab>

let $type := $work/@type
let $ID := $work/@xml:id
let $personID := $work/ancestor::tei:person/@xml:id
let $persName := $work/ancestor::tei:person/tei:persName
return 
<bibl>{$type}{$ID}
<author ref="{concat('/people/',data($personID),'.html#',$ID)}">
{$persName}
</author>
{$work/*}
<ab type="appearancesInDiary">{$appearancesInDiary}</ab>
</bibl>
}
</listBibl>
