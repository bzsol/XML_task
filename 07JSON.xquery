declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";

declare option output:method "json";
declare option output:media-type "application/json";
declare option output:indent "yes";


let $data := json-doc("https://api.nobelprize.org/2.1/laureates?limit=800")?laureates?*

return
    array {
        
        for $item in $data
            where $item?birth?place?city?en = "Budapest"
            and
            "1900-01-01" <= $item?birth?date
            order by $item?birth?date descending
        return
            map {
                "id": $item?id,
                "name": $item?knownName?en,
                "gender": $item?gender,
                "latitude": $item?birth?place?countryNow?latitude,
                "longitude": $item?birth?place?countryNow?longitude,
                "city": $item?birth?place?cityNow?en
                
            }
    
    }