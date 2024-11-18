# Life Expectancy Prediction App

## Mission Statement
My mission is to integrate *technology* and *healthcare* to empower individuals and organizations with data-driven insights, improving the understanding and prediction of critical health outcomes such as life expectancy

## Overview
The Life Expectancy Prediction App is a user-friendly platform that leverages machine learning to predict life expectancy based on health-related parameters. The app provides valuable insights to individuals, healthcare professionals, and researchers, using advanced analytics to identify trends and assess risk levels.

## Dataset
The data used in this project is sourced from **Kaggle**. 

# Dataset Description
The dataset includes the following health-related indicators:

**Life Expectancy** : The target variable, representing the average number of years a person is expected to live.
**Adult Mortality**: A measure of the likelihood of death among adults aged 15–60 years.
**Schooling**: Average years of schooling.
**Total Expenditure**: Government expenditure on healthcare as a percentage of GDP.
**BMI**: Body Mass Index, a common indicator of body fat.

| Life expectancy | Adult Mortality | Schooling | Total expenditure | BMI  |
|------------------|-----------------|-----------|-------------------|------|
| 65.0            | 263.0           | 10.1      | 8.16              | 19.1 |
| 59.9            | 271.0           | 10.0      | 8.18              | 18.6 |
| 59.9            | 268.0           | 9.9       | 8.13              | 18.1 |
| 59.5            | 272.0           | 9.8       | 8.52              | 17.6 |

## Machine Learning Model

Three machine learning models were evaluated during the development process:

Linear Regression
Random Forest
Decision Tree
After rigorous testing, the **Decision Tree model** emerged as the most accurate and reliable, with high performance in predicting life expectancy. This model was chosen for integration into the app.

## Technology Stack
The app leverages a robust backend and interactive frontend:

**Backend**: Python with FastAPI for seamless API development and hosting.
**Frontend**: Flutter for building a user-friendly interface that works across platforms.
**Machine Learning**: Scikit-learn for training and deploying the Decision Tree model.

## App Setup and Deployment

# Prerequisites
Ensure the following tools are installed on your system:

Python (Version 3.8 or later)
Flutter (Stable version)
Git

### Backend
1. Clone the repository:
   
   ```bash
   git clone (https://github.com/Skaveza/Linear_Regression_Model.git)
   cd linear_regression_model

3. Set up a virtual environment:
   
   ```bash
   python -m venv venv
   source venv/bin/activate

5. Install the required dependencies:
   
    ```bash
    pip install -r requirements.txt
    
7. Start the FastAPI server:
   
   ```bash
     uvicorn predict:app --reload

## Frontend Setup

Navigate to the Flutter app directory:

   ```bash
   Copy code
   cd flutter_app
   Get dependencies:




   