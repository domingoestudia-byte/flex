-- ============================================================
-- Tablas antropométricas para Supabase (PostgreSQL)
-- ============================================================
-- Generado: 2026-05-18
-- Nota: Las columnas numéricas usan DECIMAL para preservar precisión
--       ya que los datos originales usan coma como separador decimal
-- ============================================================

-- ---------------------------------------------------------------
-- 1. TABLA: medidas_por_edad
--    Medidas antropométricas agrupadas por rango etario
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS medidas_por_edad (
    id              SERIAL PRIMARY KEY,
    grupo_etario    VARCHAR(10)  NOT NULL,   -- Ej: '12-19', '20-30'
    medida          VARCHAR(80)  NOT NULL,   -- Nombre de la medida
    media           DECIMAL(6,3) NOT NULL,    -- Valor medio
    sd              DECIMAL(6,3) NOT NULL,    -- Desviación estándar
    p5              DECIMAL(6,3) NOT NULL,    -- Percentil 5
    p25             DECIMAL(6,3) NOT NULL,    -- Percentil 25
    p50             DECIMAL(6,3) NOT NULL,    -- Percentil 50 (mediana)
    p75             DECIMAL(6,3) NOT NULL,    -- Percentil 75
    p95             DECIMAL(6,3) NOT NULL,    -- Percentil 95
    unidad          VARCHAR(20)  GENERATED ALWAYS AS (
                        CASE
                            WHEN medida LIKE '%(m)' THEN 'metros'
                            WHEN medida LIKE '%(kg)' THEN 'kilogramos'
                            WHEN medida LIKE '%(kg/m2)' THEN 'kg/m²'
                            WHEN medida LIKE '%(cm)' THEN 'centímetros'
                            ELSE 'desconocida'
                        END
                    ) STORED,
    created_at      TIMESTAMPTZ  DEFAULT NOW(),

    CONSTRAINT chk_grupo_etario CHECK (grupo_etario IN (
        '12-19','20-30','31-40','41-50','51-60','61-70'
    ))
);

-- Índices útiles
CREATE INDEX idx_medidas_por_edad_grupo ON medidas_por_edad(grupo_etario);
CREATE INDEX idx_medidas_por_edad_medida ON medidas_por_edad(medida);

COMMENT ON TABLE medidas_por_edad IS 'Medidas antropométricas por rango etario (mujeres)';


-- ---------------------------------------------------------------
-- 2. TABLA: medidas_prenda_inferior
--    Medidas detalladas por talla de prenda inferior (pantalones, faldas, etc.)
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS medidas_prenda_inferior (
    id                      SERIAL PRIMARY KEY,
    talla                   INTEGER      NOT NULL,   -- 36, 38, 40, ..., 50
    medida                  VARCHAR(80)  NOT NULL,   -- Nombre de la medida
    p5                      DECIMAL(6,3) NOT NULL,    -- Percentil 5
    p25                     DECIMAL(6,3) NOT NULL,    -- Percentil 25
    p50                     DECIMAL(6,3) NOT NULL,    -- Percentil 50
    p75                     DECIMAL(6,3) NOT NULL,    -- Percentil 75
    p95                     DECIMAL(6,3) NOT NULL,    -- Percentil 95
    sd                      DECIMAL(6,3) NOT NULL,    -- Desviación estándar
    unidad                  VARCHAR(20)  GENERATED ALWAYS AS (
                        CASE
                            WHEN medida LIKE '%(m)' THEN 'metros'
                            WHEN medida LIKE '%(kg)' THEN 'kilogramos'
                            WHEN medida LIKE '%(kg/m2)' THEN 'kg/m²'
                            WHEN medida LIKE '%(cm)' THEN 'centímetros'
                            ELSE 'desconocida'
                        END
                    ) STORED,
    created_at              TIMESTAMPTZ  DEFAULT NOW(),

    CONSTRAINT chk_talla_inferior CHECK (talla BETWEEN 36 AND 50 AND talla % 2 = 0)
);

CREATE INDEX idx_prenda_inferior_talla ON medidas_prenda_inferior(talla);
CREATE INDEX idx_prenda_inferior_medida ON medidas_prenda_inferior(medida);

COMMENT ON TABLE medidas_prenda_inferior IS 'Medidas antropométricas detalladas por talla de prenda inferior';


-- ---------------------------------------------------------------
-- 3. TABLA: medidas_prenda_superior
--    Medidas detalladas por talla de prenda superior (blusas, chaquetas, etc.)
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS medidas_prenda_superior (
    id                      SERIAL PRIMARY KEY,
    talla                   INTEGER      NOT NULL,   -- 36, 38, 40, ..., 50
    medida                  VARCHAR(80)  NOT NULL,   -- Nombre de la medida
    p5                      DECIMAL(6,3) NOT NULL,    -- Percentil 5
    p25                     DECIMAL(6,3) NOT NULL,    -- Percentil 25
    p50                     DECIMAL(6,3) NOT NULL,    -- Percentil 50
    p75                     DECIMAL(6,3) NOT NULL,    -- Percentil 75
    p95                     DECIMAL(6,3) NOT NULL,    -- Percentil 95
    sd                      DECIMAL(6,3) NOT NULL,    -- Desviación estándar
    unidad                  VARCHAR(20)  GENERATED ALWAYS AS (
                        CASE
                            WHEN medida LIKE '%(m)' THEN 'metros'
                            WHEN medida LIKE '%(kg)' THEN 'kilogramos'
                            WHEN medida LIKE '%(kg/m2)' THEN 'kg/m²'
                            WHEN medida LIKE '%(cm)' THEN 'centímetros'
                            ELSE 'desconocida'
                        END
                    ) STORED,
    created_at              TIMESTAMPTZ  DEFAULT NOW(),

    CONSTRAINT chk_talla_superior CHECK (talla BETWEEN 36 AND 50 AND talla % 2 = 0)
);

CREATE INDEX idx_prenda_superior_talla ON medidas_prenda_superior(talla);
CREATE INDEX idx_prenda_superior_medida ON medidas_prenda_superior(medida);

COMMENT ON TABLE medidas_prenda_superior IS 'Medidas antropométricas detalladas por talla de prenda superior';


-- ---------------------------------------------------------------
-- 4. TABLA: tallas_referencia_inferior
--    Tabla resumen: cintura, cadera, tiro y altura de cadera por talla/percentil
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tallas_referencia_inferior (
    id              SERIAL PRIMARY KEY,
    tipo            VARCHAR(20)  NOT NULL DEFAULT 'inferior',
    talla           INTEGER      NOT NULL,   -- 36, 38, 40, ..., 50
    percentil       VARCHAR(5)   NOT NULL,   -- 'P5', 'P50', 'P95'
    cintura_cm      DECIMAL(5,1) NOT NULL,
    cadera_cm       DECIMAL(5,1) NOT NULL,
    tiro_cm         DECIMAL(5,1) NOT NULL,
    altura_cadera_cm DECIMAL(5,1) NOT NULL,
    created_at      TIMESTAMPTZ  DEFAULT NOW(),

    CONSTRAINT chk_talla_ref_inf CHECK (talla BETWEEN 36 AND 50 AND talla % 2 = 0),
    CONSTRAINT chk_percentil_inf CHECK (percentil IN ('P5','P50','P95'))
);

CREATE INDEX idx_tallas_ref_inf_talla ON tallas_referencia_inferior(talla);
CREATE INDEX idx_tallas_ref_inf_percentil ON tallas_referencia_inferior(percentil);

COMMENT ON TABLE tallas_referencia_inferior IS 'Tabla resumen de tallas inferiores con medidas clave por percentil';


