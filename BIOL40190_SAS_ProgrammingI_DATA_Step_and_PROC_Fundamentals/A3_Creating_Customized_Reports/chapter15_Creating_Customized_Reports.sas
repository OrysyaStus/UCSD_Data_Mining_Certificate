/* Chapter 15 */

libname learn "/courses/dc4508e5ba27fe300/c_629/saslib" access=readonly;
options fmtsearch=(learn);

*PROC REPORT is a procedure that can generate basic data displays ie. PROC PRINT, but it has features & controls 
that enable you to create more sophisticated output as well;

/* 15.1 Introduction */
*Program 15-1 Listing of MEDICAL using PROC PRINT - page 288;
title "Listing of Data Set MEDICAL from PROC PRINT";
proc print data=learn.medical;
   id Patno;
run;

/* 15.2 Using PROC REPORT */
*PROC REPORT is an interactive procedure by default, so once you submit & run the code, an interactive editor 
window opens up;
*To turn off this feature, the option NOWIINDOWS(or NOWD) is used on the PROC REPORT line - always include 
NOWD in code for this course;
*By default, variable labels (if they exist) are used as the column headers in PROC REPORT vs. PROC PRINT 
where the default is to use the variable names as the column headers;

*Program 15-2 Using PROC REPORT (all defaults) - page 289;
title "Using the PROC REPORT";
proc report data=learn.medical nowindows;
run;

/* 15.3 Selecting Variables to Include in Your Report */
*To select the variables that should be included in the output, use the COLUMN (or COLUMNS) statement;

*Program 15-3 Adding a COLUMN statement to PROC REPORT - page 291;
title "Adding a COLUMN Statement";
proc report data=learn.medical nowd;
   columns Patno DX HR Weight;
run;

/* 15.4 Comparing Detail and Summary Reports */
*PROC REPORT handles the default display of numeric variables & character variables differently vs PROC PRINT;
*If PROC REPORT is run on a data set that contains only character variables -or- both character & numeric 
variables (or the COLUMNS statement contains only character variables -or- both character & numeric varaibles), 
the resulting output will be a line by line display of all record (ie. PROC PRINT) = DETAIL report;
*If PROC REPORT is run on a data set that contains only numeric variables (or the COLUMNS statement only 
contain numeric variables), the resulting output will contain a single data line showing the SUM of the values 
of each variable = SUMMARY report;
*W/in PROC REPORT, variables are assigned a variable type which determine how they will appear in the output;
*By default, numeric variables are assigned a type of ANALYSIS w/a summary statistic of SUM, while character 
variables are assigned a type of DISPLAY;
*To control & change the type (as well as other variable attributes), the DEFINE statement is used;
*The variable name is placed in front of the '/' on the DEFINE statement, while the attribute options are 
placed behind the '/';
*Attribute options ie. the variable types, labels, column widths, formats, & data display justification;
*The variable type options are DISPLAY, ANALYSIS, GROUP, ORDER, ACROSS, and COMPUTED;
*To add a label to a variable, put the label in quotation marks;
*To control the width of the column use the width='n' option;

*Program 15-4 Using PROC REPORT with only numeric variables - page 292;
title "Report with Only Numeric Variables";
proc report data=learn.medical nowd;
   column HR Weight;
run;
*By default, numeric variables are assigned a type of ANALYSIS w/a summary statistic of SUM & the resulting 
output will contain a single data line showing the SUM of the values of each variable;

*Program 15-5 Using DEFINE statements to define a display usage - page 292;
title "Display Usage for Numeric Variables";
proc report data=learn.medical nowd;
   column HR Weight;
   define HR / display "Heart Rate" width=5;
   define Weight / display width=6;
run;
*By adding DEFINE statements for each variable, we can control the resulting data display;
*Although HR & Weight are numeric variables, they are specified as DISPLAY variables on the DEFINE statement;
*A width option can be specified to control the width of the column. Finally, a label placed in quotation 
marks can be specified to override the variable label that may be stored on the data set;

