CREATE TABLE pisos_barcelona (
    propertyCode BIGINT PRIMARY KEY,
    thumbnail TEXT,
    externalReference VARCHAR(100),
    numPhotos SMALLINT,
    floor VARCHAR(50),
    price NUMERIC(12, 2),
    priceInfo TEXT, -- CAMBIADO A TEXT
    propertyType VARCHAR(50),
    operation VARCHAR(20),
    size NUMERIC(8, 2),
    exterior TEXT, -- Mantenido TEXT
    rooms SMALLINT,
    bathrooms SMALLINT,
    address TEXT,
    province VARCHAR(100),
    municipality VARCHAR(100),
    district VARCHAR(100),
    country VARCHAR(10),
    neighborhood VARCHAR(100),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    showAddress BOOLEAN,
    url TEXT,
    distance INTEGER,
    description TEXT,
    hasVideo BOOLEAN,
    status VARCHAR(50),
    newDevelopment BOOLEAN,
    hasLift TEXT, -- Mantenido TEXT
    priceByArea NUMERIC(10, 2),
    change TEXT, -- Ya era TEXT o ahora es TEXT
    detailedType TEXT, -- CAMBIADO A TEXT
    suggestedTexts TEXT, -- CAMBIADO A TEXT
    hasPlan BOOLEAN,
    has3DTour BOOLEAN,
    has360 BOOLEAN,
    hasStaging BOOLEAN,
    highlight TEXT, -- Ya era TEXT o ahora es TEXT
    savedAd TEXT, -- Ya era TEXT o ahora es TEXT
    notes TEXT,
    topNewDevelopment BOOLEAN,
    topPlus BOOLEAN,
    parkingSpace TEXT, -- CAMBIADO A TEXT
    newDevelopmentFinished TEXT, -- Ya era TEXT
    geometry GEOMETRY(Point, 4326)
);