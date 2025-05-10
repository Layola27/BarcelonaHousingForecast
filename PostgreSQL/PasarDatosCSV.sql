COPY pisos_barcelona (
    propertyCode, thumbnail, externalReference, numPhotos, floor, price, priceInfo,
    propertyType, operation, size, exterior, rooms, bathrooms, address, province,
    municipality, district, country, neighborhood, latitude, longitude, showAddress,
    url, distance, description, hasVideo, status, newDevelopment, hasLift, priceByArea,
    change, detailedType, suggestedTexts, hasPlan, has3DTour, has360, hasStaging,
    highlight, savedAd, notes, topNewDevelopment, topPlus, parkingSpace,
    newDevelopmentFinished
)
FROM '/tmp/housing_data_current.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ',',
    QUOTE '"',
    NULL ''
);