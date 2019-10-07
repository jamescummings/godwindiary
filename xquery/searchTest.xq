xquery version "1.0";
import module namespace kwic="http://exist-db.org/xquery/kwic";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";



<div xmlns="http://www.tei-c.org/ns/1.0">
{let $searchQuery := lower-case(request:get-parameter("q", "holcroft"))
let $width := <config xmlns="" width="40"/>
for $hit in collection('/db/diary')//tei:ab[ft:query(., $searchQuery)]
let $date := $hit/tei:date[1]
order by $date/@when ascending
return
<div type="hit" xmlns="http://www.tei-c.org/ns/1.0">
{$date}
{kwic:summarize($hit, $width) }
</div>
}
</div>
