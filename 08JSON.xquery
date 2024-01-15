xquery version "3.1";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";

declare option output:method "json";
declare option output:media-type "application/json";
declare option output:indent "yes";

let $data := json-doc("https://api.nobelprize.org/2.1/laureates?limit=1000")?laureates?*

(: Hány Nobel díjas van aki 40 év alatt szerezte a díját és még életben van :)

let $youngWinnersStillAlive := count(
    for $item in $data
    let $birthYear := if (fn:string-length($item?birth?date) > 0) then xs:integer(fn:substring($item?birth?date, 0, 5)) else ()
    let $ageAtFirstPrize := if (fn:exists($birthYear) and fn:exists($item?nobelPrizes?*[1]?awardYear))
                            then xs:integer($item?nobelPrizes?*[1]?awardYear) - $birthYear
                            else ()
    where fn:exists($birthYear) and fn:exists($item?nobelPrizes?*[1]?awardYear) and $ageAtFirstPrize < 40 and not(fn:exists($item?death?date))
    return $item
)

return map {
    "YoungWinnersStillAliveCount": $youngWinnersStillAlive
}
