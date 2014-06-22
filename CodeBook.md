# Information
Details in this file include:
1. what variables were discarded from the raw data
2. merging of information and data from different files
3. what variable names were changed.

# Variables used in this data
The units of measurements provided for the raw data is unknown and left as is.
The working directory was set to the unzipped folder containing the raw data '/UCI HAR Dataset/

## Step 1:
*trainData : data read as table from "./train/X_train.txt"
*testData : data read as table from "./test/X_test.txt"
*combineData : combined data from rbind on trainData and testData

## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
*readColLabels : table containing all the measurements, read from "features.txt". The required information is only on column 2
*colLabels : take the required information (column 2) in readColLabels
*getMeanColumns : a data subset from a grep search to look for column names that contain the word 'mean'
*getStdColumns : a data subset from a grep search to look for column names that contian the word 'std' (standard deviation)
*combineMeanStdData: a new data frame that combines the subset data getMeanColumns and getStdColumns using cbind

## Step 3:

# Raw data link information
The link to download the raw data files and other information:
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]

More information on the raw data files can be found at:
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]

