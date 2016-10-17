# Logistic Regression if respone variable is binary
# Run if only depend on 1 other variable

setwd("C:/Users/Orysya/Desktop")
DT_train = read.csv("./HW07.csv")
DT_train

#download.packages("RWeka", "D:\\t\\RDataFiles")
#install.packages("RWeka")

# building the model. J48 is the function we use (C4.5 is applied using Java within this package, hence the name starting with J)

library(RWeka)

tree_RW=J48(UserResponded~CampaignMedium+CampaignCount+PreviousResponse, data= DT_train)
#to view he tree-forming rules within the model
tree_RW