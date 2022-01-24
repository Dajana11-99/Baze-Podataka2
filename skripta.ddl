
DROP TABLE administrativac CASCADE CONSTRAINTS;

DROP TABLE apoteka CASCADE CONSTRAINTS;

DROP TABLE direktor CASCADE CONSTRAINTS;

DROP TABLE dobavljac CASCADE CONSTRAINTS;

DROP TABLE dobavljeni CASCADE CONSTRAINTS;

DROP TABLE farmaceutski_tehnicar CASCADE CONSTRAINTS;

DROP TABLE galenska_laboratorija CASCADE CONSTRAINTS;

DROP TABLE galenski CASCADE CONSTRAINTS;

DROP TABLE lanac_apoteka CASCADE CONSTRAINTS;

DROP TABLE magistar_farmacije CASCADE CONSTRAINTS;

DROP TABLE magistralna_laboratorija CASCADE CONSTRAINTS;

DROP TABLE personalizovani CASCADE CONSTRAINTS;

DROP TABLE personalizovani_recept CASCADE CONSTRAINTS;

DROP TABLE proizvod CASCADE CONSTRAINTS;

DROP TABLE radnik CASCADE CONSTRAINTS;

DROP TABLE serija CASCADE CONSTRAINTS;

DROP TABLE specijalista CASCADE CONSTRAINTS;

DROP TABLE ugovor CASCADE CONSTRAINTS;

CREATE TABLE administrativac (
    mbr      INTEGER NOT NULL,
    id_ap    INTEGER NOT NULL,
    naziv_la VARCHAR2(30)NOT NULL
);

ALTER TABLE administrativac
    ADD CONSTRAINT administrativac_pk PRIMARY KEY ( mbr,
                                                    id_ap,
                                                    naziv_la );

CREATE TABLE apoteka (
    id_ap      INTEGER NOT NULL,
    br_tel     VARCHAR2(20),
    adr_ap     VARCHAR2(30) NOT NULL,
    naziv_la   VARCHAR2(30) NOT NULL,
    id_nadr_ap INTEGER,
    grad       VARCHAR2(20)
);

ALTER TABLE apoteka ADD CONSTRAINT apoteka_pk PRIMARY KEY ( id_ap,
                                                            naziv_la );

CREATE TABLE direktor (
    mbr      INTEGER NOT NULL,
    id_ap    INTEGER NOT NULL,
    naziv_la VARCHAR2(30) NOT NULL
);


ALTER TABLE direktor
    ADD CONSTRAINT direktor_pk PRIMARY KEY ( mbr,
                                             id_ap,
                                             naziv_la );
CREATE UNIQUE INDEX direktor__idx ON
    direktor (
        id_ap
    ASC );

CREATE TABLE dobavljac (
    id_dob    INTEGER NOT NULL,
    naziv_dob VARCHAR2(20) NOT NULL
);

ALTER TABLE dobavljac ADD CONSTRAINT dobavljac_pk PRIMARY KEY ( id_dob );

CREATE TABLE dobavljeni (
    id_pro   INTEGER NOT NULL,
    mbr      INTEGER NOT NULL,
    id_ap    INTEGER NOT NULL,
    naziv_la VARCHAR2(30) NOT NULL,
    id_dob   INTEGER NOT NULL
);

ALTER TABLE dobavljeni ADD CONSTRAINT dobavljeni_pk PRIMARY KEY ( id_pro );

CREATE TABLE farmaceutski_tehnicar (
    mbr      INTEGER NOT NULL,
    id_ap    INTEGER NOT NULL,
    naziv_la VARCHAR2(30) NOT NULL
);

ALTER TABLE farmaceutski_tehnicar
    ADD CONSTRAINT farmaceutski_tehnicar_pk PRIMARY KEY ( mbr,
                                                          id_ap,
                                                          naziv_la );

CREATE TABLE galenska_laboratorija (
    adr_g    VARCHAR2(20),
    naziv_la VARCHAR2(30) NOT NULL
);

ALTER TABLE galenska_laboratorija ADD CONSTRAINT galenska_laboratorija_pk PRIMARY KEY ( naziv_la );

CREATE TABLE galenski (
    id_pro           INTEGER NOT NULL,
    serija_id_serije INTEGER NOT NULL
);

