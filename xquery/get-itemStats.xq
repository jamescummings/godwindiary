xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
let $type:= request:get-parameter("type", "people")
return
<list xmlns="http://www.tei-c.org/ns/1.0" type="{$type}">
{
for $year in collection('/db/diary')/tei:TEI
let $yearNum := $year//tei:idno[1]
order by $yearNum
return
<item n="{$yearNum}">
{
let $item :=
if($type='people')
then $year//tei:ab//tei:persName
else if($type='events')
then $year//tei:ab//tei:ref[@type='dEvent' or @type='dEntertainment']
else if($type='reading')
then $year//tei:ab//tei:ref[@type='dText']
else if ($type='writing')
then $year//tei:ab//tei:ref[@type='dWrote']
else if ($type='meals')
then $year//tei:ab//tei:seg[@type='dMeal']
else if ($type='meetings')
then $year//tei:ab//tei:seg[@type='dMeeting']
else $year//tei:ab//tei:persName
let $count := count($item)
return $count
}
</item>
}</list>
