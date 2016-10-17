/* Chapter 16 */

libname learn "/courses/dc4508e5ba27fe300/c_629/saslib" access=readonly;
options fmtsearch=(learn);
*PROC MEANS can be used to generate a basic statistics report & create data sets containing the values of these statistics;
*PROC SUMMARY can be used to generate the same data sets if printed output is not needed;
*PROC SUMMARY is identical to PROC MEANS NOPRINT;

/* 16.2 PROC MEANS-Starting from the Beginning */
*By default, PROC MEANS generates a table of basic statistics (n, mean, std dev, min, max) on all numeric varibles in the data set;
*Adding the VAR statement controls the variables which will appear in the output;
*Statistics that appear in the output can be controlled using options on the PROC MEANS statement;

*Program 16-1 PROC MEANS with all the defaults - page 320;
title "PROC MEANS With All the Defaults";
proc means data=learn.blood;
run;

*Program 16-2 Adding a VAR statement and requesting specific statistics with PROC MEANS - page 322;
title "Selected Statistics Using PROC MEANS";
proc means data=learn.blood n nmiss mean median
                            min max maxdec=1;
   var RBC WBC;
run;
*The requested statistics appear in the ouput in the same order in which they are listed on the PRC MEANS statement;
*The MAXDEC= option is used to control the # of decimal places that are printed;

/* 16.3 Adding a BY Statement to PROC MEANS */
*Adding a BY statement to PROC MEANS causes the statistics to be calculated w/in subsets of the data;
*The subsets are created based on the diff. values in each BY grp.;
*As w/all other procedures, using a By statement in PROC MEANS requires the data to 1st be sorted;

*Program 16-3 Adding a BY statement to PROC MEANS - page 323;
proc sort data=learn.blood out=blood;
   by Gender;
run;

title "Adding a BY Statement to PROC MEANS";
proc means data=blood n nmiss mean median
                            min max maxdec=1;
   by Gender;
   var RBC WBC;
run;
*Adding the BY Gender statement causes the statistics to be calculated separately for each BY group (Females, Males);

/* 16.4 Using a CLASS Statement with PROC MEANS */
*The CLASS statement can be used in place of the BY statement;
*The main advantage to doing this is that the data do not need to be sorted prior to running PROC MEANS;
*The format of the output is slightly diff. but contains the same info;

*Program 16-4 Using a CLASS statement with PROC MEANS - page 324;
title "Using a CLASS Statement with PROC MEANS";
proc means data=learn.blood n nmiss mean median
                            min max maxdec=1;
   class Gender;
   var RBC WBC;
run;

/* 16.5 Applying a Format to a CLASS Variable */
*A format can be added to a CLASS variable by using a FORMAT statement;
*Adding a format to a class variable can be used to change how the CLASS variable groups the data w/o having to change the data in the data set;

*Program 16-5 Demonstrating the effect of a formatted CLASS variable - page 326;
proc format;
   value chol_group
     low -< 200 = 'Low'
     200 - high = 'High';
run;

proc means data=learn.blood n nmiss mean median
           maxdec=1;
   title "Using a CLASS Statement with PROC MEANS";
   class Chol;
   format Chol chol_group.;
   var RBC WBC;
run;

proc means data=learn.blood n nmiss mean median
           maxdec=1;
   title "Using a CLASS Statement with PROC MEANS - no format applied to Chol";
   class Chol;
   var RBC WBC;
run;
*The cholesterol variable value will be categorized into 1 of 2 grps (low & high) using a format. Then applyng this format to the variable in PROC MEANS will cuse the summary statistics to be generated for the 2 grps.;
*Note: this technique also works when using a BY statement instead of a CLASS statement;
*Creating a format & applying it in PROC MEANS allows you to turn a continuous variable into a categorical variable to get meaningful results & to make meaningful comparisons;
*W/o a format applied to Chol, PROC MEANS generates summary statistics for every unique nonmissing value of Chol in the data set;

*The general rule of thumb is to use a CLASS statement vs. a BY statement, since it eliminates the need for a PROC SORT. If the data are already correctly sorted on the values of the BY variables, using a BY statement is moer efficient;

/* 16.7 Creating Summary Data Sets Using PROC MEANS */
*Summary statistics can be routed to data sets by using an OUTPUT statement;
*Adding the NOPRINT option to PROC MEANS statement will cause the ouput to be suppressed & only a data set will be generated;
*Statistics are specified using the same statistics keywords that are used on the PROC MEANS line;
*The statistics keywords on the PROC MEANS line can be the same/diff. than the statistics that will be written to the data set;