CREATE UNIQUE INDEX galenski__idx ON
    galenski (
        serija_id_serije
    ASC );

ALTER TABLE galenski ADD CONSTRAINT galenski_pk PRIMARY KEY ( id_pro );

CREATE TABLE lanac_apoteka (
    naziv_la VARCHAR2(30) NOT NULL,
    pib      VARCHAR2(10) NOT NULL,
    jib      VARCHAR2(13) NOT NULL
);

ALTER TABLE lanac_apoteka ADD CONSTRAINT lanac_apoteka_pk PRIMARY KEY ( naziv_la );

CREATE TABLE magistar_farmacije (
    mbr      INTEGER NOT NULL,
    id_ap    INTEGER NOT NULL,
    naziv_la VARCHAR2(30) NOT NULL
);

ALTER TABLE magistar_farmacije
    ADD CONSTRAINT magistar_farmacije_pk PRIMARY KEY ( mbr,
                                                       id_ap,
                                                       naziv_la );

CREATE TABLE magistralna_laboratorija (
    id_mag     INTEGER NOT NULL,
    kvadratura FLOAT,
    id_ap      INTEGER NOT NULL,
    naziv_la   VARCHAR2(30) NOT NULL,
    mbr        INTEGER NOT NULL
);

CREATE UNIQUE INDEX magistralna_laboratorija__idx ON
    magistralna_laboratorija (
        mbr
    ASC );

CREATE UNIQUE INDEX magistralna_laboratorija__idxv1 ON
    magistralna_laboratorija (
        id_ap
    ASC,
        naziv_la
    ASC );

ALTER TABLE magistralna_laboratorija ADD CONSTRAINT magistralna_laboratorija_pk PRIMARY KEY ( id_mag );

CREATE TABLE personalizovani (
    id_pro INTEGER NOT NULL,
    id_r   INTEGER NOT NULL,
    id_mag INTEGER NOT NULL
);

CREATE UNIQUE INDEX personalizovani__idx ON
    personalizovani (
        id_r
    ASC );

ALTER TABLE personalizovani ADD CONSTRAINT personalizovani_pk PRIMARY KEY ( id_pro );

CREATE TABLE personalizovani_recept (
    id_r     INTEGER NOT NULL,
    opis     VARCHAR2(40) NOT NULL,
    jmbg_pac VARCHAR2(13) NOT NULL,
    br_lic   INTEGER NOT NULL,
    dat_izd  DATE
);

ALTER TABLE personalizovani_recept ADD CONSTRAINT personalizovani_recept_pk PRIMARY KEY ( id_r );

CREATE TABLE proizvod (
    id_pro       INTEGER NOT NULL,
    naziv_pro    VARCHAR2(20) NOT NULL,
    cena_pro     FLOAT NOT NULL,
    rok_trajanja DATE NOT NULL,
    tip_pro      VARCHAR2(15) NOT NULL,
    mbr          INTEGER,
    id_ap        INTEGER,
    naziv_la     VARCHAR2(30)

);

ALTER TABLE proizvod
    ADD CONSTRAINT ch_inh_proizvod CHECK ( tip_pro IN ( 'Dobavljeni', 'Galenski', 'Personalizovani', 'Proizvod' ) );

ALTER TABLE proizvod ADD CONSTRAINT proizvod_pk PRIMARY KEY ( id_pro );

CREATE TABLE radnik (
    ime         VARCHAR2(20) NOT NULL,
    prz         VARCHAR2(30) NOT NULL,
    tel         VARCHAR2(20),
    plt         FLOAT,
    tip_radnika VARCHAR2(25) NOT NULL,
    mbr         INTEGER NOT NULL,
    id_ap       INTEGER NOT NULL,
    naziv_la    VARCHAR2(30) NOT NULL
);

ALTER TABLE radnik
    ADD CONSTRAINT ch_inh_radnik CHECK ( tip_radnika IN ( 'Administrativac', 'Direktor', 'Farmaceutski_tehnicar', 'Magistar_farmacije',
    'Radnik' ) );

ALTER TABLE radnik
    ADD CONSTRAINT radnik_pk PRIMARY KEY ( mbr,
                                           id_ap,
                                           naziv_la );

CREATE TABLE serija (
    id_serije INTEGER NOT NULL,
    kol       INTEGER NOT NULL,
    naziv_la  VARCHAR2(30) NOT NULL
);

