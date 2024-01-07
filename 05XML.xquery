xquery version "3.1";
import schema default element namespace "" at "05XMLschema.xsd";
let $url := json-doc("https://api.nobelprize.org/2.1/laureates?limit=1000")
(: Fiatal Afrikai Nobel díjasok kiírása akik 1970 után születtek :)
return validate  { document {
    <YoungAfricanNobelPrizeWinners>
        {
            for $data in $url?laureates?* where $data?birth?place?continent?en = "Africa" and $data?birth?date ge "1970-01-01"
            
            return <Person>
            <FullName>
                {
                $data?knownName?en
                }
            </FullName>
            <Date>
                {
                $data?birth?date
                }
            </Date>
            <Country>
                {
                $data?birth?place?country?en
                }
            </Country>
            <NobelPrize>
                <AwardYear>
                {
                $data?nobelPrizes?*?awardYear
                }
                </AwardYear>
                <AwardCategory>
                {
                $data?nobelPrizes?*?category?en
                }
                </AwardCategory>
            </NobelPrize>
            
            </Person>
            
            
                
            
           
        }
    </YoungAfricanNobelPrizeWinners>
    }
}
