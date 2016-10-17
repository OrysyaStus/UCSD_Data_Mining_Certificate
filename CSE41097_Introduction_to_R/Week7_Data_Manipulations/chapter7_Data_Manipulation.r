#chapter 7: Data Manipulation
#input codes by copy and pasting

#subsetting data frames
#use painters from the MASS library
library(MASS)
head(painters)
dim(painters)   #[1] 54 5
#selecting the observations from a data frame is similar to selecting rows from a matrix
#to select observations w/Color >= 17
painters[painters$Colour >= 17,]
#to select ones from school "A" or "D", use is.element
painters[is.element(painters$School, c("A", "D")),]
# is.element(painters$School, c("A", "D")) is not = to painters$School == c("A", "D")
#Selecting vars from a data frame is also similar to selecting columns from a matrix
#to select vars: use the column index/vars names
#the followins 4 statements are equivalent
d1 <- painters[, c("School", "Colour")]
d2 <- painters[c("School", "Colour")]
d3 <- painters[, c(5,3)]
d4 <- painters[c(5,3)]
#you an also select observations & vars at the same time
painters[painters$School == "A", c("School", "Colour")]
# subset: create a data frame by selectin observations & vars
#2 important arguments: subset: 
# a logical expression that is used to select rows; missing values are taken as false
# select: an expression that is used to select columns
subset(painters, Colour >= 17)
#the select argument can be specified as one of the following forms:
# a vector of integers: select = c(1,2)
# a vector of variable names: select = c(Composition, Drawing)
# a negative sign can be used: select = -c(Composition, Drawing) select = -c(1,2)
# ranges of columns can be selected by using (:) selected = 1:3 select = Composition:Colour
subset(painters, Colour >= 17, 1:3)

#Creating & re-coding variables
#creatin indicator vars based on existing cont./cat. var.
#The indicator var can be a logical/an integer vector
#A "logical" indicator var is sufficient for modeling
#A logical vector -> an integer vector, use as.integer
#example: create an indicator variable - indicating above/below mean of Drawing
painters$DrawingInd = painters$Drawing >= mean(painters$Drawing)
head(painters)
#use the transform function to create a new var
paintersNew = transform(painters, DrawingInd = Drawing>mean(Drawing))
head(paintersNew)
#create an ordinal var w/2+ levels
painters$CompositionOrd = 1 + (painters$Composition >= 8) + (painters$Composition >= 12)
head(painters[c("Composition", "CompositionOrd")])
tapply(painters$Composition, painters$CompositionOrd, min)
tapply(painters$Composition, painters$CompositionOrd, max)
#the ifelse function has the following form: ifelse (test, true.value, false.value)
#all arguments are vectors, test: a logical vector
table(painters$School)
#to create an ordinal var that equals to 1 if the School var equal to A, B, or C, & equals to 2 otherwise
School2 = ifelse(is.element(painters$School, c("A", "B", "C")), 1, 2)
table(School2, painters$School)
#you nest an ifelse function within anotehr ifelse function
School3 = ifelse(is.element(painters$School, c("A", "B", "C")), 1, ifelse(is.element(painters$School, c("D", "E")), 2, 3))
table(School3, painters$School)
#Create a factor based on a continuous var: cut
# cut(x, breaks, labels = NULL, include.lowest = FALSE, right = TRUE) 
# x: is the variable to be divided
# breaks: a numeric vector of 2+ cut points ie. breaks = c(n1, n2, n3, n4) -> x is divided into: (n1, n2], (n2,n3], and (n3,n4]; Note: n1 is not included
# labels = NULL: the resulting factor is labeled as (n1, n2], (n2,n3], and (n3,n4]. It's better to provide your own label
# if setting include.lowest = TRUE, x is divided into: [n1, n2], (n2,n3], and (n3,n4]
# if setting right = FALSE, x is divided into: [n1, n2), [n2,n3), and [n3,n4)
#example: create a 4-level factor based on Colour var
qt = quantile(painters$Colour, c(0, 0.25, 0.5, 0.75, 1))
qt
painters$ColourCat = cut(painters$Colour, qt, labels = c("1st", "2nd", "3rd", "4th"), include.lowest=T)
head(painters)

#Re-coding Missing Values
#Sometimes, we need to recode '99' or '999' to NA. E.g
exampleMissing
exampleMissing$x1[is.element(exampleMissing$x1, c(99, 999))] = NA
exampleMissing

#Sorting an Object
#the sort function take either numeric/character vector
x = c(5,2,1)
sort(x)
sort(x, decreasing = TRUE)

