# About the Programs

## heat_spread.f90
This FORTRAN program models the spread of heat over time in a flat plate using stencil functions to solve the heat equation. 
It takes 3 command line arguments inorder to run properly, an input  file, an integer value for the frequency of output, and an output file.

EXAMPLE: ./a.out input.dat 10 output.dat

A sample input file has been provided title input.dat

## iris_classification.py
This Python program uses the K Nearest Neighbors (KNN) machine learning algorithm to make predict the species of Iris based on sepal length and width and petal length and width. The KNN algorithm is implemented from the scikit learn library for Python. GridSearchCV and RandomizedSearchCV are also used to find an optimal K value for the most accurate results. 

Note: When running the program and graph representing the Classification accuracy vs. K value will pop up. For the program to continue running the graph window must first be closed. Then the user will be prompted to enter sepal length and width, and petal length and width to be used for prediction. 

## matlab_sampling.pdf/.zip
The .pdf file shows various MATLAB scripts (matrix manipulations, functions, graphing, et al.) and screenshots of the outputs. The .zip file contains .m files for all of the scripts shown in the .pdf file. 

## random_smoothing.cpp
This file creates a large array (about 1GB) filled with random numbers. Then a stencil function is used to "smooth" the interior of the array and the result is saved in another array. All of the operations are timed and the timings are outputted to the user as well as other information about the arrays. This program will later be parallelized using OpenMP in order to produce faster run times and take advantage of Texas Advance Computing Center's Stampede supercomputer. 

