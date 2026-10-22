-- create table ANGAJATI (
--   NR_CRT INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--   NUME VARCHAR2(50) NOT NULL,
--   PRENUME VARCHAR2(50) NOT NULL,
--   FUNCTIE VARCHAR2(50) NOT NULL,
--   SALAR_BAZA INTEGER NOT NULL CHECK (SALAR_BAZA > 0),
--   SPOR INTEGER DEFAULT 0 CHECK (SPOR >= 0),
--   PREMII_BRUTE INTEGER DEFAULT 0 CHECK (PREMII_BRUTE >= 0),
--   TOTAL_BRUT INTEGER,
--   BRUT_IMPOZABIL INTEGER,
--   IMPOZIT INTEGER,
--   CAS INTEGER,
--   CASS INTEGER,
--   RETINERI INTEGER DEFAULT 0 CHECK (RETINERI >= 0),
--   VIRAT_CARD INTEGER,
--   POZA BLOB
--   );

-- create table PROCENTE (
--   ID INTEGER PRIMARY KEY,
--   CAS INTEGER DEFAULT 25 CHECK (CAS BETWEEN 0 AND 100),
--   CASS INTEGER DEFAULT 10 CHECK (CASS BETWEEN 0 AND 100),
--   IMPOZIT INTEGER DEFAULT 10 CHECK (IMPOZIT BETWEEN 0 AND 100),
--   PAROLA VARCHAR2(255) NOT NULL
--   );

-- INSERT INTO ANGAJATI (
--     NUME, PRENUME, FUNCTIE, SALAR_BAZA, SPOR, PREMII_BRUTE, 
--     TOTAL_BRUT, BRUT_IMPOZABIL, CAS, CASS, IMPOZIT, RETINERI, VIRAT_CARD, POZA
-- ) VALUES (
--     'Popescu', 'Ion', 'Inginer', 4000, 10, 0,
--     4400, 2860, 286, 1100, 440, 0, 2574, 'C:\Users\Lore\Documents\facultate AC info\Master_SIAPS\An_1\sem1\TPW\proiect\Aplicatie_WEB\poza_angajati\angajat1.jpg'
-- );

-- INSERT INTO ANGAJATI (
--     NUME, PRENUME, FUNCTIE, SALAR_BAZA, SPOR, PREMII_BRUTE, 
--     TOTAL_BRUT, BRUT_IMPOZABIL, CAS, CASS, IMPOZIT, RETINERI, VIRAT_CARD, POZA
-- ) VALUES (
--     'Caras', 'Mihai', 'Contabil', 4000, 0, 0,
--     4000, 2600, 1000, 400, 260, 0, 2340, 'C:\Users\Lore\Documents\facultate AC info\Master_SIAPS\An_1\sem1\TPW\proiect\Aplicatie_WEB\poza_angajati\angajat2.jpg'
-- );

-- INSERT INTO ANGAJATI (
--     NUME, PRENUME, FUNCTIE, SALAR_BAZA, SPOR, PREMII_BRUTE, 
--     TOTAL_BRUT, BRUT_IMPOZABIL, CAS, CASS, IMPOZIT, RETINERI, VIRAT_CARD, POZA
-- ) VALUES (
--     'Oprescu', 'Carina', 'Inginer Software', 5000, 10, 0,
--     5500, 3575, 1375, 550, 358, 200, 3017, 'C:\Users\Lore\Documents\facultate AC info\Master_SIAPS\An_1\sem1\TPW\proiect\Aplicatie_WEB\poza_angajati\angajat3.jpg'
-- );

-- INSERT INTO PROCENTE (ID, PAROLA)
-- VALUES (1, STANDARD_HASH('parola123', 'SHA256'));

create or replace procedure Calcule (
	p_id in integer,
    p_salarBaza in integer,
    p_spor in integer,
    p_premiiBrute in integer,
    p_retineri in integer
) as
	p_casProcent integer;
    p_cassProcent integer;
    p_impozitProcent integer;

    p_totalBrut integer;
    p_brutImpozabil integer;
    p_impozit integer;
    p_cas integer;
    p_cass integer;
    p_viratCard integer;
    BEGIN
		select cas, cass, impozit into p_casProcent, p_cassProcent, p_impozitProcent from PROCENTE where rownum = 1;
    
		p_totalBrut := ROUND(p_salarBaza * (1 + p_spor/100) + p_premiiBrute);
        p_cas := ROUND(p_totalBrut * (p_casProcent/100));
        p_cass := ROUND(p_totalBrut * (p_cassProcent/100));
        p_brutImpozabil := p_totalBrut - p_cas - p_cass;
        p_impozit := ROUND(p_brutImpozabil * (P_impozitProcent/100));
        p_viratCard := p_totalBrut - p_impozit - p_cas - p_cass - p_retineri;
    
		update angajati
        set total_brut = p_totalBrut,
			brut_impozabil = p_brutImpozabil,
            impozit = p_impozit,
            cas = p_cas,
            cass = p_cass,
            virat_card = p_viratCard
		where nr_crt = p_id;
        commit;
	END;
    /