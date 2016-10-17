/* Chapter 14 */

libname learn "/courses/dc4508e5ba27fe300/c_629/saslib" access=readonly;
options fmtsearch=(learn);

/* 14.2 The Basics */ 

*Program 14-1 PROC PRINT using all the defaults - page 262;
title "Listing of SALES";
proc print data=learn.sales;
run;
*This prints all variables & all observations in the data set;
 
/* 14.3 Changing the Appearance of Your Listing */
*Use the VAR statement to select/limit the variables to be included in the output & to control the print order of the variables;
*By default, an Obs column which displays the Observation # is displayed in PROC PRINT output, one way to eliminate the Obs column is to add an ID statement;
*A variable listed on the ID statement should not be also listed on teh VAR statement, otehrwise it will appear twise in teh data display;
*Another way to eliminate the Obs column is to use the noobs option on the PROC PRINT statement;

*Program 14-2 Controlling which variables appear in the listing - page 264;
title "Listing of SALES";
proc print data=learn.sales;
   var EmpID Customer TotalSales;
run;

*Program 14-3 Using an ID statement to omit the Obs column - page 264;
title "Listing of SALES";
proc print data=learn.sales;
   id EmpID;
   var Customer TotalSales;
run;

* Omitting the Obs column using NOOBS option;
title Listing of SALES using the NOOBS option;
proc print data=learn.sales noobs;
   var EmpID Customer TotalSales;
run;

/* 14.4 Changing the Appearance of Values */
*Data can be reformaated by adding a format statement in procedure;
*The format is TEMPORARILY associated with the variable for that procedure only;
*If a variable already has a format PERMANENTLY associated w/it, a new TEMPORARY format can be applied to the variable by using a format statement w/that variable in the procedure;
*To "unformat" a variable w/a PERMANENT format & display the raw data value, include the variable name on a format statment w/o specifying a format;

*Program 14-4 Adding a FORMAT statement to PROC PRINT - page 266;
proc print data=learn.sales;
   title "Listing of SALES";
   id EmpID;
   var Customer Quantity TotalSales;
   format TotalSales dollar10.2 Quantity comma7.;
run;

title;
proc contents data=learn.bicycles;
run;

proc print data=learn.bicycles;
   title "Listing of BICYCLES";
run;

proc print data=learn.bicycles;
   title "Listing of BICYCLES - no formats on totalsales and unitcost";
   format TotalSales unitcost;
run;

/* 14.5 Controlling the Observations That Appear in Your Listing */
*Use a WHERE statement to limit the data that are included in the display;

*Program 14-5 Controlling which observations appear in the listing (WHERE statement) - page 267;
title "Listing of SALES with Quantities greater than 400";
proc print data=learn.sales;
   where Quantity gt 400;
   id EmpID;
   var Customer Quantity TotalSales;
   format TotalSales dollar10.2 Quantity comma7.;
run;

*Program 14-6 Using the IN operator in a WHERE statement - page 267;
title Sales Information for Employees 1843 and 0177;
proc print data=learn.sales;
   where EmpID in ('1843' '0177');
   id EmpID;
   var Customer Quantity TotalSales;
   format TotalSales dollar10.2 Quantity comma7.;
run;

/* 14.6 Adding Additional Titles and Footnotes to Your Listing */
*Up to 10 titles & up to 10 footnotes may be added to your data displays. The more titles & footnotes on your page, the less space available for the data display, so use of many titles & footnotes is not recommended;
*Once issued, these have the effect of canceling all previous title & footnote statements. These have no effect on any new titles and footnotes subsequently created in your program;

*Program 14-7 Adding titles and footnotes to your listing - page 268;
title1 "The XYZ Company";
title3 "Sales Figures for Fiscal 2006";
title4 "Prepared by Roger Rabbit";
title5 "-----------------------------";
footnote "All sales figures are confidential";

proc print data=learn.sales;
   id EmpID;
   var Customer Quantity TotalSales;
   format TotalSales dollar10.2 Quantity comma7.;
run;

*Cancel footnotes;
footnote;

/* 14.7 Changing the Order of Your Listing */

*Program 14-8 Using PROC SORT to change the order of your observations - page 270;
proc sort data=learn.sales out=sales;
   by TotalSales;
run;

title "Listing of SALES";
proc print data=sales;
   id EmpID;
   var Customer Quantity TotalSales;
   format TotalSales dollar10.2 Quantity comma7.;
run;

*Program 14-9 Demonstrating the DESCENDING option of PROC SORT - page 271;
proc sort data=learn.sales out=sales;
   by descending TotalSales;
run;

proc sort data=learn.blood out=blood;
  by descending chol;
run;

/* 14.8 Sorting by More Than One Variable */
*If you want your data displayed in a particular order, you can use PROC SORT to re-sort the data;
*By default the data are sorted in ascending order, so missing values are printed 1st;
*Adding the DESCENDING option in front of a varaible name on the BY statement will revere the sort order, so that the data are sorted in descending order form largest to smallest;
*The descending option only affects the single variable following the word DESCENDING;
*So the word DESCENDING must be placed in front of each variable that you wanted sorted in descending order;
*Note: Since the sort procedure is destructive & overwrites the existing data set, it is almost always good programming practice to use an OUT= option when sorting a permanent data set so that the sorted data are written to a temporary data set;

*Program 14-10 Sorting by more than one variable - page 272;
proc sort data=learn.sales out=sales;
   by EmpID descending TotalSales;
run;

title "Sorting by More than One Variable";
proc print data=sales;
   id EmpID;
   var TotalSales Quantity;
   format TotalSales dollar10.2 Quantity comma7.;
run;