ALTER TABLE serija ADD CONSTRAINT serija_pk PRIMARY KEY ( id_serije );

CREATE TABLE specijalista (
    br_lic INTEGER NOT NULL,
    ime_s  VARCHAR2(20) NOT NULL,
    prz_s  VARCHAR2(20) NOT NULL
);

ALTER TABLE specijalista ADD CONSTRAINT specijalista_pk PRIMARY KEY ( br_lic );

CREATE TABLE ugovor (
    dat_isug DATE NOT NULL,
    dat_skug DATE NOT NULL,
    naziv_la VARCHAR2(30) NOT NULL,
    id_dob   INTEGER NOT NULL
);

ALTER TABLE ugovor ADD CONSTRAINT ugovor_pk PRIMARY KEY ( naziv_la,
                                                          id_dob );

ALTER TABLE administrativac
    ADD CONSTRAINT administrativac_radnik_fk FOREIGN KEY ( mbr,
                                                           id_ap,
                                                           naziv_la )
        REFERENCES radnik ( mbr,
                            id_ap,
                            naziv_la );

ALTER TABLE apoteka
    ADD CONSTRAINT apoteka_apoteka_fk FOREIGN KEY ( id_nadr_ap,
                                                    naziv_la )
        REFERENCES apoteka ( id_ap,
                             naziv_la );

ALTER TABLE apoteka
    ADD CONSTRAINT apoteka_lanac_apoteka_fk FOREIGN KEY ( naziv_la )
        REFERENCES lanac_apoteka ( naziv_la );

ALTER TABLE direktor
    ADD CONSTRAINT direktor_apoteka_fk FOREIGN KEY ( id_ap,
                                                     naziv_la )
        REFERENCES apoteka ( id_ap,
                             naziv_la );

ALTER TABLE direktor
    ADD CONSTRAINT direktor_radnik_fk FOREIGN KEY ( mbr,
                                                    id_ap,
                                                    naziv_la )
        REFERENCES radnik ( mbr,
                            id_ap,
                            naziv_la );

ALTER TABLE dobavljeni
    ADD CONSTRAINT dobavljeni_administrativac_fk FOREIGN KEY ( mbr,
                                                               id_ap,
                                                               naziv_la )
        REFERENCES administrativac ( mbr,
                                     id_ap,
                                     naziv_la );

ALTER TABLE dobavljeni
    ADD CONSTRAINT dobavljeni_proizvod_fk FOREIGN KEY ( id_pro )
        REFERENCES proizvod ( id_pro );

ALTER TABLE dobavljeni
    ADD CONSTRAINT dobavljeni_ugovor_fk FOREIGN KEY (naziv_la, id_dob )
        REFERENCES ugovor (naziv_la,  id_dob );

ALTER TABLE farmaceutski_tehnicar
    ADD CONSTRAINT farmaceutski_tehnicar_radnik_fk FOREIGN KEY ( mbr,
                                                                 id_ap,
                                                                 naziv_la )
        REFERENCES radnik ( mbr,
                            id_ap,
                            naziv_la );

ALTER TABLE galenska_laboratorija
    ADD CONSTRAINT galenska_laboratorija_lanac_apoteka_fk FOREIGN KEY ( naziv_la )
        REFERENCES lanac_apoteka ( naziv_la );

ALTER TABLE galenski
    ADD CONSTRAINT galenski_proizvod_fk FOREIGN KEY ( id_pro )
        REFERENCES proizvod ( id_pro );

ALTER TABLE galenski
    ADD CONSTRAINT galenski_serija_fk FOREIGN KEY ( serija_id_serije )
        REFERENCES serija ( id_serije );

ALTER TABLE magistar_farmacije
    ADD CONSTRAINT magistar_farmacije_radnik_fk FOREIGN KEY ( mbr,
                                                              id_ap,
                                                              naziv_la )
        REFERENCES radnik ( mbr,
                            id_ap,
                            naziv_la );

ALTER TABLE magistralna_laboratorija
    ADD CONSTRAINT magistralna_laboratorija_apoteka_fk FOREIGN KEY ( id_ap,
                                                                     naziv_la )
        REFERENCES apoteka ( id_ap,
                             naziv_la );
 
