/* Chapter 10 */

libname learn "/courses/dc4508e5ba27fe300/c_629/saslib" access=readonly;
options fmtsearch=(learn);

/* 10.2 Subsetting a SAS Data Set */

*Program 10-1 Subsetting a SAS data set using a WHERE statement - page 162;
data females;
   set learn.survey;
   where gender = 'F';
*Creates a subset dataset, only where 'F' exists will results show up;
run;

*Subsetting a SAS data set using a subsetting IF statement;
data females;
   set learn.survey;
   if gender = 'F';
*Creates a subset dataset, only where 'F' exists will results show up;
run;
*Using a WHERE statement is more efficient than using a subsetting IF statement;
*When a WHERE statement is used, SAS makes the comparison on the incoming variables and then determines if the observation should be written out to the new data set;
*When using a subsetting IF statement, all of the observations are first written to the new data set and then observations not meeting the IF criteria are deleted;

*Program 10-2 Demonstrating a DROP= data set option - page 163;
data females;
   set learn.survey(drop=Salary);
   where gender = 'F';
run;
*An efficient means of using the DROP statement, vs. using in the end of the DATA Step;

/* 10.3 Creating More Than One Subset Data Set in One DATA Step */
*Each output data set must be listed on the DAT statement. If output criteria are not specified wi\/in the data setp code and an OUTPUT statement is not used, all observations are written to all data sets specified on the DATA statement.;

*Program 10-3 Creating two data sets in one DATA step - page 164;
data males females;
*Listing the names following 'data' will create multiple subsets;
   set learn.survey;
   if gender = 'F' then output females;
   else if gender = 'M' then output males;
run;
* what data set will be printed? ;
* - the last data set which created will be printed or 'females' in this case;
proc print; 
run;

proc print data=males;
run;
*Good practice to specify what you want to have printed, as shown by data=datasetname seen above;

proc print data=females;
run;

/* 10.4 Adding Observations to a SAS Data Set */
*Or concatentation;
*Even if the data sets do not all contain the same variables, the output data set will have all variables on all observations;
*When working w/data sets that have variables of the same name, make sure that the length and the type are the same in all of the data sets;
*If the vaiable type is not the name in all data sets, SAS stops processing the code and an ERROR will be generated;

*Program to create temporary SAS data sets ONE, TWO, and THREE;
data one;
   length ID $ 3 Name $ 12;
   input ID Name Weight;
datalines;
7 Adams 210
1 Smith 190
2 Schneider 110
4 Gregory 90
;
run;

data two;
   length ID $ 3 Name $ 12;
   input ID Name Weight;
datalines;
9 Shea 120
3 O'Brien 180
5 Bessler 207
;
run;

data three;
   length ID $ 3 Gender $ 1. Name $ 12;
   Input ID Gender Name;
datalines;
10 M Horvath
15 F Stevens
20 M Brown
;
run;

*Program 10-4 Using a SET statement to combine observations from two data sets - page 165;
data one_two;
   set one two;
run;
*ONE and TWO have exactly the same data set structure, therefore the new data set also has exactly the same structure;

*Program 10-5 Setting two data sets containing different variables - page 166;
data one_three;
   set one three;
run;
*ONE and THREE do not have the same structure, the result: the 1st 4 observations come from ONE all the values of GENDER are missing since ONE did not have the variable GENDER, the last 3 observations come from THREE all the values of WEIGHT are missing since THREEE did not have the variable WEIGHT;

/* Create data sets with different attributes */
*The same variables have different attributes;
*Note: In team1 & team2 below have NAME w/diff lengths, labeled in 1/not labeled in other, ID has different labels, formatted in 1 data set and unformatted in the other;

data team1;
   length Name $ 5;
   input ID Name Weight;
   label id='Player ID';
   format id z5.;
datalines;
7 Adams 210
1 Smith 190
2 Pete  110
4 Greg 90
;
run;

data team2;
   length Name $ 12;
   input ID Name Weight salary;
   label name="Last Name"
         id='unique id';
   format salary dollar8. id z3.;
datalines;
9 Shea 120 1000
3 O'Brien 180 2000
5 Bessler 207 10000
;
run;

