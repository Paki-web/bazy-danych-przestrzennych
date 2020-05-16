-- ZAD1
-- wyswietlanie innymi kolorami w warstwie trees 
-- właściwości trees => styl => wartość unikalna => dla VEGDESC => kolory

SELECT SUM(trees.AREA_KM2) AS pole_drzew_mieszanych FROM trees WHERE VEGDESC='Mixed Trees';

-- ZAD2
-- podzielenie warstwy trees na trzy warstwy
-- wektor => narzędzia zarządzania danymi => podziel warstwę wektorową => VEGDESC jako pole z unikalnym ID => zapisz w katalogu

-- ZAD3

SELECT SUM(ST_Length(railroads.Geometry)) AS dlugosc_linii_kolejowych FROM regions, railroads WHERE regions.NAME_2='Matanuska-Susitna';

-- ZAD4

SELECT AVG(ELEV) AS srednia_wysokosc FROM airports WHERE USE='Military';
-- 8 lotnik militarnych
SELECT airports.ID as lotnisko FROM airports WHERE USE='Military';
-- 1 lotnisko militarne powyzej 1400 m.n.p.
SELECT COUNT(*) as ilosc_lotnisk FROM airports WHERE USE='Military' AND ELEV > 1400;

DELETE FROM airports WHERE USE='Military' AND ELEV>1400;

-- ZAD5
-- tworze nowa wartswe

SELECT * FROM popp, regions WHERE regions.NAME_2='Bristol Bay' AND popp.F_CODEDESC='Building' AND Contains(regions.geometry, popp.geometry);
SELECT COUNT(*) AS liczba_budynkow FROM popp, regions WHERE regions.NAME_2='Bristol Bay' AND popp.F_CODEDESC='Building' AND Contains(regions.geometry, popp.geometry);
SELECT COUNT(*) AS ilosc_budynkow2 FROM popp, regions, rivers WHERE popp.F_CODEDESC='Building' AND regions.NAME_2='Bristol Bay' AND ST_Contains(regions.geometry, popp.geometry) AND ST_Contains(ST_Buffer(rivers.Geometry,100000), popp.Geometry);

-- ZAD6

SELECT COUNT(*) FROM majrivers, railroads WHERE ST_Intersects(majrivers.Geometry, railroads.Geometry);

-- ZAD8
SELECT rgn.NAME_2 FROM regions rgn, airports arp, railroads rail WHERE ST_Distance(arp.Geometry, rgn.Geometry) < 100000 AND ST_Distance(rail.Geometry, rgn.Geometry) >= 50000 LIMIT 1;

-- ZAD9
SELECT SUM(AREAKM2) from swamp;

--liczba wierzcholkow: 7469

--wektor => narzędzia geometrii => uprość geometrię => tolerancja 100

SELECT SUM(AREAKM2) from swamp_100;

-- po uprosczeniu pole powierzchni nie zmienilo sie, liczba wierzcholkow zmienila sie na 6661