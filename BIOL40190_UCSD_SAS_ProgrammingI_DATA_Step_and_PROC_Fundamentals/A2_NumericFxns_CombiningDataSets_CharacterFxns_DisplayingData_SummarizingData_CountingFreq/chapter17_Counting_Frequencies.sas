/* Chapter 17 */

libname learn "/courses/dc4508e5ba27fe300/c_629/saslib" access=readonly;
options fmtsearch=(learn);

*PROC FREQ provides frequency counts of variable values;
*Like PROC MEANS, PROC FREQ can be used to create data sets containing these frequency counts & some statistics;

/* 17.2 Counting Frequencies */
*By default, PROC FREQ generates frequency counts & percentages for all variables in the data set;

*Program 17-1 Counting frequencies: one-way tables using PROC FREQ - page 342;
title "PROC FREQ with all the Defaults";
proc freq data=learn.survey;
run;

/* 17.3 Selecting Variables for PROC FREQ */
*Adding the TABLE (or TABLES) statement controls the variables which will appear in the output;
*The NOCUM option on the TABLES statement suppresses the printing of the cumulative statistics;
*The NOPERCENT option on the TABLES statement suppresses the printing of the percentages;


*Program 17-2 Adding a TABLES statement to PROC FREQ - page 345;
title "Adding a TABLES Statement";
proc freq data=learn.survey;
   tables Gender Ques1-Ques3 / nocum;
run;

/* 17.4 Using Formats to Label the Output */
*Using formatted variables/adding a format statement in the PROC FREQ procedure will generate output which displays the formatted values;

*Program 17-3 Adding formats to Program 17-2 - page 346;
proc format;
   value $gender
      'F' = 'Female'
      'M' = 'Male';
   value $likert
      '1' = 'Strongly disagree'
      '2' = 'Disagree'
      '3' = 'No opinion'
      '4' = 'Agree'
      '5' = 'Strongly agree';
run;

title "Adding Formats";
proc freq data=learn.survey;
   tables Gender Ques1-Ques3 / nocum;
   format Gender $gender.
          Ques1-Ques3 $likert.;
run;

/* 17.5 Using Formats to Group Values */
*Formats can also be used to recategorise/regroup the data based on the formatted values;
*This is the same technique as was seen in PROC MEANS;

*Program 17-4 Using formats to group values - page 348;
proc format;
   value agegroup
      low-<30  = 'Less than 30'
      30-<60   = '30 to 59'
      60-high  = '60 and higher';
   value $agree_disagree
      '1','2' = 'Generally disagree'
      '3'     = 'No opinion'
      '4','5' = 'Generally agree';
run;

title "Using Formats to Create Groups";
proc freq data=learn.survey;
   tables Age Ques5 / nocum nopercent;
   format Age agegroup.
          Ques5 $agree_disagree.;
run;

/* 17.6 Problems Grouping Values with PROC FREQ */
*When missing values are part of an 'OTHER' category created by PROC FORMAT, by default, all values falling into this category will be excluded from the PROC FREQ output;

*Program 17-5 Demonstrating a problem in how PROC FREQ groups values - page 349;
proc format;
   value two
      low-3 = 'Group 1'
      4-5   = 'Group 2'
      other = 'Other values';
run;

title "Grouping Values (First Try)";
proc freq data=learn.grouping;
   tables X / nocum nopercent;
   format X two.;
run;
*A format is created to group the values of X in PROC FREQ output;
*When the keyword 'other' is used in a format ucsd by PROC FREQ, the procedure assigns all values in the category 
to the lowest value found in the data;
*In this case, the smallest value is a missing value, so SAS grps all values in this category into the missing 
category;
*The problem is solved by creating a specific category for missing values in PROC FORMAT;

*Program 17-6 Fixing the grouping problem - page 350;
proc format;
   value two
      low-3 = 'Group 1'
      4-5   = 'Group 2'
      .     = 'Missing'
      other = 'Other values';
run;

title "Grouping Values - fixed";
proc freq data=learn.grouping;
   tables X / nocum nopercent;
   format X two.;
run;
*Rerunning the PROC FREQ code, the correct output is shown;

/* 17.7 Displaying Missing Values in the Frequency Table */
*Sometimes it is desirable to include missing values in the PROC FREQ output (& counts);
*This can be accomplished by adding the MISSING option on the TABLES statement;
*PROC FREQ results w/ & w/o the missing option;
*Notice the impact on the frequency counts & percentages when including/excluding the missing values;

*Program 17-7 Demonstrating the effect of the MISSING option of PROC FREQ - page 351;
title "PROC FREQ Using the MISSING Option ";
proc freq data=learn.grouping;
   tables X / missing;
   format X two.;
run;

title "PROC FREQ Without the MISSING Option";
proc freq data=learn.grouping;
   format X two.;
   tables X;
run;

