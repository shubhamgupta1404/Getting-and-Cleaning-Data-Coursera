library(data.table)
#Merges the training and the test sets to create one data set.
#Reading Data
data_train <- read.table("train/X_train.txt")
data_test <- read.table("test/X_test.txt")
label_train <- read.table("train/y_train.txt")
label_test <- read.table("test/y_test.txt")
subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")
#Merging Data
merged_data <- rbind(data_train, data_test)
label_merged <- rbind(label_train, label_test)
subject_merged <- rbind(subject_train, subject_test)

#Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("features.txt")
mean_data <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
merged_data <- merged_data[, mean_data]
names(merged_data) <- features[mean_data, 2]
names(merged_data) <- gsub("\\(|\\)", "", names(merged_data))
names(merged_data) <- tolower(names(merged_data))

#Uses descriptive activity names to name the activities in the data set
activity <- read.table("activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
label_merged[,1] <- activity[label_merged[,1],2]
names(label_merged) <- "activity"

#Appropriately labels the data set with descriptive variable names.
names(subject_merged) <- "subject"
clean_data <- cbind(subject_merged, label_merged, merged_data)
write.table(clean_data, "merged_data.txt")

#Creates a second, independent tidy data set with the average of each variable for each activity and each subject
len_subject <- length(table(subject_merged))
len_activity <- dim(activity)[1]
len_column <- dim(clean_data)[2]
ans <- matrix(NA, nrow=len_subject*len_activity, ncol=len_column) 
ans <- as.data.frame(ans)
colnames(ans) <- colnames(clean_data)
row <- 1
for(i in 1:len_subject) {
    for(j in 1:len_activity) {
        ans[row, 1] <- sort(unique(subject_merged)[, 1])[i]
        ans[row, 2] <- activity[j, 2]
        bool1 <- i == clean_data$subject
        bool2 <- activity[j, 2] == clean_data$activity
        ans[row, 3:len_column] <- colMeans(clean_data[bool1&bool2, 3:len_column])
        row <- row + 1
    }
}

#Final Preprocessed Data
write.table(ans, "data_with_means.txt")
