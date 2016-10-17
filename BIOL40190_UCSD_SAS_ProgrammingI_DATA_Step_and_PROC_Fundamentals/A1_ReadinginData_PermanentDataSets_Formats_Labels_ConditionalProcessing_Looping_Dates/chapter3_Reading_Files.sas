/* Chapter 3 */

/* 3.7 Placing Data Lines Directly in Your Program (the DATALINES Statement) */

*Program 3-5 Demonstrating the DATALINES statement - page 36;
data demographic;
   input Gender $ Age Height Weight;
datalines;
M 50 68 155
F 23 60 101
M 65  72 220
F 35 65 133
M 15 71 166
;
run;

title Program 3-5 Demonstrating the DATALINES statement - page 36;
proc print;
run;

/* The VAR statement is used in many procedures to select variables. */
proc print data=demographic;
  title also note variable order;
  var height gender age;
run;
title;

/* 3.2 Reading Data Values Separated by Blanks */

*Program 3-1 Demonstrating list input with blanks as delimiters - page 31;
data demographics;
   infile "/courses/dc4508e5ba27fe300/c_629/mydata.txt";
   input Gender $ Age Height Weight;
run;

*Program 3-2 Adding PROC PRINT to list the observations in the data set - page 31;
title "Listing of data set DEMOGRAPHICS - page 31";
proc print data=demographics;
run;

/* 3.4 Reading Data Values Separated by Commas (CSV Files) */

*Program 3-3 Reading data from a comma-separated variables (csv) file - page 33;
data demographics;
   infile "/courses/dc4508e5ba27fe300/c_629/mydata.csv" dsd;
   input Gender $ Age Height Weight;
run;

/* 3.5 Using an Alternative Method to Specify an External File */

*Program 3-4 Using a FILENAME statement to identify an external file - page 34;
filename preston  "/courses/dc4508e5ba27fe300/c_629/mydata.csv";

data demographics;
   infile preston dsd;
   input Gender $ Age Height Weight;
run;

/* 3.6 Reading Data Values Separated by Delimiters Other Than Blanks or Commas */

data info;
   infile "/courses/dc4508e5ba27fe300/c_629/colon_delim.txt" dlm=':';
   input Gender $ Age Height Weight;
run;

title;
proc print;
run;

/* 3.8 Specifying INFILE Options with the DATALINES Statement */

*Program 3-6 Using INFILE options with DATALINES - page 37;
data demographics;
   infile datalines dsd;
   input Gender $ Age Height Weight;
datalines;
"M",50,68,155
"F",23,60,101
"M",65,72,220
"F",35,65,133
"M",15,71,166
;
run;

/* adding new variables */

data demographic;
   infile "/courses/dc4508e5ba27fe300/c_629/mydata.txt";
   input Gender $ Age Height Weight;
   *compute BMI;
   BMI=(weight/2.2)/(height*.0254)**2;
run;

proc print;
run;

/* basic statistical procedures */

data pets;
   input gender $ type $ name $ feet;
datalines;
F horse Luna 4
M bird Azuel 2
M bird Killian 1.5
F cat Panther 4
M cat Tiger 4
;
run;

* frequency counts with PROC FREQ ;
proc freq; 
run;

/* TABLES statement generates frequency counts of some variables */
proc freq data=demographic;
  title adding tables statement;
  tables height gender;
run;

/* PROC MEANS - generates basic statistics for variables */

/* Generate statistics on all numeric variables */
/* Since no data set name was specified, the last data set created is used (PETS) */
title what data set was used?;
proc means;
run;

proc means data=demographic;
run;

/* VAR statement selects the variables to be used */
proc means data=demographic;
  var bmi;
run;

/* 3.9 Reading Raw Data from Fixed Columns-Method 1: Column Input */

*Program 3-7 Demonstrating column input - page 38;
data financial;
   infile "/courses/dc4508e5ba27fe300/c_629/bank.txt";
   input Subj     $   1-3
         DOB      $  4-13
         Gender   $    14
         Balance    15-21;
run;

/* 3.10 Reading Raw Data from Fixed Columns-Method 2: Formatted Input */

*Program 3-8 Demonstrating formatted input - page 40;
data financial2;
   infile "/courses/dc4508e5ba27fe300/c_629/bank.txt";
   input @1  Subj         $3.
         @4  DOB    mmddyy10.
         @14 Gender       $1.
         @15 Balance       7.;
run;