data players;
  set team1 team2;
run;
*NAME is set to length 5 b/c NAME in team1 was 5, causes truncation in the last 2 valyes from team2;
*Follows formatting of team1 here;

data players21;
  set team2 team1;
run;
*When variables of diff. atrtibutes in 2 data sets that are subsequently combined, SAS uses the 1st nonmissing attributes that it encountered as the data are combined;

/* 10.5 Interleaving Data Sets */
*Or including some observations from one data set followed by some observations from the second data set followed by more observations from the first data set, etc.;
*BY statement is needed for interleaving;
*The data in the data set must 1st be rearranged or sorted using PROC SORT;
*If there are observations w/the same BY values is 2+ data sets, SAS sets in the observations from the 1st data set, followed by the observations in the subsequent data sets in the order in which the data sets are listed on the SET statement;
*PROC SORT must be used with care, since sorting the data replaces the data set;
*It is best to use the OUT= option, especially when working with permanent data sets that may contain original source data;
*PROC SORT is required whenever you use a BY statement on a subsequent DAD step or PROC;

data one_3;
   length ID $ 3 Name $ 12;
   input ID Name Weight;
datalines;
7 Adams 210
1 Smith 190
2 Schneider 110
4 Gregory 90
3 Jones 200
;
run;

data two;
   length ID $ 3 Name $ 12;
   input ID Name Weight;
datalines;
9 Shea 120
3 O'Brien 180
5 Bessler 207
;
run;
*Program 10-6 Interleaving data sets - page 167;
proc sort data=one_3;
   by ID;
run;

proc sort data=two;
   by ID;
run;

data interleave;
   set one_3 two;
   by ID;
run;
*To interleave data sets, each data set first must be sorted by the values of these variables;
*The SORT procesure rearranges the observations in ascending order of ID;

/* 10.7 Merging Two Data Sets */
*The MERGE statment is used to combine data sets by joining observations from the diff. input data sets;
*Usually this is done by combining observations based on teh values of the variables on the BY statement. When a BY statement is used, the data must be sorted before the data sets can be merged;

*Program to-create two temporary SAS data sets EMPLOYEE and HOURS;
data employee;
   length ID $ 3 Name $ 12;
   input ID Name;
datalines;
7 Adams
1 Smith
2 Schneider
4 Gregory
5 Washington
;
run;

data hours;
   length ID $ 3 JobClass $ 1;
   input ID
         JobClass
         Hours;
datalines;
1 A 39
4 B 44
9 B 57
5 A 35
;
run;

*Program 10-8 Merging two SAS data sets - page 171;
proc sort data=employee;
   by ID;
run;

proc sort data=hours;
   by ID;
run;

data combine;
   merge employee hours;
   by ID;
run;
*Each data set is sorted on the variable ID and then the data are merged;
*Notice that the new data set contains a # of missing valyes b/c not all values of ID were in both data sets;

/* compare merge output to set output */

data combine;
   set employee hours;
   by ID;
run;
*The # of observations when using a SET statment is (almost) always equal to the sum of the observations in each of the input data sets;
*The # of observations when using a MERGE is usually less than the sum of the observations in each of the input data sets;

/* 10.8 Omitting the BY Statement in a Merge */

data noby;
   merge employee hours;
run;

options mergenoby=warn;
data noby;
   merge employee hours;
run;
*A system option (MERGEBOBY) can be used to control error and warning messages when a BY statement is omitted;
*The value can be:;
*NOWARN - no message written to the log (default);
*WARN - a warning message is written to the log;
*ERROR - SAS stops processing the code and issues an ERROR message;
*Example illustrates the importance of including common variables on a BY statement when joining data sets using a MERGE statement;
*If variables common to both data sets are not included on the BY statement, then these variables should be dropped from 1/both data sets before the merge takes place;

/* 10.9 Controlling Observations in a Merged Data Set */
*The IN= option along with a subsetting IF statement can be used to contol which observations are included from each input data set;

*Program 10-9 Demonstrating the IN= data set option - page 173;
/* omit this example
data new;
   merge employee(in=InEmploy)
         hours   (in=InHours);
   by ID;
   file print;
   put ID= InEmploy= InHours= Name= JobClass= Hours=;
run;
*/

