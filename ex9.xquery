(: 
Rangsolorni a díjazottakat, a díjazott díjazás évében betöltött életkora szerint, minél fiatalabb volt a díjazáskor annál előrébb szerepeljen.
Több díjazott is szerepelhet azonos életkorral.
Leszűrni a listát, a 10 legfiatalabb életkor (kategória) és díjazottjai szerepeljenek.
:)

import schema default element namespace "" at "schema/ex9.xsd";

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace op = "http://www.w3.org/2002/08/xquery-operators";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare function local:get-prefiltered-list($laurates) {
    for $laurate in $laurates?*
    let $year := tokenize($laurate?birth?date, "-")[1]
        where exists($year)
    let $age := min(
    for $prizes in $laurate?nobelPrizes?*
    let $age := xs:decimal($prizes?awardYear) - xs:decimal($year)
    return
        $age
    )
    return
        map {
            "name": $laurate?fullName?en,
            "age": $age
        }
};

let $laurates := json-doc("result1.json")
let $tmp := local:get-prefiltered-list($laurates)

return
    validate {
        document {
            <laurates
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:noNamespaceSchemaLocation="schema/ex9.xsd">
                {
                    for $group at $pos in (
                    for $laurate in $tmp
                    let $age := $laurate?age
                        group by $age
                        order by $age
                    return
                        <laurate
                            age="{$age}">
                            {
                                for $name in $laurate?name
                                return
                                    <name>{$name}</name>
                            }
                        </laurate>
                    )
                        where $pos le 10
                    return
                        $group
                }
            </laurates>
        }
    }
