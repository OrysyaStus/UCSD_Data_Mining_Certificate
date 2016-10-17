/* Orysya Stus		SAS Programming: Programming Assignment 2 */

/*
1-6 – Create the data set STUDY using your corrected code for Assignment 1.
*/

proc format;
  value sex 
    1=Female 
    2=Male
     ;
  value race 
    1=Asian 
    2=Black 
    3=Caucasian 
    4=Other
     ;
run;

*1. Read in the data in suppTRP-1062.txt, use the csv file method for reading in data;
data STUDY;
	*length Site $1 Pt $2;
	infile "/courses/dc4508e5ba27fe300/c_629/suppTRP-1062.txt" dsd missover;
	input site : $1.
		pt : $2.
		sex
		race
		dosedate : mmddyy10.
		height
		weight 
		result1-result3;
	format dosedate mmddyy10.;
*2. Using if-then statements and data constants, create a new variable called Doselot; 
	if '01JAN1997'd <= dosedate <= '31DEC1997'd then doselot='S0576';
  	else if '31DEC1997'd < dosedate <= '10JAN1998'd then doselot='P1122';
  	else if dosedate > '10JAN1998'd then doselot='P0526';

*3. Create 2 new variables called prot_amend and limit that meet the criteria below;
	if doselot='P0526' then do;
    	prot_amend='B';
    	if sex=1 then limit=0.03;
    	else if sex=2 then limit=0.02;
  	end;
  	else if doselot = 'S0576' or doselot='P1122' then do;
    	prot_amend='A';
    	limit=0.02;
  	end;

*4. Using a select statement, use the variable Site to create a new variable called site_name which contains the name of the Study Site;
length site_name $30;
	select;
		when (Site = 'J') site_name = 'Aurora Health Associates';
		when (Site = 'Q') site_name = 'Omaha Medical Center';
		when (Site = 'R') site_name = 'Sherwin Heights Healthcare';
		otherwise site_name = .;
	end;
*5. Create and apply formats to the Sex and Race variables;

	format sex sex. race race. dosedate date.;


*6. Using the descriptive information provided previously, create labels for these variables;
  	label site='Study Site' 
        pt='Patient'
        dosedate='Dose Date'
        doselot='Dose Lot'
        prot_amend='Protocol Amendment'
        limit='Lower Limit of Detection'
        site_name='Site Name';
run;

/*
7 – DEMOG1062 is a permanent SAS data set located on the server in the directory
/courses/dc4508e5ba27fe300/c_629/saslib
Create a new data set called PAT_INFO by merging STUDY and DEMOG1062 by their two common variables.
Also add items in 8-12 to PAT_INFO.
Note: Your code should create a single data set called PAT_INFO, which contains the merge code and items 8-12. 
PAT_INFO should contain 15 observations and 21 variables.
Referenced notes on Ch.4 & Ch. 10
*/

libname mydata "/courses/dc4508e5ba27fe300/c_629/saslib" access=readonly;
proc sort data=mydata.demog1062 out=demog1062;
   by site pt;

proc sort data=study;
   by site pt;

data PAT_INFO;
   merge study demog1062;
   by site pt;
/*
8 – Using 1 programming statement, create a variable called pt_id by concatenating Site and Pt and adding a 
hyphen between the two variables. 
An example value of pt_id should look like: Z-99. Label the variable ‘Site-Patient’.
If either Site or Pt are missing then pt_id should be missing.
Referenced notes from Ch.12
*/
   if not missing(site) or not missing(pt) then pt_id = catx('-', site, pt);
	else pt_id = .;
	label pt_id = 'Site-Patient';
/*
9 – Using 2 functions (one function will be embedded within the other) to create a variable dose_qtr by 
concatenating the letter ‘Q’ to the number which corresponds to the quarter of the year in which the dose date falls.
Values of dose_qtr should look like Q1, Q2, etc. If the dose date is missing then dose_qtr should be missing.
Use 1 programming statement for this item.
Referenced notes from Ch. 9 & Ch. 12
*/
   if not missing(dosedate) then dose_qtr = cats('Q', QTR(dosedate));
   else dose_qtr = .;
/*
10 – Use a function to create a variable mean_result which is the mean of result1, result2, and result3.
The mean should be calculated using all non-missing values of the three variables.
Format mean_result to 2 decimal places.
Referenced notes from Ch. 11
*/
	mean_result = mean(result1, result2, result3); 
	format mean_result 5.2;
/*
11 – Create a variable BMI which is calculated as: Weight ÷ (Height)2 x 703
If either Weight or Height are missing then BMI should be missing.
Format BMI to 1 decimal place.
References notes from Ch. 11
*/
	BMI = weight/(height)**2 *703;
	format BMI 4.1;