/* 14.9 Labeling Your Column Headings */
*By default, labels on varaibles are not displayed in PROC PRINT output;
*To enable printing of labels, 1 of 2 options must be used on the PROC PRINT statement: (1) the keyword LABEL or (2) the SPLIT ='splitchar' option;
*To add/change a label on a variable, use a LABEL statement w/in the PROC PRINT procedure;

*Program 14-11 Using labels as column headings with PROC PRINT - page 273;
title "Using Labels as Column Headings";
proc print data=sales label;
   id EmpID;
   var TotalSales Quantity;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;

title "Using the SPLIT= option";
proc print data=sales split='!';
   id EmpID;
   var TotalSales Quantity;
   label EmpID = "Corporate!Employee ID"
         TotalSales = "Total Sales!Worldwide"
         Quantity = "Number!Sold!Worldwide";
   format TotalSales dollar10.2 Quantity comma7.;
run;
*The SPLIT='splitchar' option provides a way to control the breakpoints when printing variables w/long labels;
*By default, SAS will use blanks to break long labels for printing;
*By inserting a break character in the label definition & then specifying this character in the SPLIT= definition on any character can be specified as the split character;
*In example above, '!' is used as the split character;

/* 14.10 Adding Subtotals and Totals to Your Listing */
*Using a BY statement in PROC PRINT causes SAS to generate a specially formatted report;
*Using both a BY statment and an ID statment generates anotehr type of report;
*Finally, adding a SUM statement, adds totals & subtotals to the output;

proc sort data=learn.sales out=sales;
   by Region;
run;

title PROC PRINT with a BY statement and no ID statement;
proc print data=sales label;
   by Region;
   var EmpID TotalSales Quantity;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;
*When using a BY statement, the data must always be sorted 1st;
*When used in any procesure, a BY statement always generates output w/dashed lines in the Listing output, teh dashed lines are absent in HTML, PDF, & RTF output;
*Adding an ID statement removes the Obs column;
*When you use a SUM statement & a BY statement w/1 BY variable, PROC PRINT sums the SUM variables for each BY group that contains more than 1 observation & totals them over all BY groups;

*Program 14-12 Using a BY statement in PROC PRINT - page 275;
title "Using Labels as Column Headings";
proc print data=sales label;
   by Region;
   id EmpID;
   var TotalSales Quantity;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;

*Program 14-13 Adding totals and subtotals to your listing - page 276;
title "Adding Totals and Subtotals to Your Listing";
proc print data=sales label;
   by Region;
   id EmpID;
   var TotalSales Quantity;
   sum Quantity TotalSales;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;

/* 14.11 Making Your Listing Easier to Read */
*Using the same variables on both the BY statement & ID statement generates a nicely formatted report;
*Only the 1st occurence of each BY variable is printed;
*In the Listing option, when SAS reaches the end of a BY group, it also skips a line before starting to print the next BY group;

*Program 14-14 Using an ID and BY statement in PROC PRINT - page 278;
proc sort data=learn.sales out=sales;
   by EmpID;
run;

title "Using the Same Variable in an ID and BY Statement";
proc print data=sales label;
   by EmpID;
   id EmpID;
   var Customer TotalSales Quantity;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;

/* 14.12 Adding the Number of Observations to Your Listing */
*Adding the 'N' option on the PROC PRINT statement will cause the total # of observations to be printed @ the end of your output (N = # of observations);

*Program 14-15 Demonstrating the N option with PROC PRINT - page 279;
title "Demonstrating the N option of PROC PRINT - no label";
proc print data=sales n;
   id EmpID;
   var TotalSales Quantity;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;

title "Demonstrating the N option of PROC PRINT with a label";
proc print data=sales n="Total number of Observations:";
   id EmpID;
   var TotalSales Quantity;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;
*'n' is specified here vs. in 1t example;

/* 14.13 Double-Spacing Your Listing */
*Use the DOUBLE option on teh PROC PRINT statement;
*This only has an effect on the output in the LISTING window, it has no impact on the HTML, PDF, & RTF output;

*Program 14-16 Double spacing your listing - page 280;
title "Double Spacing Your Listing";
proc print data=sales double;
   id EmpID;
   var TotalSales Quantity;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;

/* 14.14 Listing the First n Observations of Your Data Set */
*To list the 1st 'n' observations in a data set, use the OBS= option after the data set name on teh PROC PRINT statement;
*To start the list @ a specified observation, use the FIRSTOBS=option;
*To select a specified # of observations starting @ a specific obersation use both options: FIRSTOBS= to define the 1st observation & OBS= to define the last observation;
*In the Listing output, PROC PRINT will attempt to print all variables on a single output line by reducing the amt of white space btw variable columns & printing ariable names vertically;
*To eliminate the possibility of generating output w/variable names listed vertically, use the HEADING=H option on the PROC PRINT statement;

*Program 14-17 Listing the first 5 observations of your data set - page 281;
title "First 5 Observations from SALES";
proc print data=learn.sales(obs=5);
run;

title "Observations from SALES starting with Obs 10";
proc print data=learn.sales(firstobs=10);
run;

title "Observations 6-13 in SALES";
proc print data=learn.sales(firstobs=6 obs=13);
run;

*Program 14-18 Forcing variable labels to print horizontally - page 282;
/* Not a useful example 
title "First 5 Observations from SALES";
proc print data=learn.sales(obs=5) heading=horizontal;
run;
*/

/* Create a data set with many variables */
data manyvars;
  retain ques100-ques200 0;
  set learn.psych;
run;

 proc print;
   title 'column headers appear vertically';
 run;

proc print heading=h;
   title 'column headers appear horizontally';
run;
