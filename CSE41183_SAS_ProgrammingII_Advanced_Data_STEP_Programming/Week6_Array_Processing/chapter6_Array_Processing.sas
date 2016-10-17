/* Chapter 6: Array Processing */

*6 measurements of SBP for each patient, the missing values are coded as 999
Suppose you would like to recode 999 to periods(.)
Each of the IF statements are almost identical, only the variable names are different
Use a DO loop?;
/*
Program 6.1
*/
data ex6_1;
	set sbp;
	if sbp1 = 999 then sbp1 = .;
	if sbp2 = 999 then sbp2 = .;
	if sbp3 = 999 then sbp3 = .;
	if sbp4 = 999 then sbp4 = .;
	if sbp5 = 999 then sbp5 = .;
	if sbp6 = 999 then sbp6 = .;
run;
*Difference: variable names;

*Situations for utilizing array processing;
/*
Program 6.2
*/
data trial2(drop=rannum);
	id= 'M2390';
	rannum = ranuni(2);
	if rannum > 0.5 then group = 'D';
	else group = 'P';
	output;

	id= 'F2390';
	rannum = ranuni(2);
	if rannum > 0.5 then group = 'D';
	else group = 'P';
	output;

	id= 'F2340';
	rannum = ranuni(2);
	if rannum > 0.5 then group = 'D';
	else group = 'P';
	output;

	id= 'M1240';
	rannum = ranuni(2);
	if rannum > 0.5 then group = 'D';
	else group = 'P';
	output;
run;
*Recall: DO LOOP;
data trial2(drop=rannum);
	do id = 'M2390', 'F2390', 'F2340', 'M1240';
		rannum = ranuni(2);
		if rannum > 0.5 then group = 'D';
		else group = 'P';
		output;
	end;
run;
*Difference: The values of ID variables
The loop iterates along a sequence of values
The index variable holds these values;

*Array: a temporary grouping of SAS variables
If we can group these variables into a single unit -> we can loop along these variables

ARRAY array-name[subscript] <$><length>
	<array-elemts><(initial-value-list)>
does not become part of the output data
must be a SAS name
cannot be the name of a SAS variable
cannot be used in the LABEL, FORMAT, DROP, KEEP, or LENGTH statements
The [subscript] component describes the number of array elements
the simple form is specifying the dimensional size of the array
$ indicates that the elements in the array are character elements
$ is not necesary if the elements have been previously defined as character elements
if the lengths of array elements have not been previously specified, you can use the length option
ARRAY-ELEMENTS are the variables to be included in the array
must eitehr be all numeric or characters

array sbparray[6] sbp1 sbp2 sbp3 sbp4 sbp5 sbp6

you can also provide a range of numbers as [subscript]
array sbparray[1990:1993] sbp1990 sbp1991 sbp1992 sbp1993

you can use a asterick(*) as SUBSCRIPT, you must include ELEMENTS
array sbparray [*] sbp1 sbp2 sbp3 sbp4 sbp5 sbp6

SUBSCRIPT can be enclosed in (parentheses), {braces}, or [brackets]

if ARRAY-ELEMENTS are not specified, for example:
array sbp[6] = array sbp[6] sbp1 sbp2 sbp3 sbp4 sbp5 sbp6
if sbp1-sbp6 were not previously defined in the DATA step, they will be created by the ARRAY statement

array sbp[6] sbp1 sbp2 sbp3 sbp4 sbp5 sbp6 = array sbp[6] sbp1-sbp6
using variable list notation

_NUEMRIC_: all numeric variables
_CHARACTER_: all character variables
_ALL_: all the variables, variables must be either all numeric or character
array num [*] _numeric_
array char [*] _character_
array allvar [*] _all_

you can assign initial values to the array elements
array num[3] n1 n2 n3 (1 2 3)
array chr[3] $ ('A', 'B', 'C')

Temporary arrys contain temporary data elements
They are not output to the output dataset
Using temporary arrays is useful when you want to create an array only for calculation purpose
When referring to a temporary data element, you refer to it by the ARRAYNAME and its SUBSCRIPT
You cannot use the asterick(*) with temporary arrays
They are always automatically retained
To create a temporary array, you need to use the keyword _TEMPORARY_
array num[3] _temporary_ (1 2 3)

