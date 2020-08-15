***************************************************************************
* https://www.stata.com/support/faqs/data-management/true-and-false/      *
*                                                                         *
***************************************************************************

cd C:\statadata
use auto

browse

help count

/*Rule 1: Logical or Boolean expressions evaluate to 0
if false, 1 if true*/

count if foreign == 1 & rep78 == 4 

/* The rule is that false logical expressions have value 0
and true logical expressions have value 1. */

generate himpg1 = mpg > 30

gen himpg2 = 1 if mpg > 30

/*The rule is that Stata treats numeric missing values as
higher than any other numeric value. */

generate hirep78 = rep78 > 2 

generate hirep78a = rep78 > 2 if rep78 < .
//or
generate hirep78b = rep78 > 2 if rep78 != .
//or
generate hirep78c = rep78 > 2 & rep78 < .

/*will assign 1 if mpg were greater than 30 but not missing;
0 if mpg were not greater than 30;
and missing if mpg were missing */

generate himpg = mpg > 30 if foreign == 0

/*If foreign were not equal to 0, then the
result would be missing. Otherwise, the result
would be 1 or 0 according to whether mpg was
or was not greater than 30.*/

/*Rule 2: Logical or Boolean arguments(whatever is fed to if),
such as the argument to if or while, may take on any value, not
just 0 or 1; 0 is treated as false and any other numeric
value as true. */

list mpg if foreign == 1

list mpg if foreign

/*In the second statement, Stata looks at the values of the
variable foreign, and then executes the action if and only
if the value is a number not 0.*/


***************************************************************************
*        Using IF with Stata commands | Stata Learning Modules            *
* https://stats.idre.ucla.edu/stata/modules/using-if-with-stata-commands  *
***************************************************************************

//This module shows the use of if with common Stata commands.

/*Let's use the auto data file.*/
    
	cd C:\statadata
     use auto

/*For this module, we will focus on the variables make,
rep78, foreign, mpg, and price. We can use the keep
command to keep just these five variables.*/

    keep make rep78 foreign mpg price

	help kepp
	
/*Let's make a table of rep78 by foreign to look at
the repair histories of the foreign and domestic cars.*/

    tabulate rep78 foreign

/*Suppose we wanted to focus on just the cars with
repair histories of four or better. We can use if
suffix to do this.*/

    tabulate rep78 foreign if ...
    
	help if
	
	help tabulate


/*The use of if is not limited to the tabulate command.
Here, we use it with the list command.*/

    list if rep78 >= 4

    browse

/*Did you see that some of the observations had a value of
'.' for rep78? These are missing values. For example,
the value of rep78 for the AMC Spirit is missing. Stata
treats a missing value as positive infinity, the highest
number possible. So, when we said list if rep78 >= 4,
Stata included the observations where rep78 was '.' as well.
If we wanted to include just the valid (non-missing)
observations that are greater than or equal to 4,
we can do the following to tell Stata we want only
observations where rep78 >= 4 and rep78 is not missing.*/

	help missing
 
	missing(rep78)
	
	list if rep78 >= 4  &  ...

   
/*This code will also yield the same output as above.*/

    list if rep78 >= 4 & rep78 != .

/*We can use if with most Stata commands. Here, we get
summary statistics for price for cars with repair
histories of 1 or 2. Note the double equal (==) represents
IS EQUAL TO and the pipe ( | ) represents OR.*/

    summarize price
    summarize price if ...

//A simpler way to say this would be:

    summarize price if ...

//Likewise, we can do this for cars with repair history of 3, 4 or 5.

    summarize price if rep78 == 3 | rep78 == 4 | rep78 == 5

/*Additionally, we can use this code to designate a range
of values. Here is a summary of price for the values
3 through 5 in rep78.*/

    help inrange
	
    summarize price if inrange(rep78,3,5)
	
	//same as
	
    summarize price if 3 <= rep78 & rep78 <= 5
	
//Let's simplify this by saying rep78 >= 3.

    summarize price if rep78 >= 3

/*Did you see the mistake we made? We accidentally included
the missing values because we forgot to exclude them.
We really needed to say.*/

    summarize price if rep78 >= 3 ...
    summarize price if rep78 >= 3 ...
//Summary

/*Most Stata commands can be followed by if, for example*/

summarize if rep78 equals 2

summarize if rep78 == 2

summarize if rep78 is greater than or equal to 2

summarize if rep78 >= 2

summarize if rep78 greater than 2

summarize if rep78 >  2

summarize if rep78 less than or equal to 2

summarize if rep78 <= 2

summarize if rep78 less than 2

summarize if rep78 <2

summarize if rep78 not equal to 2

summarize if rep78 != 2

/*
If expressions can be connected with
| for OR
& for AND
*/


//Missing Values

/*Missing values are represented as '.' and are the
highest value possible. Therefore, when values are
missing, be careful with commands like*/

    summarize if rep78 >  3

    summarize if rep78 >= 3

    summarize if rep78 != 3

//to omit missing values, use:

    summarize if rep78 >  3 & !missing(rep78)

    summarize if rep78 >  3 & rep78 != .

********************************************************************************


