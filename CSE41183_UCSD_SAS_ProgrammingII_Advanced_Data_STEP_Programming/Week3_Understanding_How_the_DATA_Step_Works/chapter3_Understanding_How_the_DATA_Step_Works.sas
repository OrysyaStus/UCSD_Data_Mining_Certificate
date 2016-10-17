/* Chapter 3: Understanding How the DATA Step Works */
/* 
2-phase sequences:
Compilation phase: each statement is scanned for syntax errors
If there is no syntax error -> Execution phase: the DATA step reads and processes the input data
SAS statements in the DATA step:
Declarative statements: provide info to SAS & only take effect during the compilation phase, can be placed in any order w/in the DATA step, ie. LENGTH, FORMAT, LABEL, DROP, KEEP
Executable statements: The order of the statement matters
*/

/*
Program 3.1
*/
data ex3_1;
	infile 'W:\SAS Book\dat\example3_1.txt';
	input name $ 1-7 height 9-10 weight 12-14;
	BMI = 700*weight/(height*height);
	output;
run;
*if data entry error exists, reading in the data by columns is the best means;
*PDV (program data vector) -> memory area where SAS builds its new data set, 1 observation @ a time;
*2 automatic variables in the PDV:
_N_ = 1: 1st observation is being processed
_N_ = 2: 2nd observation is being processed
_ERROR_ = 1: signals the data error of the currently-processed observation, also automatic variable;
*A space is added to the PDV for each variable;
*Newly created BMI variable is added to the PDV;
*D = dropped & K = kept - automatic variables are never written out;
*Checks for syntax errors: invalid variable names, invalid options, incorrect punctuations, misspelled keywords during compilation phase;
*Until infile is selected the table is empty;
*If error is found in reading in data then value set to missing and SAS is notified;
*After each iteration:
1. The SAS sys returns to the beginning of the DATA step
2. The values of the vars in the PDV are reset to missing _N_ = 3;
*SAS goes to next DATA/PROC step when end of line is reached;
*OUTPUT = writed the current observation from the PDV to a SAS dataset immediately, but an implicit OUTPUT is naturally included;
*multiple output statements can be included;
*When reading a raw dataset, SAS sets each var val in the PDV to missing @ the beginning of each iteration of execution, except for: the automatic var, var that are named in the RETAIN/SUM statements, data elements in _TEMPORARY_ array, var created in the options of the FILE/INFILE statement;

/*
Program 3.2
*/
data ex3_1;
	set example1;
	BMI = 700*weight/(height*height);
	output;
run;
*the difference btw reading a raw data set & a SAS data set;

*to prevent the VARIABLE from being initialized each time the DATA step executes, use the RETAIN statement: RETAIN variable <value> ie. for total;
/*
Program 3.3
*/
data ex3_2;
	set sas3_1;
	retain total 0;
	total = sum(total, score);
run;
*the execution phase begins immediately after the completion of the compilation phase;
*the RETAIN statement is declarative statement, it does not execute during the execution phase;

*the SUM staement has the following form: variable+expression;
*it is auto set to 0 @ the beginning of the 1st iteration of the DAT step execution
retained in following iterations
If EXPRESSION is evaluated to a missing val, it is treated as 0;
/*
Program 3.4
*/
data ex3_3;
	set sas3_1;
	total + score;
run;
*Equivalent to program 3.3;

*If the EXPRESSIOn is false: no further statemenets are processed for the observation, the current observation is not written to the data set, the remaining program statements in the DATA step are not executed, SAS immediately returns to the beginning of the DATA step;
/*
Program 3.5
*/
data ex3_4;
	set sas3_1;
	total + score;
	if not missing(score);
run;

title 'Keep observations only when SCORE is not missing';
proc print data=ex3_4;
run;

*Sometimes it is more efficient (or easier) to specify a condition for excluding observations: IF expression THEN DELETE;
/*
Program 3.6
*/
data ex3_5;
	set sas3_1;
	total + score;
	if missing(score) then delete;
run;

*Sometimes you might want to determine when the last observation in an input data set has been read
You can create a temporary var by using the END= option in the SET statement
SET SAS-data-set END=variable
VARIABLE is not added to any new data sets;
/*
Program 3.7
*/
data total_score(keep =  total n);
	set sas3_1 end = last;
	total + score;
	n + 1;
	if last;
run;
title 'Only keep the last observation';
proc print data=total_score;
run;
*To calculate the total score & list total # of observations;
*detecting the end of a data set by using the END= Option;

*Restructuring datasets: data w/1 observation/subject (the wide format) -> data w/multiple observations/subject (the long format);
/*
Program 3.8
*/
data long (drop=s1-s3);
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
*The execution phase begins immediately after the completion of the compilation phase;

*SAS not only stops programs, SAS generates detailed error messages;
*Logic rrors often result in generating an unintended data set & they are difficult to debug;
*1 way to detect a logic error is to use the PUT statement in the DATA step: PUT variable | variable-list | character-string;
/*
Program 3.9
*/
data ex3_4;
	put "1st PUT" _all_;
	set sas3_1;
	put "2nd PUT" _all_;
	total + score;
	put "3rd PUT" _all_;
	if not missing(score);
	put "4th PUT" _all_;
run;