-- ---------------------------------------------------------------
-- 5. TABLA: tallas_referencia_superior
--    Tabla resumen: busto, cintura y cadera por talla/percentil
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tallas_referencia_superior (
    id              SERIAL PRIMARY KEY,
    tipo            VARCHAR(20)  NOT NULL DEFAULT 'superior',
    talla           INTEGER      NOT NULL,   -- 36, 38, 40, ..., 50
    percentil       VARCHAR(5)   NOT NULL,   -- 'P5', 'P50', 'P95'
    busto_cm        DECIMAL(5,1) NOT NULL,
    cintura_cm      DECIMAL(5,1) NOT NULL,
    cadera_cm       DECIMAL(5,1) NOT NULL,
    created_at      TIMESTAMPTZ  DEFAULT NOW(),

    CONSTRAINT chk_talla_ref_sup CHECK (talla BETWEEN 36 AND 50 AND talla % 2 = 0),
    CONSTRAINT chk_percentil_sup CHECK (percentil IN ('P5','P50','P95'))
);

CREATE INDEX idx_tallas_ref_sup_talla ON tallas_referencia_superior(talla);
CREATE INDEX idx_tallas_ref_sup_percentil ON tallas_referencia_superior(percentil);

COMMENT ON TABLE tallas_referencia_superior IS 'Tabla resumen de tallas superiores con medidas clave por percentil';


-- ============================================================
-- POLÍTICAS RLS (Row Level Security) para Supabase
-- ============================================================
-- Habilitar RLS en todas las tablas
ALTER TABLE medidas_por_edad ENABLE ROW LEVEL SECURITY;
ALTER TABLE medidas_prenda_inferior ENABLE ROW LEVEL SECURITY;
ALTER TABLE medidas_prenda_superior ENABLE ROW LEVEL SECURITY;
ALTER TABLE tallas_referencia_inferior ENABLE ROW LEVEL SECURITY;
ALTER TABLE tallas_referencia_superior ENABLE ROW LEVEL SECURITY;

-- Política: lectura pública (datos de referencia)
CREATE POLICY "Allow public read" ON medidas_por_edad
    FOR SELECT USING (true);
CREATE POLICY "Allow public read" ON medidas_prenda_inferior
    FOR SELECT USING (true);
CREATE POLICY "Allow public read" ON medidas_prenda_superior
    FOR SELECT USING (true);
CREATE POLICY "Allow public read" ON tallas_referencia_inferior
    FOR SELECT USING (true);
CREATE POLICY "Allow public read" ON tallas_referencia_superior
    FOR SELECT USING (true);

-- Política: solo usuarios autenticados pueden insertar/actualizar/eliminar
CREATE POLICY "Allow authenticated insert" ON medidas_por_edad
    FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Allow authenticated update" ON medidas_por_edad
    FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Allow authenticated delete" ON medidas_por_edad
    FOR DELETE TO authenticated USING (true);

CREATE POLICY "Allow authenticated insert" ON medidas_prenda_inferior
    FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Allow authenticated update" ON medidas_prenda_inferior
    FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Allow authenticated delete" ON medidas_prenda_inferior
    FOR DELETE TO authenticated USING (true);

CREATE POLICY "Allow authenticated insert" ON medidas_prenda_superior
    FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Allow authenticated update" ON medidas_prenda_superior
    FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Allow authenticated delete" ON medidas_prenda_superior
    FOR DELETE TO authenticated USING (true);

CREATE POLICY "Allow authenticated insert" ON tallas_referencia_inferior
    FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Allow authenticated update" ON tallas_referencia_inferior
    FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Allow authenticated delete" ON tallas_referencia_inferior
    FOR DELETE TO authenticated USING (true);

CREATE POLICY "Allow authenticated insert" ON tallas_referencia_superior
    FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Allow authenticated update" ON tallas_referencia_superior
    FOR UPDATE TO authenticated USING (true);
CREATE POLICY "Allow authenticated delete" ON tallas_referencia_superior
    FOR DELETE TO authenticated USING (true);


-- ============================================================
-- INSERTS: medidas_por_edad
-- ============================================================

INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('12-19', 'Estatura (m)', 
        1.61, 0.63, 1.51, 
        1.57, 1.61, 1.65, 1.71);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('12-19', 'Peso (kg)', 
        56.3, 10.8, 42.3, 
        49.1, 54.7, 61.6, 76.5);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('12-19', 'Índice de Masa Corporal IMC (kg/m2)', 
        21.7, 3.8, 17.1, 
        19.1, 21.0, 23.5, 29.0);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('12-19', 'Perímetro del busto (cm)', 
        87.3, 7.9, 76.9, 
        81.8, 86.1, 91.2, 102.2);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('12-19', 'Contorno de cintura (cm)', 
        74.0, 8.8, 62.9, 
        67.8, 72.4, 78.3, 90.9);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('12-19', 'Contorno de cadera (cm)', 
        98.6, 8.6, 86.2, 
        92.8, 97.8, 103.3, 114.1);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('12-19', 'Longitud de espalda entre axilas (cm)', 
        33.9, 2.7, 29.8, 
        32.1, 33.8, 35.6, 38.7);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('12-19', 'Longitud pecho-cuello (cm)', 
        25.4, 2.4, 21.9, 
        23.8, 25.1, 26.7, 29.8);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('12-19', 'Longitud cuello-cintura sobre el pecho (cm)', 
        42.4, 2.7, 38.1, 
        40.7, 42.4, 44.2, 47.0);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('12-19', 'Longitud trasera cuello-cintura (cm)', 
        39.9, 3.3, 35.3, 
        37.6, 39.5, 41.9, 46.0);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('12-19', 'Longitud brazo hasta acromion (cm)', 
        55.4, 2.9, 50.7, 
        53.5, 55.3, 57.3, 60.1);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('12-19', 'Longitud de la entrepierna (tiro del pantalón) (cm)', 
        71.0, 5.3, 63.1, 
        67.6, 70.5, 73.9, 80.2);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('12-19', 'Longitud externa pierna hasta el suelo (cm)', 
        101.1, 4.8, 93.7, 
        97.8, 101.0, 104.2, 109.1);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('20-30', 'Estatura (m)', 
        1.62, 0.62, 1.52, 
        1.58, 1.62, 1.66, 1.73);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('20-30', 'Peso (kg)', 
        60.7, 11.4, 46.4, 
        53.2, 58.4, 65.9, 82.0);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('20-30', 'Índice de Masa Corporal IMC (kg/m2)', 
        23.1, 4.2, 18.2, 
        20.3, 22.1, 25.0, 31.4);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('20-30', 'Perímetro del busto (cm)', 
        90.6, 8.5, 80.0, 
        84.7, 88.9, 94.6, 106.9);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('20-30', 'Contorno de cintura (cm)', 
        78.1, 10.1, 65.8, 
        71.0, 76.0, 82.7, 97.9);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('20-30', 'Contorno de cadera (cm)', 
        103.0, 8.8, 91.4, 
        97.2, 101.6, 107.3, 118.8);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('20-30', 'Longitud de espalda entre axilas (cm)', 
        35.3, 2.6, 31.4, 
        33.5, 35.2, 37.0, 39.8);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('20-30', 'Longitud pecho-cuello (cm)', 
        27.4, 2.7, 23.9, 
        25.6, 27.0, 28.9, 32.4);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('20-30', 'Longitud cuello-cintura sobre el pecho (cm)', 
        43.8, 2.6, 40.0, 
        42.1, 43.6, 45.4, 48.2);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('20-30', 'Longitud trasera cuello-cintura (cm)', 
        40.6, 3.0, 36.4, 
        38.5, 40.2, 42.3, 46.2);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('20-30', 'Longitud brazo hasta acromion (cm)', 
        55.7, 2.9, 51.1, 
        53.7, 55.6, 57.5, 60.6);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('20-30', 'Longitud de la entrepierna (tiro del pantalón) (cm)', 
        72.3, 5.4, 64.5, 
        68.8, 71.7, 75.2, 81.9);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('20-30', 'Longitud externa pierna hasta el suelo (cm)', 
        101.4, 4.9, 93.7, 
        98.2, 101.2, 104.4, 109.8);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('31-40', 'Estatura (m)', 
        1.61, 0.62, 1.51, 
        1.57, 1.61, 1.65, 1.71);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('31-40', 'Peso (kg)', 
        63.1, 13.0, 48.0, 
        54.2, 60.6, 68.0, 89.4);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('31-40', 'Índice de Masa Corporal IMC (kg/m2)', 
        24.3, 4.8, 18.8, 
        21.0, 22.9, 26.2, 34.3);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('31-40', 'Perímetro del busto (cm)', 
        93.4, 9.7, 81.5, 
        86.6, 91.6, 97.7, 113.3);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('31-40', 'Contorno de cintura (cm)', 
        82.7, 11.7, 68.2, 
        74.7, 80.8, 87.7, 105.6);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('31-40', 'Longitud de espalda entre axilas (cm)', 
        104.0, 9.7, 91.4, 
        97.5, 102.1, 108.3, 122.9);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('31-40', 'Longitud pecho-cuello (cm)', 
        29.0, 2.9, 24.8, 
        26.9, 28.5, 30.5, 34.3);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('31-40', 'Longitud cuello-cintura sobre el pecho (cm)', 
        44.2, 2.7, 40.3, 
        42.4, 43.9, 45.7, 48.9);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('31-40', 'Longitud trasera cuello-cintura (cm)', 
        40.9, 3.2, 36.5, 
        38.7, 40.4, 42.8, 46.8);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('31-40', 'Longitud brazo hasta acromion (cm)', 
        55.4, 2.9, 50.9, 
        53.4, 55.2, 57.3, 60.6);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('31-40', 'Longitud de la entrepierna (tiro del pantalón) (cm)', 
        72.8, 6.1, 64.6, 
        68.9, 72.1, 75.9, 84.0);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('31-40', 'Longitud externa pierna hasta el suelo (cm)', 
        100.6, 4.9, 93.1, 
        97.5, 100.4, 103.5, 108.6);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('41-50', 'Estatura (m)', 
        1.59, 0.61, 1.5, 
        1.55, 1.59, 1.63, 1.7);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('41-50', 'Peso (kg)', 
        64.9, 12.1, 48.8, 
        56.7, 62.8, 71.3, 88.3);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('41-50', 'Índice de Masa Corporal IMC (kg/m2)', 
        25.6, 4.7, 19.6, 
        22.3, 24.7, 27.7, 34.8);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('41-50', 'Perímetro del busto (cm)', 
        96.7, 9.8, 83.4, 
        89.9, 95.4, 101.9, 116.2);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('41-50', 'Contorno de cintura (cm)', 
        87.3, 11.4, 71.7, 
        79.3, 85.7, 93.4, 109.7);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('41-50', 'Contorno de cadera (cm)', 
        105.3, 9.4, 92.7, 
        99.0, 103.9, 110.1, 122.3);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('41-50', 'Longitud de espalda entre axilas (cm)', 
        37.1, 3.0, 32.7, 
        35.1, 36.9, 38.8, 42.6);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('41-50', 'Longitud pecho-cuello (cm)', 
        29.9, 2.9, 25.8, 
        27.8, 29.6, 31.6, 35.1);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('41-50', 'Longitud cuello-cintura sobre el pecho (cm)', 
        44.5, 2.8, 40.3, 
        42.6, 44.4, 46.1, 49.4);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('41-50', 'Longitud trasera cuello-cintura (cm)', 
        40.8, 3.2, 36.5, 
        38.5, 40.3, 42.6, 46.9);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('41-50', 'Longitud brazo hasta acromion (cm)', 
        54.8, 2.9, 50.0, 
        52.8, 54.8, 56.6, 59.9);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('41-50', 'Longitud de la entrepierna (tiro del pantalón) (cm)', 
        73.6, 5.5, 65.5, 
        70.1, 73.1, 76.5, 83.2);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('41-50', 'Longitud externa pierna hasta el suelo (cm)', 
        99.5, 4.9, 91.7, 
        95.9, 99.3, 102.4, 107.6);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('51-60', 'Estatura (m)', 
        1.56, 0.6, 1.47, 
        1.52, 1.56, 1.6, 1.66);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('51-60', 'Peso (kg)', 
        67.0, 11.8, 50.3, 
        58.7, 65.4, 73.3, 89.5);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('51-60', 'Índice de Masa Corporal IMC (kg/m2)', 
        27.4, 5.0, 20.9, 
        23.9, 26.6, 29.8, 36.7);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('51-60', 'Perímetro del busto (cm)', 
        99.9, 10.3, 85.1, 
        92.4, 98.8, 106.0, 118.8);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('51-60', 'Contorno de cintura (cm)', 
        92.4, 11.7, 75.2, 
        84.0, 91.4, 99.8, 113.3);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('51-60', 'Contorno de cadera (cm)', 
        107.2, 9.8, 93.9, 
        100.9, 105.7, 111.9, 126.4);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('51-60', 'Longitud de espalda entre axilas (cm)', 
        37.7, 3.1, 32.9, 
        35.7, 37.6, 39.6, 42.9);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('51-60', 'Longitud cuello-cintura sobre el pecho (cm)', 
        31.0, 2.9, 26.59, 
        29.0, 30.9, 32.9, 36.1);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('51-60', 'Longitud trasera cuello-cintura (cm)', 
        40.6, 3.2, 36.2, 
        38.3, 40.2, 42.4, 46.7);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('51-60', 'Longitud brazo hasta acromion (cm)', 
        54.1, 2.8, 49.6, 
        52.2, 54.0, 55.8, 58.9);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('51-60', 'Longitud de la entrepierna (tiro del pantalón) (cm)', 
        74.6, 5.6, 66.4, 
        70.9, 74.0, 77.9, 84.8);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('51-60', 'Longitud externa pierna hasta el suelo (cm)', 
        97.5, 4.9, 89.9, 
        94.2, 97.3, 100.6, 105.6);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('61-70', 'Estatura (m)', 
        1.55, 0.576, 1.46, 
        1.51, 1.55, 1.59, 1.64);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('61-70', 'Peso (kg)', 
        68.3, 11.0, 53.0, 
        60.1, 66.9, 75.4, 88.4);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('61-70', 'Índice de Masa Corporal IMC (kg/m2)', 
        28.6, 4.5, 22.3, 
        25.4, 28.0, 31.3, 37.1);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('61-70', 'Perímetro del busto (cm)', 
        102.6, 9.5, 87.8, 
        95.5, 102.3, 109.1, 118.9);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('61-70', 'Contorno de cintura (cm)', 
        96.8, 10.7, 80.0, 
        89.0, 96.1, 104.0, 115.6);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('61-70', 'Contorno de cadera (cm)', 
        108.7, 9.5, 95.4, 
        101.7, 107.5, 114.1, 126.8);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('61-70', 'Longitud de espalda entre axilas (cm)', 
        38.1, 3.1, 33.3, 
        35.8, 38.0, 40.1, 43.2);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('61-70', 'Longitud pecho-cuello (cm)', 
        31.7, 2.7, 27.7, 
        29.9, 31.7, 33.5, 36.6);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('61-70', 'Longitud cuello-cintura sobre el pecho (cm)', 
        44.1, 3.0, 39.2, 
        42.2, 44.1, 46.0, 49.2);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('61-70', 'Longitud trasera cuello-cintura (cm)', 
        40.7, 3.6, 35.8, 
        38.1, 39.9, 42.8, 47.3);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('61-70', 'Longitud brazo hasta acromion (cm)', 
        53.8, 2.9, 49.1, 
        51.8, 53.8, 55.7, 58.7);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('61-70', 'Longitud de la entrepierna (tiro del pantalón) (cm)', 
        75.5, 5.5, 67.2, 
        71.8, 75.1, 78.7, 85.2);
