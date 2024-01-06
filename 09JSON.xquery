xquery version "3.1";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";

declare option output:method "json";
declare option output:media-type "application/json";
declare option output:indent "yes";

let $data := json-doc("https://api.nobelprize.org/2.1/laureates?limit=800")?laureates?* 

(: Hány olyan női nobel díjas van Európában, aki 1860 és 1900 között született :)
let $femaleEuropeanWinners := (
    for $item in $data
    where $item?gender = "female"
    and $item?birth?place?continent?en = "Europe"
    and xs:date("1860-01-01") le xs:date($item?birth?date)
    and xs:date($item?birth?date) le xs:date("1900-12-31")
    return $item
)

let $femaleEuropeanWinnersByCountry :=
    array {
        for $winner in $femaleEuropeanWinners
        group by $country := $winner?birth?place?country?en
        return map {
            "Country": $country,
            "Count": count($winner)
        }
    }

return $femaleEuropeanWinnersByCountry
