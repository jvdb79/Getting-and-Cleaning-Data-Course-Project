Getting and Cleaning Data Project
=================================
run_analysis.R
--------------
The script (run_analysis.R) does the following:
-Merges the training and the test sets to create one data set.
-Extracts only the measurements on the mean and standard deviation for each measurement.
-Uses descriptive activity names to name the activities in the data set
-Appropriately labels the data set with descriptive activity names.
-Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Running the script
------------------

Run the script: run_analysis.R. You will see the following output while the script runs:

"Running 'Getting and Cleaning Data' course project analysis"
"Joining the data"
"Reshaping the data"
"Creating clean data sets"
"Saving the file in the folder specified in object accelDir"

Process
-------

For each of the test and train datasets, run_analysis will produce a preparatory dataset:
-Extract the mean and standard deviation variables (listed in section 'Mean and Standard Deviation Variables' of Codebook.md).
-Get the list of activities and adds activity lables.
-Get the list of subjects and adds subject IDs
-Rowbinds the test and train interim datasets.
-Uses melt to place each variable on its own row.
-Uses dcast to turn the table into a wide data set, caluclating the mean value for each unique combination of subject and activity.-
-Write the clean dataset to disk.

Tidy Data
------------

The resulting clean dataset is in this repository at data/tidyData.txt. It contains one row for each subject/activity pair and columns for subject, activity, and each accelerometer/gyroscope measurement selected from the original data files.

