""" Anzahl der unterschieldichen Vornamen
SELECT COUNT(DISTINCT vorname)
FROM personen;
"""
Ergebnis: 2002

""" Anzahl der unterschieldichen Nachnamen
SELECT COUNT(DISTINCT nachname)
FROM personen;
"""

Ergebnis: 404

""" Der häufigste + seltenste Vorname + durchschnittliche Häufigkeit eines Vornamens
WITH freq AS (
    SELECT vorname, COUNT(*) AS anzahl
    FROM personen
    GROUP BY vorname
)

SELECT
    (SELECT vorname FROM freq ORDER BY anzahl DESC LIMIT 1) AS haeufigster_vorname,
    (SELECT anzahl FROM freq ORDER BY anzahl DESC LIMIT 1) AS haeufigster_anzahl,

    (SELECT vorname FROM freq ORDER BY anzahl ASC LIMIT 1) AS seltenster_vorname,
    (SELECT anzahl FROM freq ORDER BY anzahl ASC LIMIT 1) AS seltenster_anzahl,

    (SELECT AVG(anzahl) FROM freq) AS durchschnittliche_haeufigkeit;
"""

Ergebnis:
    MAX = Jonas 492
    MIN = Natalja 199
    AVG = 249.75


""" Der häufigste + seltenste Nachname + durchschnittliche Häufigkeit eines Nachnamens
WITH freq AS (
    SELECT nachname, COUNT(*) AS anzahl
    FROM personen
    GROUP BY nachname
)

SELECT
    (SELECT nachname FROM freq ORDER BY anzahl DESC LIMIT 1) AS haeufigster_nachname,
    (SELECT anzahl FROM freq ORDER BY anzahl DESC LIMIT 1) AS haeufigster_anzahl,

    (SELECT nachname FROM freq ORDER BY anzahl ASC LIMIT 1) AS seltenster_nachname,
    (SELECT anzahl FROM freq ORDER BY anzahl ASC LIMIT 1) AS seltenster_anzahl,

    (SELECT AVG(anzahl) FROM freq) AS durchschnittliche_haeufigkeit;
"""

Ergebnis:
    MAX = Seifert 2533
    MIN = Tintzmann 1123
    AVG = 1237.62

""" Test-Select für Performance
SELECT COUNT(DISTINCT vorname) FROM personen;
"""

Ergebnis:
    ==> Run Time: real 0.305 user 0.281250 sys 0.031250

""" Erstellung des Index für Vornamen
CREATE INDEX idx_vorname ON personen(vorname);
"""

""" Erstellung des Index für Nachnamen
CREATE INDEX idx_nachname ON personen(nachname);
"""
Ergebnis:
    ==> Run Time: real 0.057 user 0.062500 sys 0.000000


""" Testen des Speicherbedarfs
PRAGMA page_size;
PRAGMA page_count;
"""

Ergebnis vor dem Index:
    Seitengröße: 4096B
    Seitenanzahl: 2870B
    4096 * 2870 = 11.755520MB

Ergebnis nach dem Index:
    Seitengröße: 4096B
    Seitenanzahl: 6703B
    4096 * 6703 = 27.455488MB

""" Test-Select für Performance
SELECT COUNT(DISTINCT vorname) FROM personen;
"""


Ergebnis vor Index:
    Run Time: real 0.200 user 0.156250 sys 0.031250
    Seitengröße: 4096B
    Seitenanzahl: 2648B
    4096 * 2648 = 10.846208MB

""" Index für Biased-Datenbank
CREATE INDEX idx_vorname ON personen(vorname);
"""

Ergebnis nach Index:
    Run Time: real 0.064 user 0.046875 sys 0.000000
    Seitengröße: 4096B
    Seitenanzahl: 4336B
    4096 * 4336 = 17.760256MB