/* 15.5 Producing a Summary Report */
*The variable type GROUP is used to create a report having the data displayed/summarized by the categories 
of certain variables (the grouping variables) ie. using the BY/CLASS statement in other procedures;
*To change the summary statistic on an ANALYSIS variable, list the statistic keyword after the word ANALYSIS;

*Program 15-6 Specifying a GROUP usage to create a summary report - page 293;
title "Demonstrating a GROUP Usage";
proc report data=learn.medical nowd;
   column Clinic HR Weight;
   define Clinic / group width=11;
   define HR / analysis mean "Average Heart Rate" width=12
               format=5.;
   define Weight / analysis mean "Average Weight" width=12
                   format=6.;
run;
*The variable CLINIC is defined as a GROUP variable, causing the data to be summarized/collapsed based on the 
values of the GROUP variable, so that the report contains 1 row/unique GROUP variable value;
*HR & WEIGHT columns will contain the MEAN value of those variables as calculated for that value of CLINIC;

/* 15.6 Demonstrating the FLOW Option of PROC REPORT */
*To display a long text variable, the FLOW option can be added to the DEFINE statement to enable world wrapping;
*To control the breakpoints in the data (& in the labels), the SPLIT='split character' option is added to the 
PROC REPORT statement;
*By default, in PROC REPORT, the split character is '/' thus is there are backaslashes in the data, they will 
not be displayed & will be interpreted as embedded split characters;
*To control the data display justification use RIGHT, LEFT, or CENTER on the DEFINE statement;
*To add a line separator under the column headers, use the HEADLINE option on the PROC REPORT statement;
*To add a blank line btw. the column headers & the 1st line of data, use the HEADSKIP option on the PROC REPORT 
statement;
*To control the width of your output, use the LINESIZE='n'(or LS='n') option on the PROC REPORT statement;
*To control the # of data lines to display on a page, use the PAGESIZE='n' (or PS='n') option on the PROC REPORT 
statement;

*Program 15-7 Demonstrating the FLOW option with PROC REPORT - page 294;
title "Demonstrating the FLOW Option";
proc report data=learn.medical nowd headline
            split=' ' ls=74;
   column Patno VisitDate DX HR Weight Comment;
   define Patno     / "Patient Number" width=7;
   define VisitDate / "Visit Date" width=9 format=date9.;
   define DX        / "DX Code" width=4 right;
   define HR        / "Heart Rate" width=6;
   define Weight    / width=6;
   define Comment   / width=30 flow;
run;

*Program 15-8 Explicitly defining usage for every variable - page 296;
title "Demonstrating the FLOW Option";
proc report data=learn.medical nowd headline
            split=' ' ls=74;
   column Patno VisitDate DX HR Weight Comment;
   define Patno     / display "Patient Number" width=7;
   define VisitDate / display "Visit Date" width=9
                      format=date9.;
   define DX        / display "DX Code" width=4 right;
   define HR        / display "Heart Rate" width=6;
   define Weight    / display width=6;
   define Comment   / display width=30 flow;
run;

/* 15.7 Using Two Grouping Variables */
*Just as more than 1 variable can be specified on a BY or CLASS statement, more than one GROUP variable can be 
defined in PROC REPORT;

*Program 15-9 Demonstrating the effect of two variables with GROUP usage - page 296;
title "Multiple GROUP Usages";
proc report data=learn.bicycles nowd headline ls=80;
   column Country Model Units TotalSales;
   define Country  / group width=14;
   define Model    / group width=13;
   define Units    / sum "Number of Units" width=8
                     format=comma8.;
   define TotalSales / sum "Total Sales (in thousands)"
                       width=15 format=dollar10.;
run;
*In this example, the data will be summarized for each unqiue combo of Country & Model that exists in the data;
*Units & TotalSales are ANALYSIS variables & the summary statistic to be reported for these variables is SUM, 
or the sum of the values;

/* 15.8 Changing the Order of Variables in the COLUMN Statement */
*Changing the order of the variables on the COLUMN statement changes the order in which they appear in the 
output;
*The DEFINE statements DO NOT need to be listed in the same order as the variables on the COLUMN statement;

