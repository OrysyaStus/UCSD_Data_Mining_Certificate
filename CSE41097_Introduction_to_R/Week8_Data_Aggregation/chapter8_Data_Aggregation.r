#chapter 8: Data Aggregation
#input codes by copy and pasting

#Data Tabulation - the table & ftable functions
#the table fxn takes the following data type: 1+ factors, character vectors that can be coerced into factors, ad data frame, a list whose components can be coerced into factors
#by defaylt, the missing values will NOT be included in the table
a = c(rep("A", 3), rep("B", 2), rep(NA, 3))
aTable = table(a, exclude = NULL)
aTable
class(aTable)
mode(aTable)
#each component of the table can be accessed w/its name
aTable["A"]
as.data.frame(aTable)
#passing more that 1 vector to the table fxn
race = c(rep("A", 10), rep("W", 6), rep("B", 4))
gender = c(rep("M", 4), rep("F", 3), rep("M", 6), rep("F", 7))
grade = c(3, 3, rep(c(1,2,3), 6))
table(race, grade, gender)
as.data.frame(table(grade, race, gender)) #all possible combos are included
#the following 3 statements will generate the same table:
# table(data.frame(grade, race, gender))
# table(list(grade, race, gender))
# table(grade, race, gender)
#the ftable function: display the table in a flat format
ftable(race, grade, gender)
#addmargins: display the margins of a table
# A: a table class
# margin: 1 refers to the row, 2 refers to the column
# FUN: a fxn that is used for each corresponding margin
tableRaceGender = table(gender, race)
addmargins(tableRaceGender) #default optio: both margins are displayed, FUN = sum
addmargins(tableRaceGender, 2, "mean")
addmargins(tableRaceGender, c(1,2), c("mean", "sum"))

#The prop.table Function
#prop.table: create a table of proportions instead of counts
tableRaceGender
prop.table(tableRaceGender) #Default: sum of all the cells = 1
tableRaceGender
prop.table(tableRaceGender, margin =1) #margin = 1: sum of rows = 1
tableRaceGender
prop.table(tableRaceGender, margin = 2) #margin = 2: sum of columns = 1

#Applying a function to an array - the apply fxn
#fxns to calculate statistics for rows/columns of a matrix: rowSums, rowMeans, colSums, and colMeans
#apply: for a more general operation on successive sections of an array
# X: is an array/matrix (a 2-D array)
# MARGIN: is an integer vector ie. for a matrix, 1 indicates rows, 2 indicates columns, & c(1,2) indicates rows & columns
# FUN: is a fxn which can be either a built-in/user-defined fxn that is used to apply separately to each section
# ...: any additional arguments needd by the FUN
(x = matrix(rnorm(12), 3))
apply(x, 1, min)
apply(x, 2, min)
apply(x, 2, sd)
x1 = x
x1[1, 1] = NA
apply(x1, 1, sd)
apply(x1, 1, sd, na.rm = TRUE)

#Appling fxns to an array w/more than 2 dimensions
#iris3: 3-D array size 50 by 4 by 3; it contains the measurements in cm of the vars sepal length & width & petal length & width, respectively, for 50 flowers from each of 3 species of iris
# 1st D: case # w/in the species subsample
# 2nd D: the car names Sepal L., Sepal W., Petal L., & Petal W.
# 3rd D is species (Iris setosa, versicolor, & virginica)
iris3
#calculate the means for each var by species:
apply(iris3, c(2,3), mean)
#to find the overall means for each var
apply(iris3, 2, mean)

#Applying a fxn to a vector/a list - the lapply & saaply fxns
#most R fxns can operate on each element of a vector but not for a list
#lapply & sapply: for operations on the individual components of lists/vectors:
# X: is a vector/a list
# FUN: is a fxn to be applied to each element of X
# ...: are optional arguments to FUN
#sapply: simplifies the result of a vector/an array if possible
#lapply: returns a list
#Calculate the mean of each component
set.seed(1)
aList = list(a = rnorm(20,3,4), b = rnorm(10, 5, 2), c = c(rnorm(15, 2, 1), NA))
lapply(aList, mean, na.rm = T)
sapply(aList, mean, na.rm = T)
#Calculate the mean and standard deviation:
lapply(aList, function(x) c(MEAN=mean(x, na.rm = T), SD =sd(x, na.rm = T)))
sapply(aList, function(x) c(MEAN = mean(x, na.rm = T), SD = sd(x, na.rm = T)))

