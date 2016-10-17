/* Chapter 2: Creating Variables Conditionally */
/*  */

*Suppose that you would like to create a var AGE_HI
AGE_HI = 1 for AGE > median(AGE)
AGE_HI = 0 for AGE <= median(AGE);

/*
Program 2.1
*/
title 'Evaluate the Age variable';
PROC MEANS data=hearing n nmiss median mxdec=2;
	var age;
run;
*Examine the vr AGE, if missing values, etc. using PROC MEANS;

/*
Program 2.2
*/
data hearing2_1;
	set hearing;
	if age > 26 then age_hi = 1;
	else age_hi = 0;
run;
*If-then/else statment built;

/*
Program 2.3
*/
title 'Checking AGE_HI is created correctly';
PROC MEANS data=hearing2_1 n missing min max maxdec=2;
	class age_hi;
	var age;
run;
*Checking AGE_HI is created correctly - examines min/max of AGE_HI as well as missing values;

* if age eq . then ...;
*For numeric missing values;
* or use MISSING function - if missing then 1 is not 0;

/*
Program 2.4
*/
data hearing2_2;
	set hearing;
	if missing(age) eq 0 then	
		if age > 26 then age_hi;
		else age_hi = 0;
run;
title 'Creating AGE_HI considering the mising value';
PROC MEANS data=hearing2_2 n nmiss min max maxdec=2;
	class age_hi;
	var age;
run;
*The AGE_HI is correctly created;
*The person with missing age (age=0) was not included in calculations;

/*
Program 2.5
*/
title 'Use the MISSING option to show missing values';
PROC MEANS data=hearing2_2 n nmiss min max maxdec=2 missing;
	class age_hi;
	var age;
run;
*to consider missing values use missing with PROC MEANS;
*missing will consider the missing values to create the class variables;

if missing(age) eq 0 then
	if age > 26 then age_hi = 1;
	else age_hi = 0;

if not (missing(age) eq 1) then
	if age > 26 then age_hi = 1;
	else age_hi = 0;
*TRUE: numerical values other than 0 or the missing value;
*FALSE: the missing value and 0;
if not missing(age) then
	if age > 26 then age_hi = 1;
	else age_hi = 0;

/*
Program 2.6
*/
title 'Check PREG variable';
PROC FREQ data=hearing;
	tables preg/missing nocum nopercent;
run;
*compare numeric value explicitly with 1;
*Assign preg women to group A & non-preg women to group B;
data hearing2_3;
	set hearing;
	if not missing(preg) then	
		if preg then group = "A";
		else group = "B";
run;
title 'Check Group is created correctly';
PROC FREQ data=hearing2_3;
	tables preg*group/missing norow nocol nopercent;
run;

if foo = 10 or 20;
if foo=10 or foo=20;
*write the second one;

*Create a character var (AGE_CAT) based on the AGE variable;
/*
Program 2.7
*/
data hearing2_4;
	set hearing;
	if not missing(age) then
		if age > 26 then age_cat = "old";
		else age_cat = "young";
run;

title 'The first five observations of HEARING2_4 data set';
PROC PRINT data=hearing2_4(obs=5);
	var age age_cat;
run;
*code outputs incorrectly by trunctating young to you since the length of the character vairable is not specified;
*use the length statement to define the variable length & must be placed before any other reference to the variable in the DATA step;

/*
Program 2.8
*/
data hearing2_5;
	length age_cat $ 5;
	set hearing;
	if not missing(age) then
		if age > 26 then age_cat="old";
		else age_cat="young";
run;

title 'The first 5 observations of HEARING2_5 data set';
PROC PRINT data=hearing2_5(obs=5);
	var age age_cat;
run;
*correctly created the age_cat variable when using the length statement;

*To execute a group of statements as 1 unit, use the DO statment
You can nest DO groups with Do groups
Used with If-else statements;
*Create 2 var PREG_INTO & PREG_SMOKER;
/*
Program 2.9
*/
title 'Frequency Table: Preg by Smoke';
PROC FREQ data=hearing;
	tables preg*smoke/missing norow nocol nopercent;
