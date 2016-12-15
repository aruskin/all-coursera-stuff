run_analysis is a function to transform the UCI HAR dataset by:

* Merging the training and the test sets to create one data set.
* Extracting only the measurements on the mean and standard deviation for each measurement.
* Labeling the features and observations

in order to create an independent tidy data set with the average of each variable for each activity and each subject.

run_analysis takes three optional parameters:
* write: whether to write the returned dataset to a file; default is TRUE
* outfile: the name of the text file to which to write the tidy dataset returned by the function; the default value for this is "run_analysis.txt"
* directory: the name of the folder within your current working directory where the UCI HAR dataset is stored; the default value for this is "UCI HAR Dataset"

run_analysis will return a data.frame containing the tidy dataset