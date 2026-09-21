from sqlite3 import connect
from faker import Faker
fake = Faker('de_DE')


conn = connect("path_to_db")

"""
    CREATE TABLE personen
    id INTEGER PRIMARY KEY AUTO INCREMENT
    vorname VARCHAR
    nachname VARCHAR
"""


def insert_random_person(conn):
    sql = """ 
    INSERT INTO personen(vorname, nachname)
    VALUES (?, ?)
    RETURNING *
    """
    cursor = conn.cursor()
    cursor.execute(sql, (fake.first_name(), fake.last_name()))
    return cursor.fetchone()
