-- CWICZENIA 2

-- ZAD1 do zadania wykorzystuje istniejaca baze danych w ktorej znajduje sie schemat firma

-- ZAD2

CREATE SCHEMA sklep

CREATE TABLE sklep.producenci (
    id_producenta serial  NOT NULL,
    nazwa_producenta varchar(50)  NOT NULL,
    mail varchar(50)  NOT NULL,
    telefon varchar(50)  NOT NULL,
    CONSTRAINT producenci_pk PRIMARY KEY (id_producenta)
);

CREATE TABLE sklep.produkty (
    id_produktu serial  NOT NULL,
    nazwa_produktu varchar(50)  NOT NULL,
    cena double precision NOT NULL,
    id_producenta int  NOT NULL,
    CONSTRAINT produkty_pk PRIMARY KEY (id_produktu)
);

ALTER TABLE sklep.produkty ADD CONSTRAINT produkty_producenci
    FOREIGN KEY (id_producenta)
    REFERENCES sklep.producenci (id_producenta)  
    on delete cascade
    on update cascade
;

CREATE TABLE sklep.zamowienia (
    id_zamowienia serial  NOT NULL,
    ilosc_produktu int  NOT NULL,
    id_produktu int  NOT NULL,
    data_zamowienia date  NOT NULL,
    CONSTRAINT zamowienia_pk PRIMARY KEY (id_zamowienia)
);

ALTER TABLE sklep.zamowienia ADD CONSTRAINT zamowienia_produkty
    FOREIGN KEY (id_produktu)
    REFERENCES sklep.produkty (id_produktu)  
    on delete cascade
    on update cascade
;

-- ZAD6

INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Sante', 'sante@gmail.com', '593728591');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Barilla', 'barilla@gmail.com', '483926583');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Migo', 'migo@gmail.com', '847285738');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Vivio', 'vivio@gmail.com', '483750174');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Pudliszki', 'pudliszki@gmail.com', '583017486');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Społem', 'społem@gmail.com', '584016485');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Kotlin', 'kotlin@gmail.com', '385018593');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Lays', 'lays@gmail.com', '483926591');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('Mleczna dolina', 'mleczna-dolina@gmail.com', '584926401');
INSERT INTO sklep.producenci (nazwa_producenta, mail, telefon) VALUES('President', 'president@gmail.com', '483926185');

INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Granola orzechowa', 4.50, 1);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Chipsy cebulowe', 2, 8);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Makaron Spaghetti', 5.99, 2);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Olej kokosowy', 12.99, 4);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Ketchup pikantny', 4.99, 5);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Pestki dyni', 12, 3);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Majonez kielecki', 4.99, 6);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Mleko tluste', 2.99, 9);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Smietana 30%', 3.50, 10);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Ketchup lagodny', 2.99, 7);
INSERT INTO sklep.produkty (nazwa_produktu, cena, id_producenta) VALUES('Chipsy paprykowe', 2.99, 8);


INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(12, 4, '2020-03-20');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(20, 1, '2020-01-04');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(5, 7, '2020-02-20');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(3, 5, '2020-01-15');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(15, 9, '2020-03-23');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(13, 8, '2020-03-11');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(25, 3, '2020-03-01');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(6, 10, '2020-02-12');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(4, 2, '2020-02-02');
INSERT INTO sklep.zamowienia (ilosc_produktu, id_produktu, data_zamowienia) VALUES(22, 6, '2020-01-21');

-- ZAD11

-- a)

select prc.nazwa_producenta as "producent", sum(zam.ilosc_produktu) as "liczba_zamowien", sum(zam.ilosc_produktu * prod.cena) as "wartosc_zamowienia" from sklep.zamowienia  zam join sklep.produkty prod on prod.id_produktu = zam.id_produktu join sklep.producenci prc on prc.id_producenta = prod.id_producenta group by prc.nazwa_producenta;

-- b)

