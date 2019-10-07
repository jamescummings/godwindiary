xquery version "1.0";

(:~ ================================================
    A search test for godwin based on eXist's documentation search.
    ================================================ :)
(: import module namespace xdb="http://exist-db.org/xquery/xmldb"; :)

import module namespace kwic="http://exist-db.org/xquery/kwic";

declare namespace godwin="http://godwin.oucs.ox.ac.uk";
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


(:~
	Process the query.
:)
declare function godwin:query() {
	let $query := request:get-parameter("q", ())
	let $field := request:get-parameter("domain", "diary")
	return
		if ($query) then
			let $fields := 
				if ($field ne "diary") then $godwin:FIELDS/field[@name = $field] else $godwin:FIELDS/field[1]
			let $queryParts := 
			    for $f in $fields return 
			        replace($f, "\$q", $query)
			let $xpath := string-join(
				for $p in $queryParts return
					concat("//", $p),
				" | "
			)
			let $log := util:log("DEBUG", ("Query: ", $xpath))
			let $docXPath := $queryParts 
			let $hits := util:eval($xpath)
			return
				godwin:print-results($hits, $docXPath)
		else
			()
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
    <title>Search Test</title>
    </head>
    <body>
                    <div id="f-search">
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
										<label for="view">View:</label>
										<select name="view">
											<option value="summary">Summary</option>
											<option value="kwic">One Line</option>
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
                        <div id="f-result">
						{ godwin:query() }
                        </div>
                    </div>
             
</body>
</html>
};

let $foo := 'foo'
    
return
	godwin:get-page(())
