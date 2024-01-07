xquery version "3.1";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";

declare option output:method "json";
declare option output:media-type "application/json";
declare option output:indent "yes";

let $data := json-doc("https://api.nobelprize.org/2.1/laureates")?laureates?*

(: Nobel díjasok hány évesen kapták meg az első Nobel díjukat, illetve mikor hunytak el/ élnek még-e :)

return array {
    for $item in $data

    return map {
    "name" : $item?knownName?en,
    "gender" : $item?gender,
    "birthday": $item?birth?date,
    "deathDate":  if(fn:exists($item?death))  then (xs:date($item?death?date)) else  ("he/she is still alive") ,
    "winnerAge" : xs:integer($item?nobelPrizes?*[1]?awardYear) - xs:integer(fn:substring($item?birth?date,0,5))
    
    }
}