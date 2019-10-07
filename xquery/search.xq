xquery version "1.0";

(:~ ================================================
    A search test for godwin based on eXist's documentation search.
    ================================================ :)
(: import module namespace xdb="http://exist-db.org/xquery/xmldb"; :)

import module namespace kwic="http://exist-db.org/xquery/kwic";

declare namespace godwin="http://godwindiaries.bodleian.ox.ac.uk"; 
declare namespace tei="http://www.tei-c.org/ns/1.0";

declare option exist:serialize "method=html media-type=text/html expand-xincludes=yes";

declare variable $godwin:FIELDS :=
	<fields>
	<field>collection('/db/diary')//tei:ab[ft:query(., '$q')]</field> 
	<field name="people">collection('/db/people')//tei:person[ft:query(., '$q')]</field>
		<!--field>chapter[ft:query(title, '$q')]</field-->
	</fields>;


(:~
	Display the hits: this function iterates through all hits and calls
	kwic:summarize to print out a summary of each match.
:)
declare function godwin:print($hit as element(), $docXPath as xs:string, $mode as xs:string)
as element()* {
    let $nodeId := util:node-id($hit)
	let $uri := concat('/diary/', $hit/tei:date[1]/@when, '.html')
	let $config :=
		<config xmlns="" width="40"
			table="yes"
			link="{$uri}"/>
    let $matches := kwic:get-matches($hit)
    for $ancestor in ($matches/ancestor::tei:ab)
    return
    <p>
    {data($ancestor/ancestor::tei:div/@xml:id)}
        {kwic:get-summary($ancestor, ($ancestor//exist:match)[1], $config)}
        </p>
};

(:~
	Print the hierarchical context of a hit.
:)
declare function godwin:print-headings($section as element()*, $docXPath as xs:string) {
	for $s at $p in $section/ancestor-or-self::tei:*[@xml:id][1]
	let $nodeId := util:node-id($s)
	let $uri := concat("../",
		util:document-name(root($s)), "?q=",
		escape-uri($docXPath, true()), "&amp;id=", $nodeId, "#", $nodeId
	)
	return
		(" > ", <a href="{$uri}">{data($s/tei:date[1]/@when)} </a>)
};

(:~
	Display the query results.
:)
declare function godwin:print-results($hits as element()*, $docXPath as xs:string) {
	let $mode := request:get-parameter("view", "summary")
	return
		<div id="f-results">
		<p>{$docXPath}</p>
			<p id="f-results-heading">Found: {count($hits)}.</p>
			
				<!--(:if ($mode eq 'summary') then
					for $section in $hits
					let $score := ft:score($section)
										order by $section//tei:date[1]/@when
					return
					    <div class="section">
					        <span class="score">Score: {round-half-to-even($score, 2)}</span>
							<div class="headings">{ godwin:print-headings($section, $docXPath) }</div>
							{ godwin:print($section, $docXPath, $mode) }
						</div>
				else
					<table class="kwic">
					{
						for $section in $hits
	
											order by $section//tei:date[1]/@when

						return (
							<tr>
								<td class="headings" colspan="3">
								{godwin:print-headings($section, $docXPath)}
								</td>
							</tr>,
							godwin:print($section, $docXPath, $mode)
						)
					}
					</table>
					
					:) -->
					
					<table class="kwic">
					{					
					for $section in $hits
					order by $section/tei:date[1]/@when
					return ( 
					<tr>
					<td class="headings" colspan="3" style="text-align:center;">
					{godwin:print-headings($section, $docXPath)}
					</td>
					</tr>,
					<tr>{godwin:print($section, $docXPath, $mode)}</tr>)
					}
					</table>
			
		</div>
};


declare function godwin:process-date($when as xs:string) {
let $a := "b"
return
$when
};

declare function godwin:process-name($name as  element()*){
let $a := "b"
return
$name
};


(:~
	Process the query.
:)
declare function godwin:query() {
	let $q := normalize-space(request:get-parameter("q", ()))
return
if ($q) then
	let $queryType := request:get-parameter("queryType", "or")
	let $field := request:get-parameter("domain", "diary")
	let $fields := if ($field eq "diary") then collection('/db/diary')//tei:ab else collection('/db/people')//tei:person
	let $term := if ($queryType eq 'or') then
					<query>{for $word in tokenize($q, ' ')
					return
					<term>{$word}</term>}</query>
				else if($queryType eq 'phrase') then
					<query>{<phrase>
					{$q}
					</phrase>}</query>
				else <query><bool>{
					for $word in tokenize($q, ' ')
					return
					<term occur="must">{$word}</term>
					}
					</bool></query>
           let $query := $term
           let $hits := $fields[ft:query(., $query)]
           let $count := count($hits)
          return
          <div>
	<p>
	You asked for "{$q}" as  {if ($queryType eq "or") then "an Or" else if ($queryType eq "phrase") then  "a Phrase" else "an And"} query: result: {$count} hits.
</p>
	<div class="results">
          {
           for $hit in $hits
           let $expanded := kwic:expand($hit)
           let $uri :=  if($field eq "diary") then concat('/diary/', $hit/tei:date[1]/@when, '.html') else concat('/people/', $hit/@xml:id, '.html')
           let $heading := if($field eq "diary" and $hit/tei:date[1]/@when)
                                            then godwin:process-date($hit/tei:date[1]/@when)
                                           (: else if($field eq "diary" and not($hit/tei:date[1]/@when) then "Unknown Date":)
                                            else godwin:process-name($hit/tei:persName)
                                                         
           let $config :=
		<config xmlns="" width="120"
			table="no"
			link="{$uri}"/>
           order by $heading ascending
            
           return
           <div>
              <h3><a href="{$uri}">{$heading}</a></h3>
	{kwic:get-summary($expanded, ($expanded//exist:match)[1], $config)}

<!-- <div>DEBUG:{$expanded}</div> -->
	</div>

}
{$query}

</div>
</div>
else ()
	};
	
(:~
    Return the main XML page, which will be transformed into HTML by Cocoon.
    If Javascript is enabled on the client, this function will only be called
    once. All subsequent calls to this script will be made via AJAX and we don't
    need to return the entire page.
:)
declare function godwin:get-page($action as xs:string?) 
as element() {
    <html>
    <head>
    <title>Searching William Godwin's Diary</title>
    </head>
    <body>
                    <div id="f-search">
<h3>Searching William Godwin's Diary</h3>
<p>This search system is still undergoing refinements and will eventually include more options for ways of searching the site.</p>
<p>
There is an experimental targeted search you can search the diary for individual words as 'And' (both words must be present), 'Or' (either word must be present), or 'Phrase' (the words must appear as a phrase). <!--Wildcards such as '*' or '?' may be used in 'And' or 'Or' searches.--> Search terms are case-insensitive. You may currently search the diary, or the notes on people in Godwin's Diary that the project has collected. </p>
                    
                        <form name="f-query" action="search.html" method="GET">
                            <table>
                                <tr>
                                    <td colspan="2">
                                        <label for="q">Search:</label>
                                        <input name="q" type="text" 
							value="{request:get-parameter('q', '')}"/>
                                        <label for="domain">in</label>
                                        <select name="domain">
                                            <option value="diary">Diary</option>
                                            <option value="people">People</option>
                                        </select>
                                    </td>
									<td>
										<strong> Query Type: </strong>
										<select name="queryType">
										             <option value="and">And</option>
											<option value="or">Or</option>
											<option value="phrase">Phrase</option>
										</select>
									</td>
									<td class="f-btn">
                                        <input id="f-btn-search" type="submit" 
                                            name="action" value="Search"/>
                                    </td>
                                </tr>
                            </table>
                            <input type="hidden" name="prev" value="{$action}"/>
                        </form>
<p>
Or there is a general full-text search is provided by our Google Search Appliance.
                    
<span class="searchboxB" style="font-size:100%; display:inline; border:0px; padding:0px; text-align:left;">
<form id="searchform" method="get"
        action="http://googlesearch.oucs.ox.ac.uk/search" style="border:0px;display:inline;">
Search: 
<fieldset style="border:none;display:inline;" >
      <input type="hidden" name="site" value="godwindiary"/>
      <input name="UnitPicture"   type="hidden" value="http://godwindiary.bodleian.ox.ac.uk/images/godwin-logo-sml.png"/>
      <input name="client" value="oxford" type="hidden"/>
      <input name="proxystylesheet" value="oxford" type="hidden"/>
      <input name="Unit" value="William Godwins Diary" type="hidden"/>
      <input name="q" id="input-search" size="15" onfocus="clearsearch();" maxlength="2048" value=""  type="text"/>
      <input name="Go" value="Go!" type="submit"/>
    </fieldset>

  </form>
</span>
</p>

                        <div id="f-result">
						{godwin:query()}
                        </div>
                    </div>
             
</body>
</html>
};

   let $askPass := false()
 
return
	godwin:get-page(())
