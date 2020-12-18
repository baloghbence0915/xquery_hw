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
            where exists($laurate?gender)
            order by max(array {
                    for $prize in $laurate?nobelPrizes?*
                    return $prize?awardYear
                }) descending
        return
            map {
                "name": $laurate?fullName?en,
                "gender": $laurate?gender,
                "birth": tokenize($laurate?birth?date, "-")[1],
                "death": tokenize($laurate?death?date, "-")[1],
                "prizes":
                array {
                    for $prize in $laurate?nobelPrizes?*
                    return
                        map {
                            "year": $prize?awardYear,
                            "category": $prize?category?en,
                            "institution":
                            array {
                                for $affiliation in $prize?affiliations?*
                                return
                                    $affiliation?nameNow?en
                            },
                            "motivation": $prize?motivation?en
                        }
                }
            }
    }