*Program 10-10 Using the IN= variables to select ID's that are in both data sets - page 174;
*Want to create a data set that only includes observations where the ID value is in both data sets, ID values that are only in one data set will not be included in COMBINE;
data combine;
   merge employee(in=InEmploy)
         hours(in=InHours);
   by ID;
   if InEmploy and InHours;
run;
*The ID values that are common to both data sets are 1,4,5;

*Using an IN= variable to select ID's that are in one of the data sets;
data emp_only;
   merge employee(in=InEmploy)
         hours;
   by ID;
   if InEmploy;
run;
*The IN= option can also be used to select all observations in one of the data sets;

/* 10.10 More Uses for IN= Variables */
*Controlling which variables to include can be accomplished by the use of the DROP and KEEP statements. When merging data sets that have common variables which are not used on the BY statement, the attributes of the varible (ie. length, label, format) are the attributes of the variable in the 1st data set, but the variable values are those of the last data set;
*Usually a good idea to drop duplicate variables from 1+ of the input data sets;
*When multiple data sets are created in a data step, the IN= option along with a subsetting IF statement can also be used to control which observations are written out to each output data step;

*Program 10-11 More examples of using the IN= variables - page 175;
data in_both
     missing_name(drop = Name);
   merge employee(in=InEmploy)
         hours(in=InHours);
   by ID;
   if InEmploy and InHours then output in_both;
   else if InHours and not InEmploy then
      output missing_name;
run;
*Above: ID values that are in both EMPLOYEE and HOURS are included IN_BOTH, observations that are in HOURS but not in EMPLOYEE are included in MISSING_NAME, observations that are in EMPLOYEE but not in HOURS are deleted;

/* Create data sets with different attributes */

data charlie;
   length Name $ 5;
   input ID Name Weight;
   label id='Player ID';
   format id z5.;
datalines;
7 Adams 210
1 Smith 190
2 Pete  110
4 Greg 90
9 Shea 120 
3 O'Brien 180 
5 Bessler 207
;
run;

data luna;
   length Name $ 12;
   input ID Name Weight salary;
   label name="Last Name"
         id='unique id';
   format salary dollar8. id 1.;
datalines;
7 Shea 120 1000
3 O'Brien 180 2000
5 Bessler 207 10000
;
run;

proc sort data=charlie;
  by id name;
run;

proc sort data=luna;
  by id name;
run;

data charlie_luna;
  merge charlie luna;
  by id;
run;
*For ID=7, NAME=Shea;

data luna_charlie;
  merge luna charlie;
  by id;
run;
*For ID=7, NAME=Adams, because Adams is the value of the NAME in the second data set;
*Examples have illustrated the importance of making sure your common variables have the same attributes hen joining data using a SET or a MERGE, or may have issues with trunctated values;

/* 10.11 When Does a DATA Step End? */

*Program 10-12 Demonstrating when a DATA step ends - page 176;
data short;
   input x;
datalines;
1
2
;
run;

data long;
   input x;
datalines;
3
4
5
6
;
run;

data new1;
   set short;
   output;
   set long;
   output;
run;

data new2;
   set long;
   output;
   set short;
   output;
run;

/* 10.12 Merging Two Data Sets with Different BY Variable Names */
*Sometimes it is necessary to merge 2 data sets together using variables that have diff. names in the input data sets;
*To do so, the variable(s) must be renamed in 1+ of teh data sets;

*Program to create temporary SAS data sets BERT and ERNIE;
data bert;
   input ID $ X;
datalines;
123 90
222 95
333 100
;
run;

data ernie;
   input EmpNo $ Y;
datalines;
123 200
222 205
333 317
;
run;

*Program 10-13 Merging two data sets, rename a variable in one data set - page 178;
data sesame;
   merge bert
         ernie(rename=(EmpNo = ID));
   by ID;
run;
*To merge these data sets together, one of the variables needs to be renamed;

