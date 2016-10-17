/* Chapter 8 */

/* 8.2 DO Groups */

*Program 8-1 Example of a program that does not use a DO group - page 118;
data grades;
   length Gender $ 1
          Quiz   $ 2
          AgeGrp $ 13;
   infile "/courses/dc4508e5ba27fe300/c_629/grades.txt" missover;
   input Age Gender Midterm Quiz FinalExam;
   if missing(Age) then delete;
   if Age le 39 then Agegrp = 'Younger group';
   if Age le 39 then Grade  = .4*Midterm + .6*FinalExam;
   if Age gt 39 then Agegrp = 'Older group';
   if Age gt 39 then Grade  = (Midterm + FinalExam)/2;
run;

title "Listing of GRADES";
proc print data=grades noobs;
run;

*Program 8-2 Demonstrating a DO group - page 119;
data grades;
   length Gender $ 1
          Quiz   $ 2
          AgeGrp $ 13;
   infile "/courses/dc4508e5ba27fe300/c_629/grades.txt" missover;
   input Age Gender Midterm Quiz FinalExam;
   if missing(Age) then delete;
   if Age le 39 then do;
      Agegrp = 'Younger group';
      Grade = .4*Midterm + .6*FinalExam;
   end;
   else if Age gt 39 then do;
      Agegrp = 'Older group';
      Grade = (Midterm + FinalExam)/2;
   end;
run;

title "Listing of GRADES";
proc print data=grades noobs;
run;

/* Additional Example - illustrating the necessity of the length statement */
data grades;
  * length AgeGrp $ 11;
   infile "/courses/dc4508e5ba27fe300/c_629/grades.txt" missover;
   input Age Gender $ Midterm Quiz $ FinalExam;
   if missing(Age) then delete;
   if Age le 39 then do;
      Agegrp = 'Gen X';
      Grade = .4*Midterm + .6*FinalExam;
   end;
   else if Age gt 39 then do;
      Agegrp = 'BabyBoomers';
      Grade = (Midterm + FinalExam)/2;
   end;
run;

title "Listing of GRADES";
proc print data=grades noobs;
run;

/* 8.3 The Sum Statement */

*Program 8-3 Attempt to create a cumulative total 
 (Note: this program does not work) - page 121;
data revenue;
   input Day : $3.
         Revenue : dollar6.;
   Total = Total + Revenue; /* Note: this does not work */
   format Revenue Total dollar8.;
datalines;
M $1,000
Tue $1,500
We  .
Th  $2,000
Fri $3,000
;
run;

*Program 8-4 Adding a RETAIN statement to Program 8-3 - page 122;
data revenue;
   retain Total 0;
   input Day : $3.
         Revenue : dollar6.;
   Total = Total + Revenue; /* Note: this does not work */
   format Revenue Total dollar8.;
datalines;
Mon $1,000
Tue $1,500
Wed  .
Thu $2,000
Fri $3,000
;
run;

*Program 8-5 Third attempt to create cumulative total - page 123;
data revenue;
   retain Total 0;
   input Day : $3.
         Revenue : dollar6.;
   if not missing(Revenue) then Total = Total + Revenue;
   format Revenue Total dollar8.;
datalines;
Mon $1,000
Tue $1,500
Wed  .
Thu $2,000
Fri $3,000
;
run;

*Program 8-6 Using a SUM statement to create a cumulative total - page 124;
data revenue;
   input Day : $3.
         Revenue : dollar6.;
   Total + Revenue;
   format Revenue Total dollar8.;
datalines;
Mon $1,000
Tue $1,500
Wed  .
Thu $2,000
Fri $3,000
;
run;

*Program 8-7 Using a SUM statement to create a counter - page 124;
data test;
   input x;
   if missing(x) then MissCounter + 1;
datalines;
2
.
7
.
;
run;

/* 8.4 The Iterative DO Loop */

