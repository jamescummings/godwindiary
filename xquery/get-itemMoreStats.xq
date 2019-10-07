xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
let $type:= lower-case(request:get-parameter("type", "people"))
let $subtype:= lower-case(request:get-parameter("subtype", "identified"))
return
<list xmlns="http://www.tei-c.org/ns/1.0" type="{$type}" subtype="{$subtype}">
{
for $year in collection('/db/diary')/tei:TEI
let $yearNum := $year//tei:idno[1]
order by $yearNum
return
<item n="{$yearNum}">
{
let $item :=
if($type='people' and $subtype='identified')
then $year//tei:ab//tei:persName[@ref]
else if($type='people' and $subtype='unidentified')
then $year//tei:ab//tei:persName[not(@ref)]
else if($type='people' and $subtype='nah')
then $year//tei:ab//tei:persName[@type='nah']
else if($type='events' and $subtype='accts')
then $year//tei:ab//tei:ref[@type='dEvent' and @subtype='Accts']
else if($type='events' and $subtype='death')
then $year//tei:ab//tei:ref[@type='dEvent' and @subtype='Death']
else if($type='events' and $subtype='exhib')
then $year//tei:ab//tei:ref[@type='dEntertainment' and @subtype='Exhib']
else if($type='events' and $subtype='gardens')
then $year//tei:ab//tei:ref[@type='dEntertainment' and @subtype='Gardens']
else if($type='events' and $subtype='lect')
then $year//tei:ab//tei:ref[@type='dEvent' and @subtype='Lect']
else if($type='events' and $subtype='museo')
then $year//tei:ab//tei:ref[@type='dEntertainment' and @subtype='Museo']
else if($type='events' and $subtype='musical')
then $year//tei:ab//tei:ref[@type='dEntertainment' and @subtype='Musical']
else if($type='events' and $subtype='persevent')
then $year//tei:ab//tei:ref[@type='dEvent' and @subtype='PersEvent']
else if($type='events' and $subtype='pershlth')
then $year//tei:ab//tei:ref[@type='dEvent' and @subtype='PersHlth']
else if($type='events' and $subtype='other')
then $year//tei:ab//tei:ref[@type='dEvent' and @subtype='other']
else if($type='events' and $subtype='publ')
then $year//tei:ab//tei:ref[@type='dEvent' and @subtype='Publ']
else if($type='events' and $subtype='temp')
then $year//tei:ab//tei:ref[@type='dEvent' and @subtype='Temp']
else if($type='events' and $subtype='theat')
then $year//tei:ab//tei:ref[@type='dEntertainment' and @subtype='Theat']
else if($type='events' and $subtype='trial')
then $year//tei:ab//tei:ref[@type='dEvent' and @subtype='Trial']
else if($type='events' and $subtype='weath')
then $year//tei:ab//tei:ref[@type='dEvent' and @subtype='Weath']
else if($type='events' and $subtype='topics')
then $year//tei:ab//tei:seg[@type='dTopic']
else if($type='reading' and $subtype='letterrecvd')
then $year//tei:ab//tei:ref[@type='dText'][@subtype='letterRecvd']
else if($type='reading')
then $year//tei:ab//tei:ref[@type='dText'][@subtype=$subtype]
else if ($type='writing')
then $year//tei:ab//tei:ref[@type='dWrote'][@subtype=$subtype]
else if ($type='meals' and $subtype='bg')
then $year//tei:ab//tei:seg[@type='dMeal'][@subtype='BG'] 
else if ($type='meals' and $subtype='b')
then $year//tei:ab//tei:seg[@type='dMeal'][@subtype='B'] 
else if ($type='meals' and $subtype='tg')
then $year//tei:ab//tei:seg[@type='dMeal'][@subtype='TG'] 
else if ($type='meals' and $subtype='ta')
then $year//tei:ab//tei:seg[@type='dMeal'][@subtype='Ta'] 
else if ($type='meals' and $subtype='dg')
then $year//tei:ab//tei:seg[@type='dMeal'][@subtype='DG'] 
else if ($type='meals' and $subtype='d')
then $year//tei:ab//tei:seg[@type='dMeal'][@subtype='D'] 
else if ($type='meals' and $subtype='sg')
then $year//tei:ab//tei:seg[@type='dMeal'][@subtype='SG'] 
else if ($type='meals' and $subtype='s')
then $year//tei:ab//tei:seg[@type='dMeal'][@subtype='S'] 
else if ($type='meetings' and $subtype='apres')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='Apres']
else if ($type='meetings' and $subtype='apresg')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='ApresG']
else if ($type='meetings' and $subtype='aus')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='Aus']
else if ($type='meetings' and $subtype='c')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='C']
else if ($type='meetings' and $subtype='cn')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='Cn']
else if ($type='meetings' and $subtype='cg')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='CG']
else if ($type='meetings' and $subtype='cgn')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='CGn']
else if ($type='meetings' and $subtype='do')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='Do']
else if ($type='meetings' and $subtype='inv')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='Inv']
else if ($type='meetings' and $subtype='m')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='M']
else if ($type='meetings' and $subtype='name')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='Name']
else if ($type='meetings' and $subtype='ppc')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='ppc']
else if ($type='meetings' and $subtype='ppcg')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='ppcG']
else if ($type='meetings' and $subtype='pr')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='Pr']
else if ($type='meetings' and $subtype='see')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='See']
else if ($type='meetings' and $subtype='send4')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='Send4']
else if ($type='meetings' and $subtype='sitto')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='SitTo']
else if ($type='meetings' and $subtype='sleepat')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='SleepAt']
else if ($type='meetings' and $subtype='sleeps')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='Sleeps']
else if ($type='meetings' and $subtype='sleepother')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='SleepOther']
else if ($type='meetings' and $subtype='sk')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='Sk']
else if ($type='meetings' and $subtype='tohave')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='ToHave']
else if ($type='meetings' and $subtype='other')
then $year//tei:ab//tei:seg[@type='dMeeting'][@subtype='other']
else $year//tei:ab//tei:persName[@ref]
let $count := count($item)
return $count
}
</item>
}</list>