ALTER TABLE magistralna_laboratorija
    ADD CONSTRAINT magistralna_laboratorija_magistar_farmacije_fk FOREIGN KEY ( mbr,id_ap,naziv_la )
        REFERENCES magistar_farmacije ( mbr,id_ap,naziv_la );


ALTER TABLE personalizovani
    ADD CONSTRAINT personalizovani_magistralna_laboratorija_fk FOREIGN KEY ( id_mag )
        REFERENCES magistralna_laboratorija ( id_mag );

ALTER TABLE personalizovani
    ADD CONSTRAINT personalizovani_personalizovani_recept_fk FOREIGN KEY ( id_r )
        REFERENCES personalizovani_recept ( id_r );

ALTER TABLE personalizovani
    ADD CONSTRAINT personalizovani_proizvod_fk FOREIGN KEY ( id_pro )
        REFERENCES proizvod ( id_pro );

ALTER TABLE personalizovani_recept
    ADD CONSTRAINT personalizovani_recept_specijalista_fk FOREIGN KEY ( br_lic )
        REFERENCES specijalista ( br_lic );

ALTER TABLE proizvod
    ADD CONSTRAINT proizvod_farmaceutski_tehnicar_fk FOREIGN KEY ( mbr,
                                                                   id_ap,
                                                                   naziv_la )
        REFERENCES farmaceutski_tehnicar ( mbr,
                                           id_ap,
                                           naziv_la );

ALTER TABLE radnik
    ADD CONSTRAINT radnik_apoteka_fk FOREIGN KEY ( id_ap,
                                                   naziv_la )
        REFERENCES apoteka ( id_ap,
                             naziv_la );

ALTER TABLE serija
    ADD CONSTRAINT serija_galenska_laboratorija_fk FOREIGN KEY ( naziv_la )
        REFERENCES galenska_laboratorija ( naziv_la );

ALTER TABLE ugovor
    ADD CONSTRAINT ugovor_dobavljac_fk FOREIGN KEY ( id_dob )
        REFERENCES dobavljac ( id_dob );

ALTER TABLE ugovor
    ADD CONSTRAINT ugovor_lanac_apoteka_fk FOREIGN KEY ( naziv_la )
        REFERENCES lanac_apoteka ( naziv_la );

CREATE OR REPLACE TRIGGER arc_fkarc_3_dobavljeni BEFORE
    INSERT OR UPDATE OF id_pro ON dobavljeni
    FOR EACH ROW
DECLARE
    d VARCHAR2(15);
