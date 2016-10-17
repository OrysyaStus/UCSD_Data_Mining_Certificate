/* Orysya Stus		SAS Programming: Programming Assignment 1 */

proc format;
  value sex 
    1=Female 
    2=Male
     ;
  value race 
    1=Asian 
    2=Black 
    3=Caucasian 
    4=Other
     ;
run;

*1. Read in the data in suppTRP-1062.txt, use the csv file method for reading in data;
data STUDY;
	*length Site $1 Pt $2;
	infile "/courses/dc4508e5ba27fe300/c_629/suppTRP-1062.txt" dsd missover;
	input Site : $1.
		Pt : $2.
		Sex
		Race
		Dosedate : mmddyy10.
		Height
		Weight 
		Result1-Result3;
	format Dosedate mmddyy10.;
*2. Using if-then statements and data constants, create a new variable called Doselot; 
	if '01JAN1997'd <= dosedate <= '31DEC1997'd then doselot='S0576';
  	else if '31DEC1997'd < dosedate <= '10JAN1998'd then doselot='P1122';
  	else if dosedate > '10JAN1998'd then doselot='P0526';

*3. Create 2 new variables called prot_amend and limit that meet the criteria below;
	if doselot='P0526' then do;
    	prot_amend='B';
    	if sex=1 then limit=0.03;
    	else if sex=2 then limit=0.02;
  	end;
  	else if doselot = 'S0576' or doselot='P1122' then do;
    	prot_amend='A';
    	limit=0.02;
  	end;

*4. Using a select statement, use the variable Site to create a new variable called site_name which contains the name of the Study Site;
length site_name $30;
	select;
		when (Site = 'J') site_name = 'Aurora Health Associates';
		when (Site = 'Q') site_name = 'Omaha Medical Center';
		when (Site = 'R') site_name = 'Sherwin Heights Healthcare';
		otherwise site_name = .;
	end;
*5. Create and apply formats to the Sex and Race variables;

	format sex sex. race race. dosedate date.;


*6. Using the descriptive information provided previously, create labels for these variables;
  	label site='Study Site' 
        pt='Patient'
        dosedate='Dose Date'
        doselot='Dose Lot'
        prot_amend='Protocol Amendment'
        limit='Lower Limit of Detection'
        site_name='Site Name';
run;