*Program 15-10 Reversing the order of variables in the COLUMN statement - page 298;
title "Multiple GROUP Usages";
proc report data=learn.bicycles nowd headline ls=80;
   column Model Country Manuf Units TotalSales;
   define Country  / group width=14;
   define Model    / group width=13;
   define Manuf    / width=12;
   define Units    / sum "Number of Units" width=8
                     format=comma8.;
   define TotalSales / sum "Total Sales (in thousands)"
                       width=15 format=dollar10.;
run;

/* 15.9 Changing the Order of Rows in a Report */
*Program 15-11 Demonstrating the ORDER usage of PROC REPORT - page 299;
title "Listing from SALES in EmpID Order";
proc report data=learn.sales nowd headline;
   column EmpID Quantity TotalSales;
   define EmpID / order "Employee ID" width=11;
   define Quantity / width=8 format=comma8.;
   define TotalSales / "Total Sales" width=9
                       format=dollar9.;
run;

/* 15.10 Applying the ORDER Usage to Two Variables */
*The variable type ORDER is used to create a report having the data displayed in ascending sorted order;
*To change the sort order to descending sorted order, use the keyword DESCENDING in front of ORDER;
*The data do not need to be sorted (w/PROC SORT) prior to using ORDER in PROC REPORT;

*Program 15-12 Applying the ORDER usage for two variables - page 300;
title "Applying the ORDER Usage for Two Variables";
proc report data=learn.sales nowd headline;
   column EmpID Quantity TotalSales;
   define EmpID / order "Employee ID" width=11;
   define TotalSales / descending order "Total Sales"
                       width=9 format=dollar9.;
   define Quantity / width=8 format=comma8.;
run;

/* 15.11 Creating a Multi-Column Report */
*To create a multi-column report (ie. a newspaper/a telephone book), use the PANELS='n' option on the PROC 
REPORT statement where n is the # of panels (or columns) to display per page;

*Program 15-13 Creating a multi-column report - page 302;
title "Random Assignment - Three Groups";
proc report data=learn.assign nowd panels=99
            headline ps=16;
   columns Subject Group;
   define Subject / display width=7;
   define Group / width=5;
run;

/* 15.12 Producing Report Breaks */
*To produce output w/totals & subtotal on analysis variables, us the RBREAK & BREAK statements;
*Both statements must be followed w/the keywords BEFORE/AFTER;
*Following this, BREAK also requires the name of an ORDER/GROUP variable;
*RBREAK BEFORE places a summary statistic line @ the beginning of the report;
*RBREAK AFTER places a summary statistic line @ the end of the report;

*BREAK BEFORE variablename generates a summary statistic line each time the value of variablename changes & is 
displayed @ the top of subset of data that was used to calculate it;
*BREAK AFTER variablename generates a summary statistic line each time the value of variablename changed & is 
displayed @ the bottom of the subset of data that was used to calculate it;
*Options that can be placed after the '/' include: ;
*OL - prints a single line above the summary statistic line (overline);
*DOL - prints a double line above the summary statistic line;
*UL - prints a single line below the summary statistic line (underline);
*DUL - prints a double line below the summary statistic line;
*SKIP - places a blank line after the summary line;
*SUMMARIZE - prints a summary statistic;
*SUPPRESS - prevents printing of the BREAK variable on the summary line;

*Program 15-14 Requesting a report break (RBREAK statement) - page 303;
title "Producing Report Breaks";
proc report data=learn.sales nowd headline;
   column Region Quantity TotalSales;
   define Region / width=6;
   define Quantity / sum width=8 format=comma8.;
   define TotalSales / sum "Total Sales" width=9
                       format=dollar9.;
   rbreak after / dol dul summarize;
run;

*Program 15-15 Demonstrating the BREAK statement of PROC REPORT - page 304;
title "Producing Report Breaks";
proc report data=learn.sales nowd headline;
   column Region Quantity TotalSales;
   define Region / order width=6;
   define Quantity / sum width=8 format=comma8.;
   define TotalSales / sum "Total Sales" width=9
                       format=dollar9.;
   break after region / ol summarize skip;
