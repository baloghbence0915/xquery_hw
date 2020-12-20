(: Országonként kilistázni a nobel díjak számát és sorrendbe tenni a díjak száma szerint :)

import schema default element namespace "" at "schema/ex8.xsd";

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace op = "http://www.w3.org/2002/08/xquery-operators";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

let $laurates := json-doc("result1.json")

return
    validate {
        document {
            <countries
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:noNamespaceSchemaLocation="schema/ex8.xsd">
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
        }
    }
