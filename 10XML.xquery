xquery version "3.1";
(: import schema default element namespace "" at "03XMLschema.xsd"; :)
let $url := json-doc("https://api.nobelprize.org/2.1/laureates?limit=1000")
return document {
    <HungarianNobelPrizeWinnersHasConnectionWithSzeged>
        {
            fn:exists( (for $data in $url?laureates?* where  $data?nobelPrizes?*?affiliations?*?cityNow?en = "Szeged"
            return (
                $data?nobelPrizes?*?affiliations?*?nameNow?en
            ))      
           )
        }
    </HungarianNobelPrizeWinnersHasConnectionWithSzeged>
}
