****************************************************************************
****************************************************************************
********************************** bysort **********************************
****************************************************************************
****************************************************************************

*Source: https://stats.idre.ucla.edu/stata/faq/can-i-do-by-and-sort-in-one-command/

clear
use https://stats.idre.ucla.edu/stat/stata/notes/hsb2, clear

************* without by *************
summarize read write

************** with by ***************
sort ses
by ses: summarize read write

//or:

by ses, sort: summarize read write

//or:

bysort ses: summarize read write

************************** another set of example **************************

*Source: https://stats.idre.ucla.edu/stata/seminars/stata-data-management/

clear
use https://stats.idre.ucla.edu/stat/data/patient_pt1_stata_dm, clear

************************************
summ age

egen MEAN = mean(age)
egen MAX = max(age)
egen SD = sd(age)

************************************
sort docid

by docid: egen mean_age = mean(age)

by docid: egen max_age = max(age)

by docid: egen sd_age = sd(age)

************************************
gen female = sex == "female"

replace female = . if sex == ""

by docid: gen num_female = sum(female)

by docid: egen numeg_female = sum(female)

************************************
// _n & _N

g a = _n

g b = _N

by docid: g c = _n

by docid: g d = _N


