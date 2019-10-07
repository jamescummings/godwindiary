xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
<listPerson xmlns="http://www.tei-c.org/ns/1.0">
{let $personID := upper-case(request:get-parameter("id", "SHE01"))
let $allpeople := collection('/db/people')
for $eachPerson in tokenize($personID, "\|")
(:let $file := concat('/db/people/', $eachPerson, '.xml')
let $person := doc($file):)
let $person := $allpeople/tei:person[@xml:id = $eachPerson][1]
let $appearancesInDiary := 
    for $eachYear in collection('/db/diary')/tei:TEI
    let $yearNum := $eachYear//idno[1]
    order by $yearNum
    return
    <ab n="{$yearNum}">{
    for $personAppearance in $eachYear//tei:div[@type='dMonth']//tei:persName[contains(upper-case(@ref), $eachPerson)][not(ancestor::tei:div/@xml:id='glist1796')]
    let $appearanceDate := $personAppearance/preceding::tei:date[1][@when]
    let $venue := if($personAppearance//tei:placeName[@type='venue']) 
        then "venue" else "notVenue"
    let $atHome := if($personAppearance/@type='nah') 
        then "nah" else "ah"
    let $newDate := <date n="{$venue}" type="{$atHome}" when="{data($appearanceDate/@when)}"/>
    order by $appearanceDate/@when
    return $newDate
}
</ab>

 
(:let $results := <ab type="results">
{for $year in collection('/db/diary')/tei:TEI
    let $date := $year//tei:idno[1]
    let $num := count($year//tei:persName[contains(upper-case(@ref), $personID)])
    order by $date
    return
       <seg>[{data($date)}, {
if ($num = 0)
then "null"
else $num}],</seg>
}
</ab>
:)
let $personContent:= $person/*
let $id := $person/@xml:id
let $sex := $person/@sex
return 
<person>{$id} {$sex}
{$personContent}
<ab type="appearancesInDiary">{$appearancesInDiary}</ab>
<!--{$results}-->
</person>
}

</listPerson>

