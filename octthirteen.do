cd C:\statadata
use auto
browse

****************************************************************
** ** ** ** ** ** ** ** * local macros * ** ** ** ** ** ** ** **
****************************************************************
/* Local macros are somewhat like variables in programming languages.
They are "boxes" where you can store things and pull them our later. 
This allows you to write code that will do different things depending
on the value of the macros at the time it is run.

While macros can be used like variables, they are not really variables.
What really happens is that macros are replaced by the text they contain
before Stata interprets the command.

All macros are stored as strings, even numbers. In fact we don't even
need the equals sign in the macro definition unless we want Stata to 
do some math first.*/

local x 1

//is the same as

local x=1

local x 2+2
display `x'
display "`x'"


local x -2
di `x'^2

/*If you guessed 4, you forgot either the precedence of algebraic
operators or how Stata uses macros. `x' is replaced by -2 before Stata
does anything with it, so it sees -2^2. But the power takes precedence
over the minus sign, so this is the same as -(2^2), not (-2)^2. If `x'
were a variable like in other programming languages, the minus sign
would not be separate from the 2.*/

// create local macro variable X and set it equal to the text lalala.
local X = "lalala"  

display "My variable name is: `X'"
display "My variable name is:   X"


/*Enclosing a letter or variable name in left and right quotes
tells Stata to evaluate it as a local macro variable.*/

local i 1
di `i'

/* A local macro variable can be used many times throughout a program and
thus can save a lot of typing.  It can also help keep a foeach command
from looking very messy, like if you wanted to pass through a foreach 
command 10 or more variables that could not be represented in shorthand.*/

/*if you had a big list of control variables that you used constantly,
you could define the list as a a macro called controls. Then instead of:*/


regress mpg trunk weight length

local panjere trunk weight length
regress mpg `panjere'

local panjere "trunk weight length"
regress mpg `panjere'

*** *** *** ***

reg income edu race occupation location //... (many more control variables)

//you could type
local controls occupation location
reg income edu `controls'

/*and be done. Or if you repeatedly deal with subsamples of your data,
you could define a macro that gave the conditions for that subsample.
For example:*/

reg income edu `controls' if race=="black" & sex=="female"

//could also be done as

local blackWomen race=="black" & sex=="female"

reg income edu `controls' if `blackWomen'

//1SHAMBE 12 ESFAND:
h local
local a  "apple orange banana"
di "`a'"
di `a'

local b make price 
di `b'

di price



****************************************************************
** ** ** ** ** ** ** ** **   foreach  ** ** ** ** ** ** ** ** ** 
****************************************************************

foreach i in red blue green {
di "`i'"
}

local colors red blue green
foreach i in `colors' {
di "`i'"
}

local colors red blue green
foreach i of local colors {
di "`i'"
} 

/* Note that in changed to of because local is officially a list type,
if a rather odd one. Also note that colors is not in quotes in the
foreach command. If it were in quotes, the standard macro processor
would expand it out to red blue green. Instead, we let the local list
type look up what the macro means, which it does very quickly.

Normally list types tell Stata tell what types of things are in
your list. The available types are varlist, newlist, and numlist.*/

foreach x in "hi" "bye" "aloha" {
	display "`x'"
}
**
foreach x in "Dr. Nick" "Dr. Hibbert" {
	display in yellow "`x' contains "  length("`x'") " characters"
}
**
foreach x in mpg weight {
	summarize `x', detail
}

foreach x of varlist mpg weight {
	summarize `x', detail
}

local controls price mpg weight
foreach j of local controls {
	summarize `j', detail
	egen z_`j' = std(`j')
	label var z_`j' "Z-scored `j'"
	summarize z_`j'
} 

***************************************************************
** ** ** ** ** ** ** ** ** forvalues ** ** ** ** ** ** ** ** **
***************************************************************
forvalues i = 10(10)50 {
	display `i'
	}
**
regress price mpg rep78 displacement if foreign == 0
regress price mpg rep78 displacement if foreign == 1

forvalues i = 0/1 {
	regress price mpg rep78 displacement if foreign == `i'
	}
	
	
***************************************************************
** ** ** ** ** ** ** * in-class exercise * ** ** ** ** ** ** **
***************************************************************
