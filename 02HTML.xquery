xquery version "3.1";
let $url := json-doc("https://api.nobelprize.org/2.1/nobelPrizes?limit=800")

let $html := 

<html>
<head>
<title>Kémia Nobel díj nyertesek</title>
</head>
<body>
<h1>Chemistry Nobel Prize winners</h1>
<div>
<table>
<thead>
<tr>
<th>ID</th>
<th>Known Name</th>
<th>Motivation</th>
<th>Portion</th>
<th>Year</th>
<th>Nobel link</th>
</tr>
</thead>
<tbody>
{ for $data in $url?nobelPrizes?*  where $data?category?en = "Physics" and xs:decimal($data?awardYear) ge 2000

                    for $asd in $data?laureates?*
                    return <tr>
                        <td>{$asd?id}</td>
                        <td>{$asd?fullName?en}</td>
                        <td>{$asd?motivation?en}</td>
                        <td>{$asd?portion}</td>
                        <td>{$data?awardYear}</td>
                        <td><a href="{$asd?links?*?href}">{$asd?links?*?href}</a></td>
                        
                    </tr>
                        
                }
             
</tbody>                              
</table>
</div>
</body>
</html>
    
    


return $html