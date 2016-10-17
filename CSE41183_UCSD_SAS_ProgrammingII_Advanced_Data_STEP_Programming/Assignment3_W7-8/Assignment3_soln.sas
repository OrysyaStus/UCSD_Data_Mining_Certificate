

/*
Problem 1
*/


libname assign3 'C:\Users\Arthur\Documents\UCSD_courses\Advanced_DATA_step\Assignment\Assignment3';

proc sort data=assign3.inventory out=inventory_sort;
	by id;
run;

proc sort data=assign3.sales out=sales_sort;
	by id;
run;

data leftover;
	merge inventory_sort (in=invent) sales_sort (in=sale);
	by id;
	if invent and sale then left = quantity - sold;
	else left = quantity;
run;

/*
Problem 2
*/


data geocode (drop=geoid); 
	set assign3.geocode;
	geoid = substr(geoid, 8, 2);
	id = input(geoid, 2.);
run;

data households;
	set assign3.households;
	rename geoid = id;
run;

proc sort data=geocode;
	by id;
run;

proc sort data=households;
	by id;
run;

data all;
	merge geocode (in=dat1) households (in=dat2);
	by id;
	if dat1 and dat2;
run;

proc print data=all;
run;



/*
Problem 3
*/
/* step 1:  get id and sex variables*/
data sbp1 (drop=x_exist genderLoc id);
	set assign3.sbp;
	x_exist = index(id,'x') > 0;
	if index(upcase(id),'M') > 0 then genderLoc = index(upcase(id),'M');
	else genderLoc = index(upcase(id),'F');
	if x_exist > 0 then newID = substr(id, 2, genderLoc-2);
	else newID = substr(id, 1, genderLoc-1);
	Sex = upcase(substr(id, genderLoc));
run;


/*step 2: create newSbp*/
proc sort data= sbp1 out=sbp_sort;
	by newid visit;
run;

data sbp2 (drop = visit sbp);
	set sbp_sort;
	by newid;
	retain maxsbp maxvisit; 
	if first.newid then do;
		maxsbp = .;
		maxvisit = 1;
	end;
	if sbp > maxsbp & not missing(sbp) & sbp < 300 then do;
		maxsbp = sbp;
		maxvisit = visit;
	end;
	if last.newid;
run;

proc print data=sbp2;
run;
