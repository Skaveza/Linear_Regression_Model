import pandas as pd
from sklearn.linear_model import SGDRegressor 
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import train_test_split
import joblib

# Load and filter the dataset
df = pd.read_csv('./data/heart_disease_health_indicators_BRFSS2015.csv')
df = df[['HeartDiseaseorAttack', 'HighBP', 'BMI', 'Smoker', 'Sex']] 

# Define features (X) and target (y)
X = df[['HighBP', 'BMI', 'Smoker', 'Sex']]  
y = df['HeartDiseaseorAttack']

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 1. Gradient Descent-based Linear Regression
sgd_model = SGDRegressor(max_iter=1000, tol=1e-3, random_state=42)
sgd_model.fit(X_train, y_train)
y_pred_sgd = sgd_model.predict(X_test)
mse_sgd = mean_squared_error(y_test, y_pred_sgd)
print("Gradient Descent Linear Regression MSE:", mse_sgd)

# 2. Decision Tree Regressor
dt_model = DecisionTreeRegressor(random_state=42)
dt_model.fit(X_train, y_train)
y_pred_dt = dt_model.predict(X_test)
mse_dt = mean_squared_error(y_test, y_pred_dt)
print("Decision Tree MSE:", mse_dt)

# 3. Random Forest Regressor
rf_model = RandomForestRegressor(n_estimators=100, random_state=42)
rf_model.fit(X_train, y_train)
y_pred_rf = rf_model.predict(X_test)
mse_rf = mean_squared_error(y_test, y_pred_rf)
print("Random Forest MSE:", mse_rf)

# Determine the best model based on MSE
best_model = min([(sgd_model, mse_sgd, "Gradient Descent Linear Regression"),
                  (dt_model, mse_dt, "Decision Tree"),
                  (rf_model, mse_rf, "Random Forest")], key=lambda x: x[1])

print(f"Best Model: {best_model[2]} with MSE: {best_model[1]}")

# Save the best model
joblib.dump(best_model[0], 'best_heart_disease_model.joblib')
print("Best model saved successfully.")

# Function to make a prediction
def make_prediction(input_data):
    loaded_model = joblib.load('best_heart_disease_model.joblib')
    prediction = loaded_model.predict([input_data])
    return prediction[0]


