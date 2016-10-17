/* Chapter 9 */

libname learn "/courses/dc4508e5ba27fe300/c_629/saslib" access=readonly;

/* 9.3 Reading Date Values from Raw Data  */

*Program 9-1 Program to read dates from raw data - page 143;
data four_dates;
   infile "/courses/dc4508e5ba27fe300/c_629/dates.txt" truncover;
   input @1  Subject   $3.
         @5 DOB       mmddyy10.
         @16 VisitDate mmddyy8.
         @26 TwoDigit  mmddyy8.
         @34 LastDate  date9.;
run;

*Program 9-2 Adding a format statement to format each of the date values - page 144;
data four_dates;
   infile "/courses/dc4508e5ba27fe300/c_629/dates.txt" truncover;
   input @1  Subject   $3.
         @5 DOB       mmddyy10.
         @16 VisitDate mmddyy8.
         @26 TwoDigit  mmddyy8.
         @34 LastDate  date9.;
   format DOB VisitDate date9.
          TwoDigit LastDate mmddyy10.;
run;

proc print data=four_dates;
  format VisitDate date9.
          TwoDigit ddmmyy10. LastDate mmddyy10. DOB;
run;

/* 9.4 Computing the Number of Years between Two Dates */

*Program 9-3 Compute a person's age in years - page 146;
data ages;
   set four_dates;
   Age = yrdif(DOB,VisitDate,'Actual');
   IntAge = int(yrdif(DOB,VisitDate,'Actual'));
run;

title "Listing of AGES";
proc print data=ages;
   id Subject;
   var DOB VisitDate Age;
run;

/* 9.5 Demonstrating a Date Constant */

*Program 9-4 Demonstrating a date constant - page 148;
data ages;
   set four_dates;
   Age = yrdif(DOB,'01Jan2006'd,'Actual');
   if DOB <= '5MAY1976'd then agecat=1;
   else agecat=2;
run;

title "Listing of AGES";
proc print data=ages;
   id Subject;
   var DOB Age;
   format Age 5.1;
run;

/* 9.6 Computing the Current Date */

*Program 9-5 Using the TODAY function to return the current date - page 148;
data ages;
   set four_dates;
   a_week_ago=today()-7;
   Age = yrdif(DOB,today(),'Actual');
   format a_week_ago date.;
run;

/* 9.7 Extracting the Day of the Week, Day of the Month, Month, and Year from a SAS Date */

*Program 9-6 Extracting the day of the week, day of the month, month and year from a SAS date - page 149;
data extract;
   set four_dates;
   Day = weekday(DOB);
   DayOfMonth = day(DOB);
   Month = Month(DOB);
   Year = year(DOB);
run;

title "Listing of EXTRACT";
proc print data=extract noobs;
   var DOB Day -- Year;
run;

/* 9.8 Creating a SAS Date from Month, Day, and Year Values */

libname learn "/courses/dc4508e5ba27fe300/c_629/saslib" access=readonly;
*Program 9-7 Using the MDY function to create a SAS date from month, day, and year values - page 150;
data mdy_example;
   set learn.month_day_year;
   Date = mdy(Month, Day, Year);
   format Date mmddyy10.;
run;

title "Listing of MDY_EXAMPLE";
proc print;
run;

/* 9.9 Substituting the 15th of the Month when the Day Value Is Missing */

*Program 9-8 Substituting the 15th of the month when a day value is missing - page 151;
data substitute;
   set learn.month_day_year;
   if missing(day) then Date = mdy(Month,15,Year);
   else Date = mdy(Month,Day,Year);
   format Date mmddyy10.;
run;
