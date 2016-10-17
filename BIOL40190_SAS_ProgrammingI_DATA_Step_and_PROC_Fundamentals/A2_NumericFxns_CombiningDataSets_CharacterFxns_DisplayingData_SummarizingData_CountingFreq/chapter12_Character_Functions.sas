/* Chapter 12 */

libname learn "/courses/dc4508e5ba27fe300/c_629/saslib" access=readonly;
options fmtsearch=(learn);

/* 12.2 Determining the Length of a Character Value */
*LENGTH - returns the length of a non-blank character string, excluding trailing blanks, and returns 1 for a blank character string;
*LENGTHN - returns the length of a non-blank character string, excluding trailing blanks, and returns 0 for a blank character string;
*LENGTHC - returns the length of a character string, including trailing blanks;

*Program 12-1 Determining the length of a character value - page 213;
data long_names;
   set learn.sales;
   Length_of_Name=lengthn(Name); 
   keep Name Length_of_Name;
run;
*Here blanks are included in the character count;

/* 12.3 Changing the Case of Characters */
*UPCASE - converts all characters to upper case;
*LOWERCASE - converts all characters to lower case;
*PROPCASE - converts all words in an argument to proper case;

*Program 12-2 Changing values to uppercase - page 214;
data mixed;
   set learn.mixed;
   Name = upcase(Name);
run;

data both;
   merge mixed learn.upper;
   by Name;
run;
*The UPCASE function can be used to convert the values in LEARN>MIXED to upper case before merging the data;
*Alternatively, the PROPCASE function could be applied to Name in LEARN>UPPER to convert those values to Proper case;

/* 12.4 Removing Characters from Strings */
*COMPBL - converts 2+ blanks to a single blank;
*COMPRESS - removes blanks or specified characters from a character string;

*Program 12-3 Converting multiple blanks to a single blank
 and demonstrating the PROPCASE function - page 215;
data standard;
   set learn.address;
   Name = propcase(compbl(Name));
   Street = compbl(propcase(Street));
   City = compbl(propcase(City));
   State = upcase(State);
   City2 = compress(City, 'vaEC');
*characters to be removed are placed in quotes, specification is case character ie. 'E' will be removed while 'e' will not be removed;
run;

/* 12.5 Joining Two or More Strings Together */
*The concatentaion operator is the "double pipe" or ||;
*CAT - concatenates character strings w/o removing leading and trailing blanks;
*CATS - concentenates character strings & removes leading & trailing blanks;
*CATT - concentenates character strings & removes trailing blanks;
*CATX - concentenates character strings, removes leading & trailing blanks, & inserts separators;

*Program 12-4 Demonstrating the concatenation functions - page 216;
*title "Demonstrating the Concatenation Functions";
* modified from text example;

data concat;
   Length Join Name1-Name4 $ 15;
   First = 'Ron   ';
   Last = 'Cody   ';
   Join = ':' || First || ':';
   Name1 = First || Last;
   Name2 = cat(First,Last);
   Name3 = cats(First,Last);
   Name4 = catx(' ',First,Last);
run;
*Note: the variables First and Last have 3 trailing blanks;
*The separator can be any character string placed w/in the quotes;

/* 12.6 Removing Leading or Trailing Blanks */
*The following functionc can be used to achieve the same results as with the CAT functions;
*TRIM - removes trailing blanks from character expressions;
*LEFT - left aligns a character expression;
*RIGHT - right aligns a character expression;
*STRIP - returns a character string w/all leading & trailing blanks removed;

*Program 12-5 Demonstrating the TRIM, LEFT, and STRIP functions - page 217;
data blanks;
   String = '   ABC  ';
   ***There are 3 leading and 2 trailing blanks in String;
   JoinLeft = ':' || left(String) || ':';
*Removes 3 leading blanks;
   JoinTrim = ':' || trim(String) || ':';
*Removes blanks, keeps leading blanks;
   JoinStrip = ':' || strip(String) || ':';
