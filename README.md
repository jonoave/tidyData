# A. Introduction
There are 4 files in this repository, that details the processing of the raw data collected from the accelerometers from the Samsung Galaxy S smartphone into a tidy data set.

The 4 files are:
1. README.md (this file)
2. CodeBook.md
3. run_analysis.R
4. tidyData.txt

## Repository link
The link to this repository is:
[https://github.com/jonoave/tidyData

## CodeBook.md
This is a markdown file that has the details the variables used and changed during the processing of the raw data into tidyData (using the R script run_analysis.R).

Details in CodeBook.md include:
* what variables were discarded from the raw data
* merging of information and data from different files
* what variable names were changed .
* link and references to the original data

## run_analysis.R
This is the R scrip that transforms the raw data into the new tidyData, tidyData.txt.

## tidyData.txt
This is the tidy data generated from the raw data. It is a tab-delimited file that can be easily read into R by using read.delim(tidyData)

# B. How the raw data was processed in the tidy data using run_analysis.R
* Download the zipped file (folder containing the raw data) from:
* Unzip the file, which will show a folder named 'UCI HAR Dataset'
* Set the working directory in R to /UCI HAR dataset/
* Execute the script 'run_analysis.R' in R.

The execution of the run_analysis.R script will run all the following steps automatically. The information below provides the details on what the script is doing at each step.

## Step 1: Merging the training and test data
*Set working directory /UCI HAR Dataset/
*Accelerometer data from training data (./train/X_train.txt)
and test data(./test/X_train.txt) were read as data frames
* Both training and test data were combined using rbind into a new data frame named 'combineData'

## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
* As the number of measurements were too numerous and some descriptions were not clear, it was assumed that the word 'mean' in the measurements would refer to mean. Similarly, a glance towards the column names indicate that 'std' would refer to standard dviation.
* To look for measurements on the mean, a grep search was conducted on combineData to look for column names that contain the word 'mean'.
* This was repeated for columns that contain the word 'std'.
* Column data from both grep searches were combined using cbind into a new data frame called combineMeanStdData.

## Step 3: Uses descriptive activity names to name the activities in the data set
* Each row of data in the data frame relates to one of the activities that was being carried out by a subject when the particular measurement (column name) was taken.
* The six types of activities are provided in the 'activity_labels.txt' file as the following: 'WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,SITTING, STANDING,LAYING'.
* As the activity names seemed descriptive enough, I assumed there was no need to add or modify them.
* The activities for each row can be found in both the files './train/Y_train.txt' and './test/Y_test.txt'. Information from both files were combined using rbind.
* The information was then added to combineMeanStdData as the first column using cbind, to create a new data frame 'dataWithActivityLabels'.

## Step 4: Appropriately labels the data set with descriptive variable names. 
* I assume the variable names refers to the measurements (column names) in the data frame. The variable names were provided in simplified form and since there were too many measurements (many columns), any changes to the variable names would be confusing to the user.
* Therefore the variable names were left as is given by the 'features.txt'

## Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
* There are 30 subjects that were used in this study, and the subjects that correspond to each row of data are given by the files "./train/subject_train.txt" and "./test/subject_test.txt"
* The information from both files were combined using rbind and added as a new column called "subjects" to the data frame 'dataWithActivityLabels', to form a new data frame called 'dataWithSubjects'.
* The data is now sorted by subjects, then activity.
* To get the tidy data, a loop function was written that does the following:

1. subset the data frame by subject, e.g data frame that contains only information for subject 1
2. For each measurement (column), collapse that column and get the mean value for that measurement by activity (e.g. WALKING)

* Now recombined all the data frames for each subject into a new tidyDataFrame.
* Write tidyDataFrame to a file within the same working directory called tidyData as a tab-delimited file.