select concat('Produkt: ', prod.nazwa_produktu, ', liczba zamowien: ', sum(zam.ilosc_produktu)) as "raport" from sklep.produkty prod join sklep.zamowienia zam on prod.id_produktu = zam.id_produktu group by prod.nazwa_produktu;

-- c)

select zam.id_zamowienia, prod.nazwa_produktu from sklep.zamowienia zam natural join sklep.produkty prod;

-- d) Pole data zostało wczesniej uwzglednione

-- e)

select * from sklep.zamowienia where data_zamowienia >= '2020-01-01' and data_zamowienia <= '2020-01-31';

-- f)



-- g)

select prod.nazwa_produktu, sum(zam.ilosc_produktu) as "Najczesciej zamawiane" from sklep.produkty prod join sklep.zamowienia zam on zam.id_produktu = prod.id_produktu group by prod.nazwa_produktu order by sum(zam.ilosc_produktu) desc limit 4;

-- ZAD12

-- a)

select concat('Produkt ', upper(prod.nazwa_produktu), ', ktorego producentem jest ', lower(prc.nazwa_producenta), ', zamówiono ', sum(zam.ilosc_produktu), ' razy.') as "opis" from sklep.produkty prod join sklep.zamowienia zam on zam.id_produktu = prod.id_produktu join sklep.producenci prc on prc.id_producenta = prod.id_producenta group by prc.nazwa_producenta, prod.nazwa_produktu order by sum(zam.ilosc_produktu) desc;

-- b)

select zam.id_zamowienia, prod.nazwa_produktu, sum(zam.ilosc_produktu * prod.cena) from sklep.zamowienia zam natural join sklep.produkty prod group by zam.id_zamowienia, prod.nazwa_produktu order by sum(zam.ilosc_produktu * prod.cena) desc limit (SELECT COUNT(*) FROM sklep.zamowienia) - 3;

-- c)

CREATE TABLE sklep.klienci (
    id_klienta serial  NOT NULL,
    mail varchar(50)  NOT NULL,
    telefon varchar(20)  NOT NULL,
    CONSTRAINT "sklep.klienci_pk" PRIMARY KEY (id_klienta)
);

INSERT INTO sklep.klienci (mail, telefon) VALUES('klient1@gmail.com', '583926583');
INSERT INTO sklep.klienci (mail, telefon) VALUES('klient2@gmail.com', '573819503');
INSERT INTO sklep.klienci (mail, telefon) VALUES('klient3@gmail.com', '673850163');
INSERT INTO sklep.klienci (mail, telefon) VALUES('klient4@gmail.com', '573016395');
INSERT INTO sklep.klienci (mail, telefon) VALUES('klient5@gmail.com', '105839529');
INSERT INTO sklep.klienci (mail, telefon) VALUES('klient6@gmail.com', '604839264');
INSERT INTO sklep.klienci (mail, telefon) VALUES('klient7@gmail.com', '704802618');
INSERT INTO sklep.klienci (mail, telefon) VALUES('klient8@gmail.com', '604739174');
INSERT INTO sklep.klienci (mail, telefon) VALUES('klient9@gmail.com', '483009571');
INSERT INTO sklep.klienci (mail, telefon) VALUES('klient10@gmail.com', '583920174');

-- d)

alter table sklep.zamówienia add id_klienta int;

ALTER TABLE sklep.zamowienia ADD CONSTRAINT zamowienia_klienci
    FOREIGN KEY (id_klienta)
    REFERENCES sklep.klienci (id_klienta)  
    on delete cascade
    on update CASCADE
;

UPDATE sklep.zamowienia SET id_klienta=1 WHERE id_zamowienia=3;
UPDATE sklep.zamowienia SET id_klienta=2 WHERE id_zamowienia=1;
UPDATE sklep.zamowienia SET id_klienta=3 WHERE id_zamowienia=5;
UPDATE sklep.zamowienia SET id_klienta=4 WHERE id_zamowienia=8;
UPDATE sklep.zamowienia SET id_klienta=5 WHERE id_zamowienia=2;
UPDATE sklep.zamowienia SET id_klienta=6 WHERE id_zamowienia=4;
UPDATE sklep.zamowienia SET id_klienta=7 WHERE id_zamowienia=10;
UPDATE sklep.zamowienia SET id_klienta=8 WHERE id_zamowienia=7;
UPDATE sklep.zamowienia SET id_klienta=9 WHERE id_zamowienia=6;
UPDATE sklep.zamowienia SET id_klienta=10 WHERE id_zamowienia=9;