/* 17.8 Changing the Order of Values in PROC FREQ */
*By default, PROC FREQ orders the output based on teh internal (underlying/raw) data values;
*To change the order, use the ORDER= option on the PROC FREQ statement;
*The values of ORDER are: ;
*INTERNAL - internal/raw data values (default), smallest to largest;
*FORMATTED - formatted values;
*FREQ - frequency of values, largest to smallest;
*DATA - observation order in the data set - useful when working w/data that may be sorted a certain way;

*Program 17-8 Demonstrating the ORDER= option of PROC FREQ - page 353;
proc format;
   value darwin
      1 = 'Yellow'
      2 = 'Blue'
      3 = 'Red'
      4 = 'Green'
      . = 'Missing';
run;

data test;
   input Color @@;
datalines;
3 4 1 2 3 3 3 1 2 2
;
run;

title "Default Order (Internal)";
proc freq data=test;
   tables Color / nocum nopercent missing;
   format Color darwin.;
run;
*Without the ORDER= option, the values are listed in ascending order of the unformatted/underlying data values;
*ie. Yellow is listed 1st, Blue is next, etc.;
*The display can be changed by adding the ORDER= option;

*Program 17-9 Demonstrating the ORDER= formatted, data, and freq options - page 354;
title "ORDER = formatted";
proc freq data=test order=formatted;
   tables Color / nocum nopercent;
   format Color darwin.;
run;

title "ORDER = data";
proc freq data=test order=data;
   tables Color / nocum nopercent;
   format Color darwin.;
run;

title "ORDER = freq";
proc freq data=test order=freq;
   tables Color / nocum nopercent;
   format Color darwin.;
run;
*When ORDER=FORMATTED, the values are listed in ascending order of the formatted values or Blue, Green, etc.;
*When ORDER=DATA, the data are listed in the order in which the values are found in the data. The 1st 4 values in 
the data are 3,4,1,2, so the data are displayed as Red(3), Green(4), Yellow(1), Blue(2);
*When ORDER=FREQ, the data are listed in descending order of frequency. RED is the most frequently occuring value 
so it is listed 1st, followed by the next most frequently occuring value, Blue, then Yellow and Green;

/* 17.9 Producing Two-Way Tables */
*To generate 2-way tabes, an asterick is placed bt. 2 variable names on the TABLES statement;

*Program 17-10 Requesting a two-way table - page 356;
title "A Two-way Table of Gender by Blood Type";
proc freq data=learn.blood;
   tables Gender * BloodType;
run;

/* 17.10 Requesting Multiple Two-Way Tables */
*Multiple 2-way tables can be requested by using parentheses to grp. variabels on the TABLES statement;

proc freq data=learn.blood;
   title 'generating multiple tables';
   tables Gender * (agegroup BloodType);
   tables agegroup*bloodtype;
run;
*3 tables will be generated: Gender by Agegroup, Gender by BloodType, agegroup by bloodtype;

/* 17.11 Producing Three-Way Tables */
*To generate 3-way tables, an asterick is placed btw. the 3 variable names on the TABLES statement;
*Multi-way table requests can generate ALOT of output;
*It is sometimes helpful to use the LIST option on the TABLES statement to compress this output into a more compact table;

*Program 17-11 Requesting a three-way table with PROC FREQ - page 359;
title "Example of a Three-way Table";
proc freq data=learn.blood;
   tables Gender * AgeGroup * BloodType /
          nocol norow nopercent;
run;

title "Example of a Three-way Table - adding the LIST option";
proc freq data=learn.blood;
   tables Gender * AgeGroup * BloodType / list;      
run;
*Note: not all possible combinations of all variables will necessarily be displayed in the output;
*Only the combinations that actually occur in the data are shown;

/** Creating Frequency Data Sets Using PROC FREQ **/
*Counts & frequencies generated by PROC FREQ can be routed to data sets by using an OUT= statement;
*The data set contains the variables on teh tables statement plus the variables COUNT & PERCENT;
*Variables w/cumulative counts & cumulative frequencies are not available;
*Adding the NOPRINT option to the PROC FREQ statement will cause the output to be suppressed & only a data set will be generated;

proc freq data=learn.blood;
   tables Gender*AgeGroup*BloodType / list out=freqout;
run;

/** Performing a Chi-Square Analysis Using PROC FREQ **/
*Chi-square statistics can be generated by PROC FREQ by specifying the appropriate statistics keywords on the TABLES statement;
*CELLCHI2 - individual cell chi-square values;
*CHISQ - overall chi-square value;
*EXPECTED - expected cell counts;

proc freq data=learn.blood;
   tables Gender*AgeGroup*BloodType / chisq cellchi2 expected cmh;  
run;
*When statistics options are added to the PROC FREQ code, an additional table w/the statistical results is displayed underneath the table of the frequency counts;

/** Creating Data Sets with Summary Statistics **/
*To create data sets containing statistics generated by PROC FREQ, an OUTPUT statement must be added;
*The data set will contain the statistics specified on the OUTPUT line;
*Frequency count data from the TABLES statement is not included, but as preivously shown, this data may be output to a data set by using the OUT= option on the TABLES statement;

