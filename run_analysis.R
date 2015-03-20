Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(Url,destfile="DS.zip")
unzip(zipfile="DS.zip")
testDS<- read.table("UCI HAR Dataset/test/X_test.txt")
trainDS<- read.table("UCI HAR Dataset/train/X_train.txt")
act_label<-read.table("UCI HAR Dataset/activity_labels.txt")
test_activities<- read.table("UCI HAR Dataset/test/y_test.txt")
train_activities<- read.table("UCI HAR Dataset/train/y_train.txt")
test_subject<- read.table("UCI HAR Dataset/test/subject_test.txt")
train_subject<- read.table("UCI HAR Dataset/train/subject_train.txt")
names(test_subject)<-c("subject")
names(train_subject)<-c("subject")
test_activities$sorting<- rownames(test_activities)
train_activities$sorting<- rownames(train_activities)
test_merge<-merge(test_activities, act_label, by="V1")
train_merge<-merge(train_activities, act_label, by="V1")
test_merge$sorting<-as.numeric(test_merge$sorting)
train_merge$sorting<-as.numeric(train_merge$sorting)
test_merge<-test_merge[order(test_merge[2]), ]
train_merge<-train_merge[order(train_merge[2]), ]
rownames(test_merge)<-test_merge$sorting
rownames(train_merge)<-train_merge$sorting
test_merge<-subset(test_merge, select = c(V1,V2))
train_merge<-subset(train_merge, select = c(V1,V2))
testDS1<-cbind(activity=test_merge$V2, testDS)
trainDS1<-cbind(activity=train_merge$V2, trainDS)
testDS2<-cbind(test_subject, testDS1)
trainDS2<-cbind(train_subject, trainDS1)
DS<-merge(testDS2, trainDS2, all=TRUE, sort=FALSE)
features<- read.table("UCI HAR Dataset/features.txt")
select_features<-features[((grepl("mean()", features$V2))&!(grepl("meanFreq()", features$V2)))|((grepl("std()", features$V2))),]
feature_hlp<-select_features[,1]+2
final_data<-DS[,feature_hlp]      #Display only selected Variables
final_data<-cbind(activity=DS$activity,final_data)
final_data<-cbind(subject=DS$subject,final_data)
c_names<-as.vector(select_features[,2])
col<- append("activity",c_names)
col<- append("subject",col)
colnames(final_data)<-col #Set column names
names(final_data)<-gsub("^t", "time", names(final_data))
names(final_data)<-gsub("^f", "frequency", names(final_data))
names(final_data)<-gsub("Acc", "Accelerometer", names(final_data))
names(final_data)<-gsub("Gyro", "Gyroscope", names(final_data))
names(final_data)<-gsub("Mag", "Magnitude", names(final_data))
names(final_data)<-gsub("BodyBody", "Body", names(final_data))
TidyData<-aggregate(. ~subject + activity, final_data, mean)
TidyData<-TidyData[order(TidyData$subject,TidyData$activity),]
write.table(TidyData, file = "tidydata.txt",row.name=FALSE)
