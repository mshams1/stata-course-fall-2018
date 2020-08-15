//source: https://agroganweb.wordpress.com/stata-resources/

histogram x            //will give you a nice display of one variable
histogram x, by(y)     //may be useful for comparing the distributions of two variables over the categories of y
histogram x, percent   //will scale the y-axis more intuitively in terms of percentages
histogram x, discrete  //gives a nicer display for categorical variables
twoway scatter y x     //gives you a twoway scatterplot of your data
twoway lfit y x        //will give you a linear fit graph.
//The two syntaxes may be combined e.g.
twoway (scatter y x)(lfit y x) .
graph bar x, over(y)   //is useful for creating a bar graph of a continuous or categorical variable graphed across the categories of a categorical variable

cd C:\statadata

use auto

histogram mpg
