xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
let $diary:= collection('/db/diary')
return
<table xmlns="http://www.tei-c.org/ns/1.0">
<head type="dTopicListing" >Topics</head>
<row rend="label"><cell>Diary Date</cell><cell>Diary Entry</cell></row>
{   for $text in $diary//tei:seg[@type='dTopic']
      let $date :=$text/preceding::tei:date[1]
     order by $date/@when
      return
      <row >
       <cell n="date">{$date}</cell>
       <cell n="meetingCopy">{$text}</cell>
</row>
}
</table>
