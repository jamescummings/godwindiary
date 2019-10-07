xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
let $diary:= collection('/db/diary')
return
<table xmlns="http://www.tei-c.org/ns/1.0">
<head type="dWroteListing" subtype="ALL">All writing activity</head>
<row rend="label"><cell>Diary Date</cell><cell>Diary Entry</cell></row>
{   for $text in $diary//tei:ref[@type='dWrote']
      let $date :=$text/preceding::tei:date[1]
     order by $date/@when
      return
      <row type="dWroteAll">
       <cell n="date">{$date}</cell>
       <cell n="meetingCopy">{$text}</cell>
</row>
}
</table>
