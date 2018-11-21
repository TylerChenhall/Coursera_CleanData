library(dplyr)

output_path <- "~/Documents/Coursera Data Science/03 Getting and Cleaning Data/project/"
path <- "~/Documents/Coursera Data Science/03 Getting and Cleaning Data/project/UCI HAR Dataset/"
activity_col_name <- "activity"
subject_col_name <- "subject"


## Load the training data
train_subject <- paste(path, "train/subject_train.txt", sep = "")
train_x <- paste(path, "train/X_train.txt", sep = "")
train_y <- paste(path, "train/y_train.txt", sep = "")

train_subject_data <- read.table(train_subject)
train_x_data <- read.table(train_x)
train_y_data <- read.table(train_y)


## Load the testing data
test_subject <- paste(path, "test/subject_test.txt", sep = "")
test_x <- paste(path, "test/X_test.txt", sep = "")
test_y <- paste(path, "test/y_test.txt", sep = "")

test_subject_data <- read.table(test_subject)
test_x_data <- read.table(test_x)
test_y_data <- read.table(test_y)


## Merge datasets
train_data <- cbind(train_subject_data, train_x_data, train_y_data)
test_data <- cbind(test_subject_data, test_x_data, test_y_data)

full_data <- rbind(train_data, test_data)


## Load and apply column names to the dataset
feature_file <- paste(path, "features.txt", sep = "")
features <- read.table(feature_file,
                       colClasses = c("integer", "character"))

names(full_data) <- c(subject_col_name, features[,2], activity_col_name)


## Load activity names and use them to replace activity numbers
activity_file <- paste(path, "activity_labels.txt", sep = "")
activities <- read.table(activity_file)

full_data[,activity_col_name] <- sapply(full_data[,activity_col_name],
                                        function(act_number) {
                                          return (activities[act_number,2])
                                        })


## Filter columns. We only want mean and standard deviation (std) columns,
## along with the identifying labels
selected_data <- full_data[, names(full_data) == activity_col_name |
                             names(full_data) == subject_col_name |
                             grepl("mean()", names(full_data), fixed = TRUE) |
                             grepl("std()", names(full_data), fixed = TRUE)]


## Organize the dataset before output
selected_data <- arrange(selected_data, subject)


## Output dataset 1
output_1_file <- paste(output_path, "tidy_activity_dataset.txt", sep = "")
write.table(selected_data, output_1_file, sep = " ", row.names = FALSE)


## Group by activity and subject. Average the columns.
grouped_data <- group_by(selected_data, subject, activity)
means_data <- summarize_all(grouped_data, mean)


## Output dataset 2 - Means of previously selected columns
output_2_file <- paste(output_path, "tidy_activity_dataset_means.txt", sep = "")
write.table(means_data, output_2_file, sep = " ", row.names = FALSE)


