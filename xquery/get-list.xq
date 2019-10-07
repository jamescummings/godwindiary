xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";

let $person := upper-case(request:get-parameter("id", "SHE01"))
let $diary := collection('/db/diary')
return
<div>
{
for $eachPerson in tokenize($person, "\|")
return
<div type="meetings" xmlns="http://www.tei-c.org/ns/1.0">
<head>Meetings with {$eachPerson}</head>
{   for $meeting in $diary//tei:seg[@type='dMeeting' or @type='dMeal'][contains(.//tei:persName/@ref, $eachPerson)]
      let $date := data($meeting/preceding::tei:date[1]/@when)
      let $year := substring-before($date, '-')
     (: let $month := substring-before(substring-after($date, '-'), '-')
      let $day := substring-after(substring-after($date, '-'), '-')
      :)let $type := data($meeting/@type)
      let $subtype := data($meeting/@subtype)
      let $id := concat('m', $date, '_', $type, '_', $subtype)
      let $uri := concat('/diary/', $date, '.html')
      order by $date
      return
      <list type="{$type}">
       <item n="id">{$id}</item>
       <item n="URI">{$uri}</item>
       <item n="subtype">{$subtype}</item>
       <item n="date">{$date}</item>
       <item n="nah">{if($meeting//tei:persName[@type='nah']) then "Not At Home" else "At Home"}</item>
<!--       <item n="yearMonth">{concat($year, '-', $month)}</item>
       <item n="year">{$year}</item>
       <item n="month">{$month}</item>
       <item n="day">{$day}</item>
   -->    <item n="participants">
       {for $participant in $meeting//tei:persName[not(tei:seg/@type='dTopic')]
	 where $participant/not(parent::tei:seg/@type='dTopic')
       return $participant
       }
       </item>
       <item n="numParticipants">{count($meeting//tei:persName)-count($meeting//tei:persName/tei:seg[@type='dTopic'])+1}</item>
       {if($meeting//tei:persName/tei:placeName[@type='venue'])
       then
       <item n="venue">
       {$meeting//tei:persName[tei:placeName/@type='venue']}
       </item>
       else if(lower-case($meeting/@subtype)=('cg', 'dg', 'bg', 'sg', 'tg', 'apresg', 'ppcg', 'sleeps', 'aus'))
	then
	<item n="venue"><persName ref="/people/GOD00.html"><placeName type="venue">William Godwin's</placeName></persName></item>
       else <item n="venue">No Venue</item>
       }
<item n="meetingCopy">{$meeting}</item>  
      </list>
}</div>
}</div>
