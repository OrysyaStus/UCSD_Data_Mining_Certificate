

##
## Orysya Stus
## Assignment 1
##


##
## Problem 1
## 
## 1. Generate the following vectors:
a = seq(2, 10)
a
b = seq(15, 3, by=-3)
b
d = rep(a, 2)
d
e = rep(b, 5:1)
e
## 2. Write R commands to answer the following questions (using vectors created above)
sum(d < 6 & d > 4)
any(e < 1)
sum(a > 9) + sum(b > 9)
f = c(1, 4, 5, 9, -1, NA, 2, NA, 3, NA, 9, 3)
sum(is.na(f))
sum(f, na.rm = TRUE)

##
## Problem 2
## To generate a random number that follows standard normal distribution, we can use the rnorm function.
# Create a 4 by 5 matrix containing 20 randomly generated numbers that follow standard normal distribution. Use two ways to create this matrix. One matrix will be called x1, the other one x2.
x1 <- matrix(rnorm(20), 4, 5)
x1
x2 = matrix(rnorm(20), 4, 5, byrow = TRUE)
x2
# Create a matrix, smallx, by taking the last three rows and first and last columns of x1.
smallx = x1[2:4, c(1,5)]
smallx
# dimension of smallx
dim(smallx)
# change matrix smallx into a vector
c(smallx)

##
## Problem 3
##
# Create 6 vectors, name, sex, age, height, weight, and smoke, one for each of the variables above.
name = c("Alfred", "Barbara", "John", "Kerry")
sex = c("M", "F", "M", "F")
age = c(23, 35, 25, 19)
height = c(72, 61, NA, 66)
weight = c(160.3, 125.4, 175.0, 130.2)
smoke = c(TRUE, NA, FALSE, FALSE)
# Add the names attribute for the age vector by using the name vector.
names(age) <- name
# Write an R command to find out whose weight is over 150 pounds?
name[weight > 150]
# Create a list, example.list, based on these 6 vectors. Use the names of the vector as the names of component of the list.
example.list = list(name, sex, age, height, weight, smoke)
example.list
# Create a vector, bmi, based on vectors weight and height, according to the following formula: bmi = 100weight=height2. Then concatenate bmi to example.list. Make sure bmi is a list before you concatenate it.
bmi = c(100 * (weight / (height * height)))
example.list <- c(example.list, list(bmi))
example.list
# Create a list, named small.list, based on example.list that only contains the name and sex components.
small.list <- example.list[1:2]
small.list
# Convert example.list to a data frame, named example.data.
example.data <- data.frame(example.list)
colnames(example.data) <- c("Name", "Sex", "Age", "Height", "Weight", "Smoke", "BMI")
rownames(example.data) <- c("A01", "A02", "A03", "A04")
example.data
# Create a data frame, female, based on the data frame example.data by only keeping the female subjects. When you create this data frame, only keep variables name, sex and age.
female <- example.data[c(2,4), 1:3]
# Change the variable names of the female data set from name, sex and age to f.name, f.sex, and f.age.
colnames(female) <- c("f.name", "f.sex", "f.age")
# Change the default row names of female to A01, A02.
rownames(female) <- c("A01", "A02")
female