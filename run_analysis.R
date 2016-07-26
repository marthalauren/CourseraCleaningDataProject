setwd("~/Data Science/Final/UCI HAR Dataset")
library(dplyr)

# Read Data into R
TrainSet <- read.table("~/UCI HAR Dataset/train/X_train.txt", header = FALSE)
TestSet <- read.table("~/UCI HAR Dataset/test/X_test.txt", header = FALSE)
TrainSubject <- read.table("~/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
TestSubject <- read.table("~/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
Y_train <- read.table("~/UCI HAR Dataset/train/Y_train.txt", header = FALSE)
Y_test <- read.table("~/UCI HAR Dataset/test/Y_test.txt", header = FALSE)
traintotalaccx <- read.table("~/UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", header = FALSE)
traintotalaccy <- read.table("~/UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", header = FALSE)
traintotalaccz <- read.table("~/UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", header = FALSE)
trainbodyaccx <- read.table("~/UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", header = FALSE)
trainbodyaccy <- read.table("~/UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", header = FALSE)
trainbodyaccz <- read.table("~/UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", header = FALSE)
trainbodygyrox <- read.table("~/UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt", header = FALSE)
trainbodygyroy <- read.table("~/UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt", header = FALSE)
trainbodygyroz <- read.table("~/UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt", header = FALSE)
testtotalaccx <- read.table("~/UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", header = FALSE)
testtotalaccy <- read.table("~/UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", header = FALSE)
testtotalaccz <- read.table("~/UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", header = FALSE)
testbodyaccx <- read.table("~/UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", header = FALSE)
testbodyaccy <- read.table("~/UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", header = FALSE)
testbodyaccz <- read.table("~/UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", header = FALSE)
testbodygyrox <- read.table("~/UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt", header = FALSE)
testbodygyroy <- read.table("~/UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt", header = FALSE)
testbodygyroz <- read.table("~/UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt", header = FALSE)
features <- read.table("~/UCI HAR Dataset/features.txt", header = FALSE)
ActivityLabel <- read.table("~/UCI HAR Dataset/activity_labels.txt", header = FALSE)

#combine test and train data set
DataSet <- rbind(TestSet, TrainSet)
Subject <- rbind(TestSubject, TrainSubject)
Bodyaccx <- rbind(testbodyaccx, trainbodyaccx)
Bodyaccy <- rbind(testbodyaccy, trainbodyaccy)
Bodyaccz <- rbind(testbodyaccz, trainbodyaccz)
Bodygyrox <- rbind(testbodygyrox, trainbodygyrox)
Bodygyroy <- rbind(testbodygyroy, trainbodygyroy)
Bodygyroz <- rbind(testbodygyroz, trainbodygyroz)
Acctotalx <- rbind(testtotalaccx, traintotalaccx)
Acctotaly <- rbind(testtotalaccy, traintotalaccy)
Acctotalz <- rbind(testtotalaccz, traintotalaccz)
Y_label <- rbind(Y_test,Y_train)

#Label Train data set with descriptive variable name
names(DataSet) <- features$V2
DataSet$Subject <- Subject$V1
valid_column_names <- make.names(names=names(DataSet), unique=TRUE, allow_ = TRUE)
names(DataSet) <- valid_column_names

#Use descriptive activity name for activity labels
Yfactors <- factor(Y_label$V1, levels = ActivityLabel$V1, labels = ActivityLabel$V2)
DataSet$ActivityLabel <- Yfactors

#calculate mean and sds
DataSet$meanbodygyrox <- rowMeans(Bodygyrox)
DataSet$meanbodygyroy <- rowMeans(Bodygyroy)
DataSet$meanbodygyroz <- rowMeans(Bodygyroz)
DataSet$meantotalaccx <- rowMeans(Acctotalx)
DataSet$meantotalaccy <- rowMeans(Acctotaly)
DataSet$meantotalaccz <- rowMeans(Acctotalz)
DataSet$meanbodyaccx <- rowMeans(Bodyaccx)
DataSet$meanbodyaccy <- rowMeans(Bodyaccy)
DataSet$meanbodyaccz <- rowMeans(Bodyaccz)
DataSet$sdbodygyrox <- apply(Bodygyrox, 1, sd)
DataSet$sdbodygyroy <- apply(Bodygyroy, 1, sd)
DataSet$sdbodygyroz <- apply(Bodygyroz, 1, sd)
DataSet$sdtotalaccx <- apply(Acctotalx, 1, sd)
DataSet$sdtotalaccy <- apply(Acctotaly, 1, sd)
DataSet$sdtotalaccz <- apply(Acctotalz, 1, sd)
DataSet$sdbodyaccx <- apply(Bodyaccx, 1, sd)
DataSet$sdbodyaccy <- apply(Bodyaccy, 1, sd)
DataSet$sdbodyaccz <- apply(Bodyaccz, 1, sd)
DataSet <- select(DataSet, Subject, ActivityLabel, tBodyAcc.mean...X:sdbodyaccz)

#housekeeping, remove other data and values that are not necessary
rm(TrainSet, TestSet, TrainSubject, TestSubject, Y_train, Y_test, traintotalaccx, traintotalaccy, traintotalaccz, Subject, trainbodyaccx, trainbodyaccy, trainbodyaccz, trainbodygyrox, trainbodygyroy,trainbodygyroz, testtotalaccx, testtotalaccy, testtotalaccz, testbodyaccx, testbodyaccy, testbodyaccz, testbodygyrox, testbodygyroy,testbodygyroz, Acctotalx, Acctotaly, Acctotalz, ActivityLabel, Bodyaccx, Bodyaccy, Bodyaccz, Bodygyrox, Bodygyroy, Bodygyroz, features, Y_label, Yfactors, valid_column_names)

#Create 2nd tidy set
groups <- group_by(DataSet,  Subject, ActivityLabel)
summarydata<-summarize_each(groups, "mean", tBodyAcc.mean...X:sdbodyaccz)
rm(groups)
