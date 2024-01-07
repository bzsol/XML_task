xquery version "3.1";
import schema default element namespace "" at "01XMLschema.xsd";
let $url := json-doc("https://api.nobelprize.org/2.1/nobelPrizes?limit=800")
return validate { 
    document {
        <NobelPrizeWinners>
        {
         for $laureates in $url?nobelPrizes?*?laureates?*
          return <Winner>
            <Name>
            {
                $laureates?knownName?en
            }
            </Name>
            <Motivation>
                {
                 $laureates?motivation?en  
                }
            </Motivation>
            <Portion>
                {
                 $laureates?portion  
                }
            </Portion>
            
         </Winner>
        }
        </NobelPrizeWinners>
    }
    }