---
title: "Getting and Cleaning Data - Course Project"
output: html_document
---
## Purpose
The purpose of this work is to assess, assemble, tidy (as necessary) and summarize a particular set of data. The raw data provided can be found at:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> . The description of the raw data, files and folder structure can be found in README.txt in the zip archive.

## Assessment
A few operations were done to initially assess, understand and verify the data against the provided README.txt document. The following was discovered:

1.  As indicated by the README.txt document, there were 30 unique subject IDs divided (70/30) into a training group and a test group.
2.  Vectors for student IDs and activity IDs stored in separate files (from each other and from the data.)
3.  For the test data there were 2947 student IDs, activity IDs and data rows (observations). This suggests a test set of 2947 observations made for a set of student-activity pairs.
4.  For the training data there were 7352 student IDs, activitie IDs and data rows (observations). This suggests a training set of 7352 observations made for a set of student-activity pairs.
5.  Each data set (test and training) consisted of 561 measured (or calculated) values.
6.  Column names for the variables were stored in a separate file.
7.  An evaluation of the data itself found no incomplete sets or data inconsistent with the measurement type.
8.  Evaluation of the variables indicates that there is one column per measured (or calculated) value.
9.  No variables were found to be represented by rows.
10. While an argument could be made for separating into two tables the time-domain and frequency domain data, the requested output would see these tables merged so there would be no point to separate them in the first place.

This initial assessment found the data to be percisely as described. The only issue that would need to be addressed would be the syntax of the column names. Given 8-10 above, the data is considered tidy.

##Assembly - Load, Merge and Filter Test and Training Data Sets
The data was assembled first into separate test and training data sets and then merged together. The Inertial Signals were not included as these would only be discarded later as per the project instructions (see also: [David's personal course project FAQ](https://class.coursera.org/getdata-012/forum/thread?thread_id=9)). The assembly steps were as follows:

1.  Read in the activity labels.
2.  Read in the measurement labels (called features). Parenthesis in the label names were discarded and special 'R' characters converted to dots (.). Finally, any dot at the end of the label name was discarded. As an example, meausurement label fBodyGyro-bandsEnergy()-17,32 would become fBodyGyro.bandsEnergy.17.32 .
3.  Each data set (test and training) was built-out from left to right, so to speak. The subject ID was added first followed by the activity ID followed by the data itself.
4.  A full data set was produced simply by stacking the test data set on the training data set (both sets being of equal width and having the same column names)
5.  The full data set was then filtered for variable names containing the words "mean" and "std" while ignoring case. This produced the data set called stat.data (as a data table) containing 10299 observations and 88 columns.

## Summarization - Compute Averages of Selected Variables
The requested summarization was to turn activity IDs into labels and compute the average of each variable for each unique student and activity performed. This was done as follows:

1.  The activity IDs in stat.data set were converted to factors using the 6 IDs as levels and the labels provided to name the factors.
2.  The computation of the averages was done in one step taking advantange of the features and methods of the data.table object. The code is: 
       <pre><code>mean.data <- stat.data[,lapply(.SD,mean),by="subj_ID,act_ID",.SDcols=3:88]</code></pre>
       
3. The resulting data set (called mean.data) was 180 rows by 88 columns.

## Instructions for Code Execution

1.  For simplicty, download the script, run_analysis.R, to the same folder that holds the Samsung data (i.e. UCI HAR Dataset).
2.  In R Studio, set the working directory to the location of the Samsung data.
3.  The analysis script uses data tables so **the data.table package must be installed**. Also, **the package "dplyr" must be installed.**
4.  In the R Console, load and run the script using the command, source("run_analysis.R", print.eval=T)
5.  The script will issue a message as it reads each data file.
6.  Provided the script is run with 'source' with print.eval=T, the script will generate sample output for the final measurement averages.
7.  The script will create in the execution environment the following data tables:
*   trn.data - the training data set.
*   tst.data - the test data set.
*   stat.data - the merged data set filtered for mean and standard deviation variables.
*   mean.data - the summary data set, i.e. averages of the stat.data set.

    