run;

/* 15.13 Using a Nonprinting Variable to Order a Report */
*PROC REPORT has a unique feature that allows you to create a data display sorted by the values of a variable 
that do not appear in the output;
*The varibale must be included on the COLUMNS statement & a DEFINE statement must be used;
*The variable must be defined as a GROUP variable, & the NOPRINT option must be specified;

*Program 15-16 Using a non-printing variable to order the rows of a report - page 306;
data temp;
   set learn.sales;
   length LastName $ 10;
   LastName = scan(Name,-1,' ');
run;

title "Listing Ordered by Last Name";
proc report data=temp nowd headline;
   column LastName Name EmpID TotalSales;
   define LastName / group noprint;
   define Name / group width=15;
   define EmpID / "Employee ID" group width=11;
   define TotalSales / sum "Total Sales" width=9
                       format=dollar9.;
run;

/* 15.14 Computing a New Variable with PROC REPORT */
*W/in PROC REPORT, new variables can be defined, calculated, & displayed;
*The new variable name is placed on the COLUMNS statement & calculated w/in a COMPUTE block;
*On the DEFINE statement, the variable type is COMPUTED;
*The COMPUTE block is placed after the DEFINE statement;

*Program 15-17 Computing a new variable with PROC REPORT - page 307;
title "Computing a New Variable";
proc report data=learn.medical nowd;
   column Patno Weight WtKg;
   define Patno / display "Patient Number" width=7;
   define Weight / display noprint width=6;
   define WtKg / computed "Weight in Kg"
                 width=6 format=6.1;
   compute WtKg;
      WtKg = Weight / 2.2;
   endcomp;
run;

/* 15.15 Computing a Character Variable in a COMPUTE Block */
*Creating a character variable w/in PROC REPORT is similar to creating a numeric variable;
*However, the COMPUTE statement must also specify the variable type CHARACTER;

title "Creating a Character Variable in a COMPUTE Block - page 309";
proc report data=learn.medical nowd;
   column Patno HR Weight Rate;
   define Patno / display "Patient Number" width=7;
   define HR / display "Heart Rate" width=5;
   define Weight / display width=6;
   define Rate / computed width=6;
   compute Rate / character length=6;
      if HR gt 75 then Rate='Fast';
	  else if HR gt 55 then Rate='Normal';
	  else if not missing(HR) then rate='Slow';
   endcomp;
run;

/* 15.16 Creating an ACROSS Variable with PROC REPORT */
*To create a report w/nested variables, variable names are listed on the COLUMNS statement w/a comma btw. the 
variables;
*The variables will be stacked in the report in the order in which they appear in the COLUMNS statement;
*Variables which precede a comma are defined as ACRROSS variables in the DEFINE statement;
*The ACROSS variable name/label will be centered above the columns it spans;

*Program 15-18 Demonstrating an ACROSS usage in PROC REPORT - page 310;
***Demonstrating an Across Usage;
title "Demonstrating an ACROSS Usage";
proc report data=learn.bicycles nowd headline ls=80;
   column Model,Units Country;
   define Country    / group width=14;
   define Model      / across "Model";
   define Units      / sum "# of Units" width=14
                       format=comma8.;
run;
*Model is an ACROSS variable meaning that the values of Model will not be placed in a column w/in the report, 
but will span across the report horizontally;

/* 15.17 Modifying the Column Label for an ACROSS Variable */
*If the label/variable name of an ACROSS variable begins & ends w/certain characters such as _-*<>, SAS will 
treat those characters as expansion characters;
*The variable name/label will still be centered above the columns it spans & the expansion characters will be 
repeated before & after the variable name to cover the width of all of the spanned columns;

title2 Changing the Column Heading - page 311;
proc report data=learn.bicycles nowd headline ls=80;
   column Model,Units Country;
   define Country    / group width=14;
   define Model      / across "- Model -";
   define Units      / sum "# of Units" width=14
                       format=comma8.;
