## Course Project - Getting and Cleaning Data
## July 2017
## Cristina Lozano

# a. Download and unzip the file

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/courseproject.zip",method="curl")
unzip(zipfile="./data/courseproject.zip",exdir="./data")


# b. List files

allfiles <- file.path("./data" , "UCI HAR Dataset")
files <- list.files(allfiles, recursive = TRUE)
files

# c. Reading trainings tables:
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# d. Reading testing tables:
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# e. Reading feature vector:
features <- read.table('./data/UCI HAR Dataset/features.txt')

# f. Reading activity labels:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')


# g. Naming columns
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

# h. Merge all tables and data together

mrg_train <- cbind(y_train, subject_train, x_train)
mrg_test <- cbind(y_test, subject_test, x_test)
setAllInOne <- rbind(mrg_train, mrg_test)


# i. Read columns and create vectors for: ID, mean and SD:
colNames <- colnames(setAllInOne)

mean_and_std <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)

# j. Define necessary subset

setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]

# k. Merge data according to their ID

setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)

# l. Create new data set with tidy data and export to a .txt

secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

finalSet <- write.table(secTidySet, "secTidySet.txt", row.name=FALSE)




