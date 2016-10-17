#chapter 5: Introduction to R Functions
#input codes by copy and pasting

#Functions in R are themselves R objects
#Many things in R are done using function calls
plot(height, weight)
#function name: plot; actual argument: height, weight
#to see the information for a function can write the function name as a command

#to view formal arguments of a function
formals(plot)			#$x		$y		$...

#explicitly write arguments in function via keyword matching, order doesn't matter
plot(x=height, y=weight)
plot(y=weight, x=height)

#Creating your own functions
# fname = function (arg1 <, arg2, ...>) function.body
# fname = function (arg2 <. arg2, ...>) {function.body}
#fname: is the name of the function
#function: keyword
#arg1, arg2, ...: formal arguments
#Function.body: usually a group of statements
#A functon call is called by giving its name w/argument sequence in parentheses
# fname(val1 <, y=val2, ...>)

#conduct a 2-sample t-test
set.seed(2)
var1 = rnorm(50, 3, 2)
var2 = rnorm(60, 5, 3)
result = t.test(var1, var2)
result						#Welch Two Sample t-test ...
mode(result)				#[1] "list"
#since the result of the funciton is a list you can access the information by using a $ operator
#need to define the t.test function
#to see the contents of a result easily
str(result)					#List of 9...
print(result$statistic)		#t			-3.075058
#make result more readable
print(paste("t", round(result$statistic, 3), sep = "= "))	#[1] "t= -3.075"
#the paste function is used to concatenate different types of vectors

#Write a function that used to print t-statistics, degree of freedom and p value
printT = function(tValue) {
	print(paste("t", round(tValue$statistic, 3), sep = "= "))
	print(paste("DF", round(tValue$parameter, 3), sep = "= "))
	print(paste("p", round(tValue$p.value, 3), sep = "= "))
}
printT(result)		#[1] "t= -3.075"	[1] "DF= 101.474"	[1] "p= 0.003"

#Create another function that: performs the 2-sample t-test, print the 3 statistics, return its p-value only
myTtest = function(x1, x2) {
	result = t.test(x1, x2)
	printT(reselt)
	return(result$p.value)
}
getP = myTtest(var1, var2)		#[1] "t= -3.075"	[1] "DF= 101.474"	[1] "p= 0.003"
getP	#[1] 0.002704407

#If one of the aguments is empty, return NA
myTtest1 = function(x1, x2) {
	if (length(x1) == 0 | length(x2) ==0) return (NA)
	result = t.test(x1, x2)
	printT(reselt)
	return(result$p.value)
}
getP1 = myTtest1(numeric(0), var2)
getP1			#[1] NA

#If you want to return several values, you combine them into a list
myTtest2
function(x1, x2) {
	if (length(x1) == 0 | length(x2) ==0) return (NA)
	result = t.test(x1, x2)
	printT(reselt)
	list(method=result$method, t=result$statistic, df=result$parameter, p=result$p.value)
}
result2 = myTtest2(var1, var2)		#[1] "t= -3.075"	[1] "DF= 101.474"	[1] "p= 0.003"
result2			#$method	[1] "Welch Two Sample t-test" ...

#Statements can be seaprated by: a semicolon, a new line
#If the current statement is not syntactically complete, new lines are simply igored by the evaluator
#If the session is interactive, the prompt changes from > to +

#Statements an be grouped together by { and } -> block
#Blocks will only be evaluated until a new line is entered after }
{
+	x <- 0
+	x + 5
+}	#end of a statement			#[1] 5

