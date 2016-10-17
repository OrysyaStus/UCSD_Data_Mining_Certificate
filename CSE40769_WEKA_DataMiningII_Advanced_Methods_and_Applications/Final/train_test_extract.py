from sklearn.cross_validation import train_test_split
from scipy import sparse
import numpy as np
import pandas as pd
import csv

data = pd.read_csv("C:\Users\Orysya\Desktop\Data_MiningII_Advanced_Methods_and_Applications\Final\Aids2_editted.csv")
data.columns
train_data, test_data = train_test_split(data, test_size = 0.20, random_state = 42)

train_data.head(3)

test_data.head(3)