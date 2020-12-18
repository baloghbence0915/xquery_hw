declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace op = "http://www.w3.org/2002/08/xquery-operators";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare function local:get-prize-status($laurate) {
    for $prize in $laurate?nobelPrizes?*
        (:where $prize?prizeStatus ne "received":)
    return
        $prize?prizeStatus
};

declare function local:contains-unreceived($prizeStatus) {
    exists(
        for $status in $prizeStatus
        where $status ne 'received'
        return $status
    )
};

let $laurates := json-doc("result1.json")

return
    <laurates>
        {
            for $laurate in $laurates?*
            let $prizeStatus := local:get-prize-status($laurate)
                where exists($laurate?fullName?en) and local:contains-unreceived($prizeStatus)
            return
                <laurate
                    name="{$laurate?fullName?en}">
                    {
                        for $status in $prizeStatus
                        return <prizestatus>{$status}</prizestatus>
                    }
                </laurate>
        }
    </laurates>
