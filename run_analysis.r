
## Coursera Getting and Cleaning Data Course Project
## Due 8/24/2012

# runAnalysis.r File Description:

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
# Please upload your data set as a txt file created with write.table() using row.name=FALSE

# 1. Merge the training and the test sets to create one data set.

#set working directory to the location where the UCI HAR Dataset was unzipped

setwd("C:/Users/DoverA/Desktop/Coursera Data Cleaning/Course Project/UCI HAR Dataset")

# Start with the training files
# Read in the data from files: features.txt, activity_labels.txt, subject_train.txt, x_train.txt, y_train.txt

features <- read.table('./features.txt',header=FALSE)

activityType <- read.table('./activity_labels.txt',header=FALSE)

subjectTrain <- read.table('./train/subject_train.txt',header=FALSE)

xTrain <- read.table('./train/x_train.txt',header=FALSE)

yTrain <- read.table('./train/y_train.txt',header=FALSE)

# Assigin column names to the training data

colnames(activityType) <- c('activityId','activityType')

colnames(subjectTrain) <- "subjectId"

colnames(xTrain) <- features[,2]

colnames(yTrain) <- "activityId"

# Merge yTrain, subjectTrain, and xTrain to create the trainingData

trainingData = cbind(yTrain,subjectTrain,xTrain)

# Read in the test data: subject_test.txt, x_test.txt, y_test.txt

subjectTest <- read.table('./test/subject_test.txt',header=FALSE)

xTest <- read.table('./test/x_test.txt',header=FALSE)

yTest <- read.table('./test/y_test.txt',header=FALSE)


# Assign column names to the test data 

colnames(subjectTest) <- "subjectId"

colnames(xTest) <- features[,2] 

colnames(yTest) <- "activityId"


# Merge xTest, yTest, subjectTest to create testData

testData <- cbind(yTest,subjectTest,xTest)

# Combine trainingData and testData into totalData

totalData <- rbind(trainingData,testData)


# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

# Create a vector for the column names from the totalData to select the desired mean() & stddev() columns

colNames <-colnames(totalData) 

# Create a logicalVector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others

logicalVector <- (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames))

# Subset totalData table based on the logicalVector to keep only desired columns

totalData <- totalData[logicalVector==TRUE]

# 3. Use descriptive activity names to name the activities in the data set

# Merge the totalData set with the acitivityType table to include descriptive activity names

totalData <- merge(totalData,activityType,by='activityId',all.x=TRUE)

# Update the colNames vector to include the new column names after merge

colNames <- colnames(totalData)

# 4. Appropriately label the data set with descriptive activity names

# Clean up the variable names

for (i in 1:length(colNames)) 
{
        colNames[i] = gsub("\\()","",colNames[i])
        colNames[i] = gsub("-std$","StdDev",colNames[i])
        colNames[i] = gsub("-mean","Mean",colNames[i])
        colNames[i] = gsub("^(t)","time",colNames[i])
        colNames[i] = gsub("^(f)","freq",colNames[i])
        colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
        colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
        colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
        colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
        colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
        colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
        colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
}

# Reassign the new descriptive column names to the totalData set

colnames(totalData) <- colNames

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

# Create a new table, totalDataNoActivityType without the activityType column

totalDataNoActivityType <- totalData[,names(totalData) != 'activityType']

# Summarize the totalDataNoActivityType table to include just the mean of each variable for each activity and each subject

tidyData <- aggregate(totalDataNoActivityType[,names(totalDataNoActivityType) != c('activityId','subjectId')],by=list(activityId=totalDataNoActivityType$activityId,subjectId = totalDataNoActivityType$subjectId),mean)

# Merge the tidyData with activityType to include descriptive acitvity names

tidyData <- merge(tidyData,activityType,by='activityId',all.x=TRUE)

# Export the tidyData set 

write.table(tidyData, './tidyData.txt',row.names=FALSE,sep='\t')