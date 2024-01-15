xquery version "3.1";
import schema default element namespace "" at "06XMLschema.xsd";
let $url := json-doc("https://api.nobelprize.org/2.1/laureates?limit=1000")
(: A még életben lévő Európai és női díjazottak kiírása:)
return validate  { document {
    <StillAliveNobelPrizeWinners>
        {
            for $data in $url?laureates?* where not(fn:exists($data?death)) and $data?birth?place?continent?en = "Europe" and $data?gender = "female" order by $data?birth?date descending
            
            return <Person>
            <ID>
                {
                $data?id
                }
            </ID>
            <Name>
            <GivenName>
                {
                $data?givenName?en
                }
            </GivenName>
            <FamilyName>
                {
                $data?familyName?en
                }
            </FamilyName>
            </Name>     
            <BirthPlace>
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
                <City>
                {
                $data?birth?place?city?en
                }
                </City>
            </BirthPlace>
            <NobelPrizes>
                <AwardYear>
                {
                $data?nobelPrizes?*?awardYear
                }
                </AwardYear>
                <Motivation>
                {
                $data?nobelPrizes?*?motivation?en
                }
                </Motivation>
            </NobelPrizes>
            </Person>       
        }
    </StillAliveNobelPrizeWinners>
    }
}
