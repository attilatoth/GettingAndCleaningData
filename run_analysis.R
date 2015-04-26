# setwd("GettingAndCleaningData")
# print(getwd())


dirPath <- file.path(getwd(), "UCI HAR Dataset")

# 1. Merges the training and the test sets to create
# one data set.
xTrain <- read.table(file.path(dirPath, "train", "X_train.txt"))
xTest <- read.table(file.path(dirPath, "test", "X_test.txt"))
xData <- rbind(xTrain, xTest)

sTrain <- read.table(file.path(dirPath, "train", "subject_train.txt"))
sTest <- read.table(file.path(dirPath, "test", "subject_test.txt"))
sData <- rbind(sTrain, sTest)

yTrain <- read.table(file.path(dirPath, "train", "Y_train.txt"))
yTest <- read.table(file.path(dirPath, "test", "Y_test.txt"))
yData <- rbind(yTrain, yTest)

# 2. Extracts only the measurements on the mean and
# standard deviation for each measurement. 
features <- read.table(file.path(dirPath, "features.txt"))
indices <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])

xData <- xData[, indices]

names(xData) <- features[indices, 2]
names(xData) <- gsub("\\(|\\)", "", names(xData))
names(xData) <- tolower(names(xData))

# 3. Uses descriptive activity names to name the
# activities in the data set
activities <- read.table(file.path(dirPath, "activity_labels.txt"))
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
yData[,1] = activities[yData[,1], 2]
names(yData) <- "activity"

# 4. Appropriately labels the data set with
# descriptive variable names. 
names(sData) <- "subject"
cleaned <- cbind(sData, yData, xData)
write.table(cleaned, "clean_data.txt",  row.names=F)


# 5. From the data set in step 4, creates a second,
# independent tidy data set with the average of
# each variable for each activity and each subject.
uniqueSubjects = unique(sData)[,1]
numOfSubjects = length(unique(sData)[,1])
numOfActivities = length(activities[,1])
numOfCols = dim(cleaned)[2]
result = cleaned[1:(numOfSubjects * numOfActivities), ]

row = 1
for (s in 1:numOfSubjects) {
    for (a in 1:numOfActivities) {
        result[row, 1] = uniqueSubjects[s]
        result[row, 2] = activities[a, 2]
        tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
        result[row, 3:numOfCols] <- colMeans(tmp[, 3:numOfCols])
        row = row + 1
    }
}
write.table(result, sep="\t", "clean_data_with_averages.txt",  row.names=F)
