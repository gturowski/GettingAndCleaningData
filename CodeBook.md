#Getting And Cleaning Data Codebook

#####Code book that describes the variables, the data, and any transformations or work that I performed to clean up the data.

#####The site where the data was obtained: 
#######http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

#####The data for the project: 
#######https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#####The script performs a number of operations to collect, work with, and clean the data set. Result of this script is a tidy data that can be used for later analysis.
---
run_analysis.R

* Download the file with the data for the project and put it into working directory, unzip it.
* Read X_test.txt, y_test.txt and subject_test.txt from the "UCI HAR Dataset/test" folder and store them in testDS, test_activities and test_subject variables respectively.
* Read X_train.txt, y_train.txt and subject_train.txt from the "UCI HAR Dataset/train" folder and store them in trainDS, train_activities and train_subject variables respectively.
* Read activity_labels.txt from the "UCI HAR Dataset" folder and store it in act_label variable.
* Translate activity numbers into descriptions. Because test_activities and train_activities have different number of rows than act_label which is a data frame with activity full names, an additional column needs to introduced (test_activities$sorting and train_activities$sorting) that will allow retaining the original row order. Initially this column has the same values as the rownames.
* Merge test_activities and train_activities with act_label by V1 column. As a result we are granted with test_merge and train_merge data frames where IDs are translated into full descriptions.
* Bring back old row order – we need the original order to merge this data frame with testDS and trainDS. Sorting column needs to be numeric for the sorting to be correct. Order by sorting columns.
* Set correct row names - they should be the same as the sorting column values.
* Remove sorting column - it was necessary only to solve the sorting problem.
* Add activity column to get test and train data frames with all data. testDS1 and trainDS1 are original testDS and trainDS tables respectively with activity column included.
* Add subject column to get test and train data frames with all data. testDS2 and trainDS2 are original testDS1 and trainDS1 tables respectively with subject column included.
* Merge testDS2 and trainDS2 data frames to get DS dataset with full data.
* Read features.txt from the "UCI HAR Dataset" folder and store it in features variable.
* Subset features to get only variables with mean and standard deviation, store the result in select_features variable.
* Use select_features to create final_data data frame. Subject and Activity columns must be considere that's why 2 must be added to the result which is stored in feature_hlp variable. final_data variable is crated based on feature_hlp.
* Add subject and activity columns to the final data data frame that was previously filtered by feature_hlp variable.
* Set column names using select_features variable, create additional variables called c_names and col to accomplish that.
* Label the data inside the final_data data frame with descriptive variable names: t=time, f=frequency, Acc=Accelerometer, Gyro=Gyroscope, Mag=Magnitude, BodyBody=Body.
* Create a second, independent tidy data set called TidyData and write it to tidydata.txt file
