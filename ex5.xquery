(: Díjazottak listája (kártyákon), organization és person külön tabon :)

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace op = "http://www.w3.org/2002/08/xquery-operators";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace functx = "http://www.functx.com";

declare option output:method "html";
declare option output:media-type "application/xhtml+xml";
declare option output:html-version "5.0";
declare option output:indent "yes";

declare function local:get-person-image($laurate, $i) {
    if ($laurate?gender eq "male") then
        concat("assets/male_", ($i mod 5) + 1, ".jpg")
    else
        concat("assets/female_", ($i mod 4) + 1, ".jpg")
};

declare function local:get-person-year($laurate) {
    if ($laurate?birth and $laurate?death) then
        concat($laurate?birth, " - ", $laurate?death)
    else
        $laurate?birth
};

declare function local:get-org-image($i) {
    concat("assets/org_", ($i mod 4) + 1, ".jpg")
};

let $personLaurates := json-doc("result2.json")
let $orgLaurates := json-doc("result3.json")



return
    <html>
        <head>
            <title>Nobel prices</title>
            <link
                rel="stylesheet"
                href="assets/result5.css"/>
            <link
                rel="preconnect"
                href="https://fonts.gstatic.com"/>
            <link
                href="https://fonts.googleapis.com/css2?family=Montserrat"
                rel="stylesheet"/>
            <link
                rel="preconnect"
                href="https://fonts.gstatic.com"/>
            <link
                href="https://fonts.googleapis.com/css2?family=Biryani"
                rel="stylesheet"/>
            <script
                src="assets/result5.js"></script>
        </head>
        <body>
            <div
                class="background-container">
                <div
                    class="background">
                    <div
                        class="background-inner">
                        <label>Nobel laurates</label> 🏆 </div>
                </div>
            </div>
            <header>
                <ul
                    class="navigation-bar">
                    <li
                        class="navigation-bar-item">
                        <a
                            class="navigation-bar-link"
                            href="#persons">Persons</a>
                    </li>
                    <li
                        class="navigation-bar-item">
                        <a
                            class="navigation-bar-link"
                            href="#orgs">Organizations</a>
                    </li>
                </ul>
            </header>
            <main>
                <section
                    class="laurate-tab persons">
                    <div
                        class="laurate-tab-inner">
                        {
                            for $laurate at $pos in $personLaurates?*
                            let $prize := $laurate?prizes?*[1]
                            return
                                <article
                                    id="{concat("persons_",$pos)}"
                                    class="profile">
                                    <div
                                        class="profile-header color-1">
                                    </div>
                                    <div
                                        class="profile-pic-container">
                                        <img
                                            class="profile-pic"
                                            src="{local:get-person-image($laurate, $pos)}"
                                            alt="anonymous-pic"
                                        />
                                    </div>
                                    <div
                                        class="profile-name-container">
                                        <a
                                            href="{concat("#","persons_",$pos)}"
                                            class="profile-name">{$laurate?name} - {$laurate?acronym}
                                            {
                                                string-join((for $i in 1 to array:size($laurate?prizes)
                                                return
                                                    '🏅'), '')
                                            }
                                        </a>
                                    </div>
                                    <div
                                        class="profile-year-container">
                                    </div>
                                    <div
                                        class="profile-award-container">
                                        <p>{$prize?institution?*[1]}</p>
                                        <p>{$prize?category}</p>
                                        <p>{$prize?year}</p>
                                    </div>
                                </article>
                        }
                    </div>
                </section>
                <section
                    class="laurate-tab orgs">
                    <div
                        class="laurate-tab-inner">
                        {
                            for $laurate at $pos in $orgLaurates?*
                            let $prize := $laurate?prizes?*[1]
                            return
                                <article
                                    id="{concat("orgs_",$pos)}"
                                    class="profile">
                                    <div
                                        class="profile-header color-1">
                                    </div>
                                    <div
                                        class="profile-pic-container">
                                        <img
                                            class="profile-pic"
                                            src="{local:get-org-image($pos)}"
                                            alt="anonymous-pic"
                                        />
                                    </div>
                                    <div
                                        class="profile-name-container">
                                        <a
                                            href="{concat("#","orgs_",$pos)}"
                                            class="profile-name">{$laurate?name?en}
                                            {
                                                string-join((for $i in 1 to array:size($laurate?prizes)
                                                return
                                                    '🏅'), '')
                                            }
                                        </a>
                                    </div>
                                    <div
                                        class="profile-year-container">
                                        Founded in {$laurate?foundationDate}
                                    </div>
                                    <div
                                        class="profile-award-container">
                                        <p>{$prize?institution?*[1]}</p>
                                        <p>{$prize?category}</p>
                                        <p>{$prize?year}</p>
                                    </div>
                                </article>
                        }
                    </div>
                </section>
            </main>
            <footer>Footer</footer>
        </body>
    </html>
