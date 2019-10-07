xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
let $type:= request:get-parameter("type", "Lect")
let $diary:= collection('/db/diary')
return
<table xmlns="http://www.tei-c.org/ns/1.0">
<head type="eventListing" subtype="{$type}">Events of type {$type}</head>
<row rend="label"><cell>Diary Date</cell>
{if(lower-case($type)='theat') then <cell>Theatre</cell> else()}
<cell>Event</cell></row>
{   for $event in $diary//tei:ref[@type='dEvent' or @type='dEntertainment'][lower-case(@subtype)=lower-case($type)]
      let $date :=$event/preceding::tei:date[1]
      let $theat := if(lower-case($type)='theat') then lower-case($event//tei:placeName[@type][1]/@type) else()
      let $theatre :=(
      if($theat='dl')then "Drury Lane"
      else
      if($theat='cg')then "Covent Garden"
      else
      if($theat='ft')then "Unknown"
      else
      if($theat='lp')then "Sans Souci"
      else
      if($theat='ss')then "Sans Souci"
      else
      if($theat='ba')then "Theatre Royal Bath"
      else
      if($theat='st')then "Stoke Theatre"
      else
      if($theat='pw')then "New Theatre (from 1810 Prince of Wales Theatre)"
      else
      if($theat='ws')then "Westminster School"
      else
      if($theat='rv')then "Royal Victoria"
      else
      if($theat='witn01')then "Unknown"
      else
      if($theat='ad')then "Adelphi"
      else
      if($theat='ki')then "King's"
      else
      if($theat='eo')then "English Opera House"
      else
      if($theat='su')then "Surrey Theatre"
      else
      if($theat='ol')then "Olympic Pavilion (from 1813 Olympic Theatre)"
      else
      if($theat='op')then "Olympic Pavilion (from 1813 Olympic Theatre)"
      else
      if($theat='rc')then "Royal Coburg Theatre"
      else
      if($theat='sw')then "Sadler's Wells"
      else
      if($theat='ac')then "Astley's Circus"
      else
      if($theat='hm')then "Haymarket"
      else
      if($theat='ly')then "Lyceum"
      else
      if($theat='pa')then "Pantheon"
      else
      if($theat='cg')then "Covent Garden"
    else
      $theat)
     order by $date/@when
      return
      <row type="{$type}">
       <cell n="date">{$date}</cell>
  {if(lower-case($type)='theat') then <cell>{if ($theatre='') then "Unknown" else $theatre}</cell> else()} 
       <cell n="meetingCopy">{$event}</cell>
</row>
}
</table>
