# Regression - predicts linear relationship between two variables
# Given Google Analytics data: Response variable (y) = Conversions, Predictor variable(x) = Count of New Visitors
# How to predict value 'Conversions', given the Count of New Visitors

setwd("C:/Users/Orysya/Desktop")
rawData=read.csv("RawData_LinearRegression.csv", header=T)
attach(rawData)
names(rawData)
# [1] "Count.of.New.Visitors" "Conversions"

#rawData
par(mfrow=c(1,2))
x <- Count.of.New.Visitors
y <- Conversations
plot(x,y)
result <- lm(y~x)
result

#Should output -> Call: lm(formula = y ~ x)

abline(result, col="red")
y1 <- result[[1]][2]*x + result[[1]][1]
#y1
plot(x,y1,type='l', col="blue")