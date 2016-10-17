#chapter 6: Data Input and Output
#input codes by copy and pasting

#How to read data into R & how to create files based on the object in R

#scan: create a vector by typing the data directly into the console

x = scan()  #1: 1 3 5   4:  Read 3 items
#the reading will stop when a completely blank line is entered
x       #[1] 1 3 5
#by default, scan expects all of its input to be numeric values

#to read character values...
char = scan(what ="")   #1: a b  d e  6:   Read 5 items
char     #[1] "a" "b" "c" "d" "e"

#use scan + matrix functions to read a data matrix
mat = matrix(scan(), ncol = 2, byrow = TRUE)  #1: 1 3  3: 3 4  5: 4 6  7:  Read 6 items
mat     #outputs the matrix
mat = matrix(scan(), ncol = 2)   #1: 1 3  3: 3 4  5: 4 6  7:  Read 6 items
#if byrow = TRUE is not mentioned then the rows are stored by columns in the resulting matrix
mat     #outputs the matrix

#if what argument is a list -> scan return a list of vectors
dat = scan(what = list(name= "", height = 0, smoke = TRUE))  #1: john 57 T  2: ken 50 F  3: dave 55 T  4:  Read 3 records
#height = 0 to specify numeric values, smoke = TRUE to specify logical values
dat   #$name [1] "john" "ken" "dave"  $height [1] 57 50 55 $smoke [1] TRUE FALSE TRUE

#convert dat -> a data frame by
data.frame(dat)   #outputes matrix with column & row label & associated instance values

#The fix function - allows to create a dummy dataframe and then use the fix funciton to enter in more data
dummy = data.frame(name="", age=0)
fix(dummy)

#Reading White-space, Tab-, or Comma-separated Data
#read.table: read an external text file in which each field is separate by 1+ separators
#the result is a data frame
#it has a large number of arguments
#before reading your file, consider the format criteria first
#sep: default values - spaces, tabs, newlines
#header: default values - FALSE -> R use V1, V2, ...
#header line is one column shorter than the body of the file, the 1st column -> rownames. The header option is automaticallt set to TRUE
#by default: read.table can recognize NA as a missing value of any data type; and treat NaN, Inf, and -Inf as missing for numeric data. na.string = "." -> Treat "." as missing values
#by default, any text after # are comments comment.char ="%" -> text after % are comments
#skip: to skip number of lines
#nrow: to read number of rows

#ie. example.1.txt: 
# each field in the data set is separated by a tab
# the first 2 lines are comments after the #
# the first tow after the comments have the variable names
# the numerical missing values are represented as "."
setwd("C:/Users/Arthur/DocumentsPM599 R Sp11/chapter4")
example1 = read.table(file = "example1.txt", header = T, na.strings = ".")
head(example1)    #outputs data frame with first couple of instances
#header = T
#comment.chat argument is not used
#na.strings = "."
#sep option is not used. Or sep= "\t"
#use getwd to get the current working directory

class(example1$Fname)   #[1] "factor"
#to prevent conversion to factors, you can set stringsAsFactors to FALSE
example1 = read.table(file = "example1.txt", header = T, na.strings = ".", stringAsFactors = F)
class(example1$Fname)   #[1] "character"

#write: usually used to write a matrix to a file
#3 important arguments:
# x: the data to be written-out
# file: the name of the output file
# ncolumns: the number of columns to write to the output data. By default, the write funciton writes the x to the output file in 5 columns & stored by columns

foo = matrix(1:18, ncol = 3)
foo     #outputs the matrix
write(foo, "foo.txt", ncol = 3)
#then can view foo.txt in directory
foo1 = t(foo)
foo1    #outputs a transposed foo
write(foo1, "foo1.txt", ncol = 3)
#the above 3 commands writes a matrix in row-wise order by transposing the matrix & then specifying the number oc columns to be used

#write.table: write a data frame/matrix to an output file
#the most common arguments for the write.table:
# file: the name of the output file
# quote: TRUE-(the default value), any character/factor columns will be surrounded by double quotes, FALSE-all the quotes will be eliminated, a numeric vector-serves as the indices of columns to quote
# sep: e.g. sep = "\t"
# na: default value is NA
# row.names: by default, the rownames will be printed
# col.names: by default, the colnames will be printed

dat1 = data.frame(numVar = c(round(rnorm(5), 2), NA), charVar = c(NA, letters[1:5]))
data1    #outputs the matrix dat1
write.table(dat1, file = "dat1.txt")
#each column is separated by 1 space
#character values are quoted

write.table(dat1, file = "dat1.txt", row.names = F, quote = F, sep = "\t", na = "")
#you can easily open this file by usin EXCEL