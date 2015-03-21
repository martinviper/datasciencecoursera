### Created R script called run_analysis.R does the following:
### 1. Merges the training and the test sets to create one data set.
### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
### 3. Uses descriptive activity names to name the activities in the data set.
### 4. Appropriately labels the data set with descriptive variable names.
### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#install.packages("downloader")
if (!require("downloader")) {
    install.packages("downloader")
}
#install.packages("reshape2")
if (!require("reshape2")) {
    install.packages("reshape2")
}
#install.packages("data.table")
if (!require("data.table")) {
    install.packages("data.table")
}

require("downloader")
require("reshape2")
require("data.table")


### 1) Merging data in the training and the test sets by data_merge function
### 3) Using descriptive activity names to name the activities
### 4) Labeling the data set with descriptive variable names
data_merge <- function() {
    ## reading datasets
    test_data <- read.table("test/X_test.txt")
    training_data <- read.table("train/X_train.txt")
    ## reading activity names/labels
    activity_names <- read.table("activity_labels.txt")
    ## reading the test and training subject labels
    test_subject <- read.table("test/subject_test.txt")
    training_subject <- read.table("train/subject_train.txt")
    ## reading the test and training y labels
    test_y <- read.table("test/y_test.txt")
    training_y <- read.table("train/y_train.txt")
    ## merging y test and training activity labels
    y_test_names <- merge(test_y,activity_names,by="V1")
    y_training_names <- merge(training_y,activity_names,by="V1")
    ## merging the test, training data and names/labels
    training_data <- cbind(training_subject,y_training_names,training_data)
    test_data <- cbind(test_subject,y_test_names,test_data)
    ## merging the test and training data to be returned from function
    merged_data <- rbind(training_data,test_data)
    return (merged_data)
}

### 2) Reading each measurement on the mean and standard deviation
### 3) Using descriptive activity names to name the activities
### 4) Labeling the data set with descriptive variable names
read_measurements <- function(merged_data) {
    features <- read.table("features.txt")
    ## subseting rows with column names containing the word 'mean' and 'std'
    mean_std_measurements <- subset(features, grepl("(mean\\(\\)|std\\(\\))", features$V2) )
    ## giving friendly names for column headers from combined data
    colnames(merged_data) <- c("Subject","Activity_ID","Activity",as.vector(features[,2]))
    ## getting data where column name is 'mean' or 'std' from the merged data
    ## and saving all into a vector with names sorted
    mean_cols <- grep("mean()", colnames(merged_data), fixed=TRUE)
    std_cols <- grep("std()", colnames(merged_data), fixed=TRUE)
    columns <- c(mean_cols, std_cols)
    columns <- sort(columns)
    ## extract the columns with std and mean in their column headers
    measurements <- merged_data[,c(1,2,3,columns)]
    return (measurements)
}

### 5) Creating independent tidy data set with the average of each variable
### for each activity and each subject
set_tidy_data_set <- function(merged_data) {
    our_data <- melt(merged_data, id=c("Subject","Activity_ID","Activity"))
    ## using dcast function from reshape module to get tidy data format
    tidy_data <- dcast(our_data, formula = Subject + Activity_ID + Activity ~ variable, mean)
    ## formating column names in our tidy data set
    columns <- colnames(tidy_data)
    columns <- gsub("-mean()","Mean",columns,fixed=TRUE)
    columns <- gsub("-std()","Std",columns,fixed=TRUE)
    columns <- gsub("BodyBody","Body",columns,fixed=TRUE)
    colnames(tidy_data) <- columns
    ## writing output into a file
    write.table(tidy_data, file="tidy_data_set.txt", sep="\t", row.names=FALSE)
}

merged_data <- data_merge()
measurements_data <- read_measurements(merged_data)
set_tidy_data_set(measurements_data)
