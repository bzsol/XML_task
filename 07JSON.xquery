declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";

declare option output:method "json";
declare option output:media-type "application/json";
declare option output:indent "yes";

(: Budapesti és 1900 után született Nobel díjasaink kiírása :)
let $data := json-doc("https://api.nobelprize.org/2.1/laureates?limit=800")?laureates?*

return
    array {
        for $item in $data
        where $item?birth?place?city?en = "Budapest"
          and xs:date("1900-01-01") le xs:date($item?birth?date)
        order by xs:date($item?birth?date) descending
        return
            map {
                "id": xs:integer($item?id),
                "name": $item?knownName?en,
                "gender": $item?gender,
                "latitude": xs:double($item?birth?place?countryNow?latitude),
                "longitude": xs:double($item?birth?place?countryNow?longitude),
                "city": $item?birth?place?cityNow?en,
                "birthDate": xs:date($item?birth?date)
            }
    }