#Example: extract info from the results of statistical fxns
#Compare the differences for the Composition, Drawing, Colour, and Expression variables across diff. levels of the School var
library(MASS)
head(painters)
r = apply(painters[,1:4], 2, function(x) {
  lm(x ~ School, data = painters)
})
mode(r)
r[[1]]
summary(r[[1]])
anova(s[[1]])
#Suppose that you would like to extract the F statistics w/its corresponding p-value from the ANOVA table
str(anova(r[[1]]))
names(anova(r[[1]]))
#Extract the statistics from 1 component of the list 1st
foo = anova(r[[1]])
foo["F value"][1,1]
foo["Pr(>F)"]
sapply(r, function(one){
  rANOVA = anova(one)
  c(F = rANOVA["F value"][1,1], p = rANOVA["Pr(>F)"][1,1])
})

#Applying a fxn for each level of categorical variable - The tapply fxn
#tapply: apply a fxn to each grp of values given by a unique combo of the levels of certain fectors
# X: is typically a vector
# INDEX: is the factor defining the grps
# FUN: is the fxn to be applied
# ...: are optional arguments to FUN
#Depending on the # of factors in the INDEX arguments & the # of values returned by the FUN fxn, the class &/ the mode of the object that is returned by the tapply fxn differ
#You will see some examples based on the quine data frame
head(quine)
#Suppose you would like to calculate the mean Days for each level of the Age grp
(ageTable = tapply(quine$Days, quine$Age, mean))
class(ageTable)
mode(ageTable)
dim(ageTable)
dimnames(ageTable) #Result: 1-D array
#To convert the result to a data frame...
as.data.frame(as.table(ageTable))
(ageSexTable = tapply(quine$Days, list(quine$Age, quine$Sex), mean))
mode(ageSexTable)

#The split functions
#split + sapply: apply a fxn to each grp of values given by a unique combo of the levels of certain factors
#split: split a data vector or a data frame on 1+ factors
#One factor w/a fxn returning more than 1 value
(DaysByAge = split(quine$Days, quine$Age))
#One factor w/a fxn returning more than 1 value
(ageTableNew = apply(DaysByAge, mean))
class(ageTableNew)
mode(ageTableNew)
(ageTableNew = apply(split(quine$Days, quine$Age), function(x) return(c(Mean = mean(x), Median = median(x)))))
class(ageTableNew)
mode(ageTableNew)
(ageSexTableNew = sapply(split(quine$Days, list(quine$Age, quine$Sex)), mean))
class(ageSexTableNew)
mode(ageSexTableNew)
(ageSexTable1New = apply(split(quine$Days, list(quine$Age, quine$Sex)), function(x) c(Mean = mean(x), Median = median(x))))
class(ageSexTable1New)
mode(ageSexTable1New)

#The by and aggregate fxns
#by, aggregate: calculate summary statistics for each level of 1+ factors for a df
#syntax is similar to tapply fxn
#for the aggregate fxn, the 2nd argument needs to be a list that contains a var/a factor
(ageTableBY = by(quine$Days, quine$Age, mean))
class(AgeTableBy)
mode(ageTableBy)
(ageTableAgg = aggregate(quine$Days, list(quine$Age), mean))
class(ageTableAgg)
mode(ageTableAgg)
# The iris df
head(iris)
(speciesMeanBy = by(iris[,1:4], iris[,5], colMeans))
class(speciesMeanBy)
mode(speciesMeanBy)
(speciesMeanAgg = aggregate(iris[,1:4], iris[5], mean))
class(speciesMeanAgg)
mode(speciesMeanAgg)
by(iris[,1:4], iris[,5], function(x) c(Mean = colMeans(x), SD = apply(x, 2, sd)))
aggregate(iris[,1:4], iris[5], function(x) c(Mean = mean(x), SD = sd(x)))