run;

/* 15.18 Using an ACROSS Usage to Display Statistics */
*If an ACROSS variable spans analysis variables, the ACROSS variable functions like a GROUP variable & causes 
the statistics to be generated w/in the categories of the ACROSS variable;

title "Average Blood Counts by Age Group - page 312";
proc report data=learn.blood nowd headline;
  column Gender BloodType AgeGroup,WBC AgeGroup,RBC;
  define Gender / group width=8;
  define BloodType  / group width=8 "Blood Group";
  define AgeGroup   / across "- Age Group -";
  define WBC / analysis mean format=comma8.;
  define RBC / analysis mean format=8.2;
run;

/** Working with Missing Values in GROUP, ORDER, and ACROSS variables **/
*By default, when there are missing values in GROUP, ORDER, or ACROSS variables, these will not be 
included/displayed in the output;
*To include missing values, use the MISSING option on the PROC REPORT statement;

data grocmiss;
   input Sector $ Manager Department $ Sales @@;
datalines;
se 1 np1 50    .  1 p1 100   se . np2 120   se 1 p2 80
se 2 np1 40    se 2 p1 300   se 2 np2 220   se 2 p2 70
nw 3 np1 60    nw 3 p1 600   .  3 np2 420   nw 3 p2 30
nw 4 np1 45    nw 4 p1 250   nw 4 np2 230   nw 4 p2 73
nw 9 np1 45    nw 9 p1 205   nw 9 np2 420   nw 9 p2 76
sw 5 np1 53    sw 5 p1 130   sw 5 np2 120   sw 5 p2 50
.  . np1 40    sw 6 p1 350   sw 6 np2 225   sw 6 p2 80
ne 7 np1 90    ne . p1 190   ne 7 np2 420   ne 7 p2 86
ne 8 np1 200   ne 8 p1 300   ne 8 np2 420   ne 8 p2 125
;
run;
 
proc report data=grocmiss nowd headline;
      column sector manager sales;
      define sector / group;
      define manager / group;
      define sales / format=dollar9.2;
      rbreak after / dol summarize;
      title 'Summary Report for All Sectors and Managers - without MISSING option';
run;
*W/o the MISSING option, the observations w/missing values for Sector & Manager (the GROUP variables) ARE NOT included in the output & the calculation of Total;
 
proc report data=grocmiss nowd headline missing;
   title 'Summary Report for All Sectors and Managers - with MISSING option';
   column sector manager sales;
   define sector / group;
   define manager / group;
   define sales / format=dollar9.2;
   rbreak after / dol summarize;
run;
*W/the MISSING option, the observations w/missing values for Sector & Manager (the GROUP variables) ARE included in the output & the calculation of Total;

/** Controlling the output order with the ORDER= option in GROUP, ORDER, and ACROSS variables **/
*By default, the formatted values are used to determine the print order for GROUP, ORDER, & ACROSS variables;
*;

proc format;
  value $dept 
  'np1' = 'reference'
  'np2' = 'science'
  'p1'  = 'non-fiction'
  'p2'  = 'fiction'
        ; 
  value managers 
    1 = 'Kassie'
    2 = 'Edwin'
    3 = 'Jeff'
    4 = 'Lia'
    5 = 'Arturo'
    6 = 'Cheryl'
    7 = 'Ravi'
    8 = 'Ping'
    9 = 'James'
   10 = 'Linda'
      ;   
run;

data grocmissf;
  set grocmiss;
  format department $dept. manager managers.;
run;

proc report data=grocmissf nowd headline missing;
   title 'by default, values of the formatted values are used to order the output';
   column sector manager department sales;
   define sector / group;
   define department / group;
   define manager / group;
   define sales / format=dollar9.2;
   rbreak after / dol summarize;
run;

proc report data=grocmissf nowd headline missing;
   title 'changing the order using the order= option';
   column sector manager department sales;
   define sector / group;
   define department / order=internal group;
   define manager / order=data group;
   define sales / format=dollar9.2;
   rbreak after / dol summarize;
run;
