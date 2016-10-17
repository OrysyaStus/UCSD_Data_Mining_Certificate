

libname assign1 'C:\Users\Arthur\Documents\UCSD_courses\Advanced_DATA_step\Assignment\Assignment1';

/*
Problem 1
*/

proc sort data= assign1.caseControl out= caseControl_sort;
	by id case_control;
run;

data result;
	set caseControl_sort;
	by id;
	retain grade_new stage_new;
	if first.id then do;
		grade_new = grade;
		stage_new = stage;
	end;
run;


/*
Problem 2
*/


proc sort data= assign1.q2 out=q2_sort;
	by id descending date;
run;


data last2 (drop=count);
	set q2_sort;
	by id;
	if first.id then count = 0;
	count + 1;
	if count <=2;
run;

proc print data=last2;
run;

