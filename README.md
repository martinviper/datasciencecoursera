# datasciencecoursera
Repo for Data Science Specialization projects on Coursera

## GETTING AND CLEANING DATA Project
Requirements for the project are:
-	merging the training and the test sets to create one data set.
-	extracting measurements on the mean and standard deviation for each measurement
-	usage of descriptive activity names to name the activities in the data set
-	appropriately labeling the data set with descriptive activity names
-	Creation of a tidy data set with the average (mean) of each variable for each activity and each subject

### There are 3 main functions used to manipulate input data in order to get desired output (to meet criteria of the project):
-	data_merge()
-	read_measurements()
-	set_tidy_data_set()

### data_merge()
This function merges all required input data available for this project from various text files into a single data set outputted as ‘merged_data’. It should contain observations of training and test data sets for all variables with additional columns (subject, activity, activity id).

### read_measurements()
This function subsets ‘merged_data’ outputted by previous function (takes it as an INPUT data) to get only related data from mean and standard deviation columns. Output data should be a subset of training and test data holding observations of lesser number of variables (including variables for column headers having ‘mean()’ and ‘std()’ names in it)
