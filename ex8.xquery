declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace op = "http://www.w3.org/2002/08/xquery-operators";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

let $laurates := json-doc("result1.json")

return
    <countries>
        {
            for $laurate in $laurates?*
            let $place := if ($laurate?gender) then
                $laurate?birth?place?country?en
            else
                $laurate?founded?place?country?en
                where exists($place)
                group by $place
                order by count($laurate) descending
            return
                <country
                    num="{count($laurate)}">{$place}</country>
        }
    </countries>