INSERT INTO medidas_por_edad (grupo_etario, medida, media, sd, p5, p25, p50, p75, p95)
VALUES ('61-70', 'Longitud externa pierna hasta el suelo (cm)', 
        96.5, 4.9, 88.6, 
        93.3, 96.2, 99.7, 104.7);


-- ============================================================
-- INSERTS: medidas_prenda_inferior
-- ============================================================

INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Estatura (m)', 
        1.47, 1.55, 1.59, 
        1.63, 1.71, 0.06);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Peso (kg)', 
        42.77, 46.7, 49.33, 
        50.85, 55.89, 3.35);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Índice de Masa Corporal IMC (kg/m2)', 
        16.21, 18.25, 19.94, 
        20.6, 23.68, 1.9);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Altura entrepierna (cm)', 
        63.5, 69.0, 72.1, 
        74.1, 80.6, 4.3);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Longitud de la entrepierna (tiro del pantalón) (cm)', 
        62.8, 65.6, 68.2, 
        69.0, 73.6, 2.8);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Longitud delantera de la entrepierna (tiro delantero) (cm)', 
        29.0, 30.9, 32.2, 
        32.9, 35.4, 1.6);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Longitud trasera de la entrepierna (tiro trasero) (cm)', 
        32.4, 34.1, 35.6, 
        36.2, 38.7, 1.6);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Contorno de cintura (cm)', 
        62.4, 66.5, 72.7, 
        72.7, 83.0, 5.2);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Altura de cadera (cintura-nalgas) (cm)', 
        15.4, 17.5, 18.4, 
        19.4, 21.4, 1.5);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Largo del pantalón (cm)', 
        83.9, 89.4, 92.6, 
        95.0, 101.3, 4.4);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Perímetro de la pernera en el muslo (cm)', 
        46.7, 49.3, 50.3, 
        51.5, 53.8, 1.8);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Perímetro de la pernera en la pantorrilla (cm)', 
        30.3, 32.0, 33.0, 
        33.8, 35.6, 1.4);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Perímetro de la pernera en el tobillo (cm)', 
        21.1, 22.6, 24.0, 
        24.7, 26.8, 1.5);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Altura de la caja (cm)', 
        23.9, 25.4, 26.4, 
        27.1, 29.0, 1.3);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Estatura (m)', 
        1.48, 1.55, 1.6, 
        1.63, 1.72, 0.06);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Peso (kg)', 
        44.98, 49.63, 52.48, 
        54.39, 59.98, 3.83);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Índice de Masa Corporal IMC (kg/m2)', 
        17.15, 19.19, 21.0, 
        21.69, 24.84, 1.96);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Altura entrepierna (cm)', 
        63.6, 68.7, 71.7, 
        74.2, 79.9, 4.1);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Longitud de la entrepierna (tiro del pantalón) (cm)', 
        62.9, 66.9, 68.6, 
        70.6, 74.3, 2.9);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Longitud delantera de la entrepierna (tiro delantero) (cm)', 
        28.5, 31.4, 32.2, 
        33.5, 35.8, 1.9);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Longitud trasera de la entrepierna (tiro trasero) (cm)', 
        32.9, 35.0, 36.1, 
        37.1, 39.3, 1.6);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Contorno de cintura (cm)', 
        64.4, 68.4, 76.0, 
        76.2, 87.7, 5.9);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Altura de cadera (cintura-nalgas) (cm)', 
        15.1, 17.6, 18.1, 
        19.5, 21.1, 1.5);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Largo del pantalón (cm)', 
        83.7, 89.7, 92.7, 
        95.5, 101.7, 4.6);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Perímetro de la pernera en el muslo (cm)', 
        48.3, 51.2, 52.0, 
        53.4, 55.8, 1.9);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Perímetro de la pernera en la pantorrilla (cm)', 
        30.8, 32.9, 34.0, 
        34.9, 37.1, 1.6);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Perímetro de la pernera en el tobillo (cm)', 
        21.4, 23.0, 24.2, 
        24.8, 27.1, 1.5);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Altura de la caja (cm)', 
        24.3, 25.8, 26.9, 
        27.7, 29.5, 1.3);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Estatura (m)', 
        1.48, 1.56, 1.6, 
        1.65, 1.72, 0.06);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Peso (kg)', 
        48.47, 53.23, 56.41, 
        58.38, 64.36, 4.05);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Índice de Masa Corporal IMC (kg/m2)', 
        18.1, 20.31, 22.46, 
        23.09, 26.83, 2.23);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Altura entrepierna (cm)', 
        63.0, 68.5, 71.4, 
        74.4, 79.8, 4.3);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Longitud de la entrepierna (tiro del pantalón) (cm)', 
        65.0, 68.7, 70.7, 
        72.5, 76.4, 2.9);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Longitud delantera de la entrepierna (tiro delantero) (cm)', 
        30.0, 32.2, 33.6, 
        34.6, 37.2, 1.8);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Longitud trasera de la entrepierna (tiro trasero) (cm)', 
        33.6, 36.0, 37.1, 
        38.0, 40.6, 1.8);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Contorno de cintura (cm)', 
        66.3, 71.4, 79.4, 
        80.4, 92.5, 6.7);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Altura de cadera (cintura-nalgas) (cm)', 
        15.2, 17.8, 18.5, 
        19.8, 21.8, 1.7);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Largo del pantalón (cm)', 
        84.8, 90.4, 93.1, 
        96.4, 101.5, 4.3);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Perímetro de la pernera en el muslo (cm)', 
        49.9, 52.9, 53.8, 
        55.3, 57.6, 2.0);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Perímetro de la pernera en la pantorrilla (cm)', 
        31.9, 34.0, 34.9, 
        35.9, 38.0, 1.6);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Perímetro de la pernera en el tobillo (cm)', 
        21.8, 23.5, 24.8, 
        25.4, 27.8, 1.5);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Altura de la caja (cm)', 
        24.6, 26.5, 27.5, 
        28.4, 30.4, 1.5);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Estatura (m)', 
        1.48, 1.56, 1.61, 
        1.65, 1.74, 0.07);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Peso (kg)', 
        51.62, 56.88, 60.43, 
        62.86, 69.23, 4.49);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Índice de Masa Corporal IMC (kg/m2)', 
        18.95, 21.62, 23.59, 
        24.82, 28.23, 2.37);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Altura entrepierna (cm)', 
        62.8, 68.3, 71.6, 
        74.1, 80.4, 4.5);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Longitud de la entrepierna (tiro del pantalón) (cm)', 
        66.2, 70.3, 72.3, 
        73.9, 78.5, 3.1);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Longitud delantera de la entrepierna (tiro delantero) (cm)', 
        29.8, 32.9, 34.3, 
        35.5, 38.7, 2.3);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Longitud trasera de la entrepierna (tiro trasero) (cm)', 
        33.6, 36.7, 37.6, 
        38.9, 41.5, 2.0);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Contorno de cintura (cm)', 
        68.3, 74.7, 81.9, 
        85.6, 95.5, 6.9);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Altura de cadera (cintura-nalgas) (cm)', 
        15.3, 17.7, 18.6, 
        19.9, 21.8, 1.6);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Largo del pantalón (cm)', 
        84.6, 90.5, 93.7, 
        96.5, 102.8, 4.6);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Perímetro de la pernera en el muslo (cm)', 
        51.6, 54.5, 55.9, 
        57.4, 60.2, 2.2);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Perímetro de la pernera en la pantorrilla (cm)', 
        32.5, 34.7, 35.8, 
        37.0, 39.0, 1.7);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Perímetro de la pernera en el tobillo (cm)', 
        22.1, 23.8, 25.2, 
        25.9, 28.4, 1.6);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Altura de la caja (cm)', 
        24.9, 26.9, 27.9, 
        28.8, 31.0, 1.6);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Estatura (m)', 
        1.47, 1.56, 1.61, 
        1.65, 1.74, 0.07);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Peso (kg)', 
        53.06, 60.48, 63.36, 
        66.29, 73.66, 5.25);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Índice de Masa Corporal IMC (kg/m2)', 
        19.8, 22.9, 24.91, 
        26.42, 30.03, 2.61);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Altura entrepierna (cm)', 
        62.0, 67.6, 71.3, 
        73.9, 80.6, 4.7);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Longitud de la entrepierna (tiro del pantalón) (cm)', 
        67.2, 71.5, 74.0, 
        75.7, 80.8, 3.5);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Longitud delantera de la entrepierna (tiro delantero) (cm)', 
        30.4, 33.6, 35.2, 
        36.4, 40.0, 2.4);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Longitud trasera de la entrepierna (tiro trasero) (cm)', 
        34.5, 37.4, 38.3, 
        39.7, 42.0, 1.9);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Contorno de cintura (cm) Altura de cadera (cintura-nalgas) (cm)', 
        70.8, 77.9, 85.6, 
        89.4, 100.5, 7.6);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Largo del pantalón (cm)', 
        84.1, 90.0, 93.9, 
        96.8, 103.7, 5.0);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Perímetro de la pernera en el muslo (cm)', 
        52.1, 56.4, 57.4, 
        59.4, 62.6, 2.7);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Perímetro de la pernera en la pantorrilla (cm)', 
        33.2, 35.5, 36.9, 
        38.0, 40.5, 1.9);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Perímetro de la pernera en el tobillo (cm) Altura de la caja (cm)', 
        22.3, 24.0, 25.6, 
        26.1, 28.8, 1.7);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Estatura (m)', 
        1.49, 1.55, 1.62, 
        1.65, 1.74, 0.06);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Peso (kg)', 
        56.22, 63.8, 66.82, 
        70.39, 77.42, 5.41);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Índice de Masa Corporal IMC (kg/m2)', 
        20.99, 24.4, 26.22, 
        27.89, 31.46, 2.67);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Altura entrepierna (cm)', 
        62.8, 67.4, 71.0, 
        73.7, 79.2, 4.2);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Longitud de la entrepierna (tiro del pantalón) (cm)', 
        67.0, 73.4, 75.3, 
        77.7, 83.6, 4.2);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Longitud delantera de la entrepierna (tiro delantero) (cm)', 
        31.3, 34.4, 36.5, 
        37.7, 41.7, 2.7);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Longitud trasera de la entrepierna (tiro trasero) (cm)', 
        33.9, 38.2, 38.4, 
        40.7, 43.0, 2.3);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Contorno de cintura (cm)', 
        72.6, 81.1, 88.9, 
        93.8, 105.2, 8.3);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Altura de cadera (cintura-nalgas) (cm)', 
        14.3, 17.6, 18.3, 
        20.0, 22.4, 2.1);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Largo del pantalón (cm)', 
        84.7, 90.2, 93.9, 
        96.7, 103.1, 4.7);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Perímetro de la pernera en el muslo (cm)', 
        52.8, 57.7, 58.6, 
        61.2, 64.3, 2.9);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Perímetro de la pernera en la pantorrilla (cm)', 
        33.7, 36.3, 37.5, 
        38.9, 41.3, 2.0);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Perímetro de la pernera en el tobillo (cm)', 
        22.5, 24.3, 25.6, 
        26.4, 28.7, 1.6);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Altura de la caja (cm)', 
        25.5, 27.6, 28.6, 
        29.8, 31.7, 1.6);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Estatura (m)', 
        1.47, 1.56, 1.6, 
        1.64, 1.74, 0.07);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Peso (kg)', 
        58.44, 66.53, 70.29, 
        74.44, 82.13, 6.04);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Índice de Masa Corporal IMC (kg/m2)', 
        21.91, 25.52, 27.61, 
        29.62, 33.31, 2.91);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Altura entrepierna (cm)', 
        61.3, 66.8, 70.1, 
        73.0, 78.9, 4.5);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Longitud de la entrepierna (tiro del pantalón) (cm)', 
        68.7, 74.0, 75.9, 
        78.5, 83.2, 3.7);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Longitud delantera de la entrepierna (tiro delantero) (cm)', 
        31.5, 34.8, 36.9, 
        38.2, 42.3, 2.8);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Longitud trasera de la entrepierna (tiro trasero) (cm)', 
        33.2, 38.3, 38.4, 
        41.1, 43.6, 2.7);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Contorno de cintura (cm)', 
        74.9, 83.8, 91.2, 
        98.1, 107.4, 8.3);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Altura de cadera (cintura-nalgas) (cm)', 
        13.9, 17.0, 18.1, 
        20.0, 22.3, 2.1);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Largo del pantalón (cm)', 
        83.6, 89.6, 93.3, 
        96.2, 102.9, 4.9);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Perímetro de la pernera en el muslo (cm)', 
        53.6, 58.7, 60.0, 
        62.9, 66.4, 3.3);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Perímetro de la pernera en la pantorrilla (cm)', 
        33.9, 36.9, 38.2, 
        39.9, 42.5, 2.2);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Perímetro de la pernera en el tobillo (cm)', 
        22.7, 24.6, 26.3, 
        26.9, 29.9, 1.8);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Altura de la caja (cm)', 
        25.0, 27.5, 28.6, 
        29.7, 32.2, 1.8);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Estatura (m)', 
        1.46, 1.55, 1.6, 
        1.64, 1.74, 0.07);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Peso (kg)', 
        64.31, 75.64, 78.97, 
        84.24, 93.64, 7.48);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Índice de Masa Corporal IMC (kg/m2)', 
        24.43, 29.1, 31.17, 
        33.72, 37.91, 3.44);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Altura entrepierna (cm)', 
        60.6, 66.2, 69.8, 
        72.4, 78.9, 4.7);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Longitud de la entrepierna (tiro del pantalón) (cm)', 
        71.4, 77.4, 80.6, 
        82.3, 89.7, 4.7);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Longitud delantera de la entrepierna (tiro delantero) (cm)', 
        32.9, 36.5, 39.3, 
        40.5, 45.8, 3.3);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Longitud trasera de la entrepierna (tiro trasero) (cm)', 
        34.3, 39.2, 40.1, 
        42.7, 46.0, 3.0);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Contorno de cintura (cm)', 
        80.1, 91.8, 97.7, 
        106.6, 115.3, 9.0);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Altura de cadera (cintura-nalgas) (cm)', 
        13.0, 16.5, 17.7, 
        19.9, 22.5, 2.4);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Largo del pantalón (cm)', 
        82.8, 89.4, 93.1, 
        96.6, 103.4, 5.3);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Perímetro de la pernera en el muslo (cm)', 
        55.6, 62.0, 63.7, 
        67.2, 71.7, 4.1);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Perímetro de la pernera en la pantorrilla (cm)', 
        34.7, 38.6, 40.3, 
        42.3, 46.0, 2.9);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Perímetro de la pernera en el tobillo (cm)', 
        23.5, 25.3, 27.2, 
        27.5, 30.8, 1.9);
