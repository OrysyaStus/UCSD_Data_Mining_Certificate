/* Chapter 7 */

/* 7.2 The IF and ELSE IF Statements */

*Program 7-1 First attempt to group ages into age groups (incorrect) - page 102;
data conditional;
   length Gender $ 1
          Quiz   $ 2;
   input Age Gender Midterm Quiz FinalExam;
   if Age lt 20 then AgeGroup = 1;
   if Age ge 20 and Age lt 40 then AgeGroup = 2;
   if Age ge 40 and Age lt 60 then AgeGroup = 3;
   if Age ge 60 then AgeGroup = 4;
datalines;
21 M 80 B- 82
.  F 90 A  93
35 M 87 B+ 85
48 F  . .  76
59 F 95 A+ 97
15 M 88 .  93
67 F 97 A  91
.  M 62 F  67
35 F 77 C- 77
49 M 59 C  81
;
run;

title "Listing of CONDITIONAL";
proc print data=conditional noobs;
run;

*Program 7-2 Corrected program to group ages in to age groups - page 104;
data conditional;
   length Gender $ 1
          Quiz   $ 2;
   input Age Gender Midterm Quiz FinalExam;
   if Age lt 20 and not missing(age) then AgeGroup = 1;
   else if Age ge 20 and Age lt 40 then AgeGroup = 2;
   else if Age ge 40 and Age lt 60 then AgeGroup = 3;
   else if Age ge 60 then AgeGroup = 4;
datalines;
21 M 80 B- 82
.  F 90 A  93
35 M 87 B+ 85
48 F  . .  76
59 F 95 A+ 97
15 M 88 .  93
67 F 97 A  91
.  M 62 F  67
35 F 77 C- 77
49 M 59 C  81
;
run;

*Program 7-3 An alternative to Program 7-2 - page 105;
data conditional;
   length Gender $ 1
          Quiz   $ 2;
   input Age Gender Midterm Quiz FinalExam;
   if missing(Age) then AgeGroup = .;
      else if Age lt 20 then AgeGroup = 1;
      else if Age lt 40 then AgeGroup = 2;
      else if Age lt 60 then AgeGroup = 3;
      else if Age ge 60 then AgeGroup = 4;
datalines;
21 M 80 B- 82
.  F 90 A  93
35 M 87 B+ 85
48 F  . .  76
59 F 95 A+ 97
15 M 88 .  93
67 F 97 A  91
.  M 62 F  67
35 F 77 C- 77
49 M 59 C  81
;
run;

/* 7.3 The Subsetting IF Statement */

*Program 7-4 Demonstrating a subsetting IF statement - page 106;
data females;
   length Gender $ 1
          Quiz   $ 2;
   input Age Gender Midterm Quiz FinalExam;
   if Gender eq 'F';
datalines;
21 M 80 B- 82
.  F 90 A  93
35 M 87 B+ 85
48 F  . .  76
59 F 95 A+ 97
15 M 88 .  93
67 F 97 A  91
.  M 62 F  67
35 F 77 C- 77
49 M 59 C  81
;
run;

title "Listing of FEMALES";
proc print data=Females noobs;
run;

/* 7.8 The WHERE Statement */

*Program 7-8 Using a WHERE statement to subset a SAS data set - page 112;
data females;
   set conditional;
  * where Gender eq 'F';
   where midterm >= 50 and finalexam > 60;
   where same and quiz in ('A' 'A+');
run;

/* 7.5 Using a SELECT Statement for Logical Tests */

*Program 7-5 Demonstrating a SELECT statement when a select-expression is missing - page 109;
data conditional;
   length Gender $ 1
          Quiz   $ 2;
   input Age Gender Midterm Quiz FinalExam;
   select;
      when (missing(Age)) AgeGroup = .;
      when (Age lt 20) AgeGroup = 1;
      when (Age lt 40) AgeGroup = 2;
      when (Age lt 60) AgeGroup = 3;
      when (Age ge 60) Agegroup = 4;
      otherwise;
   end;
datalines;
21 M 80 B- 82
.  F 90 A  93
35 M 87 B+ 85
48 F  . .  76
59 F 95 A+ 97
15 M 88 .  93
67 F 97 A  91
.  M 62 F  67
35 F 77 C- 77
49 M 59 C  81
;
run;

/* 7.6 Using Boolean Logic (AND, OR, and NOT Operators) */
libname learn "/courses/dc4508e5ba27fe300/c_629/saslib" access=readonly;

*Program 7-6 Combining various Boolean operators - page 110;
title "Example1 of Boolean Expressions";
proc print data=learn.medical;
   where Clinic eq 'HMC' and
         (DX in ('7' '9') or
         Weight gt 180);
   id Patno;
   var Patno Clinic DX Weight VisitDate;
run;

title "Example2 of Boolean Expressions";
proc print data=learn.medical;
   where Clinic eq 'HMC' and
         DX in ('7' '9') or
         Weight gt 180;
   id Patno;
   var Patno Clinic DX Weight VisitDate;
run;

/* 7.7 A Caution When Using Multiple OR Operators */

*Program 7-7 A caution on the use of multiple OR's - page 111;

data believe_it_or_not;
   input X;
   if X = 3 or 4 then Match = 'Yes';
   else Match = 'No';
datalines;
3
7
.
;
run;
title "Listing of BELIEVE_IT_OR_NOT";
proc print data=believe_it_or_not noobs;
run;
