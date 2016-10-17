/* Chapter 8: Useful SAS Procedures */

*Restructuring Datasets using the TRANSPOSE Prodcedure
PROC TRANSPOSE <DATA=input-data-set>
		<DELIMITER=delimiter>
		<LABEL=label>
		<LET>
		<NAME=name>
		<OUT=output-data-set>
		<PREFIX=prefix>
		<SUFFIX=suffix>
	BY <DESCENDING> variable-1
		<DESCENDING> variable-n
	COPY variable(s)
	ID variable
	IDLABEL variable
	VAR variable(s)
RUN;
/*
Program 8.1
*/
data dat1;
	input s_name $ s_id $e1-e3;
	label e1 = English1
		e2 = English2
		e3 = English3;
	datalines;
John A01 89 90 92
Mary A02 92 . 81
;
proc transpose data=dat1
				out=dat1_out1
				label=labelname
				name=varname
				delim=_;
			var e1-e3;
			id s_name s_id;
			idlabel s_id;
run;

proc print data=dat1_out1;
run;

proc contents data=dat1_out2;
run;
*Tranposing an entire data set
By default, w/o specifying the names of the transposing variables, all the numeric variables from the input data set are transposed
SUFFIX= option: attach a suffix;

/*
Program 8.2
*/
proc sort data=dat1
			out=dat1_sort;
	by s_name;
run;

proc transpose data=dat1_sort
				out=dat1_out3
				name=varname
				label=TEST;
	by s_name;
	copy s_id;
run;
*Must sort then transpose
COPY statement: copy variable(s) from the input data set directly to the transposed data set
ID statement: used to specify the variable from the input data set that contains the values to rename the transposed variables;

/*
Program 8.3
*/
proc transpose data=dat1_sort
				out=dat1_out3
				name=varname
				label=TEST;
	by s_name;
	id s_id;
run;
*Where the ID statement does not work for transposing BY-Groups
You are using the ID variable (contains 2 values) to name the transposed variable that was supposed to occupy only 1 column;

/*
Program 8.4
*/
proc sort data=dat2
			out=dat2_sort;
	by s_name;
run;
proc transpose data=dat2_sort;
				out=dat2_out1;
	var score;
	by s_name;
run;
*Where the ID statement is essential for transposing BY-Groups;
proc transpose data=dat2_sort
	out=dat2_out2 (drop=_name_)
	prefix=test_;
	var score;
	by s_name;
	id exam;
run;
*Without a user-defined prefix the output would be incorrect;

*Handling duplicated observations by using the LET option
LET option: keep the last occurrence of a particular ID valye w/in either the entire data set or a BY group;
/*
Program 8.5
*/
proc transpose data=dat3_sort
		out=dat_out (drop=_name_)
		prefix=test_
		let;
	var score;
	by s_name;
	id exam;
run;

*Handling duplicated observations by using the LET option;
/*
Program 8.6
*/
proc sort data=dat3
			out=dat3_sort;
	by s_name exam score;
run;

proc transpose data=dat3_sort
			out=dat3_out (drop=_name_)
			prefix=test
			let;
	var score;
	by s_name;
	id exam;
run;
*Keep the maximum score w/in each exam;

*Handling duplicated observations by using the LET option;
/*
Program 8.7
*/
proc sort data=dat3
			out=dat3_sort;
	by s_name exam
		descending score;
run;

proc transpose data=dat3_sort
			out=dat3_out (drop=_name_)
			prefix=test
			let;
	var score;
	by s_name;
	id exam;
run;
*Keep the minimum score w/in each exam;

*Situations requiring 2+ transpositions
To transpose from Dat4 -> Dat4_Transpose, we need a "transitional" data set;
/*
Program 8.8
*/
*Step1;
proc sort data=dat3
			out=dat4_sort1;
	by s_name;
run;

proc transpose data=dat4_sort1
				out=dat4_out1;
	by s_name;
run;
*Step2;
data dat4_out1a;
	set dat4_out1;
	test_num=substr(_name_,2);
	class=substr(_name_,1,1);
run;
*Step3;
proc sort data=dat4_out1a
			out=dat4_sort2;
	by test_num s_name;
run;
*Step4;
proc transpose
		data=dat4_sort2
		out=dat4_out2 (drop=_name_)
		delimiter=_;
	by test_num;
	var col1;
	id name class;
run;