*Program 8-8 Program without iterative loops - page 125;
data compound;
   Interest = .0375;
   Total = 100;

   Year + 1;
   Total + Interest*Total;
   output;

   Year + 1;
   Total + Interest*Total;
   output;

   Year + 1;
   Total + Interest*Total;
   output;

   format Total dollar10.2;
run;

title "Listing of COMPOUND";
proc print data=compound noobs;
run;

*Program 8-9 Demonstrating in iterative DO loop - page 126;
data compound;
   Interest = .0375;
   Total = 100;
   do Year = 1 to 3;
      Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;

*Program 8-10 Using an iterative Do loop to make a table of squares and square roots - page 127;
data table;
   do n = 1 to 10;
      Square = n*n;
      SquareRoot = sqrt(n);
      output;
   end;
run;

title "Table of Squares and Square Roots";
proc print data=table noobs;
run;

*Program 8-11 Using an iterative DO loop to graph an equation - page 128;
data equation;
   do X = -10 to 10 by .01;
      Y = 2*x**3 - 5*X**2 + 15*X -8;
      output;
   end;
run;

symbol value=none interpol=sm width=2;
title "Plot of Y versus X";
proc gplot data=equation;
   plot Y * X;
run;

/* 8.5 Other Forms of an Iterative DO Loop */

*Program 8-12 Using character values for DO loop index values - page 130;
data easyway;
   do Group = 'Placebo','Active';
      do Subj = 1 to 5;
         input Score @;
         output;
      end;
   end;
datalines;
250 222 230 210 199
166 183 123 129 234
;
run;

/* 8.6 DO WHILE and DO UNTIL Statements */

*Program 8-13 Demonstrating a DO UNTIL loop - page 131;
data double;
   Interest = .0375;
   Total = 100;
   do until (Total ge 200);
      Year + 1;
      Total = Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;

title "Listing of DOUBLE";
proc print data=double noobs;
run;

*Program 8-14 Demonstrating that a DO UNTIL loop always executes at least once - page 133;
data double;
   Interest = .0375;
   Total = 300;
   do until (Total ge 200);
      Year + 1;
      Total = Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;

*Program 8-15 Demonstrating a DO WHILE statement - page 133;
data double;
   Interest = .0375;
   Total = 100;
   do while (Total le 200);
      Year + 1;
      Total = Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;

proc print data=double noobs;
   title "Listing of DOUBLE";
run;

*Program 8-16 Demonstrating that DO WHILE loops are evaluated at the top - page 134;
data double;
   Interest = .0375;
   Total = 300;
   do while (Total lt 200);
      Year + 1;
      Total = Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;

/* 8.7 A Caution When Using DO UNTIL Statements */

*Program 8-17 Combining a DO UNTIL and iterative DO loop - page 135;
data double;
   Interest = .0375;
   Total = 100;
   do Year = 1 to 100 until (Total = 200);
      Total = Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;

/* 8.8 LEAVE and CONTINUE Statements */

*Program 8-18 Demonstrating the LEAVE statement - page 135;
data leave_it;
   Interest = .0375;
   Total = 100;
   do Year = 1 to 5;
      Total = Total + Interest*Total;
      output;
      if Total ge 200 then leave;
   end;
   format Total dollar10.2;
run;

*Program 8-19 Demonstrating a CONTINUE statement - page 136;
data continue_on;
   Interest = .0375;
   Total = 100;
   do Year = 1 to 100 until (Total ge 200);
      Total = Total + Interest*Total;
      if Total le 150 then continue;
      output;
   end;
   format Total dollar10.2;
run;

/* Program 8-19 - using a retain statement and counter */	
data continue_on2;
   retain interest .0375 total 100;
   do Year = 1 to 100 until (Total ge 200);
      Total + Interest*Total;
      if Total le 150 then continue;
      output;
   end;
   format Total dollar10.2;
run;

proc print;
run;
