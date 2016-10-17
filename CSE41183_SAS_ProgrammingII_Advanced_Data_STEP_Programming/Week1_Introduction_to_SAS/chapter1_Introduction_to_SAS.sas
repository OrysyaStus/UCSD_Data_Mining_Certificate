/* Chapter 1: Introduction to SAS */
/* A review of SAS code */

/*
Program 1.1
*/
libname saslib 'W:\SAS Book\dat';
libname desktop 'C:\Documents and Settings\Desktop';
data noise1;	*creates NOISE1.SAS7BDAT in the library WORK;
	set saslib.noise;
run;
*temporary dataset;

data desktop.noise1; /*becomes NOISE1.SAS7BDAT on C:\Documents and Settings\Desktop */
	set saslib.noise;
run;
*permanent dataset in desktop;

/*
Program 1.2
*/
data hearing;
	infile "W:\SAS_BOOK\dat\hearing.txt";
	input id $ 1-4 race $ 6 smoke $ 8-14
		Age 16-17 Preg 19 Hearing $ 21-23
		Income 25-30;
run;
*Syntax for column input method
$ is used when creating character names for character values;

data hearing_small;
	input id $ 1-4 race $ 6 smoke $ 8-14
		Age 16-17 Preg 19 Hearing $ 21-23
		Income 25-30;
datalines;
629F	H	past	26	0		35000
656F	W	never	26	1	no	48000
711F	W	never	32	1	no	30000
733F	W	current	17	0		59000
135F	B	current	29	1	no	120000
982F	W	past	26	1	yes	113000
;
*If dataset is small can input the data manually;
*If the data contains a semicolon use DATLINES4 instead of DATALINES & use 4 consecutive semicolons instead of 1 at the end;

/*
Program 1.4
*/
data score;
	input ID $ 1-4 score1 6-7 score2 9-10 score3 12-13;
	score_sum1 = score1 + score2 + score3;
	*missing values cause the answer to be missing as well;
	score_sum2 = sum(score1, score2, score3);
	*missing values treated as zero therefore the resulting answer will not be zero;
datalines;
629F	5	6	9
656F	6	10	9
711F	0	.	3
511F	9	4	10
478F	.	5	3
;

title 'Adding Three Scores By Using + Operator and SUM Function';
proc print data=score;
run;

/*
Program 1.5
*/
title 'The Contents of Hearing Data';
proc contents data=hearing varnum;
run;
*proc contents to display descriptor portion of the hearing dataset;

/*
Program 1.6
*/
proc sort data=hearing out=hearing_sort;
	by race descending preg descending age;
run;
*sorts race is asc, preg in desc, and age in desc order;

/*
Program 1.7
*/
proc sort data=hearing_small out=hearing_small_sort;
	by race;
run;

title 'Print ID SMOKE and AGE variables by RACE';
proc print data=hearing_small_sort noobs;
	by race;
	var id smoke age;
run;
*executes print procedure by specific grouping;

/*
Program 1.8
*/
title 'The Mean Procedure - Class Statement';
proc means data=hearing min median max maxdec=2;
	where race = 'W' or race = 'B';
	class smoke;
	var age;
run;
*separated by each level of the smoke variable;

proc sort data=hearing;
	by smoke;
run;
title 'The Mean Procedure - By Statement';
proc means ata=hearing min median max maxdec=2;
	where race = 'W' or race = 'B';
	class smoke;
	var age;
run;
*using the BY statement for the smoke variable, formats differ between BY and CLASS options;

/*
Program 1.9
*/
title 'No option';
proc freq data=hearing;
	tables preg;
run;
*tabulates the preg variable, with number of missing values displayed at the bottom;

title 'Using MISSING option';
proc freq data=hearing;
	tables preg/missing;
run;
*missing values are treated as 1 category in the frequency table;

title 'Using MISSPRINT option';
proc freq data=hearing;
	tables preg/missprint;
run;
*missing values are included without listing their associated percentages;

/*
Program 1.10
*/
title 'Without LIST option';
proc freq data=hearing;
	tables preg*race*smoke;
run;
*how to create a 3-way contigency table;

title 'With LIST option';
proc freq data=hearing;
	tables preg*race*smoke/list;
run;
*proc freq displays the table in a list format, if list is used;

/*
Program 1.11
*/
data dat1;
	set hearing(keep= id smoke age);
run;
*reads only the specified variables and displays in output;
*check lo to determine if the data was correctly created;

/*
Program 1.12
*/
data dat1;
	set hearing;
	keep id smoke age;
run;
*can use keep statment instead of the keep= dataset option;

/*
Program 1.13
*/
data dat2;
	set hearing (drop= race preg -- income);
run;
*lists all of the variables between preg and income using --;

/*
Program 1.14
*/
data dat2;
	set hearing;
	drop race preg -- income;
run;
*achieves the same result as in Program 1.13 but by using the drop statement;
*if you have more variables to drop that you have to keep, it will be easier for you to use teh KEEP= option or the KEEP statement;

/*
Program 1.15
*/
data dat3 (drop= income);
	set hearing (keep= id income);
	if income > 50000 then income_hi = 1;
	else income_hi = 0;
run;
*where to specify the DROP= and KEEP= data set options and DROP/KEEP statements;

/*
Program 1.16
*/
data dat4 (keep= id race smoke)
	dat5 (keep= id age preg);
	set hearing;
run;
*the DROP= and KEEP= options can be used to apply to either the unput and output data sets;
*however the KEEP and DROP statments apply only to output data sets;

/*
Program 1.17
*/
data hearing1_1;
	set hearing;
	label hearing = Hearing Loss
	income = "People's Income";
run;

title 'Assigning Labels Permanenetly';
proc print data=hearing1_1(obs=5) label;
	var hearing income;
run;
*need to use the label in proc print;

proc contents data=hearing1_1;
run;

/*
Program 1.18
*/
title 'Assign temporary label to RACE variable';
proc means data=hearing1_1 mean median std;
	label race = Ethnicity;
	class race;
	var income;
run;

/*
Program 1.19
*/
data hearing1_2;
	set hearing;
	format smoke hearing $upcase5. income dollar11.2;
run;

title 'Assigning formats to variable';
proc print data=hearing1_2(firstobs=6 obs=12);
	var smoke hearing income;
run;
*The smoke output will be trunctated to 5 characters;