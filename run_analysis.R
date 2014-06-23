#step 1
trainData <- read.table("./train/X_train.txt")
head(trainData)
testData <- read.table("./test/X_test.txt")
head(testData)
combineData <- rbind(trainData,testData)
dim(combineData)

#step 2
readColLabels <-read.table("./features.txt")
head(readColLabels)
colLabels <-readColLabels[,2]
head(colLabels)
colnames(combineData) <- colLabels # assign names to columns
head(combineData)
getMeanColumns <- combineData[,grep("mean", colnames(combineData))]
head(getMeanColumns)
getStdColumns <- combineData[,grep("std", colnames(combineData))]
head(getStdColumns)
combineMeanStdData <- cbind(getMeanColumns,getStdColumns)
head(combineMeanStdData)

#step 3
nrow(combineMeanStdData)
readYtrainActivityNumbers <-read.table("./train/y_train.txt")
readYtestActivityNumbers <- read.table("./test/y_test.txt")
yActivityNumbers <- rbind(readYtrainActivityNumbers,readYtestActivityNumbers)
readActivityLabels <- read.table("./activity_labels.txt")
head(yActivityNumbers,50)
head(readActivityLabels)
library(plyr)
mergedActivity = join(yActivityNumbers,readActivityLabels)
head(mergedActivity,100)
dataWithActivityLabels <- cbind(mergedActivity$V2, combineMeanStdData)
head(dataWithActivityLabels)
tail(dataWithActivityLabels)
colnames(dataWithActivityLabels)[1] <- "activity" # rename column

# step 5
# assign subject labels
readTrainSubjects <- read.table("./train/subject_train.txt")
readTestSubjects <- read.table("./test/subject_test.txt")
subjects <- rbind(readTrainSubjects, readTestSubjects)
nrow(subjects)
head(subjects)
dataWithSubjects <- cbind(subjects, dataWithActivityLabels)
colnames(dataWithSubjects)[1] <- "subjects" # rename column
# sort data based 
sortedSubjectData <-dataWithSubjects[order(dataWithSubjects$subjects),]
head(sortedSubjectData,10)
tail(sortedSubjectData,10)
head(rownames(dataWithSubjects))
colLabels = colnames(dataWithSubjects)
colLabels = colLabels[!colLabels=="subjects"]
colLabels = colLabels[!colLabels=="activity"]
tidyDataFrame <- data.frame()
## separate data by subjects, then melt each measurement by activity to get the mean
for(i in 1:30){
  dataSubjectI <- dataWithSubjects[dataWithSubjects$subjects == i,]
  dataIMelt <-melt(dataSubjectI, id="activity", measure.vars = colLabels)
  subjectIMelt <- dcast(data2Melt, activity ~ variable, mean)
  subjectColAdd <- cbind(rep(i, times=6),subjectIMelt) # readds subject column
  tidyDataFrame <- rbind(tidyDataFrame, subjectColAdd)
}
# check new dimensions and contensts of tidyDataFrame
head(tidyDataFrame)
tail(tidyDataFrame)
ncol(tidyDataFrame)
nrow(tidyDataFrame)

# modify the column names of tidyDataFrame to reflect the new data
newColLabels <- paste("MEAN", colLabels,sep="_")
head(newColLabels)
colnames(tidyDataFrame)[3:81] <- newColLabels
colnames(tidyDataFrame)[1] <- "subject"
head(colnames(tidyDataFrame))
write.table(tidyDataFrame, file = "tidyData", sep="\t")
