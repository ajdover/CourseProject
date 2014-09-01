### Getting and Cleaning Data Course Project
### Change after final feedback


## Description

Required Code Book for the Course Project

## Background

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

## Source Data

A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

For each record it is provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.


### Assignment

## Section 1. Merge the training and the test sets to create one data set.
After setting the source directory for the files, read into tables the data located in
- features.txt
- activity_labels.txt
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt

# Actions upon data:

Each file in the training data was read with read.table using the header=FALSE parameter
Column names were assigned to each table using colnames
Training data was merged using cbind

Each file in the test data was read with read.table using the header=FALSE parameter
Column names were assigned to each table using colnames
Test data was merged using cbind

Training data and test data were merged using rbind


## Section 2. Extract only the measurements on the mean and standard deviation for each measurement. 
Create a logcal vector that contains TRUE values for the ID, mean and stdev columns and FALSE values for the others.
Subset this data to keep only the necessary columns.

# Actions upon data:

Created a vector for column names
Created a logical vector for column names, setting the necessary columns to TRUE and the others to FALSE
Subsetted the total data by the necessary columns

## Section 3. Use descriptive activity names to name the activities in the data set
Merge data subset with the activityType table to include the descriptive activity names

# Actions upon data:

Merge data
Update column names vector

## Section 4. Appropriately label the data set with descriptive activity names.

# Actions upon data:

Use gsub function for pattern replacement to clean up the data labels.
Assign column names again


## Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
Per the project instructions, we need to produce only a data set with the average of each veriable for each activity and subject

# Actions upon data:
Create a table which removes the Activity Type column
Aggregate the data to include just the mean for each variable for each activity and each subject
Merge the data into a tidy data set, including the activity type
Use write.table to write out the tab-separated data set with row.names=FALSE
