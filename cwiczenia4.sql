-- ZAD4

CREATE TABLE tableB (
id_budynku SERIAL PRIMARY KEY,
budynek text
);

INSERT INTO tableB (budynek) SELECT F_CODEDESC FROM popp p, majrivers m WHERE Contains(Buffer(m.Geometry,100000), p.Geometry);
SELECT * FROM tableB;

-- ZAD5

CREATE TABLE airportsNew AS SELECT NAME, Geometry, ELEV FROM airports;

-- ZAD5a 
-- na zachod

SELECT * FROM airportsNew order by MbrMinY(Geometry) asc limit 1;

-- na wschod

SELECT * FROM airportsNew order by MbrMaxY(Geometry) asc limit 1;

--ZAD5b

INSERT INTO airportsNew VALUES ('airportB', (0.5*ST_Distance((SELECT Geometry FROM airportsNew 
WHERE NAME='NOATAK'),(SELECT Geometry FROM airportsNew WHERE NAME='NIKOLSKI AS'))), (0.5*((SELECT ELEV FROM airportsNew 
WHERE NAME='NOATAK')+(SELECT ELEV FROM airportsNew WHERE NAME='NIKOLSKI AS'))));

SELECT * FROM airportsNew WHERE NAME="airportB";

--ZAD6

SELECT Area(Buffer((ShortestLine(l.Geometry, a.Geometry)), 1000)) FROM lakes l, airports a WHERE l.NAMES="Iliamma Lake" AND a.NAME="AMBLER";

--ZAD7

SELECT SUM(t.AREA_KM2) AS sumaryczne_pole FROM tundra tu, swamp s, trees t WHERE Intersects(tu.Geometry, t.Geometry) OR Intersects(s.Geometry, t.Geometry);

