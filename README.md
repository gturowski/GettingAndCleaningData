
# Getting and Cleaning Data

1.	Download the file and put it into your working directory
Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(Url,destfile="./DS.zip")
2.	Unzip the file
unzip(zipfile="./data/DS.zip")
3.	Read data from files that are going to be used in the assignment
Read data from main Datasets
testDS<- read.table("UCI HAR Dataset/test/X_test.txt")
trainDS<- read.table("UCI HAR Dataset/train/X_train.txt")
Read data from Activity files
test_activities<- read.table("UCI HAR Dataset/test/y_test.txt")
train_activities<- read.table("UCI HAR Dataset/train/y_train.txt")
Read data from Subject files
test_subject<- read.table("UCI HAR Dataset/test/subject_test.txt")
train_subject<- read.table("UCI HAR Dataset/train/subject_train.txt")
Read data from additional files
act_label<-read.table("UCI HAR Dataset/activity_labels.txt")
4.	Translate activity numbers to descriptions
Because activity tables have different number of rows than act_label table which is a table with activity full names an additional column needs to introduced (column name = sorting) that will allow retaining the original row order. Initially this column is the same as the rownames.
test_activities$sorting<- rownames(test_activities)
train_activities$sorting<- rownames(train_activities)
Merging activity table with the labels
test_merge<-merge(test_activities, act_label, by="V1")
train_merge<-merge(train_activities, act_label, by="V1")
Bringing back old row order – we need the original order to merge this table with the main dataset
Sorting column needs to be numeric for the sorting to be correct
test_merge$sorting<-as.numeric(test_merge$sorting)
train_merge$sorting<-as.numeric(train_merge$sorting)
test_merge<-test_merge[order(test_merge[2]), ]
train_merge<-train_merge[order(train_merge[2]), ]
Setting correct row names
rownames(test_merge)<-test_merge$sorting
rownames(train_merge)<-train_merge$sorting
Removing sorting column
test_merge<-subset(test_merge, select = c(V1,V2))
train_merge<-subset(train_merge, select = c(V1,V2))
5.	Add activity and subject columns to get test and train data frames with all data
testDS1<-cbind(activity=test_merge$V2, testDS)
trainDS1<-cbind(activity=train_merge$V2, trainDS)
testDS2<-cbind(test_subject, testDS1)
trainDS2<-cbind(train_subject, trainDS1)
6.	Merge test and train data frames to get dataset with full data
DS<-merge(testDS2, trainDS2, all=TRUE, sort=FALSE)
7.	Read features file to get variable names
features<- read.table("UCI HAR Dataset/features.txt")
8.	Subset features to get only variables with mean and standard deviation
f1<-features[((grepl("mean()", features$V2))&!(grepl("meanFreq()", features$V2)))|((grepl("std()", features$V2))),]
9.	Display only selected variables
feature_hlp<-select_features[,1]+2
V1<-feature_hlp   
final_data<-DS[,V1]
10.	Add subject and activity to the final data data frame
final_data<-cbind(activity=DS$activity,final_data)
final_data<-cbind(subject=DS$subject,final_data)
11.	Set column names
c_names<-as.vector(select_features[,2])
col<- append("activity",c_names)
col<- append("subject",col)
colnames(final_data)<-col #Set column names
12.	Label the data with descriptive variable names
names(final_data)<-gsub("^t", "time", names(final_data))
names(final_data)<-gsub("^f", "frequency", names(final_data))
names(final_data)<-gsub("Acc", "Accelerometer", names(final_data))
names(final_data)<-gsub("Gyro", "Gyroscope", names(final_data))
names(final_data)<-gsub("Mag", "Magnitude", names(final_data))
names(final_data)<-gsub("BodyBody", "Body", names(final_data))
13.	Create a second, independent tidy data set and write it to text file
TidyData<-aggregate(. ~subject + activity, final_data, mean)
TidyData<-TidyData[order(TidyData$subject,TidyData$activity),]
write.table(TidyData, file = "tidydata.txt",row.name=FALSE)

