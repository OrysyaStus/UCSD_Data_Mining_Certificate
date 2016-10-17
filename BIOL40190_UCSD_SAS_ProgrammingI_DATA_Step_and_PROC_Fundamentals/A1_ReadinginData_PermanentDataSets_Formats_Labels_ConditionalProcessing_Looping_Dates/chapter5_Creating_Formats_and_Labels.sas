/* Chapter 5 */

/* 5.1 Adding Labels to Your Variables */

*Program 5-1 Adding labels to variables in a SAS data set - page 72;
libname learn "/courses/dc4508e5ba27fe300/c_629/saslib" access=readonly;

data test_scores;
   length ID $ 3 Name $ 15;
   input ID $ Score1-Score3;
   label ID = 'Student ID'
         Score1 = 'Math Score'
         Score2 = 'Science Score'
         Score3 = 'English Score';
datalines;
1 90 95 98
2 78 77 75
3 88 91 92
;
run;

/* 5.2 Using Formats to Enhance Your Output */

*Program 5-2 Using PROC FORMAT to create user-defined formats - page 74;
proc format;
   value $gender 'M' = 'Male'
                 'F' = 'Female'
                 ' ' = 'Not entered'
               other = 'Miscoded';
   value age low-29  = 'Less than 30'
             30-50   = '30 to 50'
             51-high = '51+';
   value $likert '1' = 'Strongly disagree'
                 '2' = 'Disagree'
                 '3' = 'No opinion'
                 '4' = 'Agree'
                 '5' = 'Strongly agree';
   value pets     1 = 'Luna'
                  2 = 'Azuel'
                  3 = 'Killian'
                  6 = 'Charlie';
run;

*Program 5-3 Adding a FORMAT statement in PROC PRINT - page 75;
title "Data Set SURVEY with Formatted Values - page 75";
proc print data=learn.surveyu;
   id ID;
   var Gender Age Salary Ques1-Ques5;
   format Gender      $gender.
          Age         age.
          Ques1-Ques5 $likert.
          Salary      dollar11.2;
run;

/* 5.3 Regrouping Values Using Formats */
 
*Program 5-4 Regrouping values using a format - page 77;
proc format;
   value $three '1','2' = 'Disagreement'
                '3'     = 'No opinion'
                '4','5' = 'Agreement';
run;

*Program 5-5 Applying the new format to several variables with PROC FREQ - page 77;
proc freq data=learn.survey;
   title "Question Frequencies Using the $three Format";
   tables Ques1-Ques5;
   format Ques1-Ques5 $three.;
run;

/* 5.4 More on Format Ranges */

proc format;
   value age low-<30  = 'Less than 30'
             30-<51   = '30 to 50'
             51-high = '51+';
run;

/* 5.6 Permanent Data Set Attributes */

*Program 5-7 Adding label and format statements in the DATA step - page 81;
libname myfmts "/courses/dc4508e5ba27fe300/c_629/saslib" access=readonly;
options fmtsearch=(myfmts);

data mysurvey;
   infile "/courses/dc4508e5ba27fe300/c_629/survey.txt" pad;
   input ID : $3.
         Gender : $1.
         Age
         Salary
         (Ques1-Ques5)(: $1.);
   format Gender      $gender.
          Age         age.
          Ques1-Ques5 $likert.
          Salary      dollar10.0;
   label ID     = 'Subject ID'
         Gender = 'Gender'
         Age    = 'Age as of 1/1/2006'
         Salary = 'Yearly Salary'
         Ques1  = 'The governor doing a good job?'
         Ques2  = 'The property tax should be lowered'
         Ques3  = 'Guns should be banned'
         Ques4  = 'Expand the Green Acre program'
         Ques5  = 'The school needs to be expanded';
run;

*Program 5-8 Running PROC CONTENTS on a data set with labels and formats - page 81;
title "Data set SURVEY";
proc contents data=mysurvey varnum;
run;
/* 5.7 Accessing a Permanent SAS Data Set with User-Defined Formats */

*Program 5-9 Using a user-defined format - page 82;

title "Using User-defined Formats";
proc freq data=learn.survey;
   tables Ques1-Ques5 / nocum;
run;

title Removing Formats;
proc freq data=learn.survey;
   tables Ques1-Ques5 / nocum;
   format Ques1-Ques5;
run;

/* 5.8 Displaying Your Format Definitions */

*Program 5-10 Displaying format definitions in a user-created library - page 83;
title "Format Definitions in the MYFMTS Library";
proc format library=myfmts fmtlib;
run;

*Program 5-11 Demonstrating a SELECT statement with PROC FORMAT - page 84;
proc format library=myfmts fmtlib;
   select age $likert;
run;
