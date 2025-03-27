```python
---
title: Python Basics
author: Erin Mansfield
date: 2025-2-17
categories: [python, basics, programming]
image: "image.png"
toc: true
---
```

# Lecture 4



```python
# Python Basics
A value is literal such as a number or text
There are different types of values
** 352.3 is known as a float or double
** 22 is an integer
** "Hello World!" is a string

A variable is a name that refers to a value
Sometimes you will hear variables referred to as objects

```


```python
# Variable in data. frame
Defintion: A data.frame is a table-like data structure used for storing data in a tabular format with rows and columns
Structure: Consisits of
** Variables
** Observations
** Values
```


```python
# Assignment (=)
In Python, we used = to assign a value to a variable

```


```python
# Assigment (=) Example
# Here we assign the integer value 5 to the variable x.
x = 5

# Now we can use the variable x in the next line.
y = x + 12
y
```


```python
# Variables Are Names, Not Places
The most basic built-in data types that we'll need to know about are:
** integers 10
** floats 1.23
** strings "like this"
** booleans "True"
** nothing None
```


```python
# Varibales Are Names, Not Places Example
list_example = [10, 1.23, "like this", True, None]
print(list_example)
type(list_example)
```


```python
# Operators
All of the basic operators we see in mathematics are available to use:
** + for addition
** - for subtraction
** * for multiplication
** for powers
** / for division
** // for integer division
```


```python
# Casting Variables
We need to explicity cast a value from one type to another
** We can do this using built-in functions like str(), int(), and float()
```


```python
# Casting Variables Examples
orig_number = 4.39898498
type(orig_number)

mod_number = int(orig_number)
mod_number
type(mod_number)

```


```python
# Dictionaries
Another built-in Python type that is enormously useful is the dictionary
We can obtain keys, values, or key-value paris from dictionaries

```


```python
# Dictionaries Examples
cities_to_temps = {"Paris": 28, "London": 22, "New York": 36, "Seoul": 29}

cities_to_temps.keys()
cities_to_temps.values()
cities_to_temps.items()
```



# Lecture 5


```python
# Booleans, Conditions, and if Statements
Boolean data have either True or False value
The == is an operator that compares the objects on eitehr side and returns True if they have the same values
```


```python
# Booleans, Conditions, and if Statements Examples
10 == 20
10 == '10'

boolean_condition1 = 10 == 20
print(boolean_condition1)

boolean_condition2 = 10 == '10'
print(boolean_condition2)

name = "Geneseo"
score = 99

if name == "Geneseo" and score > 90:
    print("Geneseo, you achieved a high score.")

if name == "Geneseo" or score > 90:
    print("You could be called Geneseo or have a high score")

if name != "Geneseo" and score > 90:
    print("You are not called Geneseo and you have a high score")

    name_list = ["Lovelace", "Smith", "Hopper", "Babbage"]

print("Lovelace" in name_list)

print("Bob" in name_list)
```


```python
# Slicing Methods
With slicing methods, we can get subset of the data object
```


```python
# Slicing Methods Strings
From strings, we can access the individual characters via slicing and indexing

```


```python
# Slicing Methods Strings Examples
string = "cheesecake"
print( string[-4:] )
string = "cheesecake"
print("String has length:")
print( len(string) )
list_of_numbers = range(1, 20)
print("List of numbers has length:")
print( len(list_of_numbers) )
```


```python
# Slicing Methods Lists
list_example = ['one', 'two', 'three']
list_example[ 0 : 1 ]
list_example[ 1 : 3 ]
```


```python
# Functions, Arguments, Parameters
A function can take any number and type of input parameters and return any number and type of output results
int("20")
float("14.3")
str(5)
int("xyz")

Much as a cooking receipe can accept ingredients, a function invocation can accpet inputs called arguments
A parameter is a name given to an expected function argument
```


```python
# Loop with while and for
Repeat with while
count = 1
while count <= 5:
  print(count)
  count += 1
Asking the user for input
stuff = input()
Type something and press retun
print(stuff)
Cancel with break
while True:
    value = input("Integer, please [q to quit]: ")
    if value == 'q': # quit
        break
    number = int(value)
    if number % 2 == 0: # an even number
        continue
    print(number, "squared is", number*number)

Repeat with while
numbers = [1, 3, 5]
position = 0

while position < len(numbers):
    number = numbers[position]
    if number > 4:  # Condition changed to checking if the number is greater than 4
        print('Found a number greater than 4:', number)
        break
    position += 1
else:  # break not called
    print('No number greater than 4 found')

```


```python
# list and dictionary comprehensions
List comprehension is a concise way to modify lists
Dictionary comprehension is a concise way to create or modify dictionaries
```


```python
# Modifying Lists and Dictionaries
append(): adds an item to the end of the list
remove(): deletes the first occurrence of value in the list
list comprehnesion: Removes items based on a condition
del statement: deletes an item by index or a slice of items
update(): adds new key value pairs or updates existing ones
dictionary comprehension: removes items based on a condition
del statement: deletes an item by key



```


```python
# Handle Errors with try and except
Python uses exceptions: code that is executed when an associated error occurs
Errors
short_list = [1, 2, 3]
position = 5
short_list[position]
Handle errors with try and except
short_list = [1, 2, 3]
position = 5

try:
    short_list[position]
except:
    print('Need a position between 0 and', len(short_list)-1, ' but got',
    position)
```


```python
# Importing and Installing Modules, Packages, and Libraries
Core libraries that enable Python to store adn analyze data efficiently are: pandas, numpy, matplotlib and seaborn
import statement
as or from
```

# Classwork 4


```python
# Question 1
val = 2**5 / (7 * (4 -2**3))
val

```


```python
# Question 2: For each expression what is the value of the expression?

boolean_condition1(20 == '20')
print(boolean_condition1)
#false

x= 4.0
y= .5
x < y or 3*y < x
print (x<y)
#false
print(3*y<x)
#false
```


```python
# Question 3: Write a code that uses slicing and the print function to print out the following message: the total trip cost is 12:80
fare = "$10.00"
tip = "2.00$"
tax = "$ 0.80"

fare = float(fare[1:])
tip = float(tip[-1])
tax = float(tax[2:])
total= fare + tip + tax
print(f"the total trip cost is: ${total}")
```


```python
# Question 4: Write a code that uses print and max function ot print out the largest value in the list, and print the largest value in the list is: 1000
list_variable = [100, 144, 169, 1000, 8]
print(f"The largest value in the list is: {max(list_variable)}")
```


```python
# Question 5: Use a whole loop to print a list and for loop to print the list [3, 2, 1, 0] one at a time
vals = [3, 2, 1, 0]
index=0
while index < len(vals):
  print(vals[index])
  index += 1
for n in vals:
  print(n)
```


```python
# Question 6:
#While loop
guess_me = 7
number = 1

while number < guess_me:
  print("too low!")
  number += 1
while number == guess_me:
  print("found it")
  number += 1
while number > guess me:
  print("oops!")
  break

# For loop
guess_me = 7
number = 1

for k in range(1,10):
  if number < guess me:
    print("too low")
  elif number == guess me:
    print("found it")
  else:
    print("oops")
    break

  number += 1
```


```python
# Question 7:
value = "320"
print(type(value))

mod_number = float(value)
print(type(mod_number))

if type(mod_number) == float:
  print(f"You entered: {value}")
else:
  print("that's not a valid number")
#<class 'str'>
#class 'float'>
#You entered: 320
```


```python
# Question 8:
import pandas as pd
%pip install itables
from itables import init_notebook_mode, show
```