/*
12 – Create a variable est_end which is the Estimated Termination Date for the patient. Use an assignment statement. 
Do not use a function. If Protocol Amendment is missing then est_end should be missing.
If Protocol Amendment is A then est_end is 120 days after Dose Date.
If Protocol Amendment is B then est_end is 90 days after Dose Date.
Apply a format so that the est_end is displayed as mm/dd/yyyy.
Label the variable ‘Estimated Termination Date’.
Referenced notes from Ch.9
	*/
	if prot_amend = 'A' then est_end = dosedate + 100;
	if prot_amend = 'B' then est_end = dosedate + 90;
	else if missing(prot_amend) then est_end = .;
	format est_end mmddyy10.;
	label est_end = "Estimated Termination Date";
run;

/*
13 – Using the data set PAT_INFO, generate the following output using PROC PRINT:
References notes from Ch. 14
*/
proc print data= PAT_INFO label double;
	title "Listing of Baseline Patient Information for Patients Having Weight > 250";
	where weight gt 250;
	by site site_name;
	id site site_name;
	var pt age sex race height weight dosedate doselot;
	label site = "Study Site"
		site_name = "Site Name"
		pt = "Patient"
		AGE = "Age"
		sex = "Sex"
		race = "Race"
		height = "Height"
		weight = "Weight"
		dosedate = "Date of First Dose"
		doselot = "Dose Lot Number";
	format dosedate mmddyy8.;
run; 

/*
14 – Use the data set PAT_INFO and one PROC MEANS to do the following:
Create output stratified by Sex for the variables Result1, Result2, Result3, Height, and Weight.
The display should show the number of non-missing values, mean, standard error, minimum value, maximum value 
and be formatted to one decimal point.
Also create an output data set that contains the median value of Weight stratified by Sex.
The variable that contains the median value of weight should be called med_wt.
Your output data set should contain two observations and two variables, Sex and med_wt.4.
Referenced notes from Ch. 16
*/
proc means data= PAT_INFO n mean stderr min max maxdec=1 nonobs nway;
	class sex;
	var result1 result2 result3 height weight;
	output out = weight_by_sex (drop = _:)
		median (sex weight) = Sex med_wt;
run;

/*
15 – Combine the data sets PAT_INFO and the output data set from item 14 by the variable Sex and 
create a new variable called wt_cat as follows:
If the patient’s weight is less than or equal to the median weight for all patients of that sex, then wt_cat=1.
If the patient’s weight is more than the median weight for all patients of that sex, then wt_cat=2.
Label this variable 'Median Weight Category'.
Create and apply a descriptive format to wt_cat:
For wt_cat=1, the descriptor is ‘<= Median Weight’
For wt_cat=2, the descriptor is ‘> Median Weight’
Hint: Your new data set should contain 15 observations.
References notes from Ch. 10
*/
proc format;
  value wt_cat
    1= '<= Median Weight'
    2= '> Median Weight'
	;
run;

proc sort data=PAT_INFO;
   by sex;

proc sort data=WEIGHT_BY_SEX;
   by sex;

data combine;
   merge PAT_INFO WEIGHT_BY_SEX;
   by sex;
   if weight <= med_wt then wt_cat = 1;
   if weight > med_wt then wt_cat = 2;
   label wt_cat = 'Median Weight Category';
run;

/*
16 – Using your data set from Item 15 and one PROC FREQ to do the following:
Show the frequency distributions of (1) Dose Lot Numbers and (2) Median Weight Category. Exclude missing values 
from the frequency distributions. (3) Generate a two-way table for Race by Weight. Include missing values in the 
frequency distribution.
Use formats to group Race and Weight variables as follows:
If Race is Caucasian then display the race as ‘White’.
If Race is anything else (including missing) then display the race as ‘Other’.
Note: Give this new race format a different name than the race format created in the first part of the assignment.
Group Weight into the following 4 categories: < 200, 200 to < 300, >= 300, Missing
References notes from Ch. 17
*/
proc format;
	value Grouped_race
		3 = 'White'
		1 = 'Other'
		2 = 'Other'
		4 = 'Other'
		. = 'Other';
	value Grouped_weight
		low-200 = 1
		200-300 = 2
		300-high = 3
		. = 4;
run;
		
proc freq data= combine order= formatted;
	tables doselot wt_cat;
	tables race * weight / missing;
	format race Grouped_race. weight Grouped_weight.;
run;

/*
17 – Using your data set from Item 15 and one PROC UNIVARIATE to do the following:
Generate summary statistics for Height stratified by Median Weight Category.
Identify the extreme values using the Site-Patient identifier variable.
*/
proc sort data= combine;
  by wt_cat;
run;

proc univariate data= combine;
  var height;
  by wt_cat;
  id pt_id;
run;
