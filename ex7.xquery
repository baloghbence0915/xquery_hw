(: 2020 díjazottainak listázása, kategória és név megjelenítése :)

import schema default element namespace "" at "schema/ex7.xsd";

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace op = "http://www.w3.org/2002/08/xquery-operators";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare function local:get-last-prize($laurate) {
    let $last := for $prize in $laurate?nobelPrizes?*
        where $prize?awardYear eq "2020"
    return
        $prize
    
    return
        $last
};

let $laurates := json-doc("result1.json")

return
    validate {
        document {
            <laurates
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:noNamespaceSchemaLocation="schema/ex7.xsd">
                {
                    for $laurate in $laurates?*
                    let $prize := local:get-last-prize($laurate)
                        where exists($prize)
                    return
                        <laurate>
                            <name>{
                                    if ($laurate?gender) then
                                        $laurate?fullName?en
                                    else
                                        $laurate?orgName?en
                                }</name>
                            <category>{$prize?category?en}</category>
                        </laurate>
                }
            </laurates>
        }
    }