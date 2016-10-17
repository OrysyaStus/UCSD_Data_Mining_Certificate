setwd("C:/Users/Orysya/Desktop")
train1 = read.csv("./HW06Train.csv")
#train 1; read in test data
test1 = read.csv("./HW06Test.csv")
#Change the datatype of the variable "Will_Visit_Again" to factor

train1$Will_Visit_Again = as.factor(train1$Will_Visit_Again)

#Creating the model
library(klaR)
model1 = NaiveBayes(Will_Visit_Again ~ Previously_Visited + SessionLength + PageViews, data = train1)

#View details of model1
#model1

#Predict value of Will_Visit_Again and associated posterior probability
pred1 = predict(model1, newdata= test1)

#View prediction
pred1