xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
<listBibl xmlns="http://www.tei-c.org/ns/1.0">
{let $biblID := lower-case(request:get-parameter("id", "te0001"))
let $doc := doc('/db/bibl/bibl.xml')
for $eachBibl in tokenize($biblID, "\|")
let $appearancesInDiary := 
    for $biblAppearance in collection('/db/diary')//tei:ref[contains(lower-case(@target), $eachBibl)]
    let $appearanceDate := $biblAppearance/preceding::tei:date[1][@when]
    order by $appearanceDate/@when
    return $appearanceDate
let $bibl := $doc//tei:bibl[@xml:id=$eachBibl]
return 
<bibl>{$bibl/@xml:id}
{$bibl/node()}
<seg type="appearancesInDiary">
{$appearancesInDiary}
</seg>
</bibl>
}
</listBibl>
