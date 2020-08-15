//{sum and total}

*Source: https://stats.idre.ucla.edu/stata/seminars/stata-data-management/

clear
use https://stats.idre.ucla.edu/stat/data/patient_pt1_stata_dm, clear

************************************

help sum()

help egen //then find total there

//compare the results:

gen gsumfem = sum(female)

egen egsumfem = sum(female)

gen gtotalfem = total(female)

egen egtotalfem = total(female)

****************************************
