##download and store data
dir.create("./data")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- "./data/Dataset.zip"
download.file(url, destfile, method = "curl")

##unzip dataset
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

##read training data
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

##read testing data
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

##read features
features <- read.table("./data/UCI HAR Dataset/features.txt")

##read actvity labels
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

##apply column names
colnames(x_train) <- features[, 2]
colnames(y_train) <- "activityId"
colnames(subject_train) <- "subjectId"
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

##merge into one dataset
merge_train <- cbind(y_train, subject_train, x_train)
merge_test <- cbind(y_test, subject_test, x_test)
merge_all <- rbind(merge_train, merge_test)

##extract mean and standard dev
column_names <- colnames(merge_all)

mean_and_std <- (grep("activityId", column_names) | 
                         grepl("subjectId", column_names) | 
                         grepl("mean..", column_names) | 
                         grepl("std..", column_names)
)

set_mean_and_std <- merge_all[ , mean_and_std == TRUE]

##name activities
data_with_activity_names <- merge(set_mean_and_std, activity_labels, by.x = "activityId", by.y = "V1", all.x = TRUE)

##create a second tidy dataset with avg of each variable for each activity and subject
second_tidy_dataset <- aggregate(. ~subjectId + activityId, data_with_activity_names, mean)
second_tidy_dataset <- second_tidy_dataset[order(second_tidy_dataset$subjectId, second_tidy_dataset$activityId), ]

write.table(second_tidy_dataset, "second_tidy_dataset.txt", row.name = FALSE)

