/* Chapter 11 */

libname learn "/courses/dc4508e5ba27fe300/c_629/saslib" access=readonly;

/* 11.2 Functions That Round and Truncate Numeric Values */

*Program 11-1 Demonstrating the ROUND and INT truncation functions - page 191;
data truncate;
   input Age Weight;
   Age = int(Age);
*integer portion of age used in the data set;
   WtKg = round(2.2*Weight,.1);
   Weight = round(Weight);
datalines;
18.8 100.7
25.12 122.4
64.99 188
;
run;

/* 11.3 Functions That Work with Missing Values */

*Program 11-2 Testing for numeric and character missing values
 (without the missing function) - page 192;
data test_miss;
   set learn.blood;
   if Gender = ' ' then MissGender + 1;
   if WBC = . then MissWBC + 1;
   if RBC = . then MissRBC + 1;
*If the above columns are missing (Gender, WBC, RBC) then create a new column which will count the number of missing values where final column will show total number of missed values;
   if Chol lt 200 and Chol ne . then Level = 'Low ';
   else if Chol ge 200 then Level = 'High';
run;

*Program 11-3 Demonstrating the MISSING function - page 192;
data test_miss;
   set learn.blood;
   if missing(Gender) then MissGender + 1;
   if missing(WBC) then MissWBC + 1;
   if missing(RBC) then MissRBC + 1;
   if Chol lt 200 and not missing(Chol) then Level = 'Low ';
*Note: Can use 'not missing' operator on column names;
	else if Chol ge 200 then Level = 'High';
*Generates the same results as Program 11-2 but different syntax;
run;

/** coding missing values in numeric data **/
*Allows for the programmer to customize the display of the missing values in output;

/* 1st method: Use a MISSING statement */
data period_a;
  missing X I;
*Missing values will be encoded with 'X' or 'I';
  input Id $4. Foodpr1 Foodpr2 Foodpr3 Coffeem1 Coffeem2;
  datalines;
1001 115 45 65 I 78
1002 86 27 55 72 86
1004 93 52 X 76 88
1015 73 X 43 I 108
1027 101 127 39 76 79
  ;
run;

* display missing codes using footnotes;
proc print data=period_a;
  title 'Results of Test Period A';
  footnote1 'X indicates TESTER ABSENT';
  footnote2 'I indicates TEST WAS INCOMPLETE';
run;

* display missing codes by creating a format;
proc format;
  value missing .x='Tester Absent'
                .i='Incomplete Test'
				.c='Result not Recorded'
                  ;
*To create a format for numeric missing values, place a period before the missing value character;
run;
*Note: The creating a format allows for ie. 'Tester Absent' to be seen in the data set vs. referenced as in footnotes;

proc print;
  format _numeric_ missing.;
*_numeric_ refers to ALL numeric variables in a data set;
*Note: _character_ refers to ALL character variables in a data set;
*The command: format _numeric_ missing. instructs SAS to aply the format named 'missing' to all numeric variables in a data set;
run;

/* 2nd method: Use an OPTIONS MISSING='value' statement */
options missing="{";
*This method will flag anything within the " " as a missing numeric variable. Must be used before DATA STEP;
*This method should be used if there is only one variable fo missing values, does not need discrimination;

data period_a; 
  input Id $4. @6 Foodpr1 3. @10 Foodpr2 3. @14 Foodpr3 2. @17 Coffeem1 3. @21 Coffeem 3.;
  datalines;
1001 115  45 65  78
1002  86  27 55  72  86
1004  93  52     76  88
1015  73  35 43 112 108
1027 101 127 39  76  79
1070 115  45 65  78   .
*Since the OPTIONS MISSING statement is a global operator, all other missing values will be labeled with '{';
*SAS recognized ' ' as well as '.' above and will replace the values with '{' using the global option above;
  ;
run;

proc print;
run;

/* 11.5 Descriptive Statistics Functions */

*Program 11-4 Demonstrating the N, MEAN, MIN, and MAX functions - page 194;
data psych;
   input ID $ Q1-Q10;
   if n(of Q1-Q10) ge 7 then Score = mean(of Q1-Q10); 
*n - returns the number of nonmissing values;
   MaxScore = max(of Q1-Q10);
   MinScore = min(of Q1-Q10);
   meanscore = mean(Q1,q2,q5);
   std = std(of q2-q5);
*Not listed but: largest - returns the nth largest value;
*With some functions, the argument of a function can be created by using the keyword OP in front of a series of variables written using variable list notation;
datalines;
001 4 1 3 9 1 2 3 5 . 3
002 3 5 4 2 . . . 2 4 .
003 9 8 7 6 5 4 3 2 1 5
;
run;

*Program 11-5 Finding the sum of the three largest values in a list of variables - page 195;
data three_large;
   set psych(keep=ID Q1-Q10);
   SumThree = sum(largest(1,of Q1-Q10),
                  largest(2,of Q1-Q10),
                  largest(3,of Q1-Q10));
*Embedded function (a function within a function), the innermost funciton is evaluated 1st and result is passed to outer function;
*The sum is the outer function and largest is the inner function;
*Find the 1st, 2nd, and 3rd largest value;
run;