INSERT INTO medidas_prenda_inferior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Altura de la caja (cm)', 
        25.3, 27.7, 29.1, 
        30.5, 32.9, 1.9);


-- ============================================================
-- INSERTS: medidas_prenda_superior
-- ============================================================

INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Estatura (m)', 
        1.46, 1.54, 1.59, 1.63, 1.73, 0.07);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Peso (kg)', 
        56.09, 64.18, 69.74, 72.47, 83.4, 6.97);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Índice de Masa Corporal IMC (kg/m2)', 
        22.63, 25.53, 27.12, 28.65, 31.62, 2.29);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Altura nuca tierra (cm)', 
        124.7, 132.1, 137.7, 140.6, 150.6, 6.6);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Largo total espalda (cm)', 
        49.1, 53.7, 55.2, 57.7, 61.4, 3.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Perímetro del cuello (cm)', 
        32.2, 33.9, 35.4, 36.2, 38.7, 1.7);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Cuello en la base (cm)', 
        36.0, 38.1, 40.0, 40.4, 44.1, 2.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Ancho de hombros (cm)', 
        30.6, 34.8, 37.6, 39.9, 44.7, 3.6);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Largo del hombro (cm)', 
        9.5, 11.8, 12.3, 13.6, 15.1, 1.4);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Frente de pecho (cm)', 
        17.9, 20.0, 21.3, 22.1, 24.6, 1.7);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Separación entre pechos (cm)', 
        18.3, 19.4, 20.2, 20.3, 22.1, 1.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Altura de pecho (cm)', 
        25.5, 28.9, 30.1, 31.8, 34.7, 2.3);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Ancho de espalda (cm)', 
        33.1, 36.3, 37.5, 39.0, 41.9, 2.2);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Encuentro práctico (cm)', 
        16.5, 18.1, 18.7, 19.5, 20.9, 1.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Profundidad sisa espalda (desde centro escote) (cm)', 
        9.1, 12.9, 14.6, 16.1, 20.1, 2.8);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Talle trasero (cm)', 
        35.6, 38.1, 42.0, 42.8, 48.5, 3.3);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Largo de manga (cm)', 
        50.3, 53.7, 56.5, 57.9, 62.6, 3.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Largo de manga hasta el codo (cm)', 
        27.0, 29.4, 31.1, 32.0, 35.2, 2.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Perímetro de manga (cm)', 
        26.1, 28.5, 30.6, 31.4, 35.1, 2.3);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Perímetro de manga en el codo (cm)', 
        23.4, 25.2, 27.3, 27.3, 31.3, 2.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Perímetro del puño (cm)', 
        14.6, 15.6, 16.5, 16.8, 18.4, 1.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (36, 'Ancho sisa total (cm)', 
        9.1, 10.4, 11.1, 11.7, 13.1, 1.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Estatura (m)', 
        1.49, 1.57, 1.61, 1.65, 1.74, 0.06);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Peso (kg)', 
        46.8, 52.51, 56.16, 58.77, 65.52, 4.77);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Índice de Masa Corporal IMC (kg/m2)', 
        17.86, 20.11, 21.74, 22.65, 25.63, 1.98);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Altura nuca tierra (cm)', 
        126.7, 134.0, 138.1, 141.6, 149.5, 5.8);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Largo total espalda (cm)', 
        51.3, 54.5, 56.7, 58.3, 62.1, 2.8);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Perímetro del cuello (cm)', 
        29.4, 30.8, 31.9, 32.5, 34.5, 1.3);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Cuello en la base (cm)', 
        33.6, 35.3, 36.9, 37.6, 40.2, 1.7);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Ancho de hombros (cm)', 
        28.3, 32.5, 35.0, 37.3, 41.7, 3.4);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Largo del hombro (cm)', 
        9.3, 11.6, 12.0, 13.3, 14.8, 1.4);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Frente de pecho (cm)', 
        16.7, 18.2, 19.3, 19.9, 21.9, 1.3);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Separación entre pechos (cm)', 
        16.5, 17.3, 17.7, 18.0, 18.9, 0.6);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Altura de pecho (cm)', 
        23.1, 25.1, 26.7, 27.6, 30.4, 1.9);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Ancho de espalda (cm)', 
        30.6, 33.0, 34.6, 35.9, 38.5, 2.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Encuentro práctico (cm)', 
        15.3, 16.5, 17.3, 17.9, 19.3, 1.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Profundidad sisa espalda (desde centro escote) (cm)', 
        8.4, 11.1, 12.8, 14.1, 17.2, 2.2);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Talle trasero (cm)', 
        35.2, 38.0, 41.0, 42.1, 46.8, 2.9);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Largo de manga (cm)', 
        50.0, 53.8, 55.7, 57.5, 61.4, 2.9);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Largo de manga hasta el codo (cm)', 
        27.6, 29.7, 31.2, 31.9, 34.8, 1.8);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Perímetro de manga (cm)', 
        23.8, 25.7, 26.9, 27.6, 30.0, 1.6);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Perímetro de manga en el codo (cm)', 
        21.6, 22.9, 24.2, 24.5, 26.8, 1.3);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Perímetro del puño (cm)', 
        13.6, 14.5, 15.2, 15.6, 16.8, 0.8);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (38, 'Ancho sisa total (cm)', 
        8.1, 9.0, 9.8, 10.1, 11.5, 0.8);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Estatura (m)', 
        1.48, 1.56, 1.62, 1.65, 1.75, 0.07);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Peso (kg)', 
        48.94, 55.44, 58.97, 61.9, 69.0, 5.12);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Índice de Masa Corporal IMC (kg/m2)', 
        18.82, 21.36, 22.87, 24.02, 26.92, 2.07);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Altura nuca tierra (cm)', 
        126.1, 134.0, 138.5, 141.6, 150.9, 6.3);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Largo total espalda (cm)', 
        51.1, 54.6, 56.5, 58.5, 62.0, 2.8);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Perímetro del cuello (cm)', 
        30.0, 31.5, 32.8, 33.3, 35.5, 1.4);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Cuello en la base (cm)', 
        34.3, 36.0, 37.5, 38.2, 40.8, 1.7);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Ancho de hombros (cm)', 
        29.0, 33.2, 35.3, 37.4, 41.6, 3.2);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Largo del hombro (cm)', 
        9.6, 11.6, 12.2, 13.3, 14.8, 1.3);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Frente de pecho (cm)', 
        17.2, 18.8, 19.8, 20.5, 22.4, 1.3);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Separación entre pechos (cm)', 
        16.8, 17.8, 18.4, 18.5, 19.9, 0.8);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Altura de pecho (cm)', 
        24.1, 26.2, 27.9, 28.9, 31.7, 1.9);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Ancho de espalda (cm)', 
        31.3, 33.8, 35.4, 36.7, 39.4, 2.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Encuentro práctico (cm)', 
        15.6, 16.9, 17.7, 18.4, 19.7, 1.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Profundidad sisa espalda (desde centro escote) (cm)', 
        8.8, 11.5, 13.2, 14.5, 17.6, 2.2);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Talle trasero (cm)', 
        35.2, 38.3, 40.8, 42.2, 46.3, 2.9);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Largo de manga (cm)', 
        49.9, 53.8, 55.9, 57.6, 62.0, 3.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Largo de manga hasta el codo (cm)', 
        27.4, 29.6, 31.2, 32.1, 35.0, 1.9);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Perímetro de manga (cm)', 
        24.5, 26.4, 27.8, 28.7, 31.0, 1.7);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Perímetro de manga en el codo (cm)', 
        21.9, 23.4, 24.9, 25.2, 27.9, 1.5);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Perímetro del puño (cm)', 
        13.8, 14.8, 15.5, 15.9, 17.2, 0.9);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (40, 'Ancho sisa total (cm)', 
        8.3, 9.4, 10.0, 10.5, 11.7, 0.9);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Estatura (m)', 
        1.47, 1.56, 1.6, 1.65, 1.74, 0.07);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Peso (kg)', 
        52.17, 58.87, 63.29, 66.02, 74.41, 5.67);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Índice de Masa Corporal IMC (kg/m2)', 
        20.23, 22.8, 24.51, 25.7, 28.79, 2.18);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Altura nuca tierra (cm)', 
        125.3, 133.4, 137.6, 141.8, 149.9, 6.3);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Largo total espalda (cm)', 
        50.4, 54.5, 56.2, 58.1, 62.0, 3.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Perímetro del cuello (cm)', 
        30.6, 32.3, 33.7, 34.4, 36.8, 1.6);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Cuello en la base (cm)', 
        34.8, 36.7, 38.2, 39.1, 41.6, 1.8);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Ancho de hombros (cm)', 
        30.3, 33.9, 36.2, 38.4, 42.2, 3.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Largo del hombro (cm)', 
        9.5, 11.7, 12.2, 13.4, 14.9, 1.4);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Frente de pecho (cm)', 
        17.5, 19.0, 20.4, 21.1, 23.4, 1.5);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Separación entre pechos (cm)', 
        17.3, 18.4, 18.9, 19.2, 20.6, 0.8);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Altura de pecho (cm)', 
        25.0, 27.2, 28.9, 29.9, 32.9, 2.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Ancho de espalda (cm)', 
        32.1, 34.8, 36.2, 37.7, 40.3, 2.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Encuentro práctico (cm)', 
        16.0, 17.4, 18.1, 18.8, 20.1, 1.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Profundidad sisa espalda (desde centro escote) (cm)', 
        8.9, 11.8, 13.8, 14.9, 18.6, 2.5);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Talle trasero (cm)', 
        35.5, 38.5, 41.3, 42.4, 47.1, 3.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Largo de manga (cm)', 
        50.1, 53.9, 55.9, 57.8, 61.7, 3.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Largo de manga hasta el codo (cm)', 
        27.2, 29.7, 30.9, 32.1, 34.7, 1.9);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Perímetro de manga (cm)', 
        25.2, 27.4, 28.8, 29.8, 32.3, 1.8);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Perímetro de manga en el codo (cm)', 
        22.6, 24.2, 25.8, 26.0, 29.0, 1.6);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Perímetro del puño (cm)', 
        14.0, 15.1, 15.8, 16.2, 17.6, 0.9);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (42, 'Ancho sisa total (cm)', 
        8.7, 9.7, 10.5, 10.9, 12.2, 0.9);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Estatura (m)', 
        1.47, 1.55, 1.6, 1.65, 1.73, 0.07);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Peso (kg)', 
        54.3, 61.3, 66.49, 69.99, 78.68, 6.22);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Índice de Masa Corporal IMC (kg/m2)', 
        21.29, 24.12, 25.96, 27.3, 30.64, 2.39);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Altura nuca tierra (cm)', 
        125.4, 132.8, 137.5, 141.4, 149.5, 6.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Largo total espalda (cm)', 
        50.5, 54.2, 56.3, 58.0, 62.2, 3.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Perímetro del cuello (cm)', 
        31.4, 33.1, 34.7, 35.3, 38.0, 1.7);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Cuello en la base (cm)', 
        35.4, 37.3, 38.9, 39.7, 42.4, 1.8);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Ancho de hombros (cm)', 
        29.6, 33.9, 36.2, 38.6, 42.8, 3.4);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Largo del hombro (cm)', 
        9.2, 11.6, 12.1, 13.3, 15.0, 1.5);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Frente de pecho (cm)', 
        17.7, 19.5, 20.8, 21.6, 24.0, 1.6);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Separación entre pechos (cm)', 
        17.5, 18.9, 19.5, 19.8, 21.4, 1.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Altura de pecho (cm)', 
        25.7, 28.1, 29.7, 30.9, 33.8, 2.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Ancho de espalda (cm)', 
        32.7, 35.3, 36.9, 38.3, 41.1, 2.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Encuentro práctico (cm)', 
        16.3, 17.6, 18.4, 19.1, 20.5, 1.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Profundidad sisa espalda (desde centro escote) (cm)', 
        8.6, 12.1, 13.8, 15.4, 19.0, 2.7);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Talle trasero (cm)', 
        35.6, 38.6, 41.6, 42.6, 47.7, 3.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Largo de manga (cm)', 
        50.0, 53.6, 56.0, 57.8, 61.9, 3.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Largo de manga hasta el codo (cm)', 
        27.5, 29.5, 31.3, 32.1, 35.0, 1.9);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Perímetro de manga (cm)', 
        25.6, 28.0, 30.2, 30.8, 34.7, 2.3);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Perímetro de manga en el codo (cm)', 
        22.9, 24.7, 26.9, 26.7, 30.9, 2.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Perímetro del puño (cm)', 
        14.3, 15.4, 16.2, 16.5, 18.2, 1.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (44, 'Ancho sisa total (cm)', 
        9.1, 10.2, 11.0, 11.4, 12.8, 1.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Estatura (m)', 
        1.46, 1.54, 1.59, 1.63, 1.73, 0.07);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Peso (kg)', 
        56.09, 64.18, 69.74, 72.47, 83.4, 6.97);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Índice de Masa Corporal IMC (kg/m2)', 
        22.63, 25.53, 27.12, 28.65, 31.62, 2.29);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Altura nuca tierra (cm)', 
        124.7, 132.1, 137.7, 140.6, 150.6, 6.6);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Largo total espalda (cm)', 
        49.1, 53.7, 55.2, 57.7, 61.4, 3.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Perímetro del cuello (cm)', 
        32.2, 33.9, 35.4, 36.2, 38.7, 1.7);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Cuello en la base (cm)', 
        36.0, 38.1, 40.0, 40.4, 44.1, 2.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Ancho de hombros (cm)', 
        30.6, 34.8, 37.6, 39.9, 44.7, 3.6);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Largo del hombro (cm)', 
        9.5, 11.8, 12.3, 13.6, 15.1, 1.4);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Frente de pecho (cm)', 
        17.9, 20.0, 21.3, 22.1, 24.6, 1.7);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Separación entre pechos (cm)', 
        18.3, 19.4, 20.2, 20.3, 22.1, 1.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Altura de pecho (cm)', 
        25.5, 28.9, 30.1, 31.8, 34.7, 2.3);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Ancho de espalda (cm)', 
        33.1, 36.3, 37.5, 39.0, 41.9, 2.2);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Encuentro práctico (cm)', 
        16.5, 18.1, 18.7, 19.5, 20.9, 1.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Profundidad sisa espalda (desde centro escote) (cm)', 
        9.1, 12.9, 14.6, 16.1, 20.1, 2.8);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Talle trasero (cm)', 
        35.6, 38.1, 42.0, 42.8, 48.5, 3.3);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Largo de manga (cm)', 
        50.3, 53.7, 56.5, 57.9, 62.6, 3.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Largo de manga hasta el codo (cm)', 
        27.0, 29.4, 31.1, 32.0, 35.2, 2.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Perímetro de manga en el codo (cm)', 
        26.1, 28.5, 30.6, 31.4, 35.1, 2.3);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Perímetro del puño (cm)', 
        14.6, 15.6, 16.5, 16.8, 18.4, 1.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (46, 'Ancho sisa total (cm)', 
        9.1, 10.4, 11.1, 11.7, 13.1, 1.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Estatura (m)', 
        1.46, 1.54, 1.59, 1.63, 1.71, 0.06);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Peso (kg)', 
        59.05, 66.15, 72.77, 75.88, 86.49, 7.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Índice de Masa Corporal IMC (kg/m2)', 
        23.23, 26.51, 28.63, 29.95, 34.03, 2.76);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Altura nuca tierra (cm)', 
        125.4, 132.3, 136.6, 140.1, 147.7, 5.7);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Largo total espalda (cm)', 
        50.4, 53.6, 55.7, 57.4, 61.0, 2.7);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Perímetro del cuello (cm)', 
        32.2, 34.6, 36.3, 37.0, 40.5, 2.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Cuello en la base (cm)', 
        36.4, 38.8, 40.5, 41.3, 44.6, 2.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Ancho de hombros (cm)', 
        29.1, 34.9, 36.5, 39.8, 43.9, 3.8);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Largo del hombro (cm)', 
        9.1, 11.5, 12.1, 13.3, 15.0, 1.5);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Frente de pecho (cm)', 
        18.2, 20.4, 21.9, 22.9, 25.5, 1.9);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Separación entre pechos (cm)', 
        18.9, 19.8, 21.0, 20.9, 23.1, 1.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Altura de pecho (cm)', 
        27.0, 29.8, 31.2, 32.6, 35.4, 2.2);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Ancho de espalda (cm)', 
        34.0, 36.8, 38.3, 39.6, 42.5, 2.2);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Encuentro práctico (cm)', 
        17.0, 18.4, 19.1, 19.8, 21.3, 1.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Profundidad sisa espalda (desde centro escote) (cm)', 
        9.8, 12.9, 14.6, 16.1, 19.4, 2.4);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Talle trasero (cm)', 
        35.7, 38.6, 42.4, 43.1, 49.0, 3.4);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Largo de manga (cm)', 
        50.0, 53.7, 56.2, 57.8, 62.3, 3.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Largo de manga hasta el codo (cm)', 
        27.0, 29.6, 31.2, 32.1, 35.5, 2.2);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Perímetro de manga (cm)', 
        26.5, 29.1, 31.5, 32.2, 36.5, 2.6);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Perímetro de manga en el codo (cm)', 
        23.8, 25.6, 28.5, 29.2, 33.2, 2.4);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Perímetro del puño (cm)', 
        14.6, 15.8, 16.6, 17.0, 18.6, 1.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (48, 'Ancho sisa total (cm)', 
        9.4, 10.6, 11.5, 12.0, 13.6, 1.1);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Estatura (m)', 
        1.46, 1.53, 1.59, 1.63, 1.73, 0.07);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Peso (kg)', 
        65.7, 75.3, 82.8, 86.6, 99.8, 8.7);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Índice de Masa Corporal IMC (kg/m2)', 
        26.7, 30.3, 33.3, 34.5, 39.9, 3.4);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Altura nuca tierra (cm)', 
        124.2, 131.7, 136.9, 140.2, 149.6, 6.5);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Largo total espalda (cm)', 
        49.2, 52.9, 55.2, 57.3, 61.2, 3.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Perímetro del cuello (cm)', 
        34.5, 36.9, 38.9, 39.8, 43.3, 2.2);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Cuello en la base (cm)', 
        38.4, 40.9, 43.2, 43.8, 48.0, 2.4);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Ancho de hombros (cm)', 
        30.3, 35.7, 38.2, 41.2, 46.1, 4.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Largo del hombro (cm)', 
        9.0, 11.5, 12.1, 13.4, 15.3, 1.6);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Frente de pecho (cm)', 
        18.9, 21.1, 23.6, 24.9, 28.3, 2.4);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Separación entre pechos (cm)', 
        19.6, 21.3, 22.5, 22.6, 25.3, 1.4);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Altura de pecho (cm)', 
        29.0, 31.6, 33.3, 34.6, 37.5, 2.2);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Ancho de espalda (cm)', 
        35.5, 39.0, 40.2, 41.8, 44.9, 2.4);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Encuentro práctico (cm)', 
        17.8, 19.5, 20.1, 20.9, 22.4, 1.2);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Profundidad sisa espalda (desde centro escote) (cm)', 
        10.9, 13.9, 16.4, 17.7, 22.0, 2.8);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Talle trasero (cm)', 
        36.1, 39.1, 43.2, 44.1, 50.3, 3.6);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Largo de manga (cm)', 
        49.9, 53.8, 55.7, 57.9, 61.5, 2.9);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Largo de manga hasta el codo (cm)', 
        26.9, 29.6, 31.3, 32.4, 35.7, 2.3);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Perímetro de manga (cm)', 
        27.9, 30.6, 33.7, 34.5, 39.5, 3.0);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Perímetro de manga en el codo (cm)', 
        25.0, 27.3, 30.1, 30.5, 35.2, 2.6);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Perímetro del puño (cm)', 
        15.3, 16.5, 17.7, 18.0, 20.1, 1.2);
