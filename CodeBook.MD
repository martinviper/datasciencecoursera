This Code Book keeps descriptions of variables, the data used for analysis and all transformations on that data performed to clean it up. 

Assumption is that INPUT data is already unzipped and placed in specific working directory. R script with transformation functions (run_analysis.R) should be placed inside the UCI HAR Dataset folder in order to work.

Main variable used is called ‘merged_data’ and it is a data table that contains the merged training and test dataset from ‘X_test.txt’ and ‘X_train.txt’ files which should give us 10299 observations with 564 columns. Column names are taken from the ‘features.txt’ file (561 of them) and 3 others called: ‘Subject’, ‘Activity_ID’ and ‘Activity’ are coming from ‘activities.txt’ and ‘y_test_names’. Variable input in terms of mean and standard deviation are loaded as data table containing 10299 observations of 69 columns created by subsetting the variable ‘merged_data’ above. Column name headers mainly consist of partial words ‘mean’ or ‘std’. As we can see the column headers are included in both variables.

We use 3 different functions in order to process data until we get tidy data set. These functions are called:
- data_merge()
- read_measurements()
- set_tidy_data_set()

### data_merge()
For data_merge() function INPUT data is taken from the following files:
-	train/y_train.txt to create variable ‘training_y’ holding data names inside this training set
-	test/y_test.txt to create variable ‘test_y’ holding data names inside this test set. 
-	train/X_train.txt loaded into ‘training_data’ variable holding 541 columns of raw training set data
-	test/X_test.txt loaded into ‘test_data’ variable holding 541 columns of raw test set data
-	activities.txt loaded into ‘activity_names’ variable holding activity types like ‘walking’, ‘sitting’, etc.
-	train/subject_train.txt loaded into ‘training_subject’ variable holding subject’s training data set
-	test/subject_test.txt loaded into ‘test_subject’ variable holding subject’s test data set

Transformations inside data_merge() function that are made on the variables (datasets) shown above include:
-	merging data for training activity names into ‘y_training_names’ variable (input data in ‘training_y’ variable gives us only numeric values like: 2,3 and we want proper names)
-	merging data for test activity names into ‘y_test_names’ variable (input data in ‘test_y’ variable gives us only numeric values like: 1,2 and we want proper names)
-	merging data for training data set into ‘training_data’ data table variable with our new column names (subject, activity, activity id) and other 541 variables
-	merging data for test data set into ‘test_data’ data table variable with our new column names (subject, activity, activity id) and other 541 variables variables
-	merging ‘training_data’ and ‘test_data’ into ‘merged_data’ variable as an output

### read_measurements()
For read_measurements() function INPUT data is taken from the following files:
- features.txt to create variable ‘features_data’ holding features names

Transformations inside read_measurements() function includes modifications on the following variables:
- subsetting data from the ‘features_data’ variable into  ‘mean_std_measurements’ variable to keep only columns for: mean() and std()
- adding 3 new columns with their header names (subject, activity, activity id) to ‘merged_data’ data set variable being output from ‘data_merge()’ function
- extracting ‘mean()’ columns from ‘merged_data’ data set into ‘mean_cols’ variable
- extracting ‘std()’ columns from ‘merged_data’ data set into ‘std_cols’ variable
- creating ‘columns’ vector for holding ‘mean’ and ‘std’ columns
- merging all above data into data table called ‘measurements’ which contains ‘merged_data’ plus 3 additional columns (subject, activity, activity id) and all ‘mean’ and ‘std’ columns defined in ‘columns’ vector

### set_tidy_data_set()
For set_tidy_data_set() function INPUT data is taken from calls to previous functions (mentioned above).

Transformations inside set_tidy_data_set() function include:
- melting data on the 'merged_data' variable in order to get the required (correct) observations into 'our_data' data set
- dcast-ing 'our_data' data set variable into 'tidy_data' variable in order to get means for each of the activities analyzed across different variables
- replacing column headers (mean() into Mean, std() into Std, BodyBody with Body) by the usage of 'columns' vector variable
- applying new column headers from above vector variable on 'tidy_data' and writing it to the table so it could be saved into file called: 'tidy_data_set.txt'
