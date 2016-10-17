#chapter 4: Subsetting Objects
#input codes by copy and pasting

#extracting components from an object

#the subsetting operators: [, [[, and $:
# using the [ operator returns the same data type
# [ can extract any numbers of elements of an object
# you can only use [[ and $ to extract one elements
# $ does not evaluate its argument, while [[ and [ does
# $ uses partial matching to extract elements, while [[ and [ do not

alist = list(name1 = c("john", "ken"), station = "AM640", time = "M-F: 3:00pm")
alist[C(1,2)]		#$name1	[1] "john" "ken"	$station	[1] "AM640"
#using the [ operator returns a list
alist["name"]		#$<NA> NULL
alist[["name"]]		#NULL
alist$name			#[1] "john" "ken"
#$ uses partial matching to extract elements

foo = "station"
alist[foo]		#$station	[1] "AM640"
alist[[foo]]	#[1] "AM640"
alist$foo		#NULL
#$ does not evaluate its argument

#subsetting vectors, matrices, or arrays can be referred to as indexing
#subsetting vector x can be done by x[index.vector]

#5 types of index vectors (cannot be mixed):

#Type 1: A Logical vector
#let x = the "target" vector, L = logical index vector
# length (X) = length(L)
#the resulting vector = values from X corresponding to TRUE
#values corresponding to NA returns NA
a = c(1,3,5, NA, 7)
b = a[!is.na(a)]
b					#[1] 1 3 5 7
ind = a > 3
ind					#[1] FALSE FALSE TRUE NA TRUE
a[ind]				#[1] 5 NA 7
#If length(L) < length(X) -> the element of L will be recycled
#If length(X) is not a multiple of the length(L), no warning message is generated
a					#[1] 1 3 5 NA 7
a[c(T, F, T)]		#[1] 1 5 NA
#If length(L) > length(X) -> the selected value will be extended to NA
a					#[1] 1 3 5 NA 7
a[c(rep(T, 7), NA)]	#[1] 1 3 5 NA 7 NA NA NA

#Type 2: A vector of positive integer
#let x = the "target" vector, P=index vector w/positive integer
# P[i]: 1, 2, ...length(X)
a					#[1] 1 3 5 NA 7
a[c(1:3, 2)]		#[1] 1 3 5 3
#if P[i] > length(X) -> selection = NA
a[6]				#[1] NA
#if the elements of P are 0 -> no corresponding resulting
a[c(0, 3)]			#[1] 5
#a non-integer value will be truncated towards 0
a[3.8]				#[1] 5
#elements of the P that are NA -> generate a NA
a[c(1, NA)]			#[1] 1 NA

#Type 3: A vector of negative integer
#the index vector specified the value to be excluded
a					#[1] 1 3 5 NA 7
a[-c(1,4)]			#[1] 3 5 7
#elements of the index vector that are 0 generate no corresponding values
#NA is not allowed to be included in the index vector
#you can not mis positive and negative index together

#Type 4: A vector of character strings
#only applies to an object that has names
#if the target vector has no names, it will result in an NA
a					#[1] 1 3 5 NA 7
a[c("a", "c")]		#[1] NA NA
names(a) = c(letters[1:4], "d")
a					#a b c d d 		1 3 5 NA 7
a[c("a", "c")]		#a c	1 5
a["d"]				#d		NA
#only the values with the lowest index is returned
#use is.element to find all occurences of duplicated names
a					#a b c d d 		1 3 5 NA 7
findD = is.element(names(a), "d")
findD				#[1] FALSE FALSE FALSE TRUE TRUE
a[findD]			#d d 	NA 7
#if one of the elements in the vector has no name (NA); including NA in the index vector will only return NA
names(a)[3] = NA
a 					#a b <NA> d d		1 3    5 NA 7
a[c(NA, "b")]		#<NA> b		NA 3
a[is.na(names(a)) | names(a) == "b"]		#b <NA>		3    5
#if the target vector doesn't contain the names that match the values in the index vector, NA will be returned. Warning & Error Messages will not be produced
a[c("e", "f")]		#<NA> <NA>		NA NA

#Type 5: The index position may be empty
#when the index vector is left empty, all the components of the vector are selected
a[] = 0
a 					#a b <NA> d d 		0 0 0 0 0
#only valid when a already exists as a vector object & it does not change the attributes
#replacement: a index vector is on the LH side of an assignment
x = c(3, 6, NA, -1)
x 					#[1] 3 6 NA -1
x[is.na(x)] = 0
x					#[1] 3 6 0 -1
x[1:3] = 1:3
x					#[1] 1 2 3 -1
x[7] = 8		
x					#[1] 1 2 3 -1 NA NA 8
#an index outside the range of 1,..., length(x)
x[-c(2,5)] = 10
x					#[1] 10 2 10 10 NA 10 10
names(x) = c(NA, letters[1:6])
x					#<NA> a b c d e f 		10 2 10 10 NA 10 10 
x[c(NA, "a")] = 3
x					#<NA> a b c d e f <NA>		10 30 10 10 NA 10 10 3
#missing values create a new element of the vector

#subsetting matrices & arrays - array indexing
#a vector is an array <-> it has dim attribute/dimension vector
x = c(1:20, rep(NA, 4))
dim(x) = c(2, 3, 4)
dimnames(x) = list(d1 = c("i", "ii"), d2 = c("I", "II", "III"), d3 = letters[1:4])
x					#reference documentation in L4

#an array is still a vector, we can use vector indexing method
x[3:6]				#[1] 3 4 5 6
x[!is.na(x)]		#[1] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
#or we can use separate indices, separated by commas
x[1,2,3]			#[1] 15
#element extracted from 1st row, 2nd column, 3rd page of array x
x[2,1, 2:3]			#b c 	8 14
#2nd row, 3rd column, 2nd/3rd page of array x

#for a k-fold indexed array, any of the 5 forms of indexing is allowed in each index position
#for empty index, the range = full range for the index position
# x is 2x3x3 -> x[, c("I", "III"), -c(2,4)] is 2x2x2
x[, c("I", "III"), -c(2,4)]
#if character values in a character index do not match with any of the values in dimname attributes, an "subscript out of bounds" error message will be produced

#dropping indices
square.matrix
#example: create a 3x1 matrix by subsetting the 1st column
single = square.matrix[,1]
single				#[1] 1 2 0
dim(single)			#NULL
#if the index range reduced to 1 value, dim is removed
#set drop option to F override it
single = square.matrix[, 1, drop = F]
single				#reference documentation in L4 
dim(single)			#[1] 3 1 