-- Portfolio demonstration: synthetic data only, SQLite-compatible.
CREATE TABLE facility_energy (
    facility TEXT NOT NULL,
    month TEXT NOT NULL,
    total_kwh REAL NOT NULL CHECK(total_kwh > 0),
    it_kwh REAL NOT NULL CHECK(it_kwh > 0 AND it_kwh <= total_kwh),
    grid_kg_co2e_per_kwh REAL NOT NULL CHECK(grid_kg_co2e_per_kwh >= 0),
    PRIMARY KEY(facility, month)
);

-- Invented inputs and emission factors; not suitable for real reporting.
INSERT INTO facility_energy VALUES
('Example East','2026-01',150000,100000,0.30),
('Example East','2026-02',145000,100000,0.30),
('Example West','2026-01',180000,120000,0.40),
('Example West','2026-02',168000,120000,0.40);

CREATE VIEW facility_summary AS
SELECT facility,
       SUM(total_kwh) AS facility_kwh,
       SUM(it_kwh) AS it_kwh,
       ROUND(SUM(total_kwh) / SUM(it_kwh), 4) AS aggregate_pue,
       ROUND(SUM(total_kwh * grid_kg_co2e_per_kwh) / 1000.0, 2)
           AS illustrative_electricity_tco2e
FROM facility_energy
GROUP BY facility;

SELECT * FROM facility_summary ORDER BY facility;