*Program 3-9 Demonstrating a format statement - page 42;
title "Listing of FINANCIAL2";
proc print data=financial2;
   format DOB     mmddyy10.
          Balance dollar11.2;
run;

*Program 3-10 Rerunning program Program 3-9 with a different format - page 42;
title "Listing of FINANCIAL2";
proc print data=financial2;
   format DOB     date9.
          Balance dollar11.2;
run;

/* 3.12 Using Informats with List Input */

*Program 3-11 Using INFORMATS with List Input - page 44;
data list_example;
   infile "/courses/dc4508e5ba27fe300/c_629/list.csv" dsd;
   input Subj   :       $3.
         Name   :      $20.
         DOB    : mmddyy10.
         Salary :  dollar8.;
   format DOB date9. Salary dollar8.;
run;

/* 3.13 Supplying an INFORMAT Statement with List Input */

data informat_only;
   informat Subj        $3.
            Name       $20.
            DOB   mmddyy10.
            Salary dollar8.;
   
run;

*Program 3-12 Supplying an INFORMAT with List Input - page 45;
data list_example;
   informat Subj        $3.
            Name       $20.
            DOB   mmddyy10.
            Salary dollar8.;
   infile "/courses/dc4508e5ba27fe300/c_629/list.csv" dsd;
   input Subj
         Name
         DOB
         Salary;
   format DOB date9. Salary dollar8.;
run;

/* 3.14 Using List Input with Embedded Delimiters */

*Program 3-13 Demonstrating the ampersand modifier for list input - page 46;
data list_example;
   infile "/courses/dc4508e5ba27fe300/c_629/list.txt";
   input Subj   :       $3.
         Name   &      $20.
         DOB    : mmddyy10.
         Salary :  dollar8.;
   format DOB date9. Salary dollar8.;
run;

/* Missing Values */

* example 1 - missing value in 2nd data line;
data info;
   input Gender $ Age Height Weight;
datalines;
M 50 68 155
F 60 101
M  65  72 220
F 35 65 133
M 15 71 166
;
run;

* example 1 solution - adding dots for the missing characters in 2nd data line;
data info;
   input Gender $ Age Height Weight;
datalines;
M 50 68 155
. . 60 101
M  65  72 220
F 35 65 133
M 15 71 166
;
run;

* example 2 - missing values at the end of the data line;
data info;
   input Gender $ Age Height Wt1 Wt2 Wt3;
datalines;
M 50 68 155 153 154
F 23 60 101 95 
M 65 72 220 210 215
F 35 65 133 132 134
M 15 71 166 166
;
run;

* example 2 solution - use the missover option;
data info;
   infile cards missover;
   input Gender $ Age Height Wt1 Wt2 Wt3;
cards;
M 50 68 155 153 154
F 23 60 101 95
M 65 72 220 210 215
F 35 65 133 132 134
M 15 71 166 166
;
run;

* example 3 - use column or formatted input;
data info;
   infile cards missover;
   input Gender $1 Age 3-4 @6 Height 2. Wt1 9-11 Wt2 13-15 @17 Wt3 3.;
cards;
M 50 68 155 153 154
F    60 101  95
M    72 220 210 215
F 35 65 133 132 134
M 15 71 166 166
;
run;

/* Additional examples on creating data sets with input statements */

* don't have to read the data in the same order as in the raw file;

data info;
   infile cards missover;
   input Wt1 9-11 Wt2 13-15 @17 Wt3 3. Gender $1 Age 3-4 @6 Height 2.;
cards;
M 50 68 155 153 154
F    60 101  95
M    72 220 210 215
F 35 65 133 132 134
M 15 71 166 166
;
run;

proc print;
title 'note variable order';
run;

* can read and re-read columns;

data info;
   infile cards missover;
   input Gender $1 Age 3-4 @6 Height 2. Wt1 9-11 Wt2 13-15 @17 Wt3 3. sexage $ 1-4 @13 wt26 3.;
cards;
M 50 68 155 153 154
F    60 101  95
M    72 220 210 215
F 35 65 133 132 134
M 15 71 166 166
;
run;

title reading & rereading columns;
proc print;
run;

* don't have to read all the raw data;

data info;
   infile cards missover;
   input @6 Height 2. Wt1 9-11 Gender $1;
cards;
M 50 68 155 153 154
F    60 101  95
M    72 220 210 215
F 35 65 133 132 134
M 15 71 166 166
;
run;

title not reading all data;
proc print;
run;

