xquery version "1.0";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace xs="http://www.w3.org/2001/XMLSchema";

let $parameters :=  request:get-parameter-names()
 
return
<results>
   <parameters>{$parameters}</parameters>
   {for $parameter in $parameters
   return
   <parameter>
      <name>{$parameter}</name>
      <value>{request:get-parameter($parameter, '')}</value>
   </parameter>
   }
</results>