To reference an array element:
array-name[subscript]
must be closed in (), [], or {}
is specified as an integer, a numeric variable, or a SAS expression
must be within the lower and upper bounds of the DIMENSION of the array;
/*
Program 6.3
*/
data ex6_2 (drop=i);
	set sbp;
	array sbparray [6] sbp1-sbp6;
	do i = 1 to 6;
		if sbparray [i] = 999 then subarray [i] = .;
	end;
run;
 
*No ned to list array elements is using sbp;
/*
Program 6.4
*/
data ex6_2 (drop=i);
	set sbp;
	array sbp [6];
	do i = 1 to 6;
		if sbparray [i] = 999 then subarray [i] = .;
	end;
run;

*The DIM function returns the number of elements in a specified dimension
It is convenient when you use _NUMERIC_, _CHARACTER_, _ALL_ as array elements
DIM <n>(array-name)
if the N value is not specified, the DIM fxn will return the # of elements in the 1st dimension of the array

The HBOUND fxn returns the upper bound in a specified dimension:
HBOUND<n>(array-name)
The LBOUND fxn returns the lower bound in a specified dimension:
LBOUND<n>(array-name);
/*
Program 6.5
*/
data ex6_3(drop=i);
	set sbp;
	array sbparray[*] _numeric_;
	do i=1 to dim(sbpary);
		if sbpary[i] = 999 then sbpary[i] = .;
	end;
run;

*Create a varible, MISS, which is used to indicate whether SBP1-SBP6 contains missing values
Use IN operator;
/*
Program 6.6
*/
data ex6_4;
	set sbp2;
	array sbpary[*] _numeric_;
	miss = . IN sbpary;
run;

*You can pass an array on to most fxns w/the OF operator
Create 2 variable: SBP_MIN & SBP_MAX:;
/*
Program 6.7
*/
data ex6_5;
	set sbp2;
	array sbpary[*] _numeric_;
	sbp_min = min(of sbpary[*]);
	sbp_max = max(of sbpary[*]);
run;

title 'Using the OP operator to create variables SBP_MIN & SBP_MAX';
proc print data=ex6_5;
run;

/*
Program 6.8
*/
data ex6_6 (drop=i);
	set sbp2;
	array sbp[6];
	array above[6];
	array threshold[6] _temporary_ (140 140 140 120 120 120);
	do i = 1 to 6;
		if (not missing(sbp[i]))
			then above [i] = sbp[i] > threshold[i];
	end;
run;
*Check if row is above average values of column
1st array - Used to group the existing variables: sbp1-sbp6
2nd array - Used to create variables: above1-above6
3rd array - The temporary array is for comparison purposes;

*Calculating products of multiple variables
Approach:
1. Create an array: num[4]
2. Treat missing value as 1
3. Set result=num[1] 
	Loop: i = 2 to 4
		result=result*num[i]
	End Loop;
/*
Program 6.9
*/
data ex6_7(drop=i);
	set product;
	array num[4];
	if missing(num[1]) then result = 1;
	else result = num[1];
	do i = 2 to 4;
		if not missing(num[i])
			then result=result*num[i];
	end;
run;

*Restructuring data sets using 1-dimensional arrays;
/*
Program 6.10
*/
data ex6_8(drop=s1-s3);
	set wide;

	time = 1;
	score = s1;
	if not missing(score) then output;

	time = 2;
	score = s2;
	if not missing(score) then output;

	time = 3;
	score = s3;
	if not missing(score) then output;
run;
*More effective approach would be to utilize array processing;
/*
Program 6.11
*/
data ex6_8(drop=s1-s3);
	set wide;
	array s[3];
	
	do time = 1 to 3;
		score = s[time];
		if not missing(score) then output;
	end;
run;

*Transforms data from long to wide format;
/*
Program 6.12
*/
data ex6_9(drop=time score);
	set long;
	by id;

	retain s1-s3;

	if first.id then do;
		s1 = .; s2 = .; s3 = .;
	end;

	if time = 1 then s1 = score;
	else if time = 2 then s2 = score;
	else s3 = score;

	if last.id;
run;
*Now by using array processing;
data ex6_9(drop=time score);
	set long;
	by id;
	array s[3];
	retain s;

	if first.id then do;
		do i = 1 to 3;
			s[i] = .;
		end;
	end;

	s[time] = score;

	if last.id;
run;