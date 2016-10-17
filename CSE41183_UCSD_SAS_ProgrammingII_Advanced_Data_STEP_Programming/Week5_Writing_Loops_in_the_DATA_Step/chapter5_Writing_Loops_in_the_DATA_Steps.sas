/* Chapter 5: Writing Loops in the DATA Step */
/* 
Implicit and explicit loops
Implicit Loops
The DATA step works like a loop - an implicit loop
It repetitvely exectutes statements: reads data values & creates observations in teh PDV one at a time
Each loop is called an iteration
Suppose you have the following dataset that contains patient IDs for a clinical trial
You would like to assign each patient w/either a drug or a placebo (50% chance or either/or)

The RANUNI function: RANUNI(SEED)
It generates a number ~Uniform(0,1) ie. 0.135, 0.567, etc.
SEED is a nonnegative integer
The RANUNI function generates a stream of numbers based on SEED
When SEED is set to 0, the generated number cannot be reproduced
When SEED is a non-zero number, the generated number can be produced
*/

/*
Program 5.1
*/
data ex5_1 (drop=rannum);
	set patient;
	rannum = ranuni(2);
	if rannum > 0.5 then group = 'D';
	else group = 'P';
run;

*Explicit Loops
Suppose you don't have a dataset containing the patient IDs
You are asked to assign 4 patients, 'M2390', 'F2390', 'F2340', 'M1240', with a 50% chance of receiving either the drug or the placebo
You can create the ID and assign each ID to a group in the DATA step at the same time
Assigning IDs in the DATA step;
/*
Program 5.2
*/
data ex5_2 (drop = rannum);
	id = 'M2390';
	rannum = ranuni(2);
	if rannum > 0.5 then group = 'D';
	else group = 'P';
	output;

	id = 'F2390';
	rannum = ranuni(2);
	if rannum > 0.5 then group = 'D';
	else group = 'P';
	output;

	id = 'F2340';
	rannum = ranuni(2);
	if rannum > 0.5 then group = 'D';
	else group = 'P';
	output;

	id = 'M1240';
	rannum = ranuni(2);
	if rannum > 0.5 then group = 'D';
	else group = 'P';
	output;
run;
*4 explicity OUTPUT statements in the PDV
4 almost identical blocks
Put identical codes in a loop, loop along the IDs, reduce amount of coding;

*General form for an iteractive DO loop:
Do index-variable = value1, value2, ..., valuen
	SAS statements
END

INDEX-VARIABLE: contains the valye of the current iteration
The loop will execute along VALUE1 through VALUEN
The VALUES can be either character or numeric;
/*
Program 5.3
*/
data ex5_3 (drop=rannum);
	do id = 'M2390', 'F2390', 'F2340', 'M1240';
		rannum = ranuni(2);
		if rannum > 0.5 then group = 'D';
		else group = 'P';
		output;
	end;
run; 

*Usually we use the iterative DO loop and loop along a sequence of integers
DO index-variable = start TO stop <BY increment>
	SAS statements
END

The loop will execute from the START to the STOP value
The optional BY clause specifies an increment between START and END, the default value for INCREMENT is 1
START, STOP, and INCREMENT: numbers, variables, SAS expressions
These values are set upon entry into the DO loop and cannot be modified during the processing of the DO loop
INDEX-VARIABLE can be changed within the loop

Suppose you are using a sequence of numbers, say 1 to 4, as patient IDs;
/*
Program 5.4
*/
data ex5_4(drop=rannum);
	do id = 1 to 4;
		rannum = ranuni(2);
		if rannum > 0.5 then group = 'D';
		else group = 'P';
		output;
	end;
run;
*There will be no implicity OUTPUT statement
Since we didn't read an input dataset, the DATA step execution ends;

*Using an iterative DO loop requires specifying the number of iterations for the DO loop
Sometimes you will need to execute statements repetitively until a condition is met
In this situation, you need to use either the DO WHILE or DO UNTIL statements
DO WHILE(expression)
SAS statements
END

EXPRESSION is evaluated at the top of the DO loop
The DO loop will not execute if the EXPRESSION is false;
/*
Program 5.5
*/
data ex5_5(drop=rannum);
	do while (id < 4);
		id + 1;
		rannum = ranuni(2);
		if rannum>0.5 then group='D';
		else group ='P';
		output;
	end;
run;

*DO UNTIL(expression)
SAS statements
END

Unlike DO WHILE loops, the DO UNTIL loop evaluates the condition at the end of the loop
The DO UNTIL loop will not continue for another iteration if the EXPRESSION is evaluated to be TRUE at the end of the current loop
That means the DO UNTIL loop always executes at least once;
/*
Program 5.6
*/
data ex5_6(drop=rannum);
	do until (id>=4);
		id + 1;
		rannum = ranuni(2);
		if rannum > 0.5 then group='D';
		else group='P';
		output;
	end;
run;
*The end expression will not continue for another iteration if the EXPRESSIOn is true;

*Suppose that you would like to assign 12 patients with either a drug or a placebo
These 12 subjects are from 3 cancer centers("COH", UCLA", and "USC") with 4 subjects per center;
/*
Program 5.7
*/
data ex5_7;
	length center $4;
	do center = "COH", "UCLA", "USC";
		do id = 1 to 4;
			if ranuni(2) > 0.5 then group = 'D';
			else group = 'P';
			output;
		end;
	end;
run;
*Code above contains outer and inner DO loop;

*Combining Implicit and Explicit Loops
In previous program all the observations were created from 1 DATA step since we didn't read any input data
Suppose the values for CENTER is sotred in a SAS dataset
For each center, you need to assign 4 patients with either a drug or a placebo;
/*
Program 5.8
*/
data trial7;
	set cancer_center;
	do id = 1 to 4;
		if ranuni(2)> 0.5 then group = 'D';
		else group = 'P';
		output;
	end;
run;
*The inner loop is an explicit loop and the outer loop is an implicit loop;

