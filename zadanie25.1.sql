CREATE TABLE pracownicy(
id INT auto_increment PRIMARY KEY,
imię VARCHAR(20) NOT NULL,
nazwisko VARCHAR(40) NOT NULL,
data_urodzenia DATE,
stanowisko VARCHAR(40),
wypłata DOUBLE
);

INSERT INTO pracownicy (imię, nazwisko, data_urodzenia, stanowisko, wypłata)
VALUES ('Jan', 'Kowalski', '1980-03-20', 'operator', 2500), 
('Adam', 'Nowak', '1985-05-21', 'kontroler', 3500),
('Anna', 'Kowalska', '1984-07-17', 'operator', 2600),
('Agata', 'Nowak', '1994-02-12', 'asystent', 1500),
('Tomasz', 'Opolski', '1991-01-11', 'kierownik', 4500),
('Barbara', 'Wrocławska', '2001-09-12', 'operator', 2700);

SELECT * FROM pracownicy
ORDER BY nazwisko;

SELECT * FROM pracownicy
WHERE stanowisko='asystent';

SELECT * FROM pracownicy
WHERE data_urodzenia < '1990-07-10';

UPDATE pracownicy
SET wypłata = wypłata * 1.1 
WHERE  id > 0 AND stanowisko = 'operator';

-- PONIŻEJ ZAKOMENTOWANA SKŁADNIA NIE DZIAŁA!
-- DELETE FROM pracownicy
-- WHERE data_urodzenia = (SELECT min(data_urodzenia)); 

DROP TABLE pracownicy;

CREATE TABLE stanowisko(
stanowisko_id INT auto_increment PRIMARY KEY,
nazwa VARCHAR(30) NOT NULL,
opis VARCHAR(200),
wypłata DOUBLE
);

CREATE TABLE adres(
adres_id INT auto_increment PRIMARY KEY,
ulica VARCHAR(20) NOT NULL,
numer INT NOT NULL,
kod_pocztowy BIGINT,
miejscowość VARCHAR(30)
);

CREATE TABLE pracownicy(
id INT auto_increment PRIMARY KEY,
imię VARCHAR(20) NOT NULL,
nazwisko VARCHAR(40) NOT NULL,
adres_id INT,
FOREIGN KEY (adres_id) REFERENCES adres(adres_id),
stanowisko_id INT,
FOREIGN KEY (stanowisko_id) REFERENCES stanowisko(stanowisko_id)
);

INSERT INTO adres (ulica, numer, kod_pocztowy, miejscowość)
VALUES ('Zielona', 13, 11111, 'Wrocław'),
('Biała', 11, 22222, 'Warszawa'),
('Czerwona', 21, 33333, 'Opole');

INSERT INTO stanowisko (nazwa, opis, wypłata)
VALUES ('operator', 'operator maszyny drukarskiej', 2500),
('kontroler', 'kontrolej jakości druku', 3500),
('technik', 'technik maszyny drukarskiej', 2800);

INSERT INTO pracownicy (imię, nazwisko, adres_id, stanowisko_id)
VALUES ('Jan', 'Nowak', 1, 1),
('Adam', 'Kowalski', 2, 2),
('Marian', 'Górny', 3, 3);

SELECT id, imię, nazwisko, ulica, numer, kod_pocztowy, miejscowość, nazwa, opis, wypłata FROM pracownicy a
LEFT JOIN adres b ON a.adres_id = b.adres_id
LEFT JOIN stanowisko c ON a.stanowisko_id = c.stanowisko_id
WHERE nazwisko = 'Nowak';

SELECT id, imię, nazwisko, ulica, numer, kod_pocztowy, miejscowość, nazwa, opis, wypłata FROM pracownicy a
LEFT JOIN adres b ON a.adres_id = b.adres_id
LEFT JOIN stanowisko c ON a.stanowisko_id = c.stanowisko_id
WHERE nazwisko = 'Nowak';

SELECT sum(wypłata)
FROM (pracownicy a LEFT JOIN stanowisko b ON a.stanowisko_id = b.stanowisko_id);

SELECT id, imię, nazwisko, ulica, numer, kod_pocztowy, miejscowość FROM pracownicy a
LEFT JOIN adres b ON a.adres_id = b.adres_id
WHERE kod_pocztowy = '22222';

DROP TABLE stanowisko, adres, pracownicy;