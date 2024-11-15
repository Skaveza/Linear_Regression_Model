import os

"""This module downloads the dataset"""


dataset = "alexteboul/heart-disease-health-indicators-dataset"
os.system(f"kaggle datasets download -d {dataset} --unzip -p ./data")
print("Dataset downloaded to ./data")
