xquery version "3.1";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";

declare option output:method "json";
declare option output:media-type "application/json";
declare option output:indent "yes";

let $data := json-doc("https://api.nobelprize.org/2.1/laureates?limit=800")?laureates?* 

let $ans := (
    for $item in $data
    where $item?gender = "female" and count($item?nobelPrizes?*) > 1
    return count($item?knownName?en)
)

return map {
    "Answer": $ans
}