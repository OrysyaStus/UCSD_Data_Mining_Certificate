# Regression - predicts linear relationship between variables
# Predictor Variable: Revenue

setwd("C:/Users/Orysya/Desktop")
rawData=read.csv("RawData_LinearRegression_RegMultiVars.csv", header=T)
attach(rawData)
y <- Revenue
x1 <- periodID
x2 <- NewVisits
x3 <- PagesPerSession
x4 <- AvgSessionDuration

result <- glm(y~x1+x2+x3+x4)
result

#Should output -> Call: glm(formula = y ~ x1 + x2 + x3 + x4)
