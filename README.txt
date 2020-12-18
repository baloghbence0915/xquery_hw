Legalább 4 lekérdezés egy érvényes XML dokumentumot kell, hogy előállítson eredményként.
Ehhez a kimeneti XML dokumentumokhoz XML sémákat kell készíteni és a kimenet előállításakor egy validate kifejezést kell használni az érvényesség ellenőrzéséhez.
-full dokumentum konvertálása xml dokumentummá leegyszerűsítve a tárolt adatokat (nem túl érdekes/ több nyelven megjelenített adatok kiszűrése)
-országunként csoportosítani a díjazottak
-rangsolorni a díjazottakat, a díjazott díjazás évében betöltött életkora szerint
-csoportosítani az eredményeket kategória és organization/person szerint

Legalább 2 lekérdezés egy tömböt vagy objektumot tartalmazó JSON dokumentumot kell, hogy előállítson eredményként.
ex1		-díjazottak tömbjének alőállítása az API-ból lapozással
ex2		-person díjazottak szűrése (név, nem, születés [év], halál [év], díjak [év/kategória/intézmény/motiváció], RENDEZÉS: legutolsó díjának éve)
ex3		-organization díjazottak szűrése (név [natív/angol], acronym, location [continent/country/city], díjak [év/kategória/intézmény/motiváció], RENDEZÉS: legutolsó díjának éve)
ex4		-magyar vonatkozású nobel díjasok nevének listázása
ex6		-azon díjazottak nevének sorolása, melyeknek 1-nél több díja van és díjak száma

Legalább 1 lekérdezés érvényes HTML kimenetet kell, hogy előállítson.
ex5		-díjazottak listája, organization és person külön tabon

A lekérdezések között lehet legfeljebb 3 olyan, mely eredményként egyetlen atomi értéket vagy egy szekvenciát állítanak elő.


A lekérdezések elején egy megjegyzésben le kell írni, hogy pontosan mi a végrehajtás eredménye (elegendő akár egyetlen mondatnyi szöveg).


Ha a feladat részeként kell előállítani a lekérdezések bemeneteként szolgáló adatállományt, akkor az adatállományt és az azt előállító lekérdezést is mellékelni kell, az utóbbi beleszámít az elkészítendő 10 lekérdezésbe.
A további lekérdezésekben lehet a lokális adatállománnyal dolgozni.


Valamennyi lekérdezésnek végrehajthatónak kell lennie, a megfelelő eredményeket kell hogy szolgáltassák.


A lekérdezésekben az XQuery minél több lehetőségének használatára kell törekedni.