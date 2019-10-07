xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
let $diaryMap := doc('/db/map/diaryMap.xml')/diary
let $diaryMapUpdated := data($diaryMap/@updated)
let $numYears := count($diaryMap/year)
let $numMonths := count($diaryMap/year/month)
let $numDays := count($diaryMap/year/month/day)
let $numPages := count($diaryMap//month//pb)
let $diary := collection('/db/diary')/tei:TEI
let $diaryUpdated := data($diary//tei:change[@when][1]/@when)
let $persNames := $diary//tei:persName
let $meetings := $diary//tei:seg[@type='dMeeting']
let $venues:= $diary//tei:placeName[@type='venue']
let $meals := $diary//tei:seg[@type='dMeal']
let $topics := $diary//tei:seg[@type='dTopic']
let $entertainment:= $diary//tei:ref[@type='dEntertainment']
let $event:= $diary//tei:ref[@type='dEvent']
let $wrote:= $diary//tei:ref[@type='dWrote']
let $reading:= $diary//tei:ref[@type='dText']
let $placeNames := $diary//tei:placeName
let $peopleFiles := collection('/db/people')/tei:person
let $peopleFilesNum := count($peopleFiles)
let $peopleFilesMale := count($peopleFiles[@sex='1'])
let $peopleFilesFemale := count($peopleFiles[@sex='2'])
let $authorFiles := collection('/db/authors')/tei:person
let $authorFilesNum := count($authorFiles)
let $lastMod := xmldb:last-modified('/db/authors', 'add01.xml')
return
<list xmlns="http://www.tei-c.org/ns/1.0">
<head>Godwin Project: Overall Stats</head>
<item><seg type="label">Diary Map Last Updated:</seg> {$diaryMapUpdated}<list>
<item><seg type="label">Number of Years:</seg> {$numYears}</item>
<item><seg type="label">Number of Months:</seg> {$numMonths}</item>
<item><seg type="label">Number of Days:</seg> {$numDays}</item>
<item><seg type="label">Number of Pagebreaks:</seg> {$numPages}</item>
</list>
</item>
<item><seg type="label">Diary Files Last Updated:</seg> {$diaryUpdated} <list>
<item>
<seg type="label">Number of Name Instances:</seg> {count($persNames)}</item>
<item><seg type="label">Number of Identified Name Instances:</seg> {count($persNames[@ref])}</item>
<item><seg type="label">Number of Unidentified Name Instances:</seg> {count($persNames[not(@ref)])}</item>
<item><seg type="label">Number of Identified Person Records:</seg> {$peopleFilesNum} (Males: {$peopleFilesMale} Females: {$peopleFilesFemale})</item>
<item><seg type="label">Number of Identified Dramatists Records:</seg> {$authorFilesNum}</item>
<item><seg type="label">Number of Meetings:</seg> {count($meetings)}</item>
<item><seg type="label">Number of Meals:</seg> {count($meals)}</item>
<item><seg type="label">Number of Placenames:</seg> {count($placeNames)}</item>
<item><seg type="label">Number of Venues:</seg> {count($venues)}</item>
<item><seg type="label">Number of Entertainments:</seg> {count($entertainment)}</item>
<item><seg type="label">Number of Events:</seg> {count($event)}</item>
<item><seg type="label">Number of Topics:</seg> {count($topics)}</item>
<item><seg type="label">Number of Acts of Writing:</seg> {count($wrote)}</item>
<item><seg type="label">Number of Acts of Reading:</seg> {count($reading)}</item>
</list>
</item>
<!-- (: count and dateTime is faked, for now, dateTime just taken from author files [FIXME] :) -->
<item><seg type="label">Image Files List Last Updated:</seg> {$lastMod}
<list>
<item><seg type="label">Number of Image Files:</seg> 2695 </item>

</list>


 </item>


</list>
