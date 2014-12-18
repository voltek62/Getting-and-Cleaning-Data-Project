Getting-and-Cleaning-Data-Project
=================================


Run_analysis.R

1. Merges the training and the test sets to create one data set.
Inouts : X_test.txt, Y_test.txt, subject_test.txt, X_train.txt, Y_train.txt, subject_train.txt 
Functions : read.table, rbind, colnames 

2. Extracts only the measurements on the mean and standard deviation for each measurement. 
Functions : grep, colnames 

3. Uses descriptive activity names to name the activities in the data set
Inouts : activity_labels.txt
Function : gsub 

4. Appropriately labels the data set with descriptive variable names. 
Functions : names, gsub

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Output : result.txt
Functions : aggregate, colanmes, write.table

The final Tidy Data Set contains the average of mean and stand deviation measures of these variables for each subject and activity. ( 180 records = 30 subjects * 6 activities )