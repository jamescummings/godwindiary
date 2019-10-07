xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";

let $date := request:get-parameter("date", "1797-08")
let $diaryID := concat('g', $date)
let $diaryMap := doc('/db/map/diaryMap.xml')//*[@xml:id=$diaryID][1]
let $diaryBit := collection('/db/diary')//tei:*[@xml:id=$diaryID][1]
let $Type := count(tokenize($date, '-')) cast as xs:integer
let $pbPrev:= data($diaryMap/preceding::pb[1]/@n)
let $yearPrev:= if($diaryID='glist1796') then "1795" else data(substring-after($diaryMap/preceding::year[1]/@xml:id, 'g'))
let $monthPrev := if($diaryID='glist1796') then "1796-09" else data(substring-after($diaryMap/preceding::month[1]/@xml:id, 'g'))
let $dayPrev := if($diaryID='glist1796') then "1796-09-24" else data(substring-after($diaryMap/preceding::day[1]/@xml:id, 'g'))
let $yearNext:= if($diaryID='glist1796') then "1796" else data(substring-after($diaryMap/following::year[1]/@xml:id, 'g'))
let $monthNext:= if($diaryID='glist1796') then "1796-10" else data(substring-after($diaryMap/following::month[1]/@xml:id, 'g'))
let $dayNext:= if($diaryID='glist1796') then "1796-10-25" else data(substring-after($diaryMap/following::day[1]/@xml:id, 'g'))
return 
<div xmlns="http://www.tei-c.org/ns/1.0">
<ab type="{
if($Type=3)
then 'day-nav'
else if($Type=2)
then 'month-nav'
else 'year-nav'
}">
<ptr type="startingFolio" target="{concat('/folio/',$pbPrev)}"/>
<ptr type="dayPrev" target="{concat('/diary/', $dayPrev, '.html')}"/>
<ptr type="monthPrev" target="{concat('/diary/', $monthPrev, '.html')}"/>
<ptr type="yearPrev" target="{concat('/diary/', $yearPrev, '.html')}"/>
<ptr type="dayNext" target="{concat('/diary/', $dayNext, '.html')}"/>
<ptr type="monthNext" target="{concat('/diary/', $monthNext, '.html')}"/>
<ptr type="yearNext" target="{concat('/diary/', $yearNext, '.html')}"/>
</ab>
{$diaryBit}
</div>