*Removes all leading & trailing blanks;
run;

* The Listing output may help you to better understand the results;
proc print;
run;

/* 12.7 Using the COMPRESS Function to Remove Characters from a String */
*Sometime it is necessary to "clean up" your data by removing characters from text strings. The COMPRESS fxn allows you to do this;

*Program 12-6 Using the COMPRESS function to remove characters from a string - page 219;
data phone;
   length PhoneNumber $ 10;
   set learn.phone;
   PhoneNumber = compress(Phone,' ()-.');
*Removes all characters that are not digits;
   drop Phone;
run;

*Program 12-7 Demonstrating the COMPRESS modifiers - page 220;
data phone;
   length PhoneNumber $ 10;
   set learn.phone;
   PhoneNumber = compress(Phone,,'kd');
*Keep only digits;
*Note: in the COMPRESS statement, do not specify which characters to remove but rather use a modifier 'kd' to specify 'keep digits' only and remove all other characters;
   drop Phone;
run;

/* 12.8 Searching for Characters */
*'Search and replace' operation on character strings can be completed using the FIND function;
*FIND - searches for a specific substring of characters w/in a character string that you specify;

*Program 12-8 Demonstrating the FIND and COMPRESS functions - page 221;
data English;
   set learn.mixed_nuts(rename=
                       (Weight = Char_Weight
                        Height = Char_Height));
   if find(Char_Weight,'lb','i') then
      Weight = input(compress(Char_Weight,,'kd'),8.);
*SAS evaluated Char_Weight & if the character string 'lb' is located, then Weight is created by 1st compressing all characters out of Char_Weight & then using the input fxn. to convert thi value to a numeric variable;
	else if find(Char_Weight,'kg','i') then
      Weight = 2.2*input(compress(Char_Weight,,'kd'),8.);
   if find(Char_Height,'in','i') then
      Height = input(compress(Char_Height,,'kd'),8.);
   else if find(Char_Height,'cm','i') then
      Height = input(compress(Char_Height,,'kd'),8.)/2.54;
   drop Char_:;
run;
*Modifiers ie. 'I' = ignores character case during the search, if this modifier is not specified, Find only searches for the character substrings w/the same case s the characters is substring
'T' = trims trailing blanks from string and substring;
*Syntax: FIND(string, substring<,modifiers><,startpos>);

data pie;
  food='Julian apple pie';
  pie_loc=find(food,'pie');
*SAS is attempted to locate the starting position of the string 'pie';
  char_loc=findc(food,'pie');
*SAS searches the string for the first occurance of any of the characters 'p,i,e';
run;
*FIND searches for an exact character string, while FINDC searches for any of the characters specified;
*FINDC - searches for specific characters that either appear or do not appear w/in a character string that you specify;

/* 12.10 Searching for Words in a String */

*Program 12-9 Demonstrating the FINDW functions - page 224;
*Note: the findw function is only available in SAS 9.2 and later;
*To search for words in a character string, either the FINDW or INDEXW fxns may be used;
*Syntax: INDEXW(source,excerpt<,delimiter>);

data look_for_roger;
   input String $40.;
  *if findw(string,'Roger') then Match = 'Yes';
   if indexw(string,'Roger') then Match = 'Yes';
   else Match = 'No';
datalines;
Will Rogers
Roger Cody
Was roger here?
Was Roger here?
MisterRoger
;
run;

/* 12.11 Searching for Character Classes */
*There are a series of fxns that are similar to the FIND fxns, but rather than searching for a particular character string, these search for grps. or classes of characters;
*ANYALNUM - searches a character string for an alphanumeric character & returns the 1st position @ which it is found;
*ANYALPHA - searches a character string for an alphabetic character & returns the 2st position @ which it is found;
*ANYDIGIT - searches a character string for a digit & returns the 1st position @ which it is found;
*ANYLOWER - searches a character string for a lowercase letter & returns the 1st position @ which it is found;
*ANYPUNCT - searches a character string for a punctuation character & returns the 1st position @ which it is found;
*ANYSPACE - searches a character string for a white-space character (blank, horizontal & vertical tab, carriage return, line feed, form feed) & returns the 1st position @ which it is found;
*ANYUPPER - searches a character string for an uppercase letter & returns the 1st position @ which it is found;

