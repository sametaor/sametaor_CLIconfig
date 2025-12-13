HTML tags have been provided for output readability
" --->


Simple Variables

Set myVariable to "myValue"

Set myNumber to 3.14



Display myVariable: #myVariable#
Display myNumber: #myNumber#

Complex Variables


Set myArray1 to an array of 1 dimension using literal or bracket notation


Set myArray2 to an array of 1 dimension using function notation


Contents of myArray1
 
Contents of myArray2
 


Operators
Arithmetic
1 + 1 = #1 + 1#
10 - 7 = #10 - 7#
15 * 10 = #15 * 10#
100 / 5 = #100 / 5#
120 % 5 = #120 % 5#
120 mod 5 = #120 mod 5#


Comparison
Standard Notation
Is 1 eq 1? #1 eq 1#
Is 15 neq 1? #15 neq 1#
Is 10 gt 8? #10 gt 8#
Is 1 lt 2? #1 lt 2#
Is 10 gte 5? #10 gte 5#
Is 1 lte 5? #1 lte 5#
Alternative Notation
Is 1 == 1? #1 eq 1#
Is 15 != 1? #15 neq 1#
Is 10 > 8? #10 gt 8#
Is 1 < 2? #1 lt 2#
Is 10 >= 5? #10 gte 5#
Is 1 <= 5? #1 lte 5#


Control Structures

Condition to test for: "#myCondition#"

#myCondition#. We're testing.

#myCondition#. Proceed Carefully!!!

    myCondition is unknown



Loops
For Loop

Index equals #i#

For Each Loop (Complex Variables)
Set myArray3 to [5, 15, 99, 45, 100]


Index equals #i#

Set myArray4 to ["Alpha", "Bravo", "Charlie", "Delta", "Echo"]


Index equals #s#

Switch Statement
Set myArray5 to [5, 15, 99, 45, 100]




#i# is a multiple of 5.


#i# is ninety-nine.


#i# is not 5, 15, 45, or 99.




Converting types




Value
As Boolean
As number
As date-time
As string




"Yes"
TRUE
1
Error
"Yes"


"No"
FALSE
0
Error
"No"


TRUE
TRUE
1
Error
"Yes"


FALSE
FALSE
0
Error
"No"


Number
True if Number is not 0; False otherwise.
Number
See "Date-time values" earlier in this chapter.
String representation of the number (for example, "8").


String
If "Yes", True If "No", False If it can be converted to 0, False If it can be converted to any other number, True
If it represents a number (for example, "1,000" or "12.36E-12"), it is converted to the corresponding number.
If it represents a date-time (see next column), it is converted to the numeric value of the corresponding date-time object. If it is an ODBC date, time, or timestamp (for example "{ts '2001-06-14 11:30:13'}", or if it is expressed in a standard U.S. date or time format, including the use of full or abbreviated month names, it is converted to the corresponding date-time value. Days of the week or unusual punctuation result in an error. Dashes, forward-slashes, and spaces are generally allowed.
String


Date
Error
The numeric value of the date-time object.
Date
An ODBC timestamp.




Components
Code for reference (Functions must return something to support IE)












































sayHello()
#sayHello()#
getHello()
#getHello()#
getWorld()
#getWorld()#
setHello("Hola")
#setHello("Hola")#
setWorld("mundo")
#setWorld("mundo")#
sayHello()
#sayHello()#
getHello()
#getHello()#
getWorld()
#getWorld()#
