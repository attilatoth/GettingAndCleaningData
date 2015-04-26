
Labels
------


Getting and Cleaning Data - Course Project Code Book
========
### Input files and required information
Source data can be found at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Description of the data is at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Project description

The `run_analysis.R` R script cleans up the data by:

* merging the training and test sets to create one data set, namely `train/X_train.txt` with `test/X_test.txt`, `train/subject_train.txt` with `test/subject_test.txt`, and `train/y_train.txt` with `test/y_test.txt`.

* reading `features.txt` and extracting only the measurements on the mean and standard deviation for each measurement.

* reading `activity_labels.txt` and appliying descriptive activity names to name the activities in the data set:
    * walking
    * walkingupstairs
    * walkingdownstairs
    * sitting
    * standing
    * laying

* labelling the data set with descriptive names. All attributes are converted to lower case, underscores and brackets () are removed.The names of the attributes are similar to the following:
    * tbodyacc-mean-x
    * tbodyacc-mean-y
    * tbodyacc-mean-z
    * tbodyacc-std-x
    * tbodyacc-std-y
    * tbodyacc-std-z
    * tgravityacc-mean-x
    * tgravityacc-mean-y

* creating a 2nd tidy data set `clean_data_with_average.txt` with the average of each measurement for each activity and each subject.
