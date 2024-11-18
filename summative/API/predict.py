from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
from typing import Union
import joblib
from fastapi.middleware.cors import CORSMiddleware
import os


current_dir = os.path.dirname(__file__)
model_path = os.path.join(current_dir, "best_model.joblib")
# Load the pre-trained Decision Tree model at app startup
model = joblib.load(model_path)

# Initialize FastAPI
app = FastAPI()

# CORS middleware to handle cross-origin requests
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Define the input data model with validation
class PredictionRequest(BaseModel):
   Adult_Mortality: float = Field(..., gt=0, description="Must be greater than 0")
   Schooling: float = Field(..., gt=0, description="Must be greater than 0")
   Total_expenditure: float = Field(..., gt=0, description="Must be greater than 0")
   BMI: float = Field(..., gt=0, description="Must be greater than 0")

# Define the prediction endpoint
@app.post("/predict/")
async def predict(data: PredictionRequest):
    try:
        # Prepare input for the model
        input_data = [[data.Adult_Mortality, data.Schooling, data.Total_expenditure, data.BMI]]
        
        # Make prediction
        prediction = model.predict(input_data)
        
        prediction_value = prediction[0]
        
        if prediction_value > 80:  
            life_expectancy = "High"
        elif prediction_value > 60:
            life_expectancy = "Moderate"
        else:
            life_expectancy = "Low"

        # Return response
        return {
            "prediction": float(prediction_value),
            "life_expectancy": life_expectancy,
            "description": "Life expectancy prediction based on provided health data."
        }
    
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Error: {str(e)}")

#health check endpoint for monitoring
@app.get("/health/")
async def health_check():
    return {"status": "healthy"}
