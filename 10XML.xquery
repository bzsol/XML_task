xquery version "3.1";

let $url := json-doc("https://api.nobelprize.org/2.1/nobelPrizes?limit=800")

(: Több Kémia és Fizika Nobel díjas van-e mint Irodalmi és Béke nobel díjas :)
let $sciencePrizesCount := count(
    for $item in $url?nobelPrizes?*
    where $item?category?en = "Chemistry" or $item?category?en = "Physics"
    return $item?laureates?*
)


let $nonSciencePrizesCount := count(
    for $item in $url?nobelPrizes?*
    where $item?category?en = "Literature" or $item?category?en = "Peace"
    return $item?laureates?*
)


let $moreSciencePrizes := $sciencePrizesCount > $nonSciencePrizesCount

return document {
    <NobelPrizeWinners>
        <MoreSciencePrizesThanOthers>{$moreSciencePrizes}</MoreSciencePrizesThanOthers>
    </NobelPrizeWinners>
}
