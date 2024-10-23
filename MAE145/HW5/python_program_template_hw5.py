#!/usr/bin/env python3
"""
Guidelines for program submission: 
    
A) To ensure readability by the grader, 
    please make sure the following submission format:

    1-- Please change the file name to python_program.py 
        ---(The file name is case sensitive, make sure it's identical)---
               
    2-- The *.py file should be compressed to the root of the *.zip file
        e.g., when you submit your homework.zip, 
                Please compress the python files directly 
        ---(Do Not compress the directory!)---
                    aka, if you unzip your *.zip, *.py files should appear
                        in the directory of *.zip file. 
                        
    ---FAIL TO FOLLOW INSTRUCTION A) MAY COST YOU SOME POINTS--- 


B) Your homework should follow the similar structure as this template

C) Keep in mind some minor points:
    
    1-- Your code should not have any debug error before submission!!!

    2-- The order of the function arguments should be the same as that in HW 

    2a-- The data type of the argument should be the same as that in template
                      
    3-- make sure your function return the value which the HW requested
    
    4-- make sure the order of the output arguments the same as those in template
    
    5-- Do not round up your output values
    
    6-- Do not use input function in your function
        
    7-- if you need uncommon modules, contact TA before submission or post it on Piazza

    8-- Please do not add any variable clearing command in the file, as this may terminate grader
    


If you had any question about the guideline, 
    contact TAs or post questions on piazza for response.
        
@author: Dan Li (lidan@ucsd.edu) & Yunhai Han (y8han@eng.ucsd.edu) at UCSD
@date: Jan 2021
"""


"""
The template starts from here
"""

# A16351004 #PID

# import all modules here if you need any
import matplotlib.pyplot as plt
import numpy as np
import random

# import numpy as np
# import matplotlib.pyplot as plt
# your file should always start from definition of functions 


def computeGridSukharev(n): 
    """ descriptions here """

    X = []
    Y = []

    for ii in range(int(np.sqrt(n))):
        x_temp = ((2*ii) + 1)*(1/(2*np.sqrt(n)))
        for jj in range(int(np.sqrt(n))):
            y_temp = ((2*jj) + 1)*(1/(2*np.sqrt(n)))
            X.append(x_temp)
            Y.append(y_temp)


    return X, Y
           
    

def computeGridRandom(n):
    np.random.seed(1)
    """ descriptions here """

    # define some variables etc.
    
    # function in np that generates a vector of random numbers

    X = []
    Y = []

    for kk in range(n):
        X.append(random.random())
        Y.append(random.random())
    
    
    return X, Y
     
    
def computeGridHalton(n, b1, b2):
    """ descriptions here """

    # define some variables etc.
    X = np.zeros(n)
    Y = np.zeros(n)

    for i in range(1,n):
        i_temp = i
        f = 1/b1
        while i_temp > 0:
            q = i_temp/b1
            r = i_temp % b1

            X[i] = X[i] + (f*r)

            i_temp = q
            f = f/b1

    for j in range(1,n):
        j_temp = i
        f = 1/b2
        while j_temp > 0:
            q = j_temp/b2
            r = j_temp % b2

            Y[i] = Y[i] + (f*r)

            j_temp = q
            f = f/b2

    X.sort()
    Y.sort()
    
    return X, Y
    
if __name__ == '__main__':
    """ 
    This is the place where you can test your function. 
    You can define variables, feed them into your function and check the output   
    """
    
    n = 4
    X, Y = computeGridSukharev(n)
    #X = [0.25, 0.75, 0.25, 0.75]
    #Y = [0.25, 0.25, 0.75, 0.75]
    #The order of points could be different, but it should be the same point set.
    #The points are (X[i], Y [i]) : (0.25, 0.25),(0.75, 0.25),(0.25, 0.75),(0.75, 0.75)
    #You can put the visualization codes here
    #print(X)
    #print(Y)
    plt.scatter(X, Y, color='r', marker='o')
    plt.title("Sukharev Grid")
    plt.xlim((0,1))
    plt.ylim((0,1))
    plt.show()
    
    n = 4
    X, Y = computeGridRandom(4)
    #You can put the visualization codes here
    plt.scatter(X, Y, color='r', marker='o')
    plt.title("Random Sampling Graph")
    plt.xlim((0,1))
    plt.ylim((0,1))
    plt.show()
    
    n = 4
    b1 = 2
    b2 = 3 
    X, Y = computeGridHalton(n, b1, b2)
    #You can put the visualization codes here
    plt.scatter(X, Y, color='r', marker='o')
    plt.title("Halton Sequence Graph")
    plt.xlim((0,1))
    plt.ylim((0,1))
    plt.show()
    print(X)
    print(Y)