INSERT INTO medidas_prenda_superior (talla, medida, p5, p25, p50, p75, p95, sd)
VALUES (50, 'Ancho sisa total (cm)', 
        10.1, 11.5, 12.6, 13.1, 15.0, 1.2);


-- ============================================================
-- INSERTS: tallas_referencia_inferior
-- ============================================================

INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 36, 'P5', 
        62.4, 86.2, 62.8, 15.4);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 36, 'P50', 
        72.7, 97.8, 68.2, 18.4);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 36, 'P95', 
        83.0, 114.1, 73.6, 21.4);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 38, 'P5', 
        64.4, 91.4, 62.9, 15.1);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 38, 'P50', 
        76.0, 101.6, 68.6, 18.1);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 38, 'P95', 
        87.7, 118.8, 74.3, 21.1);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 40, 'P5', 
        66.3, 91.4, 65.0, 15.2);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 40, 'P50', 
        79.4, 102.1, 70.7, 18.5);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 40, 'P95', 
        92.5, 122.9, 76.4, 21.8);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 42, 'P5', 
        68.3, 92.7, 66.2, 15.3);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 42, 'P50', 
        81.9, 103.9, 72.3, 18.6);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 42, 'P95', 
        95.5, 122.3, 78.5, 21.8);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 44, 'P5', 
        70.8, 93.9, 67.2, 15.0);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 44, 'P50', 
        85.6, 105.7, 74.0, 18.6);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 44, 'P95', 
        100.5, 126.4, 80.8, 22.2);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 46, 'P5', 
        72.6, 95.4, 67.0, 14.3);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 46, 'P50', 
        88.9, 107.5, 75.3, 18.3);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 46, 'P95', 
        105.2, 126.8, 83.6, 22.4);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 48, 'P5', 
        74.9, 96.5, 68.7, 13.9);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 48, 'P50', 
        91.2, 108.0, 75.9, 18.1);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 48, 'P95', 
        107.4, 128.0, 83.2, 22.3);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 50, 'P5', 
        80.1, 98.0, 71.4, 13.0);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 50, 'P50', 
        97.7, 110.0, 80.6, 17.7);
