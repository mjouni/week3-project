# _Week 3 Project_

_Description: This repo will contain the data cleanup script ran over the data provided in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones_

To run the cleanup script, please make sure to unzip the data in the above mentioned link into the same folder where run_analysis.R resides.

When the run_analysis.R script is ran, the output will be a summary_ds.txt file that will contain a grouping of the variables by activity type and subject, along with the average of each measurement taken. "summary_ds.txt" can be loaded into R by running read.table(file="summary_ds.txt". header=TRUE)
