declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace op = "http://www.w3.org/2002/08/xquery-operators";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:media-type "application/json";

declare function local:getLocation($laurate) {
    let $res := [
        $laurate?founded?place?continent?en,
        $laurate?founded?place?country?en,
        $laurate?founded?place?city?en
    ]
    
    return
        string-join($res, ", ")
};

let $laurates := json-doc("result1.json")

return
    array {
        for $laurate in $laurates?*
            where contains($laurate?birth?place?country?en, "Hungary")
        return $laurate?fullName?en
    }
    