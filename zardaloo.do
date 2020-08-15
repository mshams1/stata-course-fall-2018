**************************************************************************
** notes from sample project *********************************************
**************************************************************************

local cpi1385_U = 18.6
local cpi1386_U = 21.8
local cpi1385_R = 15.3
local cpi1386_R = 18.0

local zardaloo var1 var2 var3

foreach motegh of local zardaloo  {
  g       `motegh'_nominal=`motegh' 
  foreach sal of numlist 1385(1)1386 {
      replace `motegh'=`motegh'/`cpi`sal'_U' if year==`sal' & urban==1
      replace `motegh'=`motegh'/`cpi`sal'_R' if year==`sal' & urban==0
    }
  }
  replace `motegh'=`motegh'/CPI_scale
  replace `motegh'=`motegh'*100
}

/*
1- using varlist instead of local in first loop
2- another loop for urban/rural
3- using scalar instead of local
4- [foreach adad of numlist ...] = [forvalues adad = ...]
*/

scalar cpi1385_1 = 18.6
scalar cpi1386_1 = 21.8
scalar cpi1385_0 = 15.3
scalar cpi1386_0 = 18.0

foreach motegh of varlist var1 var2 var3  {
  g       `motegh'_nominal=`motegh'
  forvalues makan = 0(1)1 {
	forvalues sal = 1385(1)1386 {
		replace `motegh'=`motegh'/cpi`sal'_`makan' if year==`sal' & urban==`makan'
    }
  }
  replace `motegh'=`motegh'/CPI_scale
  replace `motegh'=`motegh'*100
}
