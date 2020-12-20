(: Organization típusú díjazottak szűrése (név [natív/angol], acronym, location ["continent, country, city"], alapítás éve, díjak [év/kategória/intézmény/motiváció], RENDEZÉS: legutolsó díjának éve) :)

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
            where fn:not(exists($laurate?gender))
            order by max(array {
                for $prize in $laurate?nobelPrizes?*
                return
                    $prize?awardYear
            }) descending
        return
            map {
                "name": map {
                    "en": $laurate?orgName?en,
                    "nat": $laurate?nativeName
                },
                "acronym": $laurate?acronym,
                "location": local:getLocation($laurate),
                "foundationDate": tokenize($laurate?founded?date, "-")[1],
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