from sqlite3 import connect
from faker import Faker
fake = Faker('de_DE')


def create_table(conn):
    cursor = conn.cursor()
    cursor.execute(
    """
        CREATE TABLE personen (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        vorname VARCHAR,
        nachname VARCHAR
        )
    """
    )
    conn.commit()


def insert_biased_people(conn):
    """
    Erzeugt 500k Personen:
    250k haben den Vornamen 'Max'
    """
    cursor = conn.cursor()

    sql = """
        INSERT INTO personen(vorname, nachname)
        VALUES (?, ?)
    """

    # 250k Bias: Vorname = Max
    for name in range(250_000):
        cursor.execute(sql, ("Max", fake.last_name()))

    # 250k normale Faker-Daten
    for name in range(250_000):
        cursor.execute(sql, (fake.first_name(), fake.last_name()))

    conn.commit()


conn = connect("./personen_bias.db")
create_table(conn)
insert_biased_people(conn)
conn.close()
