/* Chapter 7: Combining Data Sets */

*Vertically combining data sets
Concatenating: combining multiple data sets, 1 after the other, into a single data set;
/*
Program 7.1
*/
data ex7_1;
	set record1 record2;
run;
title 'Concatenating record1 and record2';
proc print data=ex7_1;
run;
*If the common vars have diff: type attributes -> an error message, length, label, format, or informat attributes -> SAS uses the attribute from the 1st data set;

*The RENAME= data set option:
RENAME=(old-name-1=new-name-1
	<...old-name-n=new-name-n>);
/*
Program 7.2
*/
data ex7_2;
	length Course $ 7;
	set record1 record2 (rename=(grade=score));
run;
title 'Renaming the GRADE variable before concatenating the data';
proc print data=ex7_2;
run;

*Interleaving: utilizing BY-group processing w/the SET statement to combine 2+ data sets vertically
SET data-set(s)
BY variable(s);
/*
Program 7.3
*/
proc sort data=record1 out=record1_sort;
	by Name;
run;

proc sort data=record2 out=record2_sort;
	by Name;
run;

data ex7_3;
	length Course $ 7;
	set record1_sort record2_sort;
	by Name;
run;

*Horizontally combining data sets 1-to-1 reading
1-to-1 reading utilizes multiple SET statements to combine observations from 2+ input data sets independently, forming 1 observation that contains all of the variables from each contributing data set
Observations are combined based on their relative position in each data set
SET data-set-1
SET data-set-2;
/*
Program 7.4
*/
data ex7_4;
	set record1;
	set record2;
run;

*Using the IF/THEN statement w/a SET statement to merge 1 single value w/a data set;
/*
Program 7.5
*/
proc means data=record1 noprint;
	var score;
	output out=record1_mean mean=mean_score;
run;

proc print data=record1_mean;
run;

data ex7_5;
	set record1;
	if _n_=1 then set record1_mean(keep=mean_score);
run;

title 'Use One-to-one reading to merge the mean score w/record1';
proc print data=ex7_5;
run;
*Using SET & IF statements together ensures that SAS will not encounter an end-of-file marker that would abruptly terminate the data step;

*One-to-one merging: similar to the results obtained from one-to-one reading, except that one-to-one merging continues processing all observations in all data sets that were named in the MERGE statement
MERGE data-set(s);
/*
Program 7.6
*/
data ex7_6;
	merge record1 record2;
run;

*Match-merging: combines observations from 2+ SAS data sets into a single observation according to the values of 1+ common variables
MERGE data-set(s)
BY variable(s)

One-to-one matching: a single observation in 1 data set relating to a single observation from another based on the value of 1+ common variables
One-to-many matching: a single observation in 1 data set is associated w/multiple observations from another data set
Many-to-many matching: multiple observations from each input data set can be related based on values of 1+ common variables;
/*
Program 7.7
*/
proc sort data=record1 out=record1_sort;
	by Name;
run;

proc sort data=record2 out=record2_sort;
	by Name;
run;

data ex7_7;
	merge record1_sort record2_sort;
	by Name;
run;
*The number of observations in the combined data set equals the sum of the largest number of observations in each BY group among all the input data sets;

/*
Program 7.8
*/
data ex7_8;
	merge record1_sort (drop=course rename=(score=Math_score))
		record2_sort (drop=course rename=(grade=English_score));
	by Name;
run;
title 'An improved approach to merge record1 and record2';
proc print data=ex7_8;
run;

*Using the IN= data set option to include/exclude observations:
IN=variable
 the VARIABLE a temporary variable
 the VARIABLE equals 1 if the input data set contributes to the current observation in the PDV otherwise, its value equal 0
 the IN= data set option can also be used w/the MERGE, SET, MODIFY, and UPDATE statements;
/*
Program 7.9
*/
data ex7_9;
	merge record1_sort (drop=course rename=(score=Math_score) in=in_record1)
		record2_sort (drop=scourse rename=(grade=English_score) in=in_record2);
	by Name;
	if in_record1 and in_record2;
run;
title 'Excluding unmatched observations';
proc print data=ex7_9;
run;

*Use the UPDATE statement to update a master data set w/a transaction data set

UPDATE master-data-set
	transaction-data-set
BY variable(s)

The master-data-set contains the original information
The transaction-data-set contains new information
# of obs. in the resulting data set = # of obs. in the master data set + # unmatched obs. in the transaction data set
When the transaction data set contains duplicate values of the BY variable, only the last values that are copied to the PDV are written to the output data set
If the master data set contains duplicate values of the BY variable, only the 1st observation in the master data set is updated
Updating data sets is similar to match-merged w/the MERGE statement
Missing values in the transaction data set do not replace the existing values in the master data set;
/*
Program 7.10
*/
proc sort data=record3 out=record3_out;
	by Name;
run;

data ex7_10;
	update record2_sort record3_sort;
	by name;
run;