-- e)

select kli.id_klienta, kli.mail, kli.telefon, prod.nazwa_produktu, zam.ilosc_produktu, sum(zam.ilosc_produktu * cena) as "wartosc_zamowienia" from sklep.zamowienia zam join sklep.klienci kli on kli.id_klienta = zam.id_klienta join sklep.produkty prod on prod.id_produktu = zam.id_produktugroup by prod.nazwa_produktu, kli.id_klienta, zam.ilosc_produktu;

-- f)



-- g)

DELETE FROM sklep.produkty using sklep.zamowienia WHERE not exists (select id_produktu from sklep.zamowienia where sklep.zamowienia.id_produktu = sklep.produkty.id_produktu);

-- ZAD13

-- a)

create table sklep.numer(
	liczba smallint not null
);

-- b)

create sequence liczba_seq increment by 5 minvalue 0 maxvalue 125 start with 100;

-- c)

insert into sklep.numer(liczba) values (nextval('sklep.liczba_seq'));
insert into sklep.numer(liczba) values (nextval('sklep.liczba_seq'));
insert into sklep.numer(liczba) values (nextval('sklep.liczba_seq'));
insert into sklep.numer(liczba) values (nextval('sklep.liczba_seq'));
insert into sklep.numer(liczba) values (nextval('sklep.liczba_seq'));
insert into sklep.numer(liczba) values (nextval('sklep.liczba_seq'));
insert into sklep.numer(liczba) values (nextval('sklep.liczba_seq'));

-- d)

drop sequence sklep.liczba_seq;
create sequence sklep.liczba_seq increment by 5 minvalue 0 maxvalue 125 start with 100;
alter sequence sklep.liczba_seq increment by 6;

-- e)

select nextval('sklep.liczba_seq');
select nextval('sklep.liczba_seq');

-- f)

drop sequence sklep.liczba_seq;

-- ZAD14

-- a)

SELECT u.usename AS "Role name",
  CASE WHEN u.usesuper AND u.usecreatedb THEN CAST('superuser, create
database' AS pg_catalog.text)
       WHEN u.usesuper THEN CAST('superuser' AS pg_catalog.text)
       WHEN u.usecreatedb THEN CAST('create database' AS
pg_catalog.text)
       ELSE CAST('' AS pg_catalog.text)
  END AS "Attributes"
FROM pg_catalog.pg_user u
ORDER BY 1;

-- b)

create user Superuser299635;
ALTER ROLE superuser299635 SUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;
GRANT  USAGE ON SCHEMA sklep TO Superuser299635;

create user guest299635;
ALTER ROLE guest299635 NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;
GRANT  USAGE ON SCHEMA sklep TO guest299635;
GRANT SELECT on all tables in schema "sklep" TO guest299635;

-- c)

ALTER USER superuser299635 RENAME TO student;
ALTER ROLE student NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;
GRANT SELECT on all tables in schema "sklep" TO student;

revoke ALL on all tables in schema "sklep" FROM guest299635;
drop USER guest299635;

-- ZAD15

-- a)

start transaction;
update sklep.produkty set cena = cena +10; 
end transaction;

-- b)

start transaction;
update sklep.produkty set cena = (cena + 0.1*cena) where sklep.produkty.id_produktu = 3; 
savepoint S1;
update sklep.zamowienia set ilosc_produktu = (ilosc_produktu + 0.25 * ilosc_produktu);
savepoint S2;
delete from sklep.klienci where id_klienta = 5;
rollback to savepoint S1;
rollback to savepoint S2;
end transaction;