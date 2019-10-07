xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";

let $diaryMap:= document('/db/map/diaryMap.xml')
return
<tei:list type="diaryYears" >
{
for $year in $diaryMap//year
let $yearNum := substring-after($year/@xml:id, 'g')
order by $yearNum
return
<tei:item>
<tei:label><tei:ref target="{concat('/diary/', $yearNum, '.html')}">{$yearNum}</tei:ref></tei:label>
<tei:list type="diaryMonths">
{
for $diaryMonth in $year/month
let $monthNum := substring-after($diaryMonth/@xml:id, '-')
return
<tei:item><tei:ref target="{concat('/diary/', $yearNum, '-', $monthNum, '.html')}">{$monthNum}</tei:ref></tei:item>
}
</tei:list>
</tei:item>
}
</tei:list>
