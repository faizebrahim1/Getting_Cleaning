# unzipped <- unzip("getdata%2Fprojectfiles%2FUCI HAR Dataset.zip")
stopifnot(dir.exists("UCI HAR Dataset"))

###first get column names
setwd(dir = "UCI HAR Dataset")

columnsData <- read.delim("features.txt", sep = " ", header = F, col.names = c("pos", "feature"))
numberOfColumns <- nrow(columnsData)
filteredColumnsIndex <- grep("std\\(\\)|mean\\(\\)", columnsData$feature, value = F)
filteredColumnNames <- columnsData[filteredColumnsIndex, ]
###get activity labels
activityMasterData <- read.delim("activity_labels.txt", sep = " ", header = F, col.names = c("activityid", "activity"))

###test set setup
subjectTestData <- read.delim("./test/subject_test.txt", sep ="", col.names = "subject", header = F)
activityTestData <- read.delim("./test/y_test.txt", sep ="", col.names = "activityid", header = F)
testData <- read.fwf("./test/X_test.txt", widths = c(rep.int(16, numberOfColumns) ), header = F, col.names = columnsData$pos)

###training set setup
subjectTrainData <- read.delim("./train/subject_train.txt", sep ="", col.names = "subject", header = F)
activityTrainData <- read.delim("./train/y_train.txt", sep ="", col.names = "activityid", header = F)
trainData <- read.fwf("./train/X_train.txt", widths = c(rep.int(16, numberOfColumns) ), header = F, col.names = columnsData$pos)

###merge test & train
allSubjects <- rbind(subjectTestData, subjectTrainData)
allActivities <- rbind(activityTestData, activityTrainData)
allData <- rbind(testData, trainData)

####get activity labels
activitiesWithLabels <-  join(allActivities, activityMasterData)

####get only the mean() and std() columns 
filteredColumnData <- allData[, filteredColumnsIndex]
colnames(filteredColumnData) <- filteredColumnNames$feature
joinedDataFrame <- cbind(subject = allSubjects, activitiesWithLabels, filteredColumnData)

###### STEP 5 ############
totalNumberOfColumns <- ncol(joinedDataFrame)
totalNumberOfValueColumns <- length(filteredColumnsIndex)
startIndexOfValues <- totalNumberOfColumns - totalNumberOfValueColumns + 1
aggregatedData <- aggregate(joinedDataFrame[, startIndexOfValues:totalNumberOfValueColumns], 
                            by = list(subject = joinedDataFrame$subject, activityid=joinedDataFrame$activityid, activity=joinedDataFrame$activity), 
                            mean)

tidyAggregatedData <- aggregatedData[, c(1, 2, startIndexOfValues:totalNumberOfValueColumns)]
# write.table(tidyAggregatedData, file="./summary/X_all.txt", row.names = F)
tidyAggregatedSubject <- aggregatedData[, "subject"]
# tidyAggregatedActivity <- aggregatedData[, "activityid"]
# tidyActivityLabels <- activityMasterData
# tidyFeatures <- as.data.frame(filteredColumnNames$feature, col.names = c("feature"))
# tidyFeatures$id <- seq(nrow(tidyFeatures))
# tidyFeatures <- tidyFeatures[, c(2, 1)]
write.table(tidyFeatures, file="./summary/features_subset.txt", row.names = F, col.names = F)

