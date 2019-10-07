xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=text media-type=text/plain";
 
let $diary:= collection('/db/diary')
(: special characters such as left and right curly brace and newline  :)
let $lcb := '{', $rcb := '}', $nl := '
'
(: json file header and footer as well as item header and footers :)
let $json-header := concat($lcb, $nl, ' "items" : [ ')
let $json-footer := concat($nl, '  ]', $nl,$rcb)
let $item-header := concat($nl, '    ', $lcb, '  ')
let $item-footer := concat('    ', $rcb)
return
<results>{$json-header}
{
   string-join(
      for $meeting in $diary//tei:seg[@type='dMeeting' or @type='dMeal'][contains(.//tei:persName/@ref, 'HOL01')]
      let $date := data($meeting/preceding::tei:date[1]/@when)
      let $type := data($meeting/@type)
      let $subtype := data($meeting/@subtype)
      return
<item>{$item-header}
	id:	"{concat($type, '_', $date )}",
	label:	"Meeting on {$date}",
	date:	"{$date}",
	type:	"{$type}",
	subtype:   "{$subtype}",
	
{$item-footer}</item>
   , ', ')
}{$json-footer}</results>
