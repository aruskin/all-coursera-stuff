The run_analysis.R script contains a single function, run_analysis, to transform the [UCI HAR dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) by:

* Merging the training and the test sets to create one data set.
* Extracting only the measurements on the mean and standard deviation for each measurement.
* Labeling the features and observations

in order to create an independent tidy data set with the average of each variable for each activity and each subject.

The run_analysis function takes three optional parameters:
* write: whether to write the returned dataset to a file; default is TRUE
* outfile: the name of the text file to which to write the tidy dataset returned by the function; the default value for this is "run_analysis.txt"
* directory: the name of the folder within your current working directory where the UCI HAR dataset is stored; the default value for this is "UCI HAR Dataset"

and will return a data.frame containing the tidy dataset.

---

run_analysis.txt is the result of running the function in run_analysis.R

---

CodeBook.md lists the variables in run_analysis.txt along with a description of how they were collected (largely copy-pasted from the original documentation of the UCI dataset)