#Sorting a Data Frame
#create an index vector by using the order function first
#then use this index vector to sort the data frame
#to illustrate some example, let's create a small data set
paintersABC = painters[is.element(painters$School, c("A", "B", "C")),]
paintersABC
#example: sort by row names
nameIndex = order(row.names(paintersABC))
nameIndex
paintersABC[nameIndex, ]
#example: sort by School in decreasing order
paintersABC[order(paintersABC$School, decreasing = T), ]
#we can sort the data by more than 1 var
paintersABC[order(paintersABC$School, paintersABC$Drawing), ]
#decreasing option applies to all the vars
paintersABC[order(paintersABC$School, paintersABC$Colour, paintersABC$Drawing, decreasing = T),]
#for numeric vector, we can use '-' to control which vector needs to be sorted in decreasing order
paintersABC[order(paintersABC$School, -paintersABC$Colour, paintersABC$Drawing), ]
#to use the negative sign to sort a character column, you need to use the xtfrm function
#the xtfrm function creates a numeric vector based on its argument, which will sort in the same order as its argument
xtfrm(c("A", "D", "B", "C"))
paintersABC[order(-xtfrm(paintersABC$School), paintersABC$Drawing), ]
#The na.last argument determines the handing of NAs
# na.last = NA: NAS are deleted
# na.last = TRUE(default): NAS are placed at the end
# na.last = FALSE: NAS are placed at the beginning
#unqiue: create a vector w/only unique components
v = c(letters[1:4], "d", "a")
v
unique(v)
#if fromLast = TRUE, the last(or rightmost) of identical elements will be kept
unique(v, fromLast = TRUE)
#duplicated: determine which elements of a vector are duplicates
v
duplicated(v)
v[!duplicated(v)]
v[!duplicated(v, fromLast = T)]
#unique: creates a matrix w/unique rows (or columns)
#duplicated: indicates which rows (or columns are duplicates)
mat = matrix(c(rep("c", 3), "d", "c", rep(c(letters[1:3], "c", "c"), 2), letters[1:3], "d", "c", rep("c", 5), letters[1:3], "c", "c"), ncol=5, byrow = T)
mat
unique(mat)
duplicated(mat)
unique(mat, fromLast = TRUE)
unique(mat, MARGIN = 2)
duplicated(mat, MARGIN = 2)

#Managing Duplicated Observations of Data Frames
#Manipulating a df w/duplicated observations is similar to the way of manipulating a matrix
#You can't use the MARGIN option applying to a df
set.seed(5)
dat = data.frame(ID = c(rep("A01", 3), rep("A02", 2), "A03", "A04", rep("A05", 2)), visit = c(3:1, 1, 2, rep(1,4)), score = round(rnorm(9,5,2)))
dat
unique(dat)
#Create a df that contains patients' 1st visit
datSort = dat[order(dat$ID, dat$visit), ]
datSort
firstVisit = datSort[!duplicated(datSort[, 1]), ]
firstVisit
#Create a df that contains patients' last visits
lastVisit = datSort[!duplicated(datSort[, 1], fromLast = TRUE), ]
lastVisit
#Create a df w/1 observation/subject & a df w/multiple observations/subject
dupID = unique(dat$ID[duplicated(dat$ID)])
dat[is.element(dat$ID, dupID), ]
dat[!is.element(dat$ID, dupID), ]

#Combining Data Frames
#combining data frames vertically & horizontally
#cbind: combine df/matrices/vectors column-wise
#rbind: combine df/matrices/vectors row-wise
data0 = data.frame(x1 = rep(1,6), x2 = rep(2,6))
newCol = data.frame(x3 = 0:5, x4 = 7:12)
data0 = cbind(data0, newCol)
data0
newRow = data.frame(x1 = c(1,2), x2 = c(3,4), x4 = c(5,6), x3 = c(7,8))
newRow
data0 = rbind(data0, newRow)
data0

#Merging Data Frames
#we don't need to sort before we merge dfs
data1 = data.frame(id= c(2,1,3), var1=c("A", "B", "C"))
data2 = data.frame(id= c(3,4,1), var2=c(1,3,9))
result = merge(data1, data2)
result
#use the all.x or all.y arguments
merge(data1, data2, all.x = TRUE)
#use the all argument
merge(data1, data2, all = TRUE, by = "id")
#the common columns have different var names
data3 = data.frame(ID= c(1,3,4), var2=c(1,8,9))
merge(data2, data3, by.x="id", by.y="ID")
#use the suffixes option
merge(data2, data3, by.x="id", by.y="ID", suffixes= c(".data2", ".data3"))

#Reshaping Data Frames
#re-organize a data frame to suit a certain statitical/graphical function
#the following df is not suitable for ANOVA
dat1 = data.frame(value1 = round(rnorm(3,2,3)), value2 = round(rnorm(3,4,2)), value3 = round(rnorm(3,5,1)))
dat1
dat2 = stack(dat1)
dat2
#unstack: transform the df back to its original forml but it requires a formula
dat3 = cbind(dat2, scores = round(runif(9) * 10))
dat3
unstack(dat3, values ~ ind)
unstack(dat3, scores ~ ind)
#a wide format: many observations/subject
long = reshape(wide, varying= list(c("Score1", "Score2", "Score3")), v.names = "Score", timevar="TIME", idvar="ID", direction="long")
# varying = ... : names of the var in the wide format corresponding to a single var in the long format
# v.names ...: names of the var in the long format corresponding to a single var in the wide format
# timevar ...: var in the long format differentiating multiple records from the same individual
# idvar ...: names of the 1+ vars in the long format that identify multiple records from the same individual
# direction ...: long: reshape to long format or wide: reshape to wide format
#similar syntax for transforming from long format to wide format
wide1 = reshape(log, varying= list(c("Score1", "Score2", "Score3")), v.names="Score", timevar="TIME", idvar="ID", direction="wide")