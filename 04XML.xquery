xquery version "3.1";
import schema default element namespace "" at "04XMLschema.xsd";
let $url := json-doc("https://api.nobelprize.org/2.1/laureates?limit=1000")
(: Női Nobel díjasok száma, születési évük szerint csökkenő sorrendben :)
return validate  { document {
    <FemaleNobelPrizeWinners>
        {
            for $data in $url?laureates?* where $data?gender = "female" order by $data?birth?date descending
            
            return <Laureates>
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
            <City>
                {
                $data?birth?place?city?en
                }
            </City>
            <Country>
                {
                $data?birth?place?country?en
                }
            </Country>
            <PrizeNumber>
              {
                count($data?nobelPrizes?*)
              }
            </PrizeNumber>
            
            </Laureates>
            
            
                
            
           
        }
    </FemaleNobelPrizeWinners>
    }
}
