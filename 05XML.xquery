xquery version "3.1";
import schema default element namespace "" at "05XMLschema.xsd";

let $url := json-doc("https://api.nobelprize.org/2.1/laureates?limit=1000")

(: Fiatal Nobel díjasok akik nem Európaiak kiírása akik 1985 után születtek :)
return validate { document {
    <YoungAfricanNobelPrizeWinners>
        {
            for $data in $url?laureates?* 
            where $data?birth?place?continent?en != "Europe" and $data?birth?date ge "1985-01-01"
            return <Person>
                <FullName>{ $data?knownName?en }</FullName>
                <Date>{ $data?birth?date }</Date>
                <Country>{ $data?birth?place?country?en }</Country>
                <NobelPrize>
                    <AwardYear>{ $data?nobelPrizes?*?awardYear }</AwardYear>
                    <AwardCategory>{ $data?nobelPrizes?*?category?en }</AwardCategory>
                </NobelPrize>
                <Age>
                {
               let $birthYear := xs:integer(substring($data?birth?date, 1, 4))
               let $currentYear := xs:integer(format-date(current-date(), "[Y]"))
               let $age := $currentYear - $birthYear
                    return $age
                }
                </Age>
            </Person>
        }
    </YoungAfricanNobelPrizeWinners>
}}
