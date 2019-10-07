xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
<listPerson xmlns="http://www.tei-c.org/ns/1.0">
{
let $personID := upper-case(request:get-parameter("id", "SHE01"))
for $eachPerson in tokenize($personID, "\|")
let $file := concat('/db/people/', $eachPerson, '.xml')
let $person := doc($file)
let $persName := $person/tei:person/tei:persName[1]
let $renderedName := <ab type="renderedName">
{if($persName/tei:surname[text()]) then concat($persName/tei:surname/text(), ', ') else()}
{for $othernames in $persName/tei:*[not(name()='addName')][not(name()='surname')]
return concat(' ', $othernames)}
{if($persName/tei:addName[text()]) then 
for $eachAddName in $persName/tei:addName[text()]
return concat(' (',$eachAddName, ')')
 else()}
</ab>
let $shortName := <ab type="shortName">
{for $forenames in $persName/tei:forename[text()] return concat($forenames, ' ')}
{normalize-space(for $surnames in $persName/tei:surname[text()] return concat($surnames, ' '))}
</ab>
return 
<person xml:id="{$persName/ancestor::tei:person/@xml:id}">
{$persName}

{$renderedName}	
{$shortName}	

</person>
}
</listPerson>
