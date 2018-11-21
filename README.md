# Coursera_CleanData

## Summary
This repository contains deliverables for the Coursera - Getting and Cleaning Data final project. The main file, _run\_analysis.R_ contains R code which reads in a dataset from the UCI Machine Learning Repository, and creates two tidy data summaries as output. Details about the original dataset can be found on [The UCI Machine Learning Repository website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). Several other files are included to provide details about the output files. The output files are not included in this repository.

## Analysis Requirements

* Merge testing and training data
* Only include mean and standard deviation values for each measurement in the original data
* Apply meaningful names for the columns
* Replace activity indexes with clear names for the activities

and for the final dataset,

* Take the average of each column by activity type and subject

## Overview of Analysis
We provide a brief overview of what the analysis code does (and does not) do.

First, note that several files in the original dataset are ignored by the analysis code. In particular, we have no need for the raw data in the "Inertial Signals" folders, since there are no mean or standard deviation values.

In order to provide descriptive names, the analysis code extracts feature notes from _features.txt_ (for column names) and _activity\_labels.txt_ (for activity names). This conveniently lets us avoid dealing with a long list of names manually.

### Analysis Steps

1. Read the 3 training data files
2. Read the 3 test data files
3. Bind the columns for subject and activity index to the feature data for both testing and training
4. Combine the two datasets row-wise to create a single monolithic 10299 x 563 entry table
5. Read _features.txt_, and attach the feature names to the table
6. Read _activity\_labels.txt_ and use the names to replace the activity indexes
7. Extract only the mean and standard deviation columns from the data table (plus subject and activity). This leaves 68 columns.
8. Output the large tidy dataset (which doesn't summarize row values)
9. Average each column of the table after grouping by activity and subject
10. Write the final output file, which contains one entry for each (subject, activity) pair, for each column. The value in each column corresponds to the mean taken from the column of the same name in the first dataset. This results in a table of 180 x 68 entries.

