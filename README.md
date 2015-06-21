#Getting and Cleaning Data: Course Project

##Introduction
The Peer Assessed Assignment of the popular Coursera Course

##Steps to be Executed
* Unzip the source ( https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ) in the current working directory of R.
* Put run_analysis.R in the same folder
* in RStudio: source("run_analysis.R")
* The latter will run the R script, it will read the dataset and write these files:
 - merged_data.txt -- 7.95 Mb, a 10299x68 data frame
 - data_with_means.txt -- 219 Kb, a 180x68 data frame
* Lastly, use data <- read.table("data_with_means.txt") command in RStudio to read the file. Since we are required to get the average of each variable for each activity and each subject, and there are 6 activities in total and 30 subjects in total, we have 180 rows with all combinations for each of the 66 features.