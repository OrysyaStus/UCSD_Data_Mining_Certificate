

##
## Assignment 1 - Solution
##


##
## -----------------------------------------------------------
## Problem 1 
## -----------------------------------------------------------
##

##
## 1. Generate the following vectors
##

a = seq(2, 10)
b = seq(15, 3, by=-3)
d = rep(a, 2)
e = rep(b, 5:1)

##
## 2. Write R codes to answer the following questions
##

## How many numbers in vector d are equal to 5?
sum(d==5)

## Are any elements of vector e < 1?
any(e<1)

## How many numbers are greater than 9 in both vectors a and b combined?
sum(a>9) + sum(b>9)

## How many missing values are in vector f?
f = c(1, 4, 5, 9, -1, NA, 2, NA, 3, NA, 9, 3)
sum(is.na(f))

## Calculate the sum of f
sum(f, na.rm=T)


##
## -----------------------------------------------------------
## Problem 2
## -----------------------------------------------------------
##

## Create a 4 by 5 matrix containing 20 randomly generated numbers

## method 1
x1 = matrix(rnorm(20), nrow=4)

## method 2
x2 = rnorm(20)
dim(x2) = c(4,5)

## Create a matrix, smallx, by taking the last three rows and first and last columns of x1
smallx = x1 [-1,5, drop=F]

## What is the dimension of smallx?
dim(smallx)

## How would one change smallx to a vector - any of the following commands work?
as.vector(smallx)
as.numeric(smallx)
dim(smallx) = NULL

##
## -----------------------------------------------------------
## Problem 3
## -----------------------------------------------------------
##

## Create 6 vectors, name, sex, age, height, weight, and smoke,
name = c("Alfred", "Barbara", "John", "Kerry")
sex = c("M", "F", "M", "F")
age = c(23, 35, 25, 19)
height = c(72, 61, NA, 66)
weight = c(160.3, 125.4, 175, 130.2)
smoke = c(T, NA, F, F)

## Add the names attribute for the age vector by using the name vector
names(age) = name

## Write an R command to find out whose weight is over 150 pounds?
name[weight > 150]

## Create a list, example.list
example.list = list(name=name, sex=sex, age=age, height=height, 
	weight=weight, smoke=smoke)

## Create a vector, bmi. Then concatenate bmi to example.list.
bmi = 100*weight/(height^2)
example.list = c(example.list, bmi=list(bmi))

## Create a list based on example.list that only contains the name and sex components
small.list = example.list[c("name", "sex")]

## Convert example.list to a data frame, named example.data
example.data = as.data.frame(example.list)

## Create a data frame, female
female = example.data[example.data$sex =="F",c("name", "sex", "age")]

## Change the variable names of the female data set
colnames(female) = c("f.name", "f.sex", "f.age")

## Change the default row names of female to A01 and A02
rownames(female) = c("A01", "A02")
