*Program 16-6 Creating a summary data set using PROC MEANS - page 327;
proc means data=learn.blood noprint;
   var RBC WBC;
   output out = my_summary
          mean = MeanRBC MeanWBC;
run;

title "Listing of MY_SUMMARY";
proc print data=my_summary noobs;
run;

title without the NOPRINT option, the default output is produced;
proc means data=learn.blood;
   var RBC WBC;
   output out = my_summary
          mean = MeanRBC MeanWBC;
run;
*The mean values of RBC ad WBC will be saved in the variables MeanRBC & MeanWBC in the output data set my_summary;
*By default, there are 2 automatic variables, _TYPE_ & _FREQ_, that are also written to the output data set;
*If the noprint option is removed, the procesure also generates the default output;
*Specifying statistics on the PROC MEANS statement only affects the printed output, there is no effect on the output data set;
*Thus is it possible to generate output that contains diff. statistics than those that are incldede in the output data set;

/* Creating a data set with different statistics than those displayed in the output */

proc means data=learn.blood cv std stderr q1 q3;
   title displaying statistics that are not the same as those in the output data set;
   var RBC WBC;
   output out = my_summary
          mean = MeanRBC MeanWBC;
run;

/* 16.8 Outputting Other Descriptive Statistics with PROC MEANS */
*More than 1 statistic can be written to the output data set;
*Diff. statistics can be selected for each variable on the VAR statement;

*Program 16-7 Outputting more than one statistics with PROC MEANS - page 329;
proc means data=learn.blood noprint;
   var RBC WBC;
   output out = many_stats
          mean     = M_RBC M_WBC
          n        = N_RBC N_WBC
          nmiss    = Miss_RBC Miss_WBC
          median   = Med_RBC Med_WBC;
run;
*Illustrates how to obtain the same statistics for every variable on the VAR statement;

/* Creating a data set that has different statistics for each variable */

data blood;
  set learn.blood;
  label chol=' ';
run;

proc means data=blood; 
   var RBC WBC chol;
   output out = diff_stats
          mean(wbc chol)= dog cat
		  stddev(chol) =
          n        = N_RBC N_WBC
          nmiss    = Miss_RBC Miss_WBC
          median   = Med_RBC Med_WBC;
run;
*Placing the variable name/names inside parentheses following the statistics keyword causes SAS to calculate the requested statistics for only the variables listed rather than all variables on the VAR statement;
*The mean is only calculated for WBS & Chol. The mean of WBC is saved as DOG and the mean of chol is saved in CAT;
*An output variable name is not specified for the std deve of chol, so by default, the ouput variable will have the same name as the input variable (chol);

/* 16.9 Asking SAS to Name the Variables in the Output Data Set */
*Using the AUTONAME option on the OUTPUT statement causes SAS to generate the variable names in the output data set;
*If variable names are specified after statistics-keyword, then those variable names are used;
*However, if not enough of these are specified, AUTONAME will automatically generate the remaining variable names;

*Program 16-8 Demonstrating the OUTPUT option AUTONAME - page 330;
proc means data=learn.blood noprint;
   var RBC WBC;
   output out = many_stats
          mean     =
          n        =
          nmiss    =
          median   = / autoname;
run;

proc means data=learn.blood noprint;
   var RBC WBC;
   output out = many_stats
          mean     = helen gary
          stddev(wbc) = fred
          n        = 
          nmiss    =
          median   = / autoname;
run;

/* 16.10 Outputting a Summary Data Set: Including a BY Statement */
*Adding a BY statement will cause the statistics to be calculated & output by subsetting the data based on the diff. values in each BY grp.;

*Program 16-9 Adding a BY statement to PROC MEANS - page 331;
proc sort data=learn.blood out=blood;
   by Gender;
run;

proc means data=blood noprint;
   by Gender;
   var RBC WBC;
   output out = by_gender
          mean = MeanRBC MeanWBC
          n    = N_RBC N_WBC;
run;

/* 16.11 Outputting a Summary Data Set: Including a CLASS Statement */
*A CLASS statement can also be used in place of the BY statement when creating output data sets;
*The resulting data set is slightly diff. unless the NWAY option is used on the PROC MEANS statement;

*Program 16-10 Adding a CLASS statement to PROC MEANS - page 332;
proc means data=learn.blood noprint;
   class Gender;
   var RBC WBC;
   output out = with_class
          mean = MeanRBC MeanWBC
          n    = N_RBC N_WBC;
run;

*Program 16-11 Adding the NWAY option to PROC MEANS;
proc means data=blood noprint nway;
   class Gender;
   var RBC WBC;
   output out = with_class
          mean = MeanRBC MeanWBC
          n    = N_RBC N_WBC;
