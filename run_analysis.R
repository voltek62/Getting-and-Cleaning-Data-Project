library("data.table")

# step 1 : Merges the training and the test sets to create one data set.

dt_test = read.table("./data/test/X_test.txt")
dt_test[,562] = read.table("./data/test/Y_test.txt")
dt_test[,563] = read.table("./data/test/subject_test.txt")

dt_train = read.table("./data/train/X_train.txt")
dt_train[,562] = read.table("./data/train/Y_train.txt")
dt_train[,563] = read.table("./data/train/subject_train.txt")

dt = rbind(dt_test,dt_train, fill=TRUE)

names <- read.table("./data/features.txt")

names(dt) <- names[,2]
colnames(dt)[562] <- "activity"
colnames(dt)[563] <- "subject"

# step 2 : Extracts only the measurements on the mean and standard deviation for each measurement. 

names_MeanFreq = grep("meanFreq", colnames(dt))

for (col_MeanFreq in names_MeanFreq) {  
  dt[,col_MeanFreq] <- NULL
}

dt_extract <- dt[,grep("*mean()*|std|activity|subject", colnames(dt))]

# step 3 : Uses descriptive activity names to name the activities in the data set

activities <- read.table("./data/activity_labels.txt")

current = 1
for (activity in activities$V2) {
  dt_extract$activity <- gsub(current, activity, dt_extract$activity)
  current <- current + 1
}

# step 4 : Appropriately labels the data set with descriptive variable names. 
# step 5 : From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

dt_result = aggregate(dt_extract, by=list(dt_extract$activity, as.factor(dt_extract$subject)), mean)

names(dt_result) <- gsub("Acc", " Accelerator ", names(dt_result))
names(dt_result) <- gsub("-mean", " Mean ", names(dt_result))
names(dt_result) <- gsub("-std", " Standard ", names(dt_result))
names(dt_result) <- gsub("Gyro", " Gyroscope ", names(dt_result))
#names(dt_result) <- gsub("()", " ", names(dt_result))

colnames(dt_result)[1] <- "activity"
colnames(dt_result)[2] <- "subject"

# delete useless column
dt_result[,ncol(dt_result)] <- NULL
dt_result[,ncol(dt_result)] <- NULL

write.table(dt_result, "result.txt", row.name=FALSE)
