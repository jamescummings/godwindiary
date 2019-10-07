xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace math="java:java.lang.Math";

let $diaryDoc:= document('/db/map/diaryMap.xml')
let $days := $diaryDoc//day
let $day := $days[1+round(util:random(count($days)))]
let $diaryID := $day/@xml:id
let $diaryBit := collection('/db/diary')//tei:ab[@type='dDay'][@xml:id=$diaryID][1]
let $Type := count(tokenize($diaryID, '-')) cast as xs:integer
let $pbPrev:= data($day/preceding::pb[1]/@n)
(:
let $yearPrev:= data(substring-after($day[1]/preceding::year[1]/@xml:id, 'g'))
let $monthPrev := data(substring-after($day[1]/preceding::month[1]/@xml:id, 'g'))
let $dayPrev := data(substring-after($day[1]/preceding::day[1]/@xml:id, 'g'))
let $yearNext:= data(substring-after($day[1]/following::year[1]/@xml:id, 'g'))
let $monthNext:= data(substring-after($day[1]/following::month[1]/@xml:id, 'g'))
let $dayNext:= data(substring-after($day[1]/following::day[1]/@xml:id, 'g'))
:)
return 
<div xmlns="http://www.tei-c.org/ns/1.0">
<ab type="{
if($Type=3)
then 'day-nav'
else if($Type=2)
then 'month-nav'
else 'year-nav'
}">
<!-- <ptr type="startingFolio" target="{concat('/folio/',$pbPrev)}"/>
<ptr type="dayPrev" target="{concat('/diary/', $dayPrev, '.html')}"/>
<ptr type="monthPrev" target="{concat('/diary/', $monthPrev, '.html')}"/>
<ptr type="yearPrev" target="{concat('/diary/', $yearPrev, '.html')}"/>
<ptr type="dayNext" target="{concat('/diary/', $dayNext, '.html')}"/>
<ptr type="monthNext" target="{concat('/diary/', $monthNext, '.html')}"/>
<ptr type="yearNext" target="{concat('/diary/', $yearNext, '.html')}"/>
-->
</ab>
{$diaryBit}
</div>
