from fastapi import FastAPI
from pydantic import BaseModel, Field
from typing import Union
import joblib
from fastapi.middleware.cors import CORSMiddleware

# Load pre-trained model
model = joblib.load('best_heart_disease_model.joblib')

# Initialize FastAPI
app = FastAPI()

# Add CORS middleware to handle cross-origin requests
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
class PredictionRequest(BaseModel):
    HighBP: int = Field(..., ge=0, le=1, description="0 for No, 1 for Yes")
    BMI: float = Field(..., ge=10.0, le=70.0, description="BMI between 10 and 70")
    Smoker: int = Field(..., ge=0, le=2, description="0 for Never, 1 for Rarely, 2 for Frequent")
    Sex: int = Field(..., ge=0, le=1, description="0 for Female, 1 for Male")

# Define the prediction endpoint
@app.post("/predict/")
async def predict(data: PredictionRequest):
    try:
        # Prepare input for the model
        input_data = [[data.HighBP, data.BMI, data.Smoker, data.Sex]]
        
        # Make prediction
        prediction = model.predict(input_data)
        
        # Return response
        return {
            "prediction": float(prediction[0]),
            "risk_level": "High" if prediction[0] > 0.5 else "Low"
        }
    except Exception as e:
        return {"error": str(e)}
