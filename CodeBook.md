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
