declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace op = "http://www.w3.org/2002/08/xquery-operators";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:media-type "application/json";

declare function local:getResult($n, $url) {
    let $page := json-doc(concat($url,$n))
    let $count := $n + array:size($page?laureates)
    let $max := $page?meta?count

    return if ($count lt $max) then 
        array:join(($page?laureates, local:getResult($count, $url)))
    else 
        $page?laureates
};

let $url := "https://api.nobelprize.org/2.0/laureates?offset="
let $result := local:getResult(0,$url)

return $result