#The if statement has the following formal
# if (condition) true.branch else false.branch (or NULL)
#If it is a vector, only the first component is used
x = rnorm(10)
x 			#[1] 1.83 ...	 .... 	...
if (mean(x) > median(x)) print("Mean > Median") else print ("Mean < Median")	#[1] "Mean < Median"
#The if statement can be extended to several lines...
# if (condition) {
#	true.branch.1
#	true.branch.2
#	...
# } else {
#	false.branch.1
#	false.branch.2
#	...
# }
#When the f statement is not in  block...else must appear on the same line of the if statement
# if (condition) else {
#	false.branch.1
#	false.branch.2
#	...
# }
#When the if statement is in a block...else must appear on the same line of the closing bracket }
# if (condition) {
#	true.branch.1
#	true.branch.2 
#	...
# } else {
#	false.branch.1 
#	false.branch.2 
#	...
# }
#If if statement is in a function -> else can be placed in a new line
#Multiple cases: use the if ... else if ... structure
# if (condition) {
#	...
#		...
# } else if {
#	...
# } else if {
#	...
# } else {
#	...
# }
#You can assign the value of if/else statements to a variable
#The following 2 statements are equivalent
if (any(x <= 0)) y = log(10+x) else y = log(x)
y		#[1] 2.47 	... 	...		[7] ...		...
y = if (any (x <= 0)) log(10+x) else log(x)
y 		#[1] 2.47	...		...		[7] ...		...

#The difference beteen &, | and &&, ||
#2 additional logical operators, && and ||, are useful with the if statement
#&, &&: logical AND; |, ||: logial OR
#& and | perform element-wise comparisons, while && and || do not
#&& and || evaluate left to right examining only the first element of each vector
#with &&, the RH expression is only evaluated if the LH one is true, and wih ||, only if it is false
# situation when either & or && generates the same results
a = 3
b = 3
a == 3 & b == 3		#[1] TRUE
a == 3 && b == 3	#[1] TRUE
#Both a == 3 and b == 3 return TRUE, which is a logical vector with length equaling 1
#Situations when using & - the goal of the calculations is for the element-wise comparisons
x = c(T, F, T)
y = c(T, T, T)
x & y			#[1] TRUE FALSE TRUE
x && y			# TRUE
y1 = c(F, T, T)
x && y1 		#[1] FALSE
#Situation when using &&: Suppose that you would like to test matrix y to see: if the nrow(y) > 1, and if it does, you would like to check if y[2, 1] == 2
y = matrix(1:2, 1)
y				# [1,]	1	2 
nrow(y) > 1 && y[2, 1] == 2		#[1] FALSE 
nrow(y) > 1 & y[2, 1] == 2 		#Error: subscript out of bounds

#Calculate the Square Root and Log of a Vector
sqrtAndLog = function(x) {
	if (is.numeric(x) && min(x) > 0) {
		x.sqrt <- sqrt(x)
		x.log <- log(x)
	} else stop ("x must be numeric and all componenets positive")
	return (list(x.sqrt, x.log))
}
sqrtAndLog(c(2,4,3))	#[[1]] [1] 1.414 2.000 1.73 	...
sqrtAndLog(c(2,4,-33))	#Error in sqrtAndLog...

#Example: calculate the central tendency with choices of arithmetic average, harmonic mean, or median
central = function(y, measure) {
	if (measure == "mean") return (mean(y))
	else if (measure == "harmonic") return (1/mean(1/y))
	else if (measure == "median") return (median(y))
	else stop ("Your measure is not supported")
}
z <- rnorm(10, mean=2, sd=3)
central(z, "mean")		#[1] 1.560157
central(z, "harmonic")	#[1] -1.634218
central(z, "median")	#[1] 0.73387

#Test the equality of variance ofr a 2-sample T-test
#Write a function, myTtest, to perform a 2-sample t-test: test the equality of variance, if the variance are equal, set the var.equal = T, print the t-statistics, degrees of freedom, and p-value, return the result from the t-test
myTtest = function(x, y) {
	vt.p = var.test(x, y)$p.value
	if (vt.p > 0.05) {
		print("Variance are equal")
		result = t.test(x, y, var.equal = T)
	} else {
		print("Variance are not equal")
		result = t.test(x, y)
	}
	print(paste("t: ", round(result$statistic, 2), sep = ""))
	print(paste("DF: ", result$parameter, sep = ""))
	print(paste("p: ", round(result$p.value, 2), sep = ""))
	return(result)
}
set.seed(3)
a = rnorm(10, 2, 5)
b = rnorm(8, 3, 2)
c = rnorm(9, 5, 5)
r1 = myTtest(a, b)	#[1] "Variance are not equal"	[1] "t: -0.22"	[1] "DF: 10.189.."	[1] "p: 0.83"
r1					#Welch Two Sample t-test ...
r2 = myTtest(a, c)	#[1] "Variance are equal"	[1] "t: -1.06"	[1] "DF: 17"	[1] "p: 0.3"
r2					#Welch Two Sample t-test ...

