# The purpose of this project is to demonstrate your ability to collect, 
# work with, and clean a data set. The goal is to prepare tidy data that 
# can be used for later analysis. You will be graded by your peers on a 
# series of yes/no questions related to the project. 
#
# You will be required to submit:
#
#  1) a tidy data set as described below, 
#  2) a link to a Github repository with your script for performing the 
#     analysis, and 
#  3) a code book that describes the variables, the data, and any 
#     transformations or work that you performed to clean up the data 
#     called CodeBook.md. You should also include a README.md in the repo 
#     with your scripts. This repo explains how all of the scripts work 
#     and how they are connected.  
#
# One of the most exciting areas in all of data science right now is 
# wearable computing - see for example this article . Companies like Fitbit, 
# Nike, and Jawbone Up are racing to develop the most advanced algorithms 
# to attract new users. The data linked to from the course website represent 
# data collected from the accelerometers from the Samsung Galaxy S smartphone. 
# A full description is available at the site where the data was obtained:
#
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
#
# Here are the data for the project: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
#
# You should create one R script called run_analysis.R that does the following: 
#  1.Merges the training and the test sets to create one data set.
#  2.Extracts only the measurements on the mean and standard deviation 
#     for each measurement. 
#  3.Uses descriptive activity names to name the activities in the data set
#  4.Appropriately labels the data set with descriptive activity names. 
#  5.Creates a second, independent tidy data set with the average of 
#     each variable for each activity and each subject. 


# Loads required packages 'data.table' and 'reshape2', installing them if necessary.
# 'data.table' is a package for fast subsetting and grouping
# 'reshape2' is a package for easily transforming between wide and long formats.
if (!require("data.table")) {
	install.packages("data.table")
	require("data.table")
}
if (!require("reshape2")) {
	install.packages("reshape2")
	require("reshape2")
}

# sets the various paths for later loading
data.dir <- "UCI_HAR_Dataset" # "/home/tiago/src/GetData/UCI_HAR_Dataset"

test.subject.file <- paste(data.dir, "test/subject_test.txt", sep="/")
test.x.file <- paste(data.dir, "test/X_test.txt", sep="/")
test.y.file <- paste(data.dir, "test/y_test.txt", sep="/")

train.subject.file <- paste(data.dir, "train/subject_train.txt", sep="/")
train.x.file <- paste(data.dir, "train/X_train.txt", sep="/")
train.y.file <- paste(data.dir, "train/y_train.txt", sep="/")

features.file <- paste(data.dir, "features.txt", sep="/")
activity.file <- paste(data.dir, "activity_labels.txt", sep="/")

output.file <- paste(".", "tidy_data.txt", sep="/")

# loads data 
test.subject <- read.table(test.subject.file, quote="\"")
test.x <- read.table(test.x.file, quote="\"")
test.y <- read.table(test.y.file, quote="\"")

train.subject <- read.table(train.subject.file, quote="\"")
train.x <- read.table(train.x.file, quote="\"")
train.y <- read.table(train.y.file, quote="\"")

features <- read.table(features.file, quote="\"")
activity.labels <- read.table(activity.file, quote="\"")

# extracts the column names and levels 
feature.names  <- features[,2]
activity.names <- activity.labels[,2]

# sets the column names in 'test.x' and 'train.x', selects only the columns for mean and
# standard deviation with a grep (as there are many variable, we must check each one for
# either "mean" or "std"), and binds them in a single variable 'measurements' 
names(test.x)  <- feature.names
names(train.x) <- feature.names

test.x  <- test.x[,grepl("mean|std", feature.names)]
train.x <- train.x[,grepl("mean|std", feature.names)]

measurements <- rbind(test.x, train.x)

# appends a column with activity descriptions (=levels) to 'test.y' and 'train.y', binding
# them in a single 'activities' variable, for which the column names are then labelled
test.y[,2]  <- activity.names[test.y[,1]]
train.y[,2] <- activity.names[train.y[,1]]
activities <- rbind(test.y, train.y)
names(activities) <- c("Activity.ID", "Activity.Label")

# binds the subjects from the test and train files, and labels it
subject <- rbind(test.subject, train.subject)
colnames(subject) <- "Subject.Number"

# combines the three tables into a single one, as requested in the assignment
data <- cbind(as.data.table(subject), activities, measurements)

# last step, creates a second, independent tidy data set with the avarage of each variable
# for each subject, writing the results to the specified output file
id.labels <- c("Subject.Number", "Activity.ID", "Activity.Label")
data.labels <- setdiff(colnames(data), id.labels)
temp <- melt(data, id=id.labels, measure.vars=data.labels)
output.data <- dcast(temp, Subject.Number + Activity.Label ~ variable, mean)

write.table(output.data, output.file,sep=",")

