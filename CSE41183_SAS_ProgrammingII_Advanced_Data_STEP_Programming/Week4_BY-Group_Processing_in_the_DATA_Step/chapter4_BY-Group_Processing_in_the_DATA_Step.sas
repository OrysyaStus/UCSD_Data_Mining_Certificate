/* Chapter 4: BY-Group Processing in the DATA Step */
/* 
Longitudinal data: multiple observations per subject
Identify the beginning/end of measurement for each object using BY-group processing method

BY-group processing: method of processing records from data sets that can be grouped by the values of 1+ common variables
BY variable: grouping variable
BY value: the value of a BY variable
BY group: all observations with the same BY value

BY-group processing method:
proc sort data=b;
	by by_variable;
run;
data a;
	set b;
	by by_variable;
	...
run;

For each BY-variable, SAS created 2 temp var: FIRST.VARIABLE, LAST.VARIABLE (which are set to 1 @ the beginning of the execution phase)
*/

*Approach:
Initialize TOTAL to 0 when starting to read the first observation of each subject
Accumulate TOTAL by adding the values from SCORE
Output the ID and TOTAL to the output dataset when reading the last observation of each subject;
/*
Program 4.1
*/
proc sort data=sas4_1;
	by id;
run;

data sas4_2 (drop = score);
	set sas4_1;
	by id;
	if first.id then total = 0;
	total + score;
	if last.id;
run;
*1 & 2 & 4;

*A DATA step program that uses by-group processing frequently contains the following:
1. a cumulating variable is initialized to 0 when the FIRST.VARIABLE equals 1
2. a cumulating variable is accumulated w/some values @ every iteration of the DATA step
3. some calculation needs to be performed when the LAST.VARIABLE equals 1
4. the contents of the PDV are outputted only when the LAST.VARIABLE equals 1
5. in adition to the BY variable, an additional variable will also need to be previously sorted. However, only the BY variable is used in the SET statement in the DATA step
;

*Calculating mean score w/in each by group;
/*
Program 4.2
*/
data sas4_mean (drop=score);
	set sas4_1;
	by id;
	if first.id then do;
		total = 0;
		n = 0;
	end;
	total + score;
	n + 1;
	if last.id then do;
		mean_score = total/n;
		output;
	end;
run;

*Creating data sets with duplicate or non-duplicate observations;
/*
Program 4.3
*/
proc sort data=sas4_1;
	by id score;
run;
data sas4_1_s sas4_1_d;
	set sas4_1;
	by id score;
	if first.score and last.score then output sas4_1_s;
	else output sas4_1_d;
run;

*Obtaining the most recent non-missing data w/in each BY-group
This data set PATIENTS contains the TGL measurements & smoking status for patients for diff. time periods
Some patients only have 1 measurement whereas others were measured more than once in different years
Strategy = 1. sort the data by PATID and VISIT 2. use PATID as the BY-variable;
/*
Program 4.4
*/
proc sort data= patients
			out= patients_sort;
	by patid visit;
run;

data patients_single
	(drop= visit tgl smoke);
	set patients_sort;
	by patid;
	retain tgl_new smoke_new;
	if first.patid then do;
		tgl_new = .;
		smoke_new = " ";
	end;
	if not missing(tgl) then tgl_new=tgl;
	if not missing(smoke) then smoke_new=smoke;
	if last.patid;
run;

*Restructing data sets from long format to wide format
Reading 5 observations but only creating 2 observations:
You are not copying data from the PDV to the final dataset @ each iteration
You only need to generate 1 observation once all the observations for each subject have been processed;
/*
Program 4.5
*/
proc sort data=long;
	by id time;
run;

data wide (drop=time score);
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