run;

/* 16.12 Using Two CLASS Variables with PROC MEANS */
/*
*Program 16-12 Using two CLASS variables with PROC MEANS;
proc means data=learn.blood noprint;
   class Gender AgeGroup;
   var RBC WBC;
   output out = summary
          mean =
          n = / autoname;
run;

proc print data=summary;
  title using two CLASS variables; 
run;

*Program 16-13 Adding the CHARTYPE procedure option to PROC MEANS;
proc means data=learn.blood noprint chartype;
   class Gender AgeGroup;
   var RBC WBC;
   output out = summary
          mean =
          n = / autoname;
run;

proc print data=summary;
  title adding the CHARTYPE option;
run;

*Program 16-14 Using the _TYPE_ variable to select cell means;
title "Statistics Broken Down by Gender";
proc print data=summary(drop = _freq_) noobs;
   where _TYPE_ = '10';
run;

*Program 16-15 Using a DATA step to create separate summary data sets;
data grand(drop = Gender AgeGroup)
     by_gender(drop = AgeGroup)
     by_age(drop = Gender)
     cellmeans;
   set summary;
   drop _type_;
   rename _freq_ = Number;
   if _type_ = '00' then output grand;
   else if _type_ = '01' then output by_age;
   else if _type_ = '10' then output by_gender;
   else if _type_ = '11' then output cellmeans;
run;
*/

*When there are 2+ variables on the CLASS statement, the automatic variable _TYPE_ in the output data set can be used to identify which rows correspond to which combos of the diff. levels of the variables specified in the CLASS statement;
*Modified Program 16-12 Using 3 CLASS variables with PROC MEANS - page 333;
proc means data=learn.blood noprint;
   class Gender AgeGroup bloodtype;
   var RBC WBC;
   output out = summary
          mean =
          n = / autoname;
run;
*There are 3 class variables & we will look @ the values of _TYPE_ in the output data set;

*Modified Program 16-13 Adding the CHARTYPE procedure option to PROC MEANS - page 334;
proc means data=learn.blood noprint chartype;
   class Gender AgeGroup bloodtype;
   var RBC WBC;
   output out = summary
          mean =
          n = / autoname;
run;
*Adding the CHARTYPE option to the code changes the value of _TYPE_ to a character representation of the binary value of _TYPE_;
*The length of the variable equals the # of class variables;
*So now _TYPE_ becomes a variable that contains only the digits 0 & 1, w/as mnay digits as there are CLASS variables;
*A "0" indicates that the variable's levels are not used to stratify the data in the calculation of the statistics on that observation, while a "1" indicates that the variable's levels are used to stratify the data in teh calculation of the statistics on that observation;
*So _TYPE_=011 indicates that the levels of the 2nd (AgeGroup) & 3rd (bloodtype) variables on the class statement are used to stratify the data in the calculation of the statistics on that observation;

*Modified Program 16-14 Using the _TYPE_ variable to select cell means - page 336;
title "Statistics Broken Down by Gender";
proc print data=summary(drop = _freq_) noobs;
   where _TYPE_ = '100';
run;
*The _TYPE_ variable can be used to select results of interest;

*Modified Program 16-15 Using a DATA step to create separate summary data sets - page 336;
data grand(drop = Gender AgeGroup bloodtype)
     by_gender(drop = AgeGroup bloodtype)
     by_age(drop = Gender bloodtype)
     cellmeans;
   set summary;
   drop _type_;
   rename _freq_ = Number;
   if _type_ = '000' then output grand;
   else if _type_ = '010' then output by_age;
   else if _type_ = '100' then output by_gender;
   else if _type_ = '111' then output cellmeans;
run;
*This examples illustrates using the _TYPE_ variable to subset the data in creating new data sets;

/* 16.13 Selecting Different Statistics for Each Variable */
*An output data set does not have to contain every requested statistic for every variable;
*To select the variables, place the variable names inside a set of parentheses behind the statistic keyword;

*Program 16-16 Selecting different statistics for each variable using PROC MEANS - page 337;
proc means data=learn.blood noprint nway;
   class Gender AgeGroup;
   output out = summary(drop = _:)
          mean(RBC WBC) =
          n(RBC WBC Chol) =
          median(Chol) = / autoname;
run;
*Using colon wildcar notation, The colon modifier ':' used w/a character string can be used as shorthand notation to select variables based on patten matching;
*ie. response: would select variables response1, response2,...,response_tot;
*ie. :cat would select variables acat, bcat, ccat, totcat;