#Getting and Cleaning Data - the assignment
##Human Activity Recognition Data

##Overview

This project has been an exercise in collecting, working with, and cleaning a data set.

###Project Components

This README document is a guide describing the course assignment and project steps.  
In the repository, you will find a tidy data set and the script used to perform the analysis
A code book is included that describes the variables, data and transformations performed.


A full description of the source material is available at the site where the data was obtained: 
*(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)*

The data was downloaded from the following URL:
*(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)*

###Project Objectives

   1. Merge the training and the test sets to create one data set.     
   2. Extract only the measurements on the mean and standard deviation for each measurement. 
   3. Use descriptive activity names to name the activities in the data set
   4. Appropriately label the data set with descriptive variable names.    
   5. From the data set in step 4, create a second, independent tidy data set, 
       with the average of each variable, for each activity and each subject.

##Run the Analysis

The run_analysis.R script has been successfully tested on both Windows and Mac systems.   

Before beginning the process of merging the files, I installed three useful packages.
* **Downloader, data.table and dplyr**

#Step 1
After downloading and importing into R, columns of subject, y and x files were combined.
Rows of test and train were subsequently combined into one table with 10299 observations.
Column names of *'subjectid'* and *'activityid'* were added to this temporary dataset.
The remaining variable columns were numbered from 1 to 561, for each of the feature vectors.
The features list was loaded, with new column names *'featureid'* and *'featuredescr'*

#Step 2
For extracting only the measurements of mean and standard deviation,
I searched the features file for any description of *'mean'* or *'std'*
I have included the weighted mean variables, originally labeled as *'meanFreq'* 
I created a feature index, as a method for subsetting the temporary table
In this step, the column count was reduced to 88 variables

#Step 3
To begin the process of assigning descriptive activity names,
I worked with a subset of the features related to mean and standard deviation.
You may want to reference the codebook to understand the naming convention used.
The strngcalc function was written to piece together the descriptive names.
The naming convention uses the following order.

     1. summary function of mean vs standard deviation
     2. domain of time vs frequency, including angular measurements
     3. body vs gravity 
     4. axis of the phone when listed
     5. sensor used for the reading (accelerometer vs gyroscope)
     6. magnitude when listed 

#Step 4
Having adjusted the variable names, I then assigned them as column names for the dataset.
For the activity labels, I changed the descriptions to lower case and removed the underscore.
These labels were then incorporated into the dataset as a new column.

#Step 5
To make a tidy data set, I selected all of the columns, except for the activityid.
Grouping on the subjectid and activity description, I created a mean summary for each column. 
The dataset was written to a file called 'TidyDataAssignment.csv'. 
This file is available in the repository. It has 180 observations of 88 variables.
For the tidy file, please note each observation has it's own row, with a column for each measured variable.

For more detail on Tidy Data, the Hadley Wickham whitepaper is a great resource.
*(http://vita.had.co.nz/papers/tidy-data.pdf)*



To read in the file, I would recommend including the argument 'check.names=FALSE'.
The file will load without that setting, but the spaces in the variable names will
be replaced with periods.  I have included commented code in the R script for reading the file.
      


====
*This README document has been compiled by K.Franics*