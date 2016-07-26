# CourseraCleaningDataProject
Submissions for the Getting and Cleaning Data Project for the course requirement in Coursera

This Project contains:
1. Run_Analysis.R -  code for consolidating train and test data set. Output are two data set. 1st is the clean data set(DataSet), and 2nd is the summary of variable averages by Subject and Activity (summarydata)
2. datacodebook.txt - describes the data contained in the clean data set (DataSet)

Run_Analysis.R

The code was structured to execute as follows
a. Read all the necessary data from the orignal source files
b. Combine test and train data
c. Label the data with the approproate descriptive variable names (columns)
d. Label activities by activity name (convert activity class to activity names)
e. Calculate mean and standard deviations for each measurement and attach to the DataSet
f. Remove all other unnecessary data/values
g. Summarize the data set. Resulting average values for each variable by Subject and Activity