BEGIN
    SELECT
        a.tip_pro
    INTO d
    FROM
        proizvod a
    WHERE
        a.id_pro = :new.id_pro;

    IF ( d IS NULL OR d <> 'Dobavljeni' ) THEN
        raise_application_error(
                               -20223,
                               'FK Dobavljeni_Proizvod_FK in Table Dobavljeni violates Arc constraint on Table Proizvod - discriminator column tip_pro doesn''t have value ''Dobavljeni'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_3_galenski BEFORE
    INSERT OR UPDATE OF id_pro ON galenski
    FOR EACH ROW
DECLARE
    d VARCHAR2(15);
BEGIN
    SELECT
        a.tip_pro
    INTO d
    FROM
        proizvod a
    WHERE
        a.id_pro = :new.id_pro;

    IF ( d IS NULL OR d <> 'Galenski' ) THEN
        raise_application_error(
                               -20223,
                               'FK Galenski_Proizvod_FK in Table Galenski violates Arc constraint on Table Proizvod - discriminator column tip_pro doesn''t have value ''Galenski'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_3_personalizovani BEFORE
    INSERT OR UPDATE OF id_pro ON personalizovani
    FOR EACH ROW
DECLARE
    d VARCHAR2(15);
BEGIN
    SELECT
        a.tip_pro
    INTO d
    FROM
        proizvod a
    WHERE
        a.id_pro = :new.id_pro;

    IF ( d IS NULL OR d <> 'Personalizovani' ) THEN
        raise_application_error(
                               -20223,
                               'FK Personalizovani_Proizvod_FK in Table Personalizovani violates Arc constraint on Table Proizvod - discriminator column tip_pro doesn''t have value ''Personalizovani'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_4_magistar_farmacije BEFORE
    INSERT OR UPDATE OF mbr, id_ap, naziv_la ON magistar_farmacije
    FOR EACH ROW
DECLARE
    d VARCHAR2(25);
BEGIN
    SELECT
        a.tip_radnika
    INTO d
    FROM
        radnik a
    WHERE
        a.mbr = :new.mbr
        AND a.id_ap = :new.id_ap
        AND a.naziv_la = :new.naziv_la;

    IF ( d IS NULL OR d <> 'Magistar_farmacije' ) THEN
        raise_application_error(
                               -20223,
                               'FK Magistar_farmacije_Radnik_FK in Table Magistar_farmacije violates Arc constraint on Table Radnik - discriminator column tip_radnika doesn''t have value ''Magistar_farmacije'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_4_administrativac BEFORE
    INSERT OR UPDATE OF mbr, id_ap, naziv_la ON administrativac
    FOR EACH ROW
DECLARE
    d VARCHAR2(25);
BEGIN
    SELECT
        a.tip_radnika
    INTO d
    FROM
        radnik a
    WHERE
        a.mbr = :new.mbr
        AND a.id_ap = :new.id_ap
        AND a.naziv_la = :new.naziv_la;

    IF ( d IS NULL OR d <> 'Administrativac' ) THEN
        raise_application_error(
                               -20223,
                               'FK Administrativac_Radnik_FK in Table Administrativac violates Arc constraint on Table Radnik - discriminator column tip_radnika doesn''t have value ''Administrativac'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_4_direktor BEFORE
    INSERT OR UPDATE OF mbr, id_ap, naziv_la ON direktor
    FOR EACH ROW
DECLARE
    d VARCHAR2(25);
BEGIN
    SELECT
        a.tip_radnika
    INTO d
    FROM
        radnik a
    WHERE
        a.mbr = :new.mbr
        AND a.id_ap = :new.id_ap
        AND a.naziv_la = :new.naziv_la;

    IF ( d IS NULL OR d <> 'Direktor' ) THEN
        raise_application_error(
                               -20223,
                               'FK Direktor_Radnik_FK in Table Direktor violates Arc constraint on Table Radnik - discriminator column tip_radnika doesn''t have value ''Direktor'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkar_farmaceutski_tehnicar BEFORE
    INSERT OR UPDATE OF mbr, id_ap, naziv_la ON farmaceutski_tehnicar
    FOR EACH ROW
DECLARE
    d VARCHAR2(25);
BEGIN
    SELECT
        a.tip_radnika
    INTO d
    FROM
        radnik a
    WHERE
        a.mbr = :new.mbr
        AND a.id_ap = :new.id_ap
        AND a.naziv_la = :new.naziv_la;

    IF ( d IS NULL OR d <> 'Farmaceutski_tehnicar' ) THEN
        raise_application_error(
                               -20223,
                               'FK Farmaceutski_tehnicar_Radnik_FK in Table Farmaceutski_tehnicar violates Arc constraint on Table Radnik - discriminator column tip_radnika doesn''t have value ''Farmaceutski_tehnicar'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/


Insert into LANAC_APOTEKA (NAZIV_LA,PIB,JIB) values ('BENUQ','12345678','1234567890123');

Insert into APOTEKA (ID_AP,BR_TEL,ADR_AP,NAZIV_LA,ID_NADR_AP,GRAD) values (1,'021/890-098','Dunavska 3','BENUQ',null,'Novi Sad');
Insert into APOTEKA (ID_AP,BR_TEL,ADR_AP,NAZIV_LA,ID_NADR_AP,GRAD) values (2,'021/890-198','Njegoseva 18','BENUQ',1,'Novi Sad');
Insert into APOTEKA (ID_AP,BR_TEL,ADR_AP,NAZIV_LA,ID_NADR_AP,GRAD) values (3,'021/890-138',' Bulevar Evrope 3','BENUQ',1,'Novi Sad');
Insert into APOTEKA (ID_AP,BR_TEL,ADR_AP,NAZIV_LA,ID_NADR_AP,GRAD) values (4,'011/890-138',' Kralja Petra 1','BENUQ',1,'Beograd');
Insert into APOTEKA (ID_AP,BR_TEL,ADR_AP,NAZIV_LA,ID_NADR_AP,GRAD) values (5,'011/830-138','Bulevar umetnosti','BENUQ',1,'Beograd');
Insert into APOTEKA (ID_AP,BR_TEL,ADR_AP,NAZIV_LA,ID_NADR_AP,GRAD) values (6,'011/820-138','Trnska 65','BENUQ',1,'Beograd');
Insert into APOTEKA (ID_AP,BR_TEL,ADR_AP,NAZIV_LA,ID_NADR_AP,GRAD) values (7,'018/820-138','Dusanova ulica 6','BENUQ',1,'Nis');
Insert into APOTEKA (ID_AP,BR_TEL,ADR_AP,NAZIV_LA,ID_NADR_AP,GRAD) values (8,'018/850-138','Hilandarska 6','BENUQ',1,'Nis');


Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Milan','Rajcevic','018/851-138',50000,'Administrativac',1234,1,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Milena','Milanovic','018/151-138',90000,'Magistar_farmacije',1235,1,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Dajana','Zlokapa','061/151-138',190000,'Direktor',1236,1,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Bojana','Cvjetojevic','061/154-138',70000,'Farmaceutski_tehnicar',1237,1,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Dajana','Cvjetojevic','061/194-138',65000,'Farmaceutski_tehnicar',1237,2,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Magdalena','Reljin','061/154-138',75000,'Farmaceutski_tehnicar',1238,3,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Milan','Reljin','061/154-138',75000,'Farmaceutski_tehnicar',1239,4,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Stefan','Zlokapa','061/194-131',65000,'Farmaceutski_tehnicar',1241,5,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Nikola','Risojevic','061/164-131',75000,'Farmaceutski_tehnicar',1242,6,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Boris','Bogdan','061/144-131',75000,'Farmaceutski_tehnicar',1243,7,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Nikolina','Kontic','061/144-134',75000,'Farmaceutski_tehnicar',1244,8,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Mira','Bogdan','061/144-134',95000,'Magistar_farmacije',1247,4,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Marko','Markovic','018/851-138',50000,'Administrativac',8000,2,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Nikola','Markovic','018/851-138',50000,'Administrativac',8001,3,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Jovan','Markovic','018/851-138',50000,'Administrativac',8002,4,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Vukasin','Markovic','018/851-138',50000,'Administrativac',8003,5,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Jovica','Markovic','018/851-138',50000,'Administrativac',8004,6,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Milica','Markovic','018/851-138',50000,'Administrativac',8005,7,'BENUQ');
Insert into RADNIK (IME,PRZ,TEL,PLT,TIP_RADNIKA,MBR,ID_AP,NAZIV_LA) values ('Katarina','Markovic','018/851-138',50000,'Administrativac',8006,8,'BENUQ');

Insert into DIREKTOR (MBR,ID_AP,NAZIV_LA) values (1236,1,'BENUQ');


Insert into FARMACEUTSKI_TEHNICAR (MBR,ID_AP,NAZIV_LA) values (1237,1,'BENUQ');
Insert into FARMACEUTSKI_TEHNICAR (MBR,ID_AP,NAZIV_LA) values (1237,2,'BENUQ');
Insert into FARMACEUTSKI_TEHNICAR (MBR,ID_AP,NAZIV_LA) values (1238,3,'BENUQ');
Insert into FARMACEUTSKI_TEHNICAR (MBR,ID_AP,NAZIV_LA) values (1239,4,'BENUQ');
Insert into FARMACEUTSKI_TEHNICAR (MBR,ID_AP,NAZIV_LA) values (1241,5,'BENUQ');
Insert into FARMACEUTSKI_TEHNICAR (MBR,ID_AP,NAZIV_LA) values (1242,6,'BENUQ');
Insert into FARMACEUTSKI_TEHNICAR (MBR,ID_AP,NAZIV_LA) values (1243,7,'BENUQ');
Insert into FARMACEUTSKI_TEHNICAR (MBR,ID_AP,NAZIV_LA) values (1244,8,'BENUQ');


Insert into MAGISTAR_FARMACIJE (MBR,ID_AP,NAZIV_LA) values (1235,1,'BENUQ');
Insert into MAGISTAR_FARMACIJE (MBR,ID_AP,NAZIV_LA) values (1247,4,'BENUQ');


Insert into ADMINISTRATIVAC (MBR,ID_AP,NAZIV_LA) values (1234,1,'BENUQ');
Insert into ADMINISTRATIVAC (MBR,ID_AP,NAZIV_LA) values (8000,2,'BENUQ');
Insert into ADMINISTRATIVAC (MBR,ID_AP,NAZIV_LA) values (8001,3,'BENUQ');
Insert into ADMINISTRATIVAC (MBR,ID_AP,NAZIV_LA) values (8002,4,'BENUQ');
Insert into ADMINISTRATIVAC (MBR,ID_AP,NAZIV_LA) values (8003,5,'BENUQ');
Insert into ADMINISTRATIVAC (MBR,ID_AP,NAZIV_LA) values (8004,6,'BENUQ');
Insert into ADMINISTRATIVAC (MBR,ID_AP,NAZIV_LA) values (8005,7,'BENUQ');
Insert into ADMINISTRATIVAC (MBR,ID_AP,NAZIV_LA) values (8006,8,'BENUQ');

INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (1,'Brufen',500.0,TO_DATE('2023-01-21','YYYY-MM-DD'),'Dobavljeni',1237,1,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (2,'Caffetine',200.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1237,1,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (3,'Aerius',300.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1237,1,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (4,'Febricet',300.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1237,1,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (5,'Vitamin C',100.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1237,1,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (6,'Fervex',200.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1237,1,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (7,'Paracetamol',400.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1237,2,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (8,'Coldrex',300.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1237,2,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (9,'Berodual',1000.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1237,2,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (10,'Vitamin D',1500.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1237,2,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (11,'Linex',500.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1237,2,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (12,'Singulair',1000.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1238,3,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (13,'Panklav',650.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1238,3,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (14,'Bensedin',870.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1239,4,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (15,'Sirup sljez',330.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1239,4,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (16,'Pavloviceva mast',230.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1241,5,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (17,'Elocom',379.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1242,6,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (18,'Xanax',979.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1242,6,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (19,'Aspirin',579.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1243,7,'BENUQ');
INSERT INTO proizvod (id_pro,naziv_pro,cena_pro,rok_trajanja,tip_pro,mbr,id_ap,naziv_la)
VALUES (20,'Bisoprolom',179.0,TO_DATE('2024-01-21','YYYY-MM-DD'),'Dobavljeni',1244,8,'BENUQ');

INSERT INTO dobavljac (id_dob,naziv_dob)
VALUES (1,'Farmalogist doo');
INSERT INTO dobavljac (id_dob,naziv_dob)
VALUES (2,'InPharm Co.');
INSERT INTO dobavljac (id_dob,naziv_dob)
VALUES (3,'BeoHem');

INSERT INTO ugovor (dat_isug,dat_skug,id_dob,naziv_la)
VALUES (TO_DATE('2022-12-31','YYYY-MM-DD'),TO_DATE('2022-01-01','YYYY-MM-DD'),1,'BENUQ');
INSERT INTO ugovor (dat_isug,dat_skug,id_dob,naziv_la)
VALUES (TO_DATE('2022-12-31','YYYY-MM-DD'),TO_DATE('2022-01-01','YYYY-MM-DD'),2,'BENUQ');
INSERT INTO ugovor (dat_isug,dat_skug,id_dob,naziv_la)
VALUES (TO_DATE('2022-12-31','YYYY-MM-DD'),TO_DATE('2022-01-01','YYYY-MM-DD'),3,'BENUQ');


Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (1,1234,1,'BENUQ',1);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (2,1234,1,'BENUQ',1);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (3,1234,1,'BENUQ',1);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (4,1234,1,'BENUQ',2);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (5,1234,1,'BENUQ',2);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (6,1234,1,'BENUQ',3);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (7,8000,2,'BENUQ',1);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (8,8000,2,'BENUQ',1);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (9,8000,2,'BENUQ',3);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (10,8000,2,'BENUQ',3);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (11,8000,2,'BENUQ',2);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (12,8001,3,'BENUQ',2);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (13,8001,3,'BENUQ',3);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (14,8002,4,'BENUQ',1);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (15,8002,4,'BENUQ',3);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (16,8003,5,'BENUQ',3);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (17,8004,6,'BENUQ',3);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (18,8004,6,'BENUQ',1);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (19,8005,7,'BENUQ',2);
Insert into DOBAVLJENI (ID_PRO,MBR,ID_AP,NAZIV_LA,ID_DOB) values (20,8006,8,'BENUQ',2);

