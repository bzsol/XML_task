xquery version "3.1";
import schema default element namespace "" at "01XMLschema.xsd";
let $url := json-doc("https://api.nobelprize.org/2.1/nobelPrizes?limit=800")
(: A kémia és fizika Nobel díjak kiírása díjazottak száma alapján rendezve adott évben :)
return validate { document {
    
        <NobelPrizeWinners>
        {
         for $item in $url?nobelPrizes?* where $item?category?en = "Chemistry" or  $item?category?en = "Physics" order by count($item?laureates?*) descending
          return <WinnersWhoWonChemistryAndPhysics>
            <AwardDate>
            <Year>
            {
                $item?awardYear
            }
            </Year>
            
                {
                    if (fn:exists($item?dateAwarded)) then
                    <ExactDate>{$item?dateAwarded}</ExactDate>
                    else ""
                }
            
            </AwardDate>
            <NumberOLaureates>
                {
                count($item?laureates?*)
                }
            </NumberOLaureates>
            <Category>
                <ShortenedEnglish>
                    {
                       $item?category?en 
                    }
                </ShortenedEnglish>
                <FullName>
                    {
                        $item?categoryFullName?en
                    }
                </FullName>
            </Category>
            <Prize>
                <Amount>
                       {$item?prizeAmount}
                </Amount>
                <Adjusted>
                       {$item?prizeAmountAdjusted}
                </Adjusted>
            </Prize>
         </WinnersWhoWonChemistryAndPhysics>
        }
        </NobelPrizeWinners>
        }
    }