run;
*Examine Preg and Smoke frequencies;
data hearing2_6;
	set hearing;
	if not missing(preg) then
	do;
		preg info = 1;
		if smoke = "current" and preg = 1 then preg_smoker = 1;
		else preg_smoker = 0;
	end;
	else preg_info = 0;
run;

title 'Check if PREG_SMOKER and PREG_INFO are created correctly';
PROC FREQ data=hearing2_6;
	tables preg_smoker preg_info /missprint;
run;
*Freq table created in the end to determine if output is correct;
*Also DO group was used;

*Create a var AGEGROUP based on AGE var;
/*
Program 2.10
*/
data hearing2_7;
	set hearing;

	*method1;
	if age > 30 then agegroup1 = 3;
	else if age > 20 then agegroup1 = 2;
	else if age > . then agegroup1 = 1;
	*threshold values in descending order;

	*method2;
	if not missing(age) then
		if age <=20 then agegroup2 = 1;
		else if age <= 30 then agegroup2 = 2;
		else agegroup2 = 3;
	*threshold values in ascending order;
run;

title 'Check AGEGROUP1 is created correctly';
PROC MEANS data=hearing2_7 missing n nmiss min max maxdec=2;
	class agegroup1;
	var age;
run;

title 'Check AGREGROUP2 is created correctly';
PROC MEANS data=hearing2_7 missing n nmiss min max maxdec=2;
	class agegroup2;
	var age;
run;
*PROC MEANS used to evaluate whether the vars are correctly created;

/*
Program 2.11
*/
data hearing2_8;
	set hearing;
	length trial $4;
	if preg = 1 then do;
		trial = "A";
		requireInfo = 0;
	end;
	else if preg = 0 then do;
		trial = "B";
		requireInfo = 0;
	end;
	else do;
		trial = "Wait";
		requireInfo = 1;
	end;
run;

title 'Checking if TRIAL and REQUIREINFO are created correctly';
PROC FREQ data= hearing2_8;
	tables (trial requireInfo)*preg/missing nocol norow nopercent;
run;
*Created 2 var: TRIAL & REQUIREINFO based on the var PREG;
*Multiple if-else statements with DO statement;


*SAS compares the results from select-expression & when-expression & returns a value of TRUW or FALSE
if it is TRUE for a WHEN statement, the corresponding statement is executed
if it is FALSE, a comparison is performed for either the next when-expression within the current WHEN statement or the 1 in the next WHEN statement
if there is no WHEN-condition that is TRUE, the OTHERWISE statement is executed if 1 exists
if there is no OTHERWISE statement, SAS will issue an error message & terminate DATA step execution
if the comparison is TRUE for more than 1 WHEN statement, only the first WHEN statement is executed
only the when-expression is evaluated & generates a value of TRUE or FALSE
if it is TRUE for a WHEN statement, the corresponding statement is exectuted;
/*
Program 2.12
*/
data dearing2_9;
	set hearing;
	length ehtnic $ 10;
	select (race);
		when ("W", "H") ethnic = "white";
		when ("B", "A") ethnic = "non-white";
	end;
	*If the result of all SELECT-WHEN comparisons is false & no OTHERWISE statement is present, SAS will issue an error message;
	select (preg);
		when (1) do;
			trial = "A";
			drug = "Treatment";
		end;
		when (0) do;
			trial = "B";
			drug = "placebo";
		end;
		otherwise;
	end;
	*OTHERWISE +null statement - this means that if PREG is otehr than 1 or 0, the TRIAL & DRUG variables will be assigned missing values;
	select(hearing);
		when ("yes") group = 1;
		when ("no") group = 2;
		otherwise group = 3;
	end;
	select;
		when (income > 100000) highincome = 1;
		when (income > .) highincome = 0;
		otherwise;
	end;
	*SELECT-EXPRESSIOn is not used;
run;

*Modifying the IF-THEN/ELSE statement with the assignment statement;
/*
Program 2.13
*/
data hearing2_10;
	set hearing;
	agegroup = (age>.) + (age>20) + (age>30);
run;

title 'Check if AGEGROUP is created correctly';
PROC MEANS data=hearing2_10 n nmiss min max maxdec=2 missing;
	class agegroup;
	var age;
run;
*creates the agegroup var by using the assignment statement;