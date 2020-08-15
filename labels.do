version 13
capture log close
//log using "path/do-filename.log", replace

/* STATA1397 */ 
/* Labels */ 
/* Mahdi */ 
/* Nov 04, 2018 */ 
/* Where it is */

clear all
set more off
//use "path/datafilename.dta"

*****************************************************************************************
********* https://stats.idre.ucla.edu/stata/modules/labeling-data/***********************
*****************************************************************************************

clear
use https://stats.idre.ucla.edu/stat/stata/modules/autolab.dta

describe

label data "This file contains auto data for the year 1978"

describe

label variable rep78   "the repair record from 1978" 

label variable price   "the price of the car in 1978" 

label variable mpg     "the miles per gallon for the car" 

label variable foreign "the origin of the car, foreign or domestic

describe

label define foreignl 0 "domestic car" 1 "foreign car" 

label values foreign foreignl  

describe

*********************** Summary ***********************

//Assign a label to the data file currently in memory.

    label data "1978 auto  data"

//Assign a label to the variable foreign.

    label variable foreign "the origin  of the car, foreign or domestic"

//Create the value label foreignl and assign it to the variable foreign.

    label define foreignl 0 "domestic  car"  1 "foreign  car"
    label values foreign foreignl
	
	
*****************************************************************************************
*https://www.cpc.unc.edu/research/tools/data_analysis/statatutorial/documenting/vallabel*
*****************************************************************************************

clear
use "C:\statadata\examfac2.dta"
browse
keep facid q102_1-q102_5

describe

 
browse


browse, nolabel 


label dir    //List all value labels stored in examfac2.dta. 


label list title  //Show what the value label title is. 


label drop title //Remove the value label title.  

browse

* Re-creating the title value label: 
help delimit

#delimit ;
 label define title 
            1 "Doctor"
            2 "AssistMedOff"
            3 "ClinOff"
            4 "AssistClinOff"
            5 "NurseOff"
            6 "Nurse/Midwife";

* Add more to the title value label.; 

label define title
            7 "PH NurseB"
            8 "MCH Aide"
            9 "NurseAssist"
           10 "Other"
		   11 "Dr. Doolittle"
           99 "dalalalal", add;
#delimit cr

* Change the title value label. 

label define title 99 "balalal", modify

* Re-assign the title value label to each q102_* variable. 
 
foreach v of varlist q102* {
   label val `v' title
}
browse




********************************************************************************	
	
log close
