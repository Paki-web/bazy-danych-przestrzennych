create table obiekty
(
	nazwa VARCHAR(30),
	geom GEOMETRY
);

insert into obiekty (nazwa, geom) values ('obiekt1', ST_GEOMFROMTEXT('COMPOUNDCURVE(LINESTRING(0 1, 1 1), CIRCULARSTRING(1 1, 2 0, 3 1), CIRCULARSTRING(3 1, 4 2, 5 1), LINESTRING(5 1, 6 1))', -1));

insert into obiekty (nazwa, geom) values ('obiekt2', ST_GEOMFROMTEXT('CURVEPOLYGON(COMPOUNDCURVE(LINESTRING(10 6, 14 6), CIRCULARSTRING(14 6, 16 4, 14 2), CIRCULARSTRING(14 2, 12 0, 10 2), LINESTRING(10 2, 10 6)), CIRCULARSTRING(11 2, 13 2, 11 2))', -1));

insert into obiekty (nazwa, geom) values ('obiekt3', ST_GEOMFROMTEXT('POLYGON((7 15, 10 17, 12 13, 7 15))', -1));

insert into obiekty (nazwa, geom) values ('obiekt4', ST_GEOMFROMTEXT('LINESTRING(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)', -1));

insert into obiekty (nazwa, geom) values ('obiekt5', ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(MULTIPOINT(30 30 59 , 38 32 234))', -1));

insert into obiekty (nazwa, geom) values ('obiekt6', ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(LINESTRING(1 1, 3 2), POINT(4 2))', -1));

-- ZAD1

SELECT ST_Area(ST_Buffer(ST_ShortestLine(a.geom, b.geom), 5)) FROM obiekty a, obiekty b WHERE a.nazwa='obiekt3' AND b.nazwa='obiekt4';

-- ZAD2

UPDATE obiekty SETgeom = ST_MAKEPOLYGON(ST_AddPoint(geom, ST_StartPoint(geom))) WHERE nazwa = 'obiekt4';
SELECT ST_MakePolygon(ST_AddPoint(a.geom, ST_StartPoint(a.geom))) FROM obiekty a WHERE a.nazwa= 'obiekt4';

-- ZAD3

INSERT INTO obiekty values ('obiekt7', ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(7 15, 10 17), LINESTRING(10 17, 12 13), LINESTRING(12 13, 7 15), LINESTRING(20 20, 25 25), LINESTRING(25 25, 27 24), LINESTRING(27 24, 25 22), LINESTRING(25 22, 26 21), LINESTRING(26 21, 22 19), LINESTRING(22 19, 20.5 19.5))', -1));

-- ZAD4

SELECT nazwa, ST_Area(ST_Buffer(geom, 5)) FROM obiekty WHERE not ST_HasArc(geom);