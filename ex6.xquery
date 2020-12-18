declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace op = "http://www.w3.org/2002/08/xquery-operators";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:media-type "application/json";

let $laurates := json-doc("result1.json")

return
    array {
        for $laurate in $laurates?*
        let $count := array:size($laurate?nobelPrizes)
            where $count > 1
        return
            map {
                "name": if ($laurate?gender) then
                    $laurate?fullName?en
                else
                    $laurate?orgName?en,
                "count": $count
            }
    }