*Program 12-10 Demonstrating the ANYDIGIT function - page 225;
data only_alpha mixed;
   infile "/courses/dc4508e5ba27fe300/c_629/id.txt" truncover;
   input ID $10.;
   if anydigit(ID) then output mixed;
   else output only_alpha;
run;
*Creates multiple output data sets;
*Multiple output statement w/in the data step code are used to control which observations & variables are written to each output data set;
*If the value of ID contains a digit, then the observation is written to MIXED. Otherwise the observation is written to ONLY_ALPHA;

/* 12.12 Using the NOT Functions for Data Cleaning */
*NOTALNUM -  searches a character string for a non-alphanumeric character & returns the 1st position @ which it is found;
*NOTALPHA - searches a character string for a non-alphabetic character & returns the 1st position @ which it is found;
*NOTDIGIT - searches a character string for any character that is not a digit & retuns the 1st position @ which that character is found;
*NOTLOWER - searches a character string for a character that is not a lowercase letter & returns the 1st position @ which that character is found;
*NOTPUNCT - searches a character string for a character that is not a punctuation character & returns the 1st position @ which it is found;
*NOTUPPER - searches a character string for a character that is not an uppercase letter & returns the 1st position @ which that character is found;

*Program 12-11 Demonstrating the "NOT" functions for data cleaning - page 227;
title "Data Cleaning Application";
* modified from text example;
data _null_;
   set learn.cleaning;
   if notalpha(trim(Letters))  then put Subject= Letters=;
   if notdigit(trim(Numerals)) then put Subject= Numerals=;
   if notalnum(trim(Both))     then put Subject= Both=;
run;
*The special data set name _null_ which causes no output data set to be created;
*The PUT Statement is used to write lines to the SAS log;

/* 12.13 Describing a Real Blockbuster Data Cleaning Function */
*The VERIFY fxn returns the position of the 1st character that is unique to an expression;

*Program 12-12 Using the VERIFY function for data cleaning - page 228;
data errors valid;
   input ID $  Answer : $5.;
   verify_val=verify(Answer,'ABCDE');
   if verify(Answer,'ABCDE') then output errors;
   else output valid;
datalines;
001 AABDE
002 A5BBD
003 12345
;
run;
*If SAS finds any characters other than ABCDE is the variable Anser, then the VERIFY fxn returns the position where it 1st encountered such a character;
*Otherwise, the VERIFY fxn returns the value 0;

/* 12.14 Extracting Part of a String */
*To extract parts of a character string, the substring function is used;
*Syntax: SUBSTR(string, position<,length>);
*SUBSTR(to the left of =) - replaces character value contents;
*SUBSTR(to the right of =) - extracts a substring from an argument;

*Program 12-13 Using the SUBSTR function to extract substrings - page 229;
* modified from text example;
data extract;
   input ID : $10. @@;
   length State $ 2 Gender $ 1 Last $ 5;
   * using SUBSTR on the right;
   State = substr(ID,1,2);
   Number = input(substr(ID,3,2),3.);
   Gender = substr(ID,5,1);
   Last = substr(ID,6);
   * using SUBSTR on the left;
   ID2=ID;
   substr(ID2,1,2)='ZZ';
   ID3=ID;
   substr(ID3,4)='charlie';
datalines;
NJ12M99 NY76F4512 TX91M5
;
run;

/* 12.15 Dividing Strings into Words */
*The SCAN fxn is used to extract words from a character string;
*Syntax: SCAN(string,n<,delimiter(s)>);
*If a delimiter is not specified, SAS will treat any of the following as delimiters: blank.<(+&!$*)^-/,%| ;

