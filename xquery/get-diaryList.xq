xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";

let $diaryCollection := collection(/db/diary)
return
<list type="diaryYears" xmlns="http://www.tei-c.org/ns/1.0">
{
for $diary in $diaryCollection//tei:TEI
let $idno := $diary//tei:publicationStmt/tei:idno
order by $idno
return
<item>
<label><ref target="{concat('/diary/', $idno, '.html')}">{$idno/text()}</ref></label>
<list type="diaryMonths">
{
for $diaryMonth in $diary//tei:div[@type='dMonth']
let $month := substring-after($diaryMonth/@xml:id, '-')
return
<item><ref target="{concat('/diary/', $idno, '-', $month, '.html')}">{$month}</ref></item>
}
</list>
</item>
}
</list>
