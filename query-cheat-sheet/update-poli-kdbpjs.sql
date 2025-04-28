UPDATE poliklinik
SET kdpolibpjs = CASE
    WHEN nampoli LIKE '%UMUM%' THEN '001'
    WHEN nampoli LIKE '%GIGI%' THEN '002'
    WHEN nampoli LIKE '%MULUT%' THEN '002'
    WHEN nampoli LIKE '%KIA%' THEN '003'
    WHEN nampoli LIKE '%LAB%' THEN '004'
    WHEN nampoli LIKE '%LABORATORIUM%' THEN '004'
    WHEN nampoli LIKE '%UGD%' THEN '005'
    WHEN nampoli LIKE '%KB%' THEN '008'
    WHEN nampoli LIKE '%GIZI%' THEN '029'
    WHEN nampoli LIKE '%JIWA%' THEN '031'
    WHEN nampoli LIKE '%KUSTA%' THEN '032'
    WHEN nampoli LIKE '%TB%' THEN '033'
    WHEN nampoli LIKE '%PARU%' THEN '033'
    WHEN nampoli LIKE '%Home-Visit%' THEN '020'
    WHEN nampoli LIKE '%Konseling%' THEN '021'
    WHEN nampoli LIKE '%Imunisasi%' THEN '023'
    WHEN nampoli LIKE '%Prolanis%' THEN '036'
    WHEN nampoli LIKE '%Kunjungan Online%' THEN '998'
END
WHERE (
    nampoli LIKE '%UMUM%' OR
    nampoli LIKE '%GIGI%' OR
    nampoli LIKE '%MULUT%' OR
    nampoli LIKE '%KIA%' OR
    nampoli LIKE '%LAB%' OR
    nampoli LIKE '%LABORATORIUM%' OR
    nampoli LIKE '%UGD%' OR
    nampoli LIKE '%KB%' OR
    nampoli LIKE '%GIZI%' OR
    nampoli LIKE '%JIWA%' OR
    nampoli LIKE '%KUSTA%' OR
    nampoli LIKE '%TB%' OR
    nampoli LIKE '%PARU%' OR
    nampoli LIKE '%Home-Visit%' OR
    nampoli LIKE '%Konseling%' OR
    nampoli LIKE '%Imunisasi%' OR
    nampoli LIKE '%Prolanis%' OR
    nampoli LIKE '%Kunjungan Online%'
);

UPDATE poliklinik 
SET statussakit = 
    CASE 
        WHEN kdpolibpjs IN ('001', '002', '003', '004', '005', '008', '010', '011', '012', '029', '031', '998', '032', '033') THEN '1'
        WHEN kdpolibpjs IN ('020', '021', '023', '024', '025', '026', '027', '036', '037', '999') THEN '2'
        ELSE statussakit
    END;