from fastapi import FastAPI
from pydantic import BaseModel
import pandas as pd
import joblib

app = FastAPI()
pipeline = joblib.load("model_pipeline.pkl")

class Piso(BaseModel):
    size: float
    rooms: int
    bathrooms: int
    latitude: float
    longitude: float
    numPhotos: int
    geo_cluster: int
    mean_price_district: float
    count_district: float
    propertyType: str
    operation: str
    floor: str
    exterior: str
    province: str
    municipality: str
    district: str
    neighborhood: str
    status: str
    hasLift: str
    newDevelopment: str

@app.post("/predict")
def predict(piso: Piso):
    df = pd.DataFrame([piso.dict()])
    precio = pipeline.predict(df)[0]
    return {"precio": round(float(precio), 2)}