/* 10.13 Merging Two Data Sets with Different BY Variable Data Types */
*To merge data sets using a variable that is of diff. types in the various input data sets, the variable must be converted so that is is the same type in all of the data sets;
*To d so, must rename the variable and use a put or input function in 1+ of the input data sets;

*Program to create temporary SAS data sets DIVISION1 and DIVISION2;
Data division1;
   input SS
         DOB : mmddyy10.
         Gender : $1.;
   format DOB mmddyy10.;
datalines;
111223333 11/14/1956 M
123456789 5/17/1946 F
987654321 4/1/1977 F
;
run;

data division2;
   input SS : $11.
         JobCode : $3.
         Salary : comma8.0;
datalines;
111-22-3333 A10 $45,123
123-45-6789 B5 $35,400
987-65-4321 A20 $87,900
;
run;

/* Method 1: numeric to character */

*Program 10-14 Merging two data sets where the BY variables are different data types - page 179;
data division1c;
   set division1(rename=(SS = NumSS));
   SS = put(NumSS,ssn11.);
   drop NumSS;
run;
*SS is 1st renamed to NumSS, so the variable SS no longer exists in DIVISION1;
*Then, a new character variable SS is created. The (old) numeric variable NumSS is no longer needed, so it is dropped from DIVISION1C;

data both_divisions;
   ***Note: Both data sets already in order
      of BY variable;
   merge division1c division2;
   by SS;
run;
*Finally, the 2 data sets may be merged on the common chracter variable SS;

/* Method 2: character to numeric */

*Program 10-15 An alternative to Program 10-14 - page 180;
data division2n;
   set division2(rename=(SS = CharSS));
   SS = input(compress(CharSS,'-'),9.);
   ***Alternative:
   SS = input(CharSS,comma11.);
   drop CharSS;
run;
*SS is 1st renamed to CharSS, so the variable SS no longer exists in DIVISION2;
*New Numeric variable SS is created;
*The COMPRESS function removes the nonnumeric '-' characters from CharSS;
*The (old) character variable CharSS is no longer needed, so it is dropped from DIVISION2N;

data both_divisions2;
   merge division1 division2n;
   by SS;
run;

/* 10.14 One-to-One, One-to-Many, and Many-to-Many Merges */
*one-to-one merge: has exactly 1 observation for each value of the BY variables in each input data set;
*one-to-many merge: has exactly 1 observation for each value of teh BY variables in 1+ of the input data set(s) & more than 1 observation for each value of the BY variables in 1 of the input data set(s);
*many-to-many merge: has more than 1 obersation for each value of the BY variables in more than one of the input data set(s);

*Program to create temporary SAS data set OSCAR used in chapter 10;
data oscar;
   input ID $ Y;
datalines;
123  200
123  250
222  205
333  317
333  400
333  500
;
run;

data combine;
  merge bert oscar;
  by id;
run;

data one;
   input ID X;
datalines;
123 90
123 80
222 95
333 100
333 150
333 200
;
run;

data two;
   input ID Y;
datalines;
123 3
123 4
123 5
222 6
333 7
333 8
400 9
;
run;

data many_to_many;
  merge one two;
  by id;
run;
*Usually a many-to-many merge does not create a desirable result;
*Note: running the commands above leads to the log hightlighting that there may be a problem;
*You see repeating IDs, where SAS automatically fills in values whereas they would previously be missing there;

/* 10.15 Updating a Master File from a Transaction File */

*Program to create temporary SAS data sets PRICES and NEW15DEC2006
 used in chapter 10;
data prices;
   Length ItemCode $ 3 Description $ 17;
   input ItemCode Description & Price;
datalines;
150 50 foot hose  19.95
175 75 foot hose  29.95
200 greeting card  1.99
204 25 lb. grass seed  18.88
208 40 lb. fertilizer  17.98
;
run;

data new15dec2005;
   Length ItemCode $ 3;
   input ItemCode Price;
datalines;
204 17.87
175 25.11
208 .
;
run;

*Program 10-16 Updating a master file from a transaction file - page 184;
proc sort data=prices;
   by ItemCode;
run;
proc sort data=new15dec2005;
   by ItemCode;
run;

data prices_15dec2005;
   update prices new15dec2005;
   by ItemCode;
run;