INSERT INTO tallas_referencia_inferior (tipo, talla, percentil, cintura_cm, cadera_cm, tiro_cm, altura_cadera_cm)
VALUES ('inferior', 50, 'P95', 
        115.3, 130.0, 89.7, 22.5);


-- ============================================================
-- INSERTS: tallas_referencia_superior
-- ============================================================

INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 36, 'P5', 
        76.9, 62.9, 86.2);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 36, 'P50', 
        86.1, 72.4, 97.8);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 36, 'P95', 
        102.2, 90.9, 114.1);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 38, 'P5', 
        80.0, 65.8, 91.4);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 38, 'P50', 
        88.9, 76.0, 101.6);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 38, 'P95', 
        106.9, 97.9, 118.8);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 40, 'P5', 
        81.5, 68.2, 91.4);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 40, 'P50', 
        91.6, 80.8, 102.1);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 40, 'P95', 
        113.3, 105.6, 122.9);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 42, 'P5', 
        83.4, 71.7, 92.7);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 42, 'P50', 
        95.4, 85.7, 103.9);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 42, 'P95', 
        116.2, 109.7, 122.3);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 44, 'P5', 
        85.1, 75.2, 93.9);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 44, 'P50', 
        98.8, 91.4, 105.7);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 44, 'P95', 
        118.8, 113.3, 126.4);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 46, 'P5', 
        87.8, 80.0, 95.4);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 46, 'P50', 
        102.3, 96.1, 107.5);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 46, 'P95', 
        118.9, 115.6, 126.8);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 48, 'P5', 
        88.7, 83.0, 96.5);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 48, 'P50', 
        104.0, 93.0, 108.0);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 48, 'P95', 
        120.0, 118.0, 128.0);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 50, 'P5', 
        90.0, 85.0, 98.0);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 50, 'P50', 
        106.0, 96.0, 110.0);
INSERT INTO tallas_referencia_superior (tipo, talla, percentil, busto_cm, cintura_cm, cadera_cm)
VALUES ('superior', 50, 'P95', 
        122.0, 120.0, 130.0);