*Program 12-14 Demonstrating the SCAN function - page 230;
data original;
   input Name $ 30.;
datalines;
Jeffrey Smith
Ron Cody
Alan Wilson
Alfred E. Newman
;
run;

data first_last;
   set original;
   length First Last $ 15;
   First = scan(Name,1,' ');
   Last = scan(Name,2,' ');
run;
*First is created by scanning the 1st word, & Last is created by scanning the 2nd word;

*Program 12-15 Using the SCAN function to extract the last name - page 231;
data last;
   set original;
   length LastName $ 15;
   LastName = scan(Name,-1,' ');
run;
*If a negative # is specified in the SCAN fxn, then the fxn scans in reverse, starting @ the end of the string. So scan(Name,-1) would scan in the 1st word starting @ the end of the string;
*This provides a way to correctly scan in the last name for all of the data values;

proc sort data=last;
   by LastName;
run;

title "Alphabetical list of names";
proc print data=last noobs;
   var Name;
run;

/* 12.16 Comparing Strings */

*Program 12-16 Demonstrating the COMPARE function - page 232;
data diagnosis;
   input Code $10.;
   if compare(Code,'V450','i:') eq 0 then Match = 'Yes';
   else Match = 'No';
datalines;
V450
v450
v450.100
V900
;
run;

*Program 12-17 Clarifying the use of the colon modifier with
 the COMPARE function - page 233;
data _null_;
   String1 = 'ABC   ';
   String2 = 'ABCXYZ';
   Compare1 = compare(String1,String2,':');
   Compare2 = compare(trim(String1),String2,':');
   put String1= String2= Compare1= Compare2=;
run;

/* 12.17 Performing a Fuzzy Match */

*Program 12-18 Using the SPEDIS function to perform a fuzzy match - page 234;
data fuzzy;
   input Name $20.;
   Value = spedis(Name,'Friedman');
datalines;
Friedman
Freedman
Xriedman
Freidman
Friedmann
Alfred
FRIEDMAN
;
run;

/* 12.18 Substituting Characters or Words */
*TRANSLATE - replaces specific characters in a character expression;
*TRANWRD - replaces or removes all occurrences of a word in a character string;

*Program 12-19 Demonstrating the TRANSLATE function - page 236;
data trans;
   input Answer : $5.;
      Answer = translate(Answer,'ABCDE','12345');
datalines;
14325
AB123
51492
;
run;
*In this example, the characters 12345 will be replaced by the character ABCDE on a 1-to-1 basis;

*Program 12-20 Using the TRANWRD function to standardize an address - page 237;
data address;
   infile datalines dlm=' ,';
   *Blanks or commas are delimiters;
   input #1 Name $30.
         #2 Line1 $40.
         #3 City & $20. State : $2. Zip : $5.;

   Name = tranwrd(Name,'Mr.',' ');
   Name = tranwrd(Name,'Mrs.',' ');
   Name = tranwrd(Name,'Dr.',' ');
   Name = tranwrd(Name,'Ms.',' ');
   Name = left(Name);

   Line1 = tranwrd(Line1,'Street','St.');
   Line1 = tranwrd(Line1,'Road','Rd.');
   Line1 = tranwrd(Line1,'Avenue','Ave.');
datalines;
Dr. Peter Benchley
123 River Road
Oceanside, NY 11518
Mr. Robert Merrill
878 Ocean Avenue
Long Beach, CA 90818
Mrs. Laura Smith
80 Lazy Brook Road
Flemington, NJ 08822
;
run;
*When there are multiple lines of data that need to be read into a single observation, a line pointer must be used on the input statement, the symbol for a line pointer is #;
*The line pointer is followed by the line number/row in the raw data, followed by the variables to be read from that line of data;
*Any input method can be used to read in the variables;
*In this example, the TRANWRD fxn is used to remove titles from the data lines, so Mr., Mrs., Dr. etc are replaced w/a blank;