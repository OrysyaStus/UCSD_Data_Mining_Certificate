#chapter 1: Introduction to R
#input codes by copy and pasting

#Use R as a Calculator
3 * 2 + 4
4^2 + 1
log(2) + exp(5)

#Assigning a value to a variable
a <- 5 * pi
a = 5*pi
#r names are case sensitive, do not use reserved words

#a data vector is an array of numbers/characters that can be constructed by using
weight = c(60, 72, 57, 90, 95, 72)
weight
height = c(1.75, 1.8, 1.65, 1.9, 1.74, 1.91)
#Perform the calculation with vectors of the same/different length
bmi = weight/height^2
bmi
#during the calculation the shorter vector is recycled

#if the longer vector is not a multiple of the shorter vector, R will issue a warning exmple
a = c(1,2,3)
b = c(1,2)
a + b
#Warning message: In a + b: longer object length is not a multiple of shorter object length

#calculate the mean of the bmi:
sum(height)
length(height)
sum(height)/length(height)
#or
mean(height)

#an use user defined stats
t.test(bmi, mu = 22.5)

#has a rich collection of graphical functions
plot(height, weight)

#to learn how to use an R functions
?var
help(var)
#invoke the documentation of the var function
help('+')
#invoke the documentation of the operator
args(var)
#can provide the name of the inputs for a given function
help.search("linear models")

#find the mode and class
n1 = c(1,4,pi,10)
n1
mode(n1)
#most commonly encountered modes are numeric, character, logical
#the class describes the data sructure of an object, the concept of class is closely related to objected-oriented programming
n2 = matrix(n1, nrow = 2)
n2
mode(n2)
class(n2)
class(n1)

#another useful function that can be used to distinguish objects is the attributes function
attributes(n1)
attributes(n2)

#to change matrix to a vector, you can also use the attributes function
n3 = n2
attributes(n3)
attribute(n3) = NULL
n3
#determine the dimensions
dim(n2)
dim(n1)

#the is.xxx function tests whether or not its arguments is of a required mode or class
#the result from the is.xxx function is either TRUE or FALSE
is.numeric(n2)
is.character(n2)
is.vector(n2)
is.matrix(n2)

#as.xxx converts one type of object to another type with different mode or data structure
as.character(n1)
as.vector(n2)

#NA is used for missing elements in numeric, character, and logical vectors
#NA is not a value but a marker for a missing value
#the missing values are sometimes intended or may result from computation or data type conversion
c1 = c("A", "B", "C")
as.numeric(c1)
#will have a warning message because NAs are introduced

#the is.na function can be used to indicate which elements of a vector are missing
#the length of the result from the is.na function is the same as its arguments
n4 = c(1, NA, 3)
is.na(n4)

#to see the contents of the working directory, type: dir()
#you can change the directory bu using the setwd() function
#the workspace is the collection of R objects that are listed upon typing ls() or objects()
#if you decide to remove some of the objects from the workspace, you can use the rm function
#use rm(list=ls()) to remove everything in your current workspace

#search paths
library(MASS)
search()
searchpaths()
#the name of the objects held in any place in the search path can be displayed by giving the objects function

#the function find can be used to discover where can an object appear on teh search path
find("iris3")
find("quine")

#there is one object in the MASS package named "Traffic"
#Suppose you create an object with the same name in the workspace. Then try to find the "Traffic"
Traffice = c(1,2,3)
find("Traffic")
#Traffic appears twice on the search path
#since the newly created Traffic is in position 1, which is before the position where the MASS package was located, when you type Trafficm you will get the one in package 1
Traffic
get("Traffic", pos = 2)
conflicts()
#conflicts will find the location of path dispute

#Saving objects
#you can save the workspace to a file at any time. If you type save.image(), then the objects from the workspace will be saved in the file called .Rdata in your working direction
#you can also specify a file name, such as save.image("lect1.RData")
#if you want to save only a few selected objects, you can use the save function. For example, to save objects, you can type save(height, weight, file= "ht.RData")
#the .RData file can be loaded by default if you double click on this file. The saved file can be loaded to your current workspace by using the load function. For example, load("ht.RData")