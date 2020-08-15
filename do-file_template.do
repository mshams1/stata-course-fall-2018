version 13
capture log close
log using "path/do-filename.log", replace

/* What project this is */ 
/* What this do-file does */ 
/* Mahdi */ 
/* Nove 5, 2018, updating */ 
/* Where it is */

clear all
set more off
use "path/datafilename.dta"
  
*** your commands go here *** 

log close