#The ifelse function has the following form:
# ifelse (test, true.value, false.value)
#all the values in the true.value vector will need to be evaluated
#all the values in the false.value vector will need to be evaluated
#Example: create an indicator variable
treatment = c(rep("case", 3), rep("control", 2))
treat.ind = ifelse(treatment == "case", 1, 0)
treat.ind 			#[1] 1 1 1 0 0
#Example: Taking square root of a negative number
x = -3:5
sqrt(x)		#[1] NaN 	NaN	 NaN 	0 	1 	1.414	1.7320 2.0 	2.2360 Warning message: In sqrt(x) NaNs produced
#Use the ifelse function to avoid the warning message
sqrt(ifelse(x >= 0, x, NA))		#[1] NA	NA	NA 	0 	1 	1.414	1.7320 2.0 	2.2360
#The following code will still generate vwarning message since all arguments in the ifelse function are evaluated
ifelse(x >= 0, sqrt(x), NA)	#[1] NaN 	NaN	 NaN 	0 	1 	1.414	1.7320 2.0 	2.2360 Warning message: In sqrt(x) NaNs produced
	
#The switch function has the following form:
# swtich(statement, ...)
#if value of statement is a number & 1 <= value <= length(...) is TRUE then the corresponding element list is evaluated and result returned
#if value of statement is a number & 1 <= value <= length(...) is FALSE then NULL
x = 3
switch(x, 2+2, mean(1:10), rnorm(5))	#[1] 0.9319	0.6316	1.3671	-2.3049	-1.9256
switch(2, 2+2, mean(1:10), rnorm(5))	#[1] 5.5
foo = switch(6, 2+2, mean(1:10), rnorm(5))	
foo 					#NULL
#if value of statement is a character vector & the element of ... with a name that exactly matches value & found match then the matched element
#if value of statement is a character vector & the element of ... with a name that exactly matches value & no match then NULL
y = "fruit"
switch(y, fruit = "banana", veggi = "broccoli", meat = "beef")	#[1] "banana"
#Make a selection according to the character value of 1 of the arguments to a function
central = function(y, measure) {
	switch(measure, mean = return(mean((y)),
			harmonic = return(1/mean(1/y)),
			median = return(median(y)),
			stop ("Your measure is not supported"))
}
z = rnorm(10, mean=2, sd=3)
central(z, "mean")			#[1] 1.570131

#Two types of loop: implicit and explicit
#Three types of explicit loop: for, while, and repeat
#break, and next can be used explicity to control looping: break causes an exist from the innermost loop & next causes control to return the start of the loop 
#for loop has the following form:
# for(variable in sequence) statement 
#for a grouped statement, enclosed within {}
ss <- 0 
total <- 0 
for (i in c(20, 30, 25, 40)){
+	total <- total + i 
+ 	ss <- ss + i^2 
+ }
total 			#[1] 115
ss				#[1] 3525
#Previous example is equivalent to...
i <- c(20, 30, 25, 40)
total.1 <- sum(i)
ss.1 <- sum(i^2)
total.1 		#[1] 115 
ss.1 			#[1] 3525 

#The while loop has the following form:
# while (condition) statement
#If Condition is TRUE, statement is evaluated
#This process continues until statement evaluates to FALSE 
x <- 0 
test <- 1 
while (test > 0) {
+	x <- x + 1 
+ 	print (x^2)
+	test <- x < 6 
+ }				#[1] 1 	[1] 4 	[1] 9 ...

#The repeat loop has the following form:
# Repeat {statement}
#statement must be a block statement
x <- 0 
repeat {
+	x <- x + 1 
+ 	print(x^2)
+	if (x == 6) break
+ }				#[1] 1 	[1] 4 	[1] 9 ...