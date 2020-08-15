version 13
/* Stata1397 */ 
/* _Notes */ 
/* Mahdi */ 
/* December 04, 2018 */ 
/* Where it is */
clear all
set more off

**************************************************************************
** Macros *****************************************************************
**************************************************************************

global golabi = 1

local golabi = 2

scalar golabi = 3

di $golabi

di `golabi'

di golabi



**************************************************************************
** Loops *****************************************************************
**************************************************************************

**************************************************************************
** foreach ***************************************************************

clear
input famid inc1-inc12
1 3281 3413 3114 2500 2700 3500 3114 3319 3514 1282 2434 2818
2 4042 3084 3108 3150 3800 3100 1531 2914 3819 4124 4274 4471
3 6015 6123 6113 6100 6100 6200 6186 6132 3123 4231 6039 6215
end

//wrong way
foreach mah of numlist 2/12 {
  local maheghabli  `mah' - 1
  generate wdelta`mah' = 1 if ( inc`mah' >  inc`maheghabli' )
  replace  wdelta`mah' = 0 if ( inc`mah' <= inc`maheghabli' )
}

//right way  
foreach mah of numlist 2/12 {
  local maheghabli = `mah' - 1
  generate rdelta`mah' = 1 if ( inc`mah' >  inc`maheghabli' )
  replace  rdelta`mah' = 0 if ( inc`mah' <= inc`maheghabli' )
}

**************************************************************************
** forvalues *************************************************************

forvalues i = 10(10)50 {
	display `i'
	}
***	
clear
use http://www.stata-press.com/data/r9/auto.dta

regress price mpg rep78 displacement if foreign == 0
regress price mpg rep78 displacement if foreign == 1

//same as:

forvalues i = 0/1 {
	regress price mpg rep78 displacement if foreign == `i'
	}
	
**************************************************************************
** if ********************************************************************
**************************************************************************

clear
use http://www.stata-press.com/data/r9/auto.dta

generate hirep78 = rep78 > 2 

generate hirep78a = rep78 > 2 if rep78 < .

generate hirep78b = rep78 > 2 if rep78 != .

generate hirep78c = rep78 > 2 & rep78 < .


**************************************************************************
** Labeling **************************************************************
**************************************************************************

//Assign a label to the data file currently in memory:
    label data "..."
	
//Assign a label to the variable foreign:
    label variable varname "..."
	
//Create the value label foreignl and assign it to the variable foreign:
    label define labelname 0 "x"  1 "y"
    label values varname labelname
	
	
/*               Problem --> multiple line commands
                Solution -->
                            use /// at the end of each line
                       or:
			            	use   #delimit ;
                            all the lines
				        	  ;
					        #delimit cr
*/

**************************************************************************
** bys *******************************************************************
**************************************************************************
* Source: https://stats.idre.ucla.edu/stata/faq/can-i-do-by-and-sort-in-one-command

clear
use https://stats.idre.ucla.edu/stat/stata/notes/hsb2

//without by
summarize read write

//with by 

//1st type:

sort ses
by ses: summarize read write

//2nd type:

by ses, sort: summarize read write

//3rd type:

bysort ses: summarize read write


**************************************************************************
** sum & total ***********************************************************
**************************************************************************

clear
use https://stats.idre.ucla.edu/stat/data/patient_pt1_stata_dm

gen sumbmi = sum(bmi)

egen totalbmi = total(bmi)

help sum()

help egen //then find total there


**************************************************************************
**************************************************************************
**************************************************************************

log close
