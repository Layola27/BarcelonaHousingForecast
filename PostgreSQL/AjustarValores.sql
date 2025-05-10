-- Para priceInfo
ALTER TABLE pisos_barcelona
ALTER COLUMN priceInfo TYPE JSONB
USING replace(priceInfo, '''', '"')::jsonb;

-- Para detailedType
ALTER TABLE pisos_barcelona
ALTER COLUMN detailedType TYPE JSONB
USING replace(detailedType, '''', '"')::jsonb;

-- Para suggestedTexts
ALTER TABLE pisos_barcelona
ALTER COLUMN suggestedTexts TYPE JSONB
USING replace(suggestedTexts, '''', '"')::jsonb;

-- Para parkingSpace (¡Ojo! Puede tener NULLs, la conversión fallará en NULLs si no se maneja)
ALTER TABLE pisos_barcelona
ALTER COLUMN parkingSpace TYPE JSONB
USING CASE
        WHEN parkingSpace IS NULL OR parkingSpace = '{}' OR parkingSpace = '' THEN NULL -- Maneja NULLs y vacíos explícitamente
        ELSE replace(parkingSpace, '''', '"')::jsonb
      END;

-- Añade comandos ALTER TABLE similares para 'change', 'highlight', 'savedAd' SI las quieres como JSONB
-- Ejemplo para change (si aplica):
-- ALTER TABLE pisos_barcelona
-- ALTER COLUMN change TYPE JSONB
-- USING replace(change, '''', '"')::jsonb;