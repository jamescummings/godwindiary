xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace util="http://exist-db.org/xquery/util";
let $date := request:get-parameter("date", "1797")
let $diaryID := concat('g', $date)
let $diaryBit := document(concat('/db/diary/', $date, '.xml'))
return $diaryBit
