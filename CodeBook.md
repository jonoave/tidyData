# Information
Details in this file include:
1. what variables were discarded from the raw data
2. merging of information and data from different files
3. what variable names were changed.

# Variables used in this data
The units of measurements provided for the raw data is unknown and left as is.
The working directory was set to the unzipped folder containing the raw data "/UCI HAR Dataset/""

## Step 1: Merging the training and test data
* trainData : data read as table from "./train/X_train.txt"
* testData : data read as table from "./test/X_test.txt"
* combineData : combined data from rbind on trainData and testData

## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
* readColLabels : table containing all the measurements, read from "features.txt". The required information is only on column 2
* colLabels : take the required information (column 2) in readColLabels. The column labels (measurements) were used to label all the measurements in combineData.
* getMeanColumns : a data subset from a grep search to look for column names that contain the word 'mean'. 
* getStdColumns : a data subset from a grep search to look for column names that contian the word 'std' (standard deviation).
* combineMeanStdData: a new data frame that combines the subset data getMeanColumns and getStdColumns using cbind.

## Step 3: Uses descriptive activity names to name the activities in the data set 
* readYtrainActivityNumbers: data that was read and contains the activity numbers (1-6) for each row of the training data set. 
* readYtestActivityNumbers: data that was read and contains the activity numbers (1-6) for each row of the test data set.
* yActivityNumbers: combined data from readYtrainActivityNumbers and readYtestActivityNumbers using rbind.
* readActivityLabels: data that was read from "activity_labels.txt" that reads the 6 activities (e.g. WALKING)
* mergedActivity: merge the numbers in yActivityNumbers to the corresponding activity.
dataWithActivityLabels: new data frame that was created by adding the mergedActivity information (in column form) to combineMeanStdData using cbind

## Step 4: Appropriately labels the data set with descriptive variable names.
No changes or data manipulations were done here, as I assume variable names are the same as measurement names.
The measurement names have already been added to the data frame in Step 1.

## Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* readTrainSubjects: data that was read and contains the subject numbers (1-30) for each row of the training data set."./train/subject_train.txt"
* readTestSubjects: data that was read and contains the activity numbers (1-30) for each row of the test data set."./test/subject_test.txt"
* subjects: combined data from readTrainSubjects and readTestSubjects using rbind
* dataWithSubjects: new data frame by adding subjects as first column to dataWithActivityLabels. The first column is renamed to "subjects"
* sortedSubjectData: modified dataWithSubjects where it is sorted by subjects (1-30)
* colLabels: list of column names (measurements), excluding the first 2 columns ("subjects" and "activity")
* tidyDataFrame: initiate empty data frame to store information from subsequently modified data of dataWithSubjects
### variables used in a loop function to subset data by subject, then melt each measurement by activiy to get the mean of each measurement
* dataSubjectI: subset of dataWithSubjects only for subject I (I is between 1-30)
* dataIMelt: melt dataSubject I for all measurements (given by colLabels) by activity 
* subjectIMelt: collapse all measurement columns as mean per activity
* subjectColAdd: readds the subject column to subset data dataSubjectI. Append dataSubjectI to tidyDataFrame.
* tidyDataFrame: after completion of loop, this data frame has 81 rows (30 subjects * 6 activities, plus one header row)
* tidyData.txt: a text file, where tidyDataFrame is written out as tab-delimited tab file.

# Raw data link information
The link to download the raw data files and other information:
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]

More information on the raw data files can be found at:
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]

