# Logistic Regression if respone variable is binary
# Run if only depend on 1 other variable

setwd("C:/Users/Orysya/Desktop")
train = read.csv("./HW05-P2_2vars.csv")
(lr_model1=glm(formula= Converted~AvgSessionLength, data = train, family=binomial))
