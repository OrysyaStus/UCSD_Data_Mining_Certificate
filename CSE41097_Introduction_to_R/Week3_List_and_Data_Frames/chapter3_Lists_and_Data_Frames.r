#chapter 3: Lists and Data Frames
#input codes by copy and pasting

#List = the most encountered/useful object in R is the list

#create a list - using the list function
student <- list(name = "John", year = 2, classTaken = + c("PM510", "PM5511A", "PM511B"), GPA = 3.85)
student #outputs the list

#use str(object) to display the internal structure
#displays the content of a list in a more compact format
str(student)

#the componenets of a list are always numbered
length(student)		#4
student[[1]]		#"John"
names(student)		#"name"		"year"		"classTaken"	"GPA"
student$GPA			#3.85
student[[3][1]		#"PM510"
#or
student$classTaken[1]	#"PM510"

#we can change the names of the list
names(student) = letters[1:4]

#using [] returns a list with the selected componenets
#the result is still a list
student[2]		#$b		y
student[3:4]	#$c "PM510"		"PM511A"	"PM511B"	$d	3.85

#using [[]] extends or replaces the components of a list
#the result is a vector
student[[3]]	#"PM510"	"PM511A"	"PM511B"
#student[[3:4]] is not allowed

#you can use the c function to add components to a list
student = c(student, age = 25)
student
#the c function has a recursive argument
#setting recursive = TRUE will unlist the arguments first before joining them
list2 = c(list(x=letters[1:3), y=2:4), list(z=c(1,2.0,3.5)),+ recursive=TRUE)
list2
mode(list2)		#"character"
#the numeric values -> characters

#the unlist function converts a list to a vector
unlist(student)
unlist(student, use.names = F)		#"John"	"2"		"PM510"	"PM511A"	"PM511B"	"3.85"	"25"

#to remove the components of a list, we can do the following
student1 = student2 = student3 = list(name = "John", year = 2, classTaken = c("PM510", "PM511A", "PM511B"), GPA = 3.85)
student1["year"] = NULL
student1		#has the year removed

#to remove the components of a list, we can do the following
student2[["year"]] = NULL
student2
#instead of using names, we can also use the number
student1[2] = NULL
student2[[2]] = NULL

#to set the year components to NULL...
student3["year"] = list(NULL)
student3		#displays all data as well as $year NULL

#Data frame = data set
#a data frame = special case of a list; length of each components are the same
sex = c("M", "F", "F", "M", "M")
height = c(65, 63, 60, 62, 57)
weight = c(150, 140, 135, 165, 175)
live.on.campus = c(TRUE, TRUE, FALSE, FALSE, FALSE)
d = data.frame(sex, height, weight, live.on.campus)
d
#all the character columns -> factors, unless using I()
d1 = data.frame(I(sex), height, weight, live.on.campus)

#to find colnames(variable names) or rownames...
colnames(d)
rownames(d)
names(d)
#to assign a meaning rownames...
id = c(2345, 1236, 2986, 6543, 6544)
rownames(d) = id
d
#matrices can have rownames and colnames

#data frame can be indexed in the same way as matrices
d[1:3, c(1,3,4)]	#extracts the 1st 3 rows of the data frame

#use $ to access a variable ie. a list object
d$height[1:3]		#65 63 60
d$live.on.campus
d$sex
d1$sex