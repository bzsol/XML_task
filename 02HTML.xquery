xquery version "3.1";

let $url := json-doc("https://api.nobelprize.org/2.1/nobelPrizes?limit=800")

let $html := 
    <html>
        <head>
            <title>Fizika Nobel díj nyertesek 2000 után</title>
        </head>
        <body>
            <h1>Physics Nobel Prize winners after 2000</h1>
            <div>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Known Names</th>
                            <th>Motivations</th>
                            <th>Portions</th>
                            <th>Years</th>
                            <th>Nobel links</th>
                        </tr>
                    </thead>
                    <tbody>
                        {
                            for $data in $url?nobelPrizes?*  
                            where $data?category?en = "Physics" and xs:decimal($data?awardYear) ge 2000
                            for $asd in $data?laureates?*
                            group by $year := $data?awardYear
                            return 
                                <tr>
                                    <td>{$asd?id}</td>
                                    <td>{$asd?fullName?en}</td>
                                    <td>{$asd?motivation?en}</td>
                                    <td>{$asd?portion}</td>
                                    <td>{$data?awardYear}</td>
                                    <td>
                                        <a href="{$asd?links?*?href}">
                                            {if ($asd?links?*?rel = "laureate") then "Laureate Link" else "Other Link"}
                                        </a>
                                    </td>
                                </tr>
                        }
                    </tbody>                              
                </table>
            </div>
        </body>
    </html>

return $html
