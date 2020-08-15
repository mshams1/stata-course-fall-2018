******************************************************************
*Working across variables using foreach***************************
*Stata Learning Modules -- idre***********************************
*Oct 19, 2018*****************************************************
******************************************************************

/*Consider the sample program below,which
reads in income data for twelve months.*/

input famid inc1-inc12
1 3281 3413 3114 2500 2700 3500 3114 3319 3514 1282 2434 2818
2 4042 3084 3108 3150 3800 3100 1531 2914 3819 4124 4274 4471
3 6015 6123 6113 6100 6100 6200 6186 6132 3123 4231 6039 6215
end

browse

/*Say that we wanted to compute the amount of tax (10%)
paid for each month, the simplest way to do this is to
compute 12 variables (taxinc1-taxinc12) by multiplying
each of the (inc1-inc12) by .10 as illustrated below.
As you see, this requires entering a command computing
the tax for each month of data (for months 1 to 12) via
the generate command.*/

generate taxinc1 = inc1 * .10 
generate taxinc2 = inc2 * .10 
generate taxinc3 = inc3 * .10 
generate taxinc4 = inc4 * .10 
generate taxinc5 = inc5 * .10  
generate taxinc6 = inc6 * .10 
generate taxinc7 = inc7 * .10 
generate taxinc8 = inc8 * .10 
generate taxinc9 = inc9 * .10 
generate taxinc10= inc10 * .10 
generate taxinc11= inc11 * .10 
generate taxinc12= inc12 * .10 

/*Another way to compute 12 variables representing the
amount of tax paid (10%) for each month is to use the
foreach command.In the example below we use the foreach
command to cycle through the variables inc1 to inc12 and
compute the taxable income as taxinc1 – taxinc12.*/

foreach i of varlist taxinc2-taxinc11 {
  drop `i'
}

help varlist

foreach var of varlist inc1-inc12 {
  generate tax`var' = `var' * .10
}

browse

/*The initial foreach statement tells Stata that we want
to cycle through the variables inc1 to inc12 using the
statements that are surrounded by the curly braces.
The first time we cycle through the statements,
the value of var will be inc1  and the second time
the value of var will  be inc2 and so on until the
final iteration where the value of var will be inc12.
Each statement within the loop (in this case, just the
one generate statement) is evaluated and executed.
When we are inside the foreach loop, we can access
the value of var by surrounding it with the funny
quotation marks like this `var’ .  
The first time through the loop, `var’ is replaced
with inc1, so the statement

    generate tax`var' = `var' * .10 

becomes

    generate taxinc1 = inc1 * .10 

This is repeated for inc2 and then inc3 and so on
until inc12. So, this foreach loop is the equivalent
of executing the 12 generate statements manually,
but much easier and less error prone.*/

/*Often one needs to sum across variables (also known
as collapsing across variables). For example, let’s say
the quarterly income for each observation is desired.  
In order to get this information, four quarterly variables
incqtr1-incqtr4 need to be computed. Again, this can be
achieved manually or by using the foreach command. Below
is an example of how to compute 4 quarterly income variables
incqtr1-incqtr4 by simply adding together the months
that comprise a quarter.*/

generate incqtr1 = inc1 + inc2 + inc3 
generate incqtr2 = inc4 + inc5 + inc6 
generate incqtr3 = inc7 + inc8 + inc9 
generate incqtr4 = inc10+ inc11+ inc12 

browse

/*This same result as above can be achieved using
the foreach command. The example below illustrates
how to compute the quarterly income variables 
incqtr1-incqtr4 using the foreach command.*/ 

drop incqtr1-incqtr4

help numlist

foreach qtr of numlist 1/4 {
	local m3 = `qtr'*3
	local m2 = (`qtr'*3)-1
	local m1 = (`qtr'*3)-2
	generate incqtr`qtr' = inc`m1' + inc`m2' + inc`m3'
}

browse

/*The foreach command can also be used to identify
patterns across variables of a dataset.  Let’s say,
for example, that one needs to know which months had
income that was less than the income of the previous
month. To obtain this information, dummy indicators
can be created to indicate in which months this occurred.
Note that only 11 dummy indicators are needed for a 12
month period because the interest is in the change from
one month to the next.  When a month has income that is
less than the income of the previous month, the dummy
indicators lowinc2-lowinc12 get assigned a “1”.  When
this is not the case, they are assigned a “0”.*/

foreach curmon of numlist 2/12 {
  local lastmon = `curmon' - 1
  generate lowinc`curmon' = 1 if ( inc`curmon' <  inc`lastmon' )
  replace  lowinc`curmon' = 0 if ( inc`curmon' >= inc`lastmon' )
}

browse

help replace 



/*If you were using foreach to span a large range of values
(say 1/1000) then it is more effcient to use forvalues since
it is designed to quickly increment through a sequential list,
for example:*/

drop lowinc2-lowinc12

    forvalues curmon = 2/12 {
      local lastmon = `curmon' - 1
      generate lowinc`curmon' = 1 if ( inc`curmon' <  inc`lastmon' )
      replace  lowinc`curmon' = 0 if ( inc`curmon' >= inc`lastmon' )
    }

	//Source: https://stats.idre.ucla.edu/stata/modules/working-across-variables-using-foreach/