/* 11.6 Computing Sums within an Observation */
*When a missing value is encountered in an assignment statement expression, the result will be a missing value;
*When a missing value is encountered in a function, any missing values are ignored and the result is calculated by using only the nonmissing values;

*Program 11-6 Using the SUM function to compute totals - page 197;
data sum;
   set learn.EndOfYear;
   Total = sum(0, of Pay1-Pay12, of Extra1-Extra12);
   tot_by_fcn=sum(of pay1-pay4);
   tot_by_assignment=pay1+pay2+pay3+pay4; 
*Note: using functions ignores the missing value and computes the sum, while using '+' once encounters a missing value the result will be missing;
run;

/* 11.7 Mathematical Functions */

*Program 11-7 Demonstrating the ABS, SQRT, EXP, and LOG functions - page 197;
data math;
   input x @@;
*The '@@'=double trailing @ sign on the INPUT statement, instructs SAS to "hold on" to the current input data line and continue to read data from that line on the next iteration of the data step, rather than moving to the next line of data, the '@@' is needed when you don't instruct how many data values it will need to read on the line(s) of data;
   Absolute = abs(x);
   Square = sqrt(x);
   Exponent = exp(x);
   Natural = log(x);
datalines;
2 -2 10 100
;
run;

/* 11.8 Computing Some Useful Constants */

*Program 11-8 Computing some useful constants with the CONSTANT function - page 198;
data constance;
   Pi = constant('pi');
   e = constant('e');
   Integer3 = constant('exactint',3);
   Integer4 = constant('exactint',4);
   Integer5 = constant('exactint',5);
   Integer6 = constant('exactint',6);
   Integer7 = constant('exactint',7);
   Integer8 = constant('exactint',8);
run;

/* 11.9 Generating Random Numbers */

*Program 11-9 Using the RANUNI function to randomly select observations - page 200;
data subset;
   set learn.blood;
   if ranuni(1347564) le .1;
run;

*Program 11-10 Using PROC SURVEYSELECT to obtain a random sample - page 200;
proc surveyselect data=learn.blood
                  out=subset
                  method=srs
                  sampsize=100;
run;

/* 11.10 Special Functions */
*INPUT - converts character values to numeric values;
*PUT - converts numeric values to a character values;
*DROP - drops variables from a data set;
*KEEP -keeps variables in a data set (dropping all other variables);
*RENAME - renames variables;
*Note: do not use DROP and KEEP at the same line -> if you are dropping many variables and keeping a few, use KEEP and if you are dropping a few variables and keeping many, use DROP;

*Syntax when coding within the data step;
*DROP variablename1 variablename2...variablename'n';
*KEEP variablename1 variablename2...variablename'n';
*RENAME oldvariablename1=newvariablename1 oldvariablename2=newvariablename2;
*If variables are renamed, code within the data step must be written using the NEW variable names;
*If variables are renamed within the data set, code must be written using the OLD variable names;

proc contents data=learn.chars;
run;

*Program 11-11 Using the INPUT function to perform a character-to-numeric conversion - page 202;
data nums;
   set learn.chars (rename=
                   (Height = Char_Height
                    Weight = Char_Weight
                    Date   = Char_Date));
*Options on the SET statement are applied first since it in the incoming data set, with inner function RENAME executed first;
   Height = input(Char_Height,8.);
   Weight = input(Char_Weight,8.);
   Date   = input(Char_Date,mmddyy10.);
   drop Char_Height Char_Weight Char_Date;
*Along with RENAME, DROP is the last statement executed in the data step code;
*DROP deletes the 3 variables from the result set;
run;

proc contents;
run;

*Program 11-12 Demonstrating the PUT function - page 203;
proc format;
   value agefmt low-<20 = 'Group One'
                20-<40  = 'Group Two'
                40-high = 'Group Three';
run;

data convert;
   set learn.numeric;
   Char_Date = put(Date,date9.);
*Format is used with the PUT statement;
   AgeGroup = put(Age,agefmt.);
*Outputted as: 'Group Two';
   Char_Cost = put(Cost,dollar10.);
   drop Date Cost;
run;

proc contents;
run;

/* 11.11 Functions That Return Values from Previous Observations */

*Program 11-13 Demonstrating the LAG and LAGn functions - page 204;
data look_back;
   input Time Temperature;
   Prev_temp = lag(Temperature);
   Two_back = lag2(Temperature);
datalines;
1 60
2 62
3 65
4 70
;
run;

*Program 11-14 Demonstrating what happens when you execute a LAG function conditionally - page 205;
data laggard;
   input x @@;
   if X ge 5 then Last_x = lag(x);
datalines;
9 8 7 1 2 12
;
run;

*Program 11-15 Using the LAG function to compute inter-observation differences - page 206;
data diff;
   input Time Temperature;
   Diff_temp = Temperature - lag(Temperature);
datalines;
1 60
2 62
3 65
4 70
;
run;

*Program 11-16 Demonstrating the DIF function - page 207;
data diff;
   input Time Temperature;
   Diff_temp = dif(Temperature);
datalines;
1 60
2 62
3 65
4 70
;
run;



