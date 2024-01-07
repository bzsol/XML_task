xquery version "3.1";
(: import schema default element namespace "" at "03XMLschema.xsd"; :)
let $url := json-doc("https://api.nobelprize.org/2.1/laureates?limit=1000")
return document {
    <HungarianNobelPrizeWinners>
        {
            count (for $data in $url?laureates?* where $data?birth?place?country?en = "Hungary" or $data?birth?place?country?en = "Austria-Hungary" and $data?birth?place?countryNow?en = "Hungary"
            return (
                $data?knownName?en
            ))      
           
        }
    </HungarianNobelPrizeWinners>
}