proc freq data=learn.blood;
   tables Gender*AgeGroup*BloodType / chisq cellchi2 expected cmh out=freqout;  
   output out=freqstats cmh pchi;
run;
*This examples illustrates outputting 2 data sets;
*FREOUT - contains the info. from the TABLES statement;
*FREQSTATS - contains the statistical results;

/* PROC UNIVARIATE */
*Provides descriptive univariate statistics on numeric variables;
*The syntax is very similar to that of PROC FREQ & PROC MEANS & like those procedures, output data sets can also 
be produced;
*Crude data plots can also be obtained from PROC UNIVARIATE;

/* (1) Basic PROC UNIVARIATE */

proc univariate data=learn.blood;
  title;
run;
*By default, PROC UNIVARIATE generated univariate statistics output for all numeric variables in the data set;
*Generates quite a bit of output;

/* (2) Adding VAR and ID statements */
*Adding an ID statement causes the value of the ID variable(s) to be added to the list of Extreme Observations 
to better identify these values;

proc univariate data=learn.blood;
  title Adding VAR and ID statements;
  var rbc wbc;
  id subject;
run;
*Now the Extreme Observations list also includes the value of Subject for each observation listed;
*Caveat: there may be more observations in the data set w/these highest & lowest values, but SAS only prints 
5 of them;
*In the example code, we create a data set that will have duplicate values of the analysis variable;
*Once SAS has identified 5 values, it does not expand the list to accommodate duplicates;

* Example showing that not all highest and lowest values are displayed;

data bp;
  set learn.bloodpressure learn.bloodpressure(drop=gender);
  if gender='' then gender='X';
run;

proc sort;
  by sbp;
run;

proc print;
  title note the 5th lowest & 5th highest values;
run;

title;
proc univariate data=bp;
  var sbp;
  id gender age;
run;

/* (3) Adding a BY or CLASS statement */
*A BY or CLASS statment can be added to obtain univariate statistics for subgroups;
*When a BY statement is used, the data must 1st be sorted;

proc sort data=learn.blood out=blood;
  by gender;
run;

proc univariate data=blood;
  title Using a BY statement; 
  var wbc;
  by gender;
  id subject;
run;

/* (4) Other Options */
*FREQ - generated a frequency table of all the variable values (similar to PROC FREQ output);
*PLOT - produces a stem-&-leaf plot, box plot, & normal probability plot;
*NORMAL - provides test for normality statistics;

proc univariate data=learn.blood freq plot normal;
  title Adding FREQ, PLOT, and NORMAL options;
  var rbc;
  class agegroup;
  id subject;
run;
*Histogram is generated here;
*Adding the NORMAL option adds the test for normality statistics;

/* (5) Adding options to generate output data sets */
*The procedure & conventions for routing statistics to an output data set is the same as for PROC MEANS;

proc univariate data=learn.blood noprint;
   class Gender AgeGroup;
   var rbc wbc chol;
   output out = summary
          mean = m_rbc m_wbc m_chol
          median = goat pig; 
run;

/* 10.6 Combining Detail and Summary Data */
*Data sets created from PROC MEANS, FREQ, & UNIVARIATE are often merged back onto the data sets from which they were derived to enable additional processing;

*Program 10-7 Combining detail and summary data: Conditional SET statement - page 168;
proc means data=learn.blood noprint;
   var Chol;
   output out = means(keep=AveChol)
          mean = AveChol;
run;

data percent;
   set learn.blood(keep=Subject Chol);
   if _n_ = 1 then set means;
   PerChol = Chol / AveChol;
   format PerChol percent8.;
run;
*1st, PROC MEANS is used to create a data set that contains 1 observation w/1 varible, the mean value of cholesterol;
*The data step illustrates the use of the automatic variable _n_ that counts iterations of the data step;
*The 1st time SAS executes the data step code, _n_=1, so the MEANS data set is set into the data step & the variable AveChol is added;
*MEANS is not added for any other iteration of the data step;
*However, since variable values are retained, this has the effect of adding the value on every observation that is read in from LEARN.BLOOD;

/** Combining detail and summary data using a merge **/
*A merge can also be used to combine summary info. back into a data set;

proc means data=learn.blood noprint nway;
   class gender bloodtype;
   var Chol;
   output out = means
          mean = AveChol;
run;

proc sort data=learn.blood out=blood;
  by gender bloodtype;
run;

data percent;
   merge blood means; 
   by gender bloodtype;
   PerChol = Chol / AveChol;
   if chol > avechol then cat='H';
   else if . < chol < avechol then cat='L';
   else if chol ne . then cat='*';
run;
*The data are sorted by gener & bloodtype & then the 2 data sets are merged together on gender & bloodtype;
*The AveChol value on each record is reflective of the AveChol value for all subjects having the same Gender & bloodtype;
*A new variable is also created to indicate if the chol value is higher/lower than the mean value;
