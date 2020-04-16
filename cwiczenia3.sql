Create extension postgis;

create table budynki(
	id_budynku serial primary key,
	geometria geometry,
	nazwa varchar(20),
	wysokosc int
);

create table drogi(
	id_drogi serial primary key,
	geom geometry,
	nazwa varchar(20)
);

create table pktinfo(
	id_punktu serial primary key,
	geometria geometry,
	nazwa varchar(30),
	liczprac int
);

insert into budynki (geometria, nazwa, wysokosc) values ( ST_GeomFromText('POLYGON((8 4, 10.5 4, 10.5 1.5, 8 1.5 , 8 4))', -1), 'BuildingA', 12);
insert into budynki (geometria, nazwa, wysokosc) values ( ST_GeomFromText('POLYGON((4 7, 6 7, 6 5, 4 5, 4 7))', -1), 'BuildingB', 10);
insert into budynki (geometria, nazwa, wysokosc) values ( ST_GeomFromText('POLYGON((3 8, 5 8, 5 6, 3 6, 3 8))', -1), 'BuildingC', 10);
insert into budynki (geometria, nazwa, wysokosc) values ( ST_GeomFromText('POLYGON((9 9, 10 9, 10 8, 9 8, 9 9))', -1), 'BuildingD', 5);
insert into budynki (geometria, nazwa, wysokosc) values ( ST_GeomFromText('POLYGON((1 2, 2 2, 2 1, 1 1, 1 2))', -1), 'BuildingF', 6);	

insert into drogi (geometria, nazwa) values ( ST_GeomFromText('LINESTRING(0 4.5, 12 4.5)', -1), 'RoadX');
insert into drogi (geometria, nazwa) values ( ST_GeomFromText('LINESTRING(7.5 10.5, 7.5 0)', -1), 'RoadY');

insert into pktinfo (geometria, nazwa, liczprac) values (ST_GeomFromText('POINT(1 3.5)', -1), 'G', 4);
insert into pktinfo (geometria, nazwa, liczprac) values (ST_GeomFromText('POINT(5.5 1.5)', -1), 'H', 7);
insert into pktinfo (geometria, nazwa, liczprac) values (ST_GeomFromText('POINT(9.5 6)', -1), 'I', 3);
insert into pktinfo (geometria, nazwa, liczprac) values (ST_GeomFromText('POINT(6.5 6)', -1), 'J', 1);
insert into pktinfo (geometria, nazwa, liczprac) values (ST_GeomFromText('POINT(6 9.5)', -1), 'K', 5);

-- ZAD1

select sum(ST_Length(geometria)) as "Calkowita dlugosc drog" from drogi;

-- ZAD2

select geometria as "Geometria", ST_Area(geometria) as "Pole powierzchni", ST_Perimeter(geometria) as "Obwod" from budynki where nazwa = 'BuildingA';

-- ZAD3

select nazwa, ST_Area(geometria) as "Pole powierzchni" from budynki order by nazwa;

-- ZAD4

select nazwa, ST_Perimeter(geometria) as "Obwod" from budynki order by ST_Area(geometria) desc limit 2;

-- ZAD5

select ST_Distance(budynki.geometria, pktinfo.geometria) as "Najkrotsza odleglosc" from budynki, pktinfo where budynki.nazwa = 'BuildingC' and pktinfo.nazwa = 'G';

-- ZAD6



-- ZAD7

select budynki.nazwa from budynki, drogi where ST_Y(ST_Centroid(budynki.geometria))>ST_Y(ST_Centroid(drogi.geometria)) and drogi.nazwa = 'RoadX';

-- ZAD8

select ST_Area(ST_SymDifference(budynki.geometria, ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))', -1))) as "Pole" from budynki where nazwa = 'BuildingC';