"""Run the synthetic SQLite example. Python standard library only."""
from pathlib import Path
import sqlite3
import csv

root = Path(__file__).resolve().parent
with sqlite3.connect(':memory:') as connection:
    connection.executescript((root / 'analysis.sql').read_text(encoding='utf-8'))
    cursor = connection.execute('SELECT * FROM facility_summary ORDER BY facility')
    columns = [field[0] for field in cursor.description]
    rows = cursor.fetchall()
    assert rows == [
        ('Example East', 295000.0, 200000.0, 1.475, 88.5),
        ('Example West', 348000.0, 240000.0, 1.45, 139.2),
    ], rows
    try:
        connection.execute("INSERT INTO facility_energy VALUES ('Invalid', '2026-01', 10, 20, 0.3)")
    except sqlite3.IntegrityError:
        pass
    else:
        raise AssertionError('Invalid IT energy was accepted')
    with (root / 'expected-results.csv').open('w', newline='', encoding='utf-8') as stream:
        writer = csv.writer(stream)
        writer.writerow(columns)
        writer.writerows(rows)
    print('Verified calculations and invalid-input rejection. Results:')
    print(columns)
    for